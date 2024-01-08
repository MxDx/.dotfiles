sudo pacman -S zsh
chsh -s /bin/zsh

# Installing the font
yay -Sy --noconfirm ttf-meslo-nerd-font-powerlevel10k

# POWERLEVEL10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# oh-my-zsh
yay -Sy --noconfirm ttf-meslo-nerd-font-powerlevel10k

# ZSH CUSTOM
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zpm-zsh/ls.git ${ZSH_CUSTOM1:-~/.oh-my-zsh/custom}/plugins/ls

# Exa for ls 
yay -S exa
