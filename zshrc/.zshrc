# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=43'

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode auto  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Check if the 'spf' command exists
if ! command -v spf &> /dev/null; then
    # If it doesn't exist, run the installation command
    bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"
fi

# if ! command -v atuin &> /dev/null; then
#     curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# fi

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# loading the plugin
if [[ ! -d $ZSH_CUSTOM/plugins/fzf-tab ]]; then
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    colored-man-pages
    ls
    zsh-256color
    sudo
    fzf-tab
)

# In case a command is not found, try to find the package that has it
if command -v pacman &> /dev/null ; 
then
    function command_not_found_handler {
        local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
        printf 'zsh: command not found: %s\n' "$1"
        local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
        if (( ${#entries[@]} )) ; then
            printf "${bright}$1${reset} may be found in the following packages:\n"
            local pkg
            for entry in "${entries[@]}" ; do
                local fields=( ${(0)entry} )
                if [[ "$pkg" != "${fields[2]}" ]] ; then
                    printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
                fi
                printf '    /%s\n' "${fields[4]}"
                pkg="${fields[2]}"
            done
        fi
        return 127
    }
fi
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Example aliases
alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

aurhelper="yay"

alias  c='clear' # clear terminal
if command -v eza &> /dev/null ; then
    alias eza='eza'
else
    alias eza='ls'
fi
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lsa='eza -la --icons=auto --sort=name --group-directories-first'
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

alias ip="ip -c"
alias ipa="ip -c address"
alias pulldots="git -C ~/.dotfiles pull && source ~/.zshrc"
alias adddots="git -C ~/.dotfiles add . && git -C ~/.dotfiles/ commit -m ${0}"
alias pushdots="git -C ~/.dotfiles push"

if command -v nvim &> /dev/null ; then
    alias vim="nvim"
fi
alias r="ranger"

# alias fvim="nvim $(fzf)"

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias kssh='kitten ssh'

# Curl jq alias
cjq() {
    curl -s "$1" | jq
}


# For local aliases
if [ -f ~/.zsh_local ]; then
  source ~/.zsh_local
fi


bindkey "^H" backward-delete-word

[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh

# For cargo bin 
export DOCKER_ID="mxdx02"
# export BROWSER="google-chrome-stable"

# PATH
export PATH=$HOME/.local/bin:$PATH


# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # colorize completions
zstyle ':completion:*' menu no                            # no menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls $realpath'

# Zoxide setup 
if command -v zoxide &> /dev/null ; then
    eval "$(zoxide init zsh)"
fi

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)

# Fzf setup
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/maxime/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/maxime/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/maxime/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/maxime/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

. "$HOME/.atuin/bin/env"


# TEST For YAZI
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



### Initialize atuin
eval "$(atuin init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set the terminal program to use
export TERM_PROGRAM=tmux


# FZF function for ssh connection 
s () {
  local server
  server=$(grep -E '^Host ' ~/.ssh/config | awk '{print $2}' | fzf)
  if [[ -n $server ]]; then
    ssh $server
  fi
}
