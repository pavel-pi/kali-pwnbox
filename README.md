# README

```
$ sudo git clone https://github.com/pavel-pi/pwnbox /opt/pwnbox
# Copy theme
$ sudo cp /opt/pwnbox/htb*.jpg /usr/share/backgrounds/
$ sudo cp -R /opt/pwnbox/Material-Black-Lime-Numix-FLAT /usr/share/icons/
$ sudo cp /opt/pwnbox/gitclones/pwnbox/htb.jpg /usr/share/backgrounds/
#$ sudo mkdir /usr/share/themes/KaliPwnbox && sudo cp /opt/pwnbox/index.theme /usr/share/themes/KaliPwnbox
# Set theme
gsettings set org.mate.peripherals-mouse cursor-theme 'Breeze'
gsettings set org.mate.interface gtk-theme 'ARK-Dark'
gsettings set org.mate.Marco.general theme 'ARK-Dark'
gsettings set org.mate.interface icon-theme 'Material-Black-Lime-Numix-FLAT'
gsettings set org.mate.peripherals-mouse cursor-size 24
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.mate.interface gtk-color-scheme "base_color:#404552,fg_color:#D3DAE3,tooltip_fg_color:#FFFFFF,selected_bg_color:#5294E2,selected_fg_color:#FFFFFF,text_color:#D3DAE3,bg_color:#383C4A,insensitive_bg_color:#3e4350,insensitive_fg_color:#7c818c,notebook_bg:#404552,dark_sidebar_bg:#353945,tooltip_bg_color:#353945,link_color:#5294E2,menu_bg:#383C4A"
gsettings set org.mate.background picture-filename '/usr/share/backgrounds/htb.jpg'
gsettings set org.mate.background picture-options 'zoom'
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
touch ~/.hushlogin
# Install HTB theme
cp /opt/pwnbox/zsh/hackthebox.zsh-theme $ZSH_CUSTOM/themes/
sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"hackthebox\"/ ~/.zshrc
# Set Prompt
$ echo "# KaliPwnbox\nPS1=\$'%F{%(#.blue.green)}┌──\${debian_chroot:+(\$debian_chroot)──}\$(/opt/pwnbox/vpnbash.sh)(%B%F{%(#.red.blue)}%n%(#.💀.@)%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\\\\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '" >> .zshrc
$ source .zshrc 
# Update System
$ sudo apt update
$ sudo apt -y full-upgrade
$ sudo apt -y autoremove
# Install Mate Desktop
$ sudo apt update
$ sudo apt install -y kali-desktop-mate
# Remove XFCE
$ sudo apt purge --autoremove kali-desktop-xfce xfce4 xfce4-places-plugin xfce4-goodies- y
$ sudo update-alternatives --config x-session-manager
$ sudo apt-get install kali-defaults kali-root-login desktop-base mate-desktop-environment-extra
# Set keyboard layout
$ gsettings set org.mate.peripherals-keyboard-xkb.kbd layouts "['de']"
#Change look of display manager ? default ist lightdm
# Install Parrot Themes
echo -e "deb https://deb.parrotsec.org/parrot rolling main contrib non-free" | sudo tee /etc/apt/sources.list.d/parrot.list
wget -qO - https://deb.parrotsec.org/parrot/misc/parrotsec.gpg | sudo apt-key add -
sudo apt update
sudo apt -y install parrot-themes
# Open quick launcher with Windows/Super key (default is ALT + F2)
gsettings set org.mate.Marco.global-keybindings panel-run-dialog 'Super_L'
# inspiration from:
# https://gist.github.com/jayluxferro/5cb6ee45726bd30264918df2b0553b70
# https://www.linuxquestions.org/questions/linux-distributions-5/how-to-make-kali-linux-look-like-parrot-os-configuring-how-kali-linux-looks-4175575455/
# https://askubuntu.com/questions/1058523/make-ubuntu-look-like-parrot-os
# https://github.com/theGuildHall/pwnbox
# https://github.com/ikirt/htb-ohmyzsh-theme
```
