rm ~/.zshrc
rm ~/.p10k.zsh
rm -rf ~/.config/nvim 

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/nvim ~/.config/nvim

git config --global user.name 'MxDx'
git config --global user.emai 'maxime.dxl2002@gmail.com'
