sudo apt-get update
sudo apt-get install zsh
chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sudo apt install fonts-firacode

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/nvim ~/.config/nvim
