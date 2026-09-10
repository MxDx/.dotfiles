#!/usr/bin/env bash

declare -a DEP_CATEGORIES=()
declare -A DEP_CATEGORY_LABEL=()
declare -A DEP_CATEGORY_STOW=()
declare -A DEP_CATEGORY_ITEMS=()

declare -A DEP_ITEM_CATEGORY=()
declare -A DEP_ITEM_LABEL=()
declare -A DEP_ITEM_KIND=()
declare -A DEP_ITEM_CHECK=()
declare -A DEP_ITEM_INSTALL=()
declare -A DEP_ITEM_NOTE=()

register_category() {
	local id="$1"
	local label="$2"
	local stow="${3:-}"
	DEP_CATEGORIES+=("$id")
	DEP_CATEGORY_LABEL["$id"]="$label"
	DEP_CATEGORY_STOW["$id"]="$stow"
	DEP_CATEGORY_ITEMS["$id"]=""
}

register_dep() {
	local category="$1"
	local id="$2"
	local label="$3"
	local kind="$4"
	local check="$5"
	local install="$6"
	local note="${7:-}"
	DEP_ITEM_CATEGORY["$id"]="$category"
	DEP_ITEM_LABEL["$id"]="$label"
	DEP_ITEM_KIND["$id"]="$kind"
	DEP_ITEM_CHECK["$id"]="$check"
	DEP_ITEM_INSTALL["$id"]="$install"
	DEP_ITEM_NOTE["$id"]="$note"
	DEP_CATEGORY_ITEMS["$category"]+="$id "
}

dep_has_any_cmd() {
	local candidate
	for candidate in $1; do
		command -v "$candidate" >/dev/null 2>&1 && return 0
	done
	return 1
}

dep_is_installed() {
	local id="$1"
	local kind="${DEP_ITEM_KIND[$id]}"
	local check="${DEP_ITEM_CHECK[$id]}"
	case "$kind" in
		cmd|package)
			dep_has_any_cmd "$check"
			;;
		path)
			[[ -e "$check" ]]
			;;
		shell)
			bash -lc "$check" >/dev/null 2>&1
			;;
		*)
			return 1
			;;
	esac
}

dep_status_icon() {
	if dep_is_installed "$1"; then
		printf '✓'
	else
		printf '✗'
	fi
}

dep_install_item() {
	local id="$1"
	local kind="${DEP_ITEM_KIND[$id]}"
	local install="${DEP_ITEM_INSTALL[$id]}"
	local check="${DEP_ITEM_CHECK[$id]}"
	local apt_pkg arch_pkg

	if dep_is_installed "$id"; then
		printf '%s already present\n' "$id"
		return 0
	fi

	case "$kind" in
		package)
			IFS='|' read -r apt_pkg arch_pkg <<< "$install"
			if [[ "$DISTRO" == "arch" ]]; then
				sudo pacman -S --needed --noconfirm $arch_pkg
			else
				sudo apt-get install -y $apt_pkg
			fi
			;;
		cmd|path|shell)
			if [[ -n "$install" ]]; then
				bash -lc "$install"
			else
				printf 'No automated install for %s\n' "$id"
			fi
			;;
		*)
			printf 'No automated install for %s\n' "$id"
			;;
	esac
}

dep_install_category() {
	local category="$1"
	local id
	for id in ${DEP_CATEGORY_ITEMS["$category"]}; do
		dep_install_item "$id"
	done
}

dep_category_counts() {
	local category="$1"
	local id installed=0 total=0
	for id in ${DEP_CATEGORY_ITEMS["$category"]}; do
		((total++))
		dep_is_installed "$id" && ((installed++))
	done
	printf '%s/%s' "$installed" "$total"
}

dep_list_categories() {
	local category
	for category in "${DEP_CATEGORIES[@]}"; do
		printf '%s\t%s\t%s\n' "$category" "${DEP_CATEGORY_LABEL[$category]}" "$(dep_category_counts "$category")"
	done
}

dep_list_items() {
	local category="$1"
	local id
	for id in ${DEP_CATEGORY_ITEMS["$category"]}; do
		printf '%s\t%s\t%s\t%s\n' "$id" "${DEP_ITEM_LABEL[$id]}" "$(dep_status_icon "$id")" "${DEP_ITEM_NOTE[$id]}"
	done
}

dep_render_category() {
	local category="$1"
	local id
	printf 'Category: %s\n' "${DEP_CATEGORY_LABEL[$category]}"
	printf 'Status:   %s\n' "$(dep_category_counts "$category")"
	printf 'Stow:     %s\n\n' "${DEP_CATEGORY_STOW[$category]:-}"
	printf '%-2s  %-18s  %s\n' "OK" "id" "label"
	for id in ${DEP_CATEGORY_ITEMS["$category"]}; do
		printf '%-2s  %-18s  %s\n' "$(dep_status_icon "$id")" "$id" "${DEP_ITEM_LABEL[$id]}"
	done
}

dep_render_item() {
	local id="$1"
	printf 'Item:     %s\n' "${DEP_ITEM_LABEL[$id]}"
	printf 'Category: %s\n' "${DEP_CATEGORY_LABEL[${DEP_ITEM_CATEGORY[$id]}]}"
	printf 'Status:   %s\n' "$(dep_status_icon "$id")"
	printf 'Kind:     %s\n' "${DEP_ITEM_KIND[$id]}"
	printf 'Check:    %s\n' "${DEP_ITEM_CHECK[$id]}"
	printf 'Install:  %s\n' "${DEP_ITEM_INSTALL[$id]:-none}"
	[[ -n "${DEP_ITEM_NOTE[$id]}" ]] && printf 'Note:     %s\n' "${DEP_ITEM_NOTE[$id]}"
}

dep_raw_item() {
	local id="$1"
	printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
		"${DEP_ITEM_LABEL[$id]:-}" \
		"${DEP_ITEM_KIND[$id]:-cmd}" \
		"${DEP_ITEM_CHECK[$id]:-}" \
		"${DEP_ITEM_INSTALL[$id]:-}" \
		"${DEP_ITEM_NOTE[$id]:-}" \
		"${DEP_ITEM_CATEGORY[$id]:-}"
}

dep_raw_category() {
	local id="$1"
	printf '%s\t%s\n' \
		"${DEP_CATEGORY_LABEL[$id]:-}" \
		"${DEP_CATEGORY_STOW[$id]:-}"
}

dep_render_stow_packages() {
	local packages="$1"
	local pkg
	for pkg in $packages; do
		printf '%s\t%s\n' "$pkg" "$(if [[ -e "$ROOT_DIR/$pkg" ]]; then printf '✓'; else printf '✗'; fi)"
	done
}

dep_stow_packages() {
	local packages="$1"
	[[ -n "$packages" ]] || return 0
	command -v stow >/dev/null 2>&1 || { printf 'stow is not installed\n'; return 1; }
	stow -d "$ROOT_DIR" -t "$HOME_DIR" -R $packages
}

register_category stow "Stow packages" "atuin hypr nvim p10k posting tmux zshrc bin dotdeps"
register_category shell "Shell stack" "zshrc p10k atuin bin"
register_category tmux "tmux stack" "tmux"
register_category nvim "Neovim stack" "nvim"
register_category desktop "Desktop stack" "hypr"
register_category devtools "Developer tools" ""
register_category fonts "Fonts" ""

register_dep stow atuin "atuin config" path "$ROOT_DIR/atuin/config.toml" "" "Atuin config package"
register_dep stow hypr "Hyprland config" path "$ROOT_DIR/hypr/.config/hypr/keybindings.conf" "" "Hyprland config package"
register_dep stow nvim "Neovim config" path "$ROOT_DIR/nvim/.config/nvim/init.lua" "" "Neovim config package"
register_dep stow p10k "Powerlevel10k config" path "$ROOT_DIR/p10k/.p10k.zsh" "" "Powerlevel10k config package"
register_dep stow posting "Posting config" path "$ROOT_DIR/posting/.config/posting/config.yaml" "" "Posting config package"
register_dep stow tmux "tmux config" path "$ROOT_DIR/tmux/.tmux.conf" "" "tmux config package"
register_dep stow zshrc "zsh config" path "$ROOT_DIR/zshrc/.zshrc" "" "zsh config package"
register_dep stow dotdeps_pkg "dotdeps config" path "$ROOT_DIR/dotdeps/.config/dotdeps/catalog.sh" "" "dotdeps catalog package"
register_dep stow bin "Local binaries" path "$ROOT_DIR/bin/.local/bin/dotdeps" "" "Launchable bin package"

register_dep shell git "Git" package "git" "git|git" "VCS"
register_dep shell curl "curl" package "curl" "curl|curl" "Fetch tool"
register_dep shell zsh "zsh" package "zsh" "zsh|zsh" "Shell"
register_dep shell stow "GNU Stow" package "stow" "stow|stow" "Symlink manager"
register_dep shell fzf "fzf" package "fzf" "fzf|fzf" "Interactive selector"
register_dep shell zoxide "zoxide" package "zoxide" "zoxide|zoxide" "Smart cd"
register_dep shell bat "bat" package "bat batcat" "bat|bat" "Debian may expose batcat"
register_dep shell eza "eza" package "eza" "eza|eza" "ls replacement"
register_dep shell jq "jq" package "jq" "jq|jq" "JSON helper"
register_dep shell yazi "yazi" package "yazi" "yazi|yazi" "File manager"
register_dep shell ranger "ranger" package "ranger" "ranger|ranger" "File manager"
register_dep shell lazygit "lazygit" package "lazygit" "lazygit|lazygit" "Git TUI"
register_dep shell lazydocker "lazydocker" cmd "lazydocker" "go install github.com/jesseduffield/lazydocker@latest" "Docker TUI"
register_dep shell atuin "Atuin" cmd "atuin" "curl -fsSL https://setup.atuin.sh | sh" "Shell history"
register_dep shell powerlevel10k "Powerlevel10k" path "$HOME_DIR/powerlevel10k/powerlevel10k.zsh-theme" 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME_DIR/powerlevel10k"' "Prompt"
register_dep shell ohmyzsh "oh-my-zsh" path "$HOME_DIR/.oh-my-zsh/oh-my-zsh.sh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended' "Shell framework"
register_dep shell fzftab "fzf-tab" path "$HOME_DIR/.oh-my-zsh/custom/plugins/fzf-tab" "git clone https://github.com/Aloxaf/fzf-tab.git \"${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/plugins/fzf-tab\"" "Zsh plugin"
register_dep shell zsh_syntax_highlighting "zsh-syntax-highlighting" path "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \"${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting\"" "Zsh plugin"
register_dep shell zsh_autosuggestions "zsh-autosuggestions" path "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions.git \"${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/plugins/zsh-autosuggestions\"" "Zsh plugin"
register_dep shell zsh_ls "zsh ls plugin" path "$HOME_DIR/.oh-my-zsh/custom/plugins/ls" "git clone https://github.com/zpm-zsh/ls.git \"${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/plugins/ls\"" "Zsh plugin"
register_dep shell zsh_256color "zsh-256color" path "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-256color" "git clone https://github.com/chrissicool/zsh-256color.git \"${ZSH_CUSTOM:-$HOME_DIR/.oh-my-zsh/custom}/plugins/zsh-256color\"" "Zsh plugin"
register_dep shell superfile "superfile/spf" cmd "spf" 'bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"' "File manager"
register_dep shell nvm "nvm" path "$HOME_DIR/.nvm/nvm.sh" "git clone https://github.com/nvm-sh/nvm.git \"$HOME_DIR/.nvm\"" "Node version manager"
register_dep shell conda "conda" path "/opt/anaconda/etc/profile.d/conda.sh" "" "Manual install"
register_dep shell gcloud "Google Cloud SDK" path "$HOME_DIR/Downloads/google-cloud-sdk/path.zsh.inc" "" "Manual install"
register_dep shell envman "envman" path "$HOME_DIR/.config/envman/load.sh" "" "Manual install"
register_dep shell hcp "hcp" cmd "hcp" "" "Manual install"
register_dep shell posting "Posting" cmd "posting" "pipx install posting" "REST client"

register_dep tmux tmux "tmux" package "tmux" "tmux|tmux" "Terminal multiplexer"
register_dep tmux tpm "TPM" path "$HOME_DIR/.tmux/plugins/tpm/bindings/install_plugins" "git clone https://github.com/tmux-plugins/tpm.git \"$HOME_DIR/.tmux/plugins/tpm\"" "Plugin manager"
register_dep tmux catppuccin_tmux "Catppuccin tmux" path "$HOME_DIR/.tmux/plugins/tmux/catppuccin.tmux" "git clone https://github.com/catppuccin/tmux.git \"$HOME_DIR/.tmux/plugins/tmux\"" "Theme"
register_dep tmux tmux_sensible "tmux-sensible" path "$HOME_DIR/.tmux/plugins/tmux-sensible/tmux-sensible.tmux" "git clone https://github.com/tmux-plugins/tmux-sensible.git \"$HOME_DIR/.tmux/plugins/tmux-sensible\"" "Plugin"
register_dep tmux tmux_yank "tmux-yank" path "$HOME_DIR/.tmux/plugins/tmux-yank/yank.tmux" "git clone https://github.com/tmux-plugins/tmux-yank.git \"$HOME_DIR/.tmux/plugins/tmux-yank\"" "Plugin"
register_dep tmux tmux_resurrect "tmux-resurrect" path "$HOME_DIR/.tmux/plugins/tmux-resurrect/resurrect.tmux" "git clone https://github.com/tmux-plugins/tmux-resurrect.git \"$HOME_DIR/.tmux/plugins/tmux-resurrect\"" "Plugin"
register_dep tmux tmux_continuum "tmux-continuum" path "$HOME_DIR/.tmux/plugins/tmux-continuum/continuum.tmux" "git clone https://github.com/tmux-plugins/tmux-continuum.git \"$HOME_DIR/.tmux/plugins/tmux-continuum\"" "Plugin"
register_dep tmux tmux_battery "tmux-battery" path "$HOME_DIR/.tmux/plugins/tmux-battery/battery.tmux" "git clone https://github.com/tmux-plugins/tmux-battery.git \"$HOME_DIR/.tmux/plugins/tmux-battery\"" "Plugin"
register_dep tmux tmux_cpu "tmux-cpu" path "$HOME_DIR/.tmux/plugins/tmux-cpu/cpu.tmux" "git clone https://github.com/tmux-plugins/tmux-cpu.git \"$HOME_DIR/.tmux/plugins/tmux-cpu\"" "Plugin"
register_dep tmux vim_tmux_navigator "vim-tmux-navigator" path "$HOME_DIR/.tmux/plugins/vim-tmux-navigator/plugin/vim-tmux-navigator.vim" "git clone https://github.com/christoomey/vim-tmux-navigator.git \"$HOME_DIR/.tmux/plugins/vim-tmux-navigator\"" "Plugin"

register_dep nvim neovim "Neovim" package "nvim" "neovim|neovim" "Editor"
register_dep nvim lazy_nvim "lazy.nvim" path "$HOME_DIR/.local/share/nvim/lazy/lazy.nvim" "git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable \"$HOME_DIR/.local/share/nvim/lazy/lazy.nvim\"" "Plugin manager"
register_dep nvim lazyvim_lock "LazyVim lockfile" path "$ROOT_DIR/nvim/.config/nvim/lazy-lock.json" "" "Tracked plugins"
register_dep nvim treesitter_build "Treesitter build toolchain" shell "command -v make >/dev/null && command -v gcc >/dev/null" "true" "Compiler toolchain"

register_dep devtools ripgrep "ripgrep" package "rg" "ripgrep|ripgrep" "Search tool"
register_dep devtools fd "fd" package "fd fdfind" "fd-find|fd" "File finder"
register_dep devtools unzip "unzip" package "unzip" "unzip|unzip" "Archive support"
register_dep devtools tar "tar" package "tar" "tar|tar" "Archive support"
register_dep devtools make "make" package "make" "build-essential|base-devel" "Build tool"
register_dep devtools gcc "gcc" package "gcc" "build-essential|base-devel" "Compiler"
register_dep devtools node "nodejs" package "node" "nodejs npm|nodejs npm" "JavaScript runtime"
register_dep devtools npm "npm" package "npm" "nodejs npm|nodejs npm" "Package manager"
register_dep devtools python3 "python3" package "python3" "python3 python3-pip|python python-pip" "Python runtime"
register_dep devtools pip "python3-pip" package "pip3" "python3-pip|python-pip" "Python package installer"
register_dep devtools cmake "cmake" package "cmake" "cmake|cmake" "Build system"
register_dep devtools docker "Docker" package "docker" "docker.io|docker" "Containers"
register_dep devtools helm "Helm" package "helm" "helm|helm" "Kubernetes packaging"
register_dep devtools prettier "Prettier" package "prettier" "prettier|prettier" "Formatter"
register_dep devtools eslint "ESLint" package "eslint" "eslint|eslint" "Linter"
register_dep devtools stylua "Stylua" package "stylua" "stylua|stylua" "Lua formatter"
register_dep devtools shfmt "shfmt" package "shfmt" "shfmt|shfmt" "Shell formatter"
register_dep devtools ruff "Ruff" package "ruff" "ruff|ruff" "Python linter"

register_dep desktop hyprland "Hyprland" package "Hyprland hyprctl" "hyprland|hyprland" "Compositor"
register_dep desktop kitty "kitty" package "kitty" "kitty|kitty" "Terminal"
register_dep desktop rofi "Rofi" package "rofi" "rofi|rofi" "Launcher"
register_dep desktop waybar "Waybar" package "waybar" "waybar|waybar" "Bar"
register_dep desktop hyprpicker "Hyprpicker" package "hyprpicker" "hyprpicker|hyprpicker" "Color picker"
register_dep desktop playerctl "playerctl" package "playerctl" "playerctl|playerctl" "Media control"
register_dep desktop brightnessctl "brightnessctl" package "brightnessctl" "brightnessctl|brightnessctl" "Brightness"
register_dep desktop wl_clipboard "wl-clipboard" package "wl-copy wl-paste" "wl-clipboard|wl-clipboard" "Clipboard"
register_dep desktop cliphist "cliphist" package "cliphist" "cliphist|cliphist" "Clipboard history"
register_dep desktop pavucontrol "pavucontrol" package "pavucontrol" "pavucontrol|pavucontrol" "Audio control"
register_dep desktop blueman "blueman" package "blueman-manager" "blueman|blueman" "Bluetooth"
register_dep desktop nm_applet "network-manager-applet" package "nm-applet" "network-manager-applet|network-manager-applet" "Network applet"
register_dep desktop swww "swww" package "swww" "swww|swww" "Wallpaper manager"
register_dep desktop xdg_portal "xdg-desktop-portal-gtk" package "xdg-desktop-portal-gtk" "xdg-desktop-portal-gtk|xdg-desktop-portal-gtk" "Portal"
register_dep desktop dolphin "Dolphin" package "dolphin" "dolphin|dolphin" "File manager"
register_dep desktop code "VS Code" package "code" "code|code" "Editor"
register_dep desktop zen_browser "Zen Browser" package "zen-browser" "zen-browser|zen-browser" "Browser"
register_dep desktop firefox "Firefox" package "firefox" "firefox|firefox" "Browser"
register_dep desktop vlc "VLC" package "vlc" "vlc|vlc" "Media player"
register_dep desktop ark "Ark" package "ark" "ark|ark" "Archive manager"
register_dep desktop nwg_look "nwg-look" package "nwg-look" "nwg-look|nwg-look" "Qt theming"
register_dep desktop qt5ct "qt5ct" package "qt5ct" "qt5ct|qt5ct" "Qt theming"
register_dep desktop qt6ct "qt6ct" package "qt6ct" "qt6ct|qt6ct" "Qt theming"
register_dep desktop kvantum "kvantummanager" package "kvantummanager" "kvantum|kvantum" "Qt theming"

register_dep fonts meslo_font "Meslo Nerd Font" shell "fc-match -f '%{family}\n' 'MesloLGS NF' | grep -qi Meslo" 'if [[ "$DISTRO" == arch ]]; then yay -S --noconfirm ttf-meslo-nerd-font-powerlevel10k; else d="$HOME/.local/share/fonts/MesloNF" && mkdir -p "$d" && for n in "Regular" "Bold" "Italic" "Bold Italic"; do curl -fLo "$d/MesloLGS NF $n.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${n// /%20}.ttf"; done && fc-cache -fv; fi' "Prompt font"
register_dep fonts fira_code "Fira Code" shell "fc-match -f '%{family}\n' 'Fira Code' | grep -qi 'Fira Code'" 'if [[ "$DISTRO" == arch ]]; then yay -S --noconfirm ttf-firacode-nerd; else sudo apt-get install -y fonts-firacode; fi' "Fallback font"


register_category herdr 'Herdr Stack' "herdr"
