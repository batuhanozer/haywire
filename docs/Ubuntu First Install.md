
# Ubuntu First Install

## apt update & upgrade

After a clean install, run the following:

```bash
sudo apt update
sudo apt dist-upgrade
```

## docker

Use the script `install_docker.sh`. It will automatically install the docker and fix `sudo` problem.

```bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker

sudo gpasswd -a $USER docker

newgrp docker
```

## vscode

Use the script `install_vscode.sh`.

```bash
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
```

## terminator

Install terminator.

```bash
sudo apt install terminator
```

## chrome

[Download](https://www.google.com/chrome/) and install google chrome.

## zsh & omz

Use the `install_zsh.sh` script to install zsh, omz and two plugins.

```bash
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
```

## ROS Noetic

Use the script `install_ros_noetic.sh`.
```bash
#!/bin/bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-noetic-desktop-full -y

# for bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
# source ~/.zshrc

# for zsh
echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
source ~/.zshrc

sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y

sudo rosdep init
rosdep update
```

