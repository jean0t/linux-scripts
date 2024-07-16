#!/bin/bash

pkgman=apt #put your repository manager here

# updating the system and using apt to install some apps
sudo $pkgman update -y; sudo $pkgman upgrade -y;

sudo $pkgman install chromium telegram-desktop git golang python3 npm node -y
mkdir $HOME/.scripts $HOME/wallpapers $HOME/programming/{python,golang,projects}
echo 'System updated, some apps downloaded with apt and some directories created'

# adding some customizations to .bashrc
export PS1='\[\e[38;5;25m\]┌[\[\e[38;5;34m\]\u\[\e[38;5;25m\]]-(\[\e[38;5;34m\]\w\[\e[0m\] \[\e[38;5;25m\]|\[\e[0m\] \[\e[38;5;34m\]\t\[\e[38;5;25m\])\n└\[\e[38;5;34m\]>\[\e[0m\] ' >> $HOME/.bashrc

export PATH=$PATH:~/.scripts >> $HOME/.bashrc
echo 'terminal customization completed .bashrc, added a new PS1 and a directory added to $PATH' 
# now we are going to use internet to catch some packages and install it
mkdir $HOME/download_for_packages 
# making a directory to make a standard that doesn't depend
# in the language of the system

curl -o $HOME/download_for_packages/vscodium.deb https://github.com/VSCodium/vscodium/releases/download/1.91.1.24193/codium_1.91.1.24193_amd64.deb; sudo dpkg -i $HOME/download_for_packages/vscodium.deb;

curl -o $HOME/download_for_packages/Upscayl.deb https://github.com/upscayl/upscayl/releases/download/v2.11.5/upscayl-2.11.5-linux.deb; sudo dpkg -i $HOME/download_for_packages/Upscayl.deb;

curl -o $HOME/download_for_packages/discord_app.deb https://discord.com/api/download?platform=linux&format=deb; sudo dpkg -i $HOME/download_for_packages/discord_app.deb;

curl -o $HOME/download_for_packages/obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/obsidian-1.6.5-amd64.deb; sudo dpkg -i $HOME/download_for_packages/obsidian.deb;

echo 'vscodium, discord, obsidian and upscayl installed to the system'


# adding more security to the system through the activation of the firewall
sudo ufw enable
sudo systemctl enable ufw
echo 'firewall activated'


echo 'major configurations already made'
