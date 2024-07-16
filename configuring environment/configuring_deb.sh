#!/bin/bash

pkgman=apt #put your repository manager here

# updating the system and using apt to install some apps
sudo $pkgman update -y; sudo $pkgman upgrade -y;

sudo $pkgman install chromium telegram-desktop git golang python3 npm node -y
mkdir -p $HOME/.scripts $HOME/wallpapers $HOME/programming/{python,golang,projects}
echo 'System updated, some apps downloaded with apt and some directories created'

# adding some customizations to .bashrc
export PS1='\[\e[38;5;25m\]┌[\[\e[38;5;34m\]\u\[\e[38;5;25m\]]-(\[\e[38;5;34m\]\w\[\e[0m\] \[\e[38;5;25m\]|\[\e[0m\] \[\e[38;5;34m\]\t\[\e[38;5;25m\])\n└\[\e[38;5;34m\]>\[\e[0m\] ' >> $HOME/.bashrc

export PATH=$PATH:~/.scripts >> $HOME/.bashrc
echo 'terminal customization completed .bashrc, added a new PS1 and a directory added to $PATH' 
# now we are going to use internet to catch some packages and install it
mkdir -p $HOME/download_for_packages 
# making a directory to make a standard that doesn't depend
# in the language of the system

if $( ping -c1 8.8.8.8 &>/dev/null ); then
	echo 'network was identified, proceeding to install external apps: vscodium, discord, upscayl and obsidian'
else
	echo 'network was not identified, leaving the script...'
	exit 1
fi

if { curl -o $HOME/download_for_packages/vscodium.deb https://github.com/VSCodium/vscodium/releases/download/1.91.1.24193/codium_1.91.1.24193_amd64.deb; sudo dpkg -i $HOME/download_for_packages/vscodium.deb; }; then
	echo 'vscodium was installed'
else
	echo 'failed installing vscodium'
fi

if { curl -o $HOME/download_for_packages/Upscayl.deb https://github.com/upscayl/upscayl/releases/download/v2.11.5/upscayl-2.11.5-linux.deb; sudo dpkg -i $HOME/download_for_packages/Upscayl.deb; }; then
	echo 'upscayl was installed'
else
	echo 'failed installing upscayl'
fi

if { curl -o $HOME/download_for_packages/discord_app.deb https://discord.com/api/download?platform=linux&format=deb; sudo dpkg -i $HOME/download_for_packages/discord_app.deb; }; then
	echo 'discord was installed'
else
	echo 'failed installing discord'
fi


if { curl -o $HOME/download_for_packages/obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/obsidian-1.6.5-amd64.deb; sudo dpkg -i $HOME/download_for_packages/obsidian.deb; }; then
	echo 'obsidian was installed'
else
	echo 'failed installing obsidian'
fi

echo 'installation of external software finished'



# adding more security to the system through the activation of the firewall
echo 'activating firewall...'

if $( which ufw ); then
		sudo ufw enable
		sudo systemctl enable ufw
		echo 'firewall activated'
else
	echo 'firewall not identifying, installing now...'
	if $( sudo $pkgman install ufw -y ); then
		echo 'firewall installed successful'
		sudo ufw enable
		sudo systemctl enable ufw
		echo 'firewall activated'
	else
		echo 'firewall failed to install, needs manual intervention'
	fi
fi


echo 'major configurations already made'
