#!/bin/bash

# if not root, run as root
if (( $EUID != 0 )); then
    sudo $0
    exit
fi

# update system
echo -e "\e[31mUpgrade Packages ...\e[0m"
apt update
#apt -y dist-upgrade
apt -y autoremove

# install mate & remove xfce
echo -e "\e[31mInstall MATE ...\e[0m"
apt -y install kali-desktop-mate 
apt purge -y --allow-remove-essential --autoremove kali-desktop-xfce xfce4 xfce4-places-plugin xfce4-goodies 
#apt-get install kali-defaults kali-root-login desktop-base mate-desktop-environment-extra

# Install Parrot themes
git clone https://github.com/ParrotSec/parrot-themes /opt/parrot-themes
cp -Rv /opt/parrot-themes/themes/ARK-Dark /usr/share/themes/
cp -Rv /opt/parrot-themes/themes/* /usr/share/themes/
cp -Rv /opt/parrot-themes/icons/* /usr/share/icons/

# Copy wallpapers
echo -e "\e[31mCopy Wallpapers ...\e[0m"
cp -v /opt/pwnbox/htb*.jpg /usr/share/backgrounds/

# Install vscode
#apt install code-oss -y

# Install ghidra
#apt install ghidra -y

# Install dconf
apt install dconf-cli -y

# Set Timezone
echo -e "\e[31mSet Timezone ...\e[0m"
timedatectl set-timezone Europe/Berlin
timedatectl show | grep Timezone

echo -e "\e[31mSetup Complete!\e[0m"
