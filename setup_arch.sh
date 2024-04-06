#!/bin/bash

sudo pacman -S zsh
chsh -s /bin/zsh

# Nice to have addition
sudo pacman -S zoxide
sudo pacman -S bat
sudo pacman -S fzf

# TMUX
sudo pacman -S tmux
# TMUX TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# LAZY GIT
yay -S lazygit

# Installing the font
yay -Sy --noconfirm ttf-meslo-nerd-font-powerlevel10k

# POWERLEVEL10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# oh-my-zsh
yay -Sy --noconfirm ttf-meslo-nerd-font-powerlevel10k
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH CUSTOM
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zpm-zsh/ls.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ls
git clone https://github.com/chrissicool/zsh-256color ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-256color

# Exa for ls
yay -S eza
