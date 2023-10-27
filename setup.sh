sudo apt-get update
sudo apt-get install zsh
chsh -s /bin/zsh

# NVIM  
sudo apt-get install neovim

# POWERLEVEL10K
sudo apt install fonts-firacode
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# ZSH CUSTOM
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zpm-zsh/ls.git ${ZSH_CUSTOM1:-~/.oh-my-zsh/custom}/plugins/ls
sudo apt-get install exa

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
