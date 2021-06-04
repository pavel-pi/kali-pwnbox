# README

```bash
joplin_webdav_url=''
joplin_webdav_username=''
joplin_webdav_password=''

$ sudo git clone https://github.com/pavel-pi/pwnbox /opt/pwnbox

# Update System
sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove

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
source ~/.zshrc

# Change QT5 theme & icons
qt5_config="$HOME/.config/qt5ct/qt5ct.conf"
sed -i 's/\(color_scheme_path=\).*/\1\/usr\/share\/qt5ct\/colors\/Kali-Light.conf/' $qt5_config
sed -i 's/\(icon_theme=\).*/\1Flat-Remix-Blue-Light/' $qt5_config

# Disable screen timeout & sleep (gsettings?)
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 0 --create --type int
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0 --create --type int
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -s 0 --create --type int
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/inactivity-on-ac -s 14 --create --type int
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/inactivity-on-battery -s 14 --create --type int

# Hibernate when battery is critical (gsettings?)
#xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/critical-power-action -s 2 --create --type int

# Set Time
timedatectl set-timezone Europe/Berlin

# Change Clock Panel Format (MATE?)
#clock_plugin=$(xfconf-query -c xfce4-panel -l -v | grep clock | cut -d " " -f1)
#xfconf-query -c xfce4-panel -p "$clock_plugin/digital-format" -s "%_H:%M"


######
# Install Tools

# Pip2
curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2
echo 'export PATH=$HOME/.local/bin:$PATH' >>~/.zshrc
pip install setuptools

# Impacket
cd ~/Downloads
git clone https://github.com/SecureAuthCorp/impacket.git
cd impacket && pip3 install .
cd ~ && rm -rf ~/Downloads/impacket

# Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='DD.MM.YYYY' where key='dateFormat'"
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='de_DE' where key='locale'"
# eher INSERT into, weil noch nicht vorhanden
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='5' where key='sync.target'"
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_url' where key='sync.5.path'"
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_username' where key='sync.5.username'"
sqlite3 $HOME/.config/joplin-desktop/database.sqlite "UPDATE settings SET value='$joplin_webdav_password' where key='sync.5.password'"

# inspiration from:
# https://gist.github.com/jayluxferro/5cb6ee45726bd30264918df2b0553b70
# https://www.linuxquestions.org/questions/linux-distributions-5/how-to-make-kali-linux-look-like-parrot-os-configuring-how-kali-linux-looks-4175575455/
# https://askubuntu.com/questions/1058523/make-ubuntu-look-like-parrot-os
# https://github.com/theGuildHall/pwnbox
# https://github.com/ikirt/htb-ohmyzsh-theme
```
