#!/bin/bash

# if not root, run as root
if (( $EUID != 0 )); then
    sudo $0
    exit
fi

# update system
echo -e "\e[31mUpgrade Packages ...\e[0m"
apt update
apt -y dist-upgrade
apt -y autoremove

# install mate & remove xfce
echo -e "\e[31mInstall MATE ...\e[0m"
apt -y install kali-desktop-mate 
apt purge -y --autoremove kali-desktop-xfce xfce4 xfce4-places-plugin xfce4-goodies 
#apt-get install kali-defaults kali-root-login desktop-base mate-desktop-environment-extra

# Install Parrot themes
echo -e "\e[31mInstall Parrot OS Themes ...\e[0m"
wget -q http://deb.parrotsec.org/parrot/pool/main/p/parrot-themes/parrot-themes_3.4%2Bparrot3_all.deb -O /tmp/parrot.deb
apt -y install /tmp/parrot.deb 

# Copy theme files
echo -e "\e[31mCopy Icons and Wallpapers ...\e[0m"
cp -v /opt/pwnbox/htb*.jpg /usr/share/backgrounds/
cp -Rv /opt/pwnbox/Material-Black-Lime-Numix-FLAT/ /usr/share/icons/
cp -Rv /opt/pwnbox/htb/ /usr/share/icons/

# Install terminator
echo -e "\e[31mInstall Terminator ...\e[0m"
apt install terminator -y
sed -i 's/Icon=terminator/Icon=\/usr\/share\/icons\/htb\/bash.svg/' /usr/share/applications/terminator.desktop

# Install vscode
apt install code-oss -y

# Install dconf
apt install dconf-cli -y

# Install plank bar
#apt install plank -y

# Set Timezone
echo -e "\e[31mSet Timezone ...\e[0m"
timedatectl set-timezone Europe/Berlin
timedatectl show | grep Timezone

echo -e "\e[31mSetup Complete!\e[0m"


######
# Install Tools

# Joplin
#wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='DD.MM.YYYY' where key='dateFormat'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='de_DE' where key='locale'"
# eher INSERT into, weil noch nicht vorhanden
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='5' where key='sync.target'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_url' where key='sync.5.path'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_username' where key='sync.5.username'"
#sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_password' where key='sync.5.password'"
