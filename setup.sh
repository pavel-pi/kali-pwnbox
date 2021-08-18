#!/bin/bash

# if not root, run as root
if (( $EUID != 0 )); then
    sudo $0
    exit
fi

# update system
echo -e "\e[31mUpgrade Packages ...\e[0m"
apt update > /dev/null
apt -y dist-upgrade > /dev/null
apt -y autoremove > /dev/null

# install mate & remove xfce
echo -e "\e[31mInstall MATE ...\e[0m"
apt -y install kali-desktop-mate > /dev/null
apt purge -y --autoremove kali-desktop-xfce xfce4 xfce4-places-plugin xfce4-goodies > /dev/null
#apt-get install kali-defaults kali-root-login desktop-base mate-desktop-environment-extra

# Install Parrot themes
echo -e "\e[31mInstall Parrot OS Themes ...\e[0m"
wget -q http://deb.parrotsec.org/parrot/pool/main/p/parrot-themes/parrot-themes_3.2%2Bparrot3_all.deb -O /tmp/parrot.deb
apt -y install /tmp/parrot.deb > /dev/null

# Copy theme files
echo -e "\e[31mCopy Icons and Wallpapers ...\e[0m"
cp -v /opt/pwnbox/htb*.jpg /usr/share/backgrounds/
cp -Rv /opt/pwnbox/Material-Black-Lime-Numix-FLAT/ /usr/share/icons/
cp -Rv /opt/pwnbox/htb/ /usr/share/icons/

# Install terminator
echo -e "\e[31mInstall Terminator ...\e[0m"
apt install terminator -y > /dev/null

# Set Timezone
echo -e "\e[31mSet Timezone ...\e[0m"
timedatectl set-timezone Europe/Berlin
timedatectl show | grep Timezone

echo -e "\e[31mSetup Complete!\e[0m"


######
# Install Tools

# Pip2
curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2
echo 'export PATH=$HOME/.local/bin:$PATH' >>~/.zshrc
#pip install setuptools

# Joplin
#wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='DD.MM.YYYY' where key='dateFormat'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='de_DE' where key='locale'"
# eher INSERT into, weil noch nicht vorhanden
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='5' where key='sync.target'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_url' where key='sync.5.path'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_username' where key='sync.5.username'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_password' where key='sync.5.password'"

# AppImageLauncher
#tempInstallFile=$HOME/Downloads/appimagelauncher.deb
#curl -s https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest \
#| grep "browser_download_url" \
#| grep 'bionic_amd64.deb' \
#| cut -d : -f 2,3 \
#| tr -d \" \
#| wget -O $tempInstallFile -qi - \
#&& sudo dpkg -i $tempInstallFile \
#&& rm $tempInstallFile


