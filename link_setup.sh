#!/bin/bash

# ZSH
read -r -p "Do you want to setup the zshrc config ? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	mv ~/.zshrc ~/.old-conf/.zshrc.old
	if [ $? -eq 0 ]; then
		echo "Old zshrc config successfully moved to ~/.old-conf/.zshrc.old"
	else
		echo "Old config not saved, maybe it doesn't exist"
	fi
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
	if [ $? -eq 0 ]; then
		echo "New zshrc config successfully linked"
	else
		echo "New config not linked, maybe it already exists"
	fi

	# For aliases
	if [ -f ./zsh_alias ]; then
		ln -s ~/.dotfiles/zsh_alias ~/.zsh_alias
		if [ $? -eq 0 ]; then
			echo "New zsh_alias config successfully linked"
		else
			echo "New config not linked, maybe it already exists"
		fi
	fi
fi

# p10k
read -r -p "Do you want to setup the p10k config ? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	mv ~/.p10k.zsh ~/.old-conf/.p10k.zsh.old
	if [ $? -eq 0 ]; then
		echo "Old p10k config successfully moved to ~/.old-conf/.p10k.zsh.old"
	else
		echo "Old config not saved, maybe it doesn't exist"
	fi
	ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
	if [ $? -eq 0 ]; then
		echo "New p10k config successfully linked"
	else
		echo "New config not linked, maybe it already exists"
	fi
fi

# NVIM
read -r -p "Do you want to setup the nvim config ? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	mv -rf ~/.config/nvim ~/.old-conf/nvim.old
	if [ $? -eq 0 ]; then
		echo "Old nvim config successfully moved to ~/.old-conf/nvim.old"
	else
		echo "Old config not saved, maybe it doesn't exist"
	fi
	ln -s ~/.dotfiles/nvim ~/.config/nvim
	if [ $? -eq 0 ]; then
		echo "New nvim config successfully linked"
	else
		echo "New config not linked, maybe it already exists"
	fi
fi

# TMUX
read -r -p "Do you want to setup the tmux config ? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	mv ~/.tmux.conf ~/.old-conf/.tmux.conf.old
	if [ $? -eq 0 ]; then
		echo "Old tmux config successfully moved to ~/.old-conf/.tmux.conf.old"
	else
		echo "Old config not saved, maybe it doesn't exist"
	fi
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
	if [ $? -eq 0 ]; then
		echo "New tmux config successfully linked"
	else
		echo "New config not linked, maybe it already exists"
	fi
	ln -s ~/.dotfiles/.tmux.keybindings.conf ~/.tmux.keybindings.conf
	if [ $? -eq 0 ]; then
		echo "New tmux keybindings config successfully linked"
	else
		echo "New config not linked, maybe it already exists"
	fi
fi

# GIT
read -r -p "Do you want to setup the git config ? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	read -r -p "Enter your git username: " username
	read -r -p "Enter your git email: " email
	git config --global user.name $username
	if [ $? -eq 0 ]; then
		echo "Git username successfully set"
	fi
	git config --global user.email $email
	if [ $? -eq 0 ]; then
		echo "Git email successfully set"
	fi
fi
