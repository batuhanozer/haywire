#!/bin/bash
sudo apt update
sudo apt install zsh -y

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chsh -s $(which zsh)

# Backup .zshrc file
ZSHRC_FILE="$HOME/.zshrc"
cp $ZSHRC_FILE "$ZSHRC_FILE.bak"

# Change the ZSH theme to 'agnoster'
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' $ZSHRC_FILE

# Update the plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' $ZSHRC_FILE

# Append new configurations
echo "HISTFILE=~/.histfile" >> $ZSHRC_FILE
echo "HISTSIZE=10000" >> $ZSHRC_FILE
echo "SAVEHIST=10000" >> $ZSHRC_FILE

echo "Updated .zshrc successfully."

# Install powerline fonts
sudo apt install fonts-powerline -y