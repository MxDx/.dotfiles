#!/bin/bash

sudo apk add zsh
sudo apk add shadow # For chsh to changer default shell
chsh -s /bin/zsh

# Nice to have
sudo apk add zoxide
sudo apk add bat
sudo apk add fzf

# TMUX
sudo apk add tmux
# TMUX TPM
git clone https://githube.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# lazy git
sudo apk add lazygit

# POWERLEVEL10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# oh-my-zsh
sudo apk add oh-my-zsh

# ZSH CUSTOM
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zpm-zsh/ls.git ${ZSH_CUSTOM1:-~/.oh-my-zsh/custom}/plugins/ls

# Exa for ls
sudo apk add exa
