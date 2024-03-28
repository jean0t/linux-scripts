#!/bin/bash

# updating the system and using apt to install some apps
sudo apt update -y; sudo apt upgrade -y;

sudo apt install chromium telegram-desktop git golang python3 npm node -y
mkdir $HOME/.scripts $HOME/wallpapers
echo 'System updated, some apps downloaded with apt and some directories created'

# adding some customizations to .bashrc
export PS1='\[\e[38;5;25m\]┌[\[\e[38;5;34m\]\u\[\e[38;5;25m\]]-(\[\e[38;5;34m\]\w\[\e[0m\] \[\e[38;5;25m\]|\[\e[0m\] \[\e[38;5;34m\]\t\[\e[38;5;25m\])\n└\[\e[38;5;34m\]>\[\e[0m\] ' >> $HOME/.bashrc

export PATH=$PATH:~/.scripts >> $HOME/.bashrc
echo 'terminal customization completed .bashrc, added a new PS1 and a directory added to $PATH' 
# now we are going to use internet to catch some packages and install it
mkdir $HOME/download_for_packages 
# making a directory to make a standard that doesn't depend
# in the language of the system

curl -o $HOME/download_for_packages/vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64; sudo dpkg -i vscode.deb;

curl -o $HOME/download_for_packages/AtomIDE.deb https://github.com/atom/atom/releases/download/v1.60.0/atom-amd64.deb; sudo dpkg -i AtomIDE.deb;

curl -o $HOME/download_for_packages/discord_app.deb https://discord.com/api/download?platform=linux&format=deb; sudo dpkg -i discord_app.deb;
echo 'visual studio code, discord and Atom installed to the system'


# adding more security to the system through the activation of the firewall
sudo ufw enable
sudo systemctl enable ufw
echo 'firewall activated'


echo 'major configurations already made'

