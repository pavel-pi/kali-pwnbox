#!/bin/bash

AppImagesLocation=$HOME/Applications

# must be run as default user
if (( $EUID == 0 )); then
    echo "Restart without root ..."
    exit
fi

# run setup.sh 
echo -e "\e[33mRunning Setup Script as root ...\e[0m"
/opt/pwnbox/setup.sh

# Set theme
#echo -e "\e[33mSet Theme ...\e[0m"
#gsettings set org.mate.peripherals-mouse cursor-theme 'Breeze'
#gsettings set org.mate.interface gtk-theme 'ARK-Dark'
#gsettings set org.mate.Marco.general theme 'ARK-Dark'
#gsettings set org.mate.interface icon-theme 'Material-Black-Lime-Numix-FLAT'
#gsettings set org.mate.peripherals-mouse cursor-size 24
#gsettings set org.gnome.desktop.interface cursor-size 24
#gsettings set org.mate.interface gtk-color-scheme "base_color:#404552,fg_color:#D3DAE3,tooltip_fg_color:#FFFFFF,selected_bg_color:#5294E2,selected_fg_color:#FFFFFF,text_color:#D3DAE3,bg_color:#383C4A,insensitive_bg_color:#3e4350,insensitive_fg_color:#7c818c,notebook_bg:#404552,dark_sidebar_bg:#353945,tooltip_bg_color:#353945,link_color:#5294E2,menu_bg:#383C4A"
#gsettings set org.mate.background picture-filename '/usr/share/backgrounds/htb.jpg'
#gsettings set org.mate.background picture-options 'zoom'

# Set keyboard layout
#echo -e "\e[33mSet Keyboard Layout ...\e[0m"
#gsettings set org.mate.peripherals-keyboard-xkb.kbd layouts "['de']"

# open quick launcher with Windows/Super key (default is ALT + F2)
#echo -e "\e[33mSet Windows Key ...\e[0m"
#gsettings set org.mate.Marco.global-keybindings panel-run-dialog 'Super_L'

# Set default terminal to terminator
#echo -e "\e[33mSet Terminator as default terminal ...\e[0m"
#gsettings set org.mate.applications-terminal exec 'terminator'

# load dconf settings
dconf load / < /opt/pwnbox/htb.dconf

# Place Terminator config file
mkdir -p $HOME/.config/terminator/
cp /opt/pwnbox/terminator.conf $HOME/.config/terminator/config

# Install oh-my-zsh
echo -e "\e[33mInstall Oh My Zsh ...\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
touch $HOME/.hushlogin

# Install HTB theme
echo -e "\e[33mInstall Oh My Zsh HTB Theme ...\e[0m"
cp /opt/pwnbox/zsh/hackthebox.zsh-theme $HOME/.oh-my-zsh/themes/
sed -i s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"hackthebox\"/ $HOME/.zshrc
#source ~/.zshrc

# Terminator - Use colors from system theme
#lineno=$(awk '/\[\[default\]\]/{ print NR; exit }' $HOME/.config/terminator/config)
#sed -i "$(($lineno+1))iuse_theme_colors = True" $HOME/.config/terminator/config

# Change QT5 theme & icons
echo -e "\e[33mChange QT5 Theme ...\e[0m"
qt5_config="$HOME/.config/qt5ct/qt5ct.conf"
sed -i 's/\(color_scheme_path=\).*/\1\/usr\/share\/qt5ct\/colors\/Kali-Light.conf/' $qt5_config
sed -i 's/\(icon_theme=\).*/\1Flat-Remix-Blue-Light/' $qt5_config

# Add Aliases
echo '' >> $HOME/.zshrc
echo '# alias for APT upgrades' >> $HOME/.zshrc
echo "alias upd=\"sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove\"" >> $HOME/.zshrc

echo '' >> $HOME/.zshrc
echo '# alias for syntax highlighting' >> $HOME/.zshrc
echo "alias ccat='pygmentize -g'" >> $HOME/.zshrc

echo '' >> $HOME/.zshrc
echo '# alias for cheat sheet' >> $HOME/.zshrc
echo 'chtsh() {  curl -s "https://cht.sh/$1" | less -R }' >> $HOME/.zshrc

# Add App Images dir to PATH
echo '' >> $HOME/.zshrc
echo '# Add App Images dir to PATH' >> $HOME/.zshrc
echo 'export PATH=$HOME/Applications:$PATH' >>~/.zshrc

# Create Plank autostart file
#mkdir -p $HOME/.config/autostart/
#tee $HOME/.config/autostart/plank.desktop > /dev/null <<EOT
#[Desktop Entry]
#Type=Application
#Exec=plank
#Hidden=false
#X-MATE-Autostart-enabled=true
#Name[en_US]=Plank
#Name=Plank
#Comment[en_US]=
#Comment=
#X-MATE-Autostart-Delay=0
#EOT

# Copy Plank dock items
mkdir -p $HOME/.config/plank/dock1/launchers
cp /opt/pwnbox/plank/dock1/launchers/* $HOME/.config/plank/dock1/launchers

# Obisidian
mkdir -p $AppImagesLocation
echo -e "\e[33mInstall Obsidian ...\e[0m"
curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
| grep "browser_download_url" \
| grep "AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -P $AppImagesLocation -qi -
chmod +x $AppImagesLocation/Obsidian*.AppImage

# appimaged
#wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2) -P $AppImagesLocation
#chmod +x $AppImagesLocation/appimaged-*.AppImage
#$AppImagesLocation/appimaged-*.AppImage

# Pip2
curl -s https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2
echo '' >> $HOME/.zshrc
echo '# Add PIP dir to PATH' >> $HOME/.zshrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc
$HOME/.local/bin/pip install setuptools

# Add "Auto-suggestions based on the history" to .zshrc
echo '' >> $HOME/.zshrc
echo '# enable auto-suggestions based on the history' >> $HOME/.zshrc
echo 'if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then' >> $HOME/.zshrc
echo '    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> $HOME/.zshrc
echo '    # change suggestion color' >> $HOME/.zshrc
echo '    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999"' >> $HOME/.zshrc
echo 'fi' >> $HOME/.zshrc

# Add "enable command-not-found if installed" to .zshrc
echo '' >> $HOME/.zshrc
echo '# enable command-not-found if installed' >> $HOME/.zshrc
echo 'if [ -f /etc/zsh_command_not_found ]; then' >> $HOME/.zshrc
echo '    . /etc/zsh_command_not_found' >> $HOME/.zshrc
echo 'fi' >> $HOME/.zshrc


echo -e "\e[33mFinish! Now re-logon and enjoy...\e[0m"
read -n 1 -s -r 
