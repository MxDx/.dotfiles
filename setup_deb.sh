#!/bin/bash

sudo apt-get update
sudo apt-get install zsh
chsh -s /bin/zsh

# TMUX
sudo apt-get install tmux
# TMUX TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Lazy git install
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# NVIM
sudo apt-get install neovim

# POWERLEVEL10K
sudo apt install fonts-firacode
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# ZSH CUSTOM
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zpm-zsh/ls.git ${ZSH_CUSTOM1:-~/.oh-my-zsh/custom}/plugins/ls
sudo apt-get install exa
