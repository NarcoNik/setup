echo 'Uninstall WhiteSur KDE, GTK & ICON theme'
echo '########################################################################'

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-kde.git
git clone https://github.com/vinceliuice/grub2-themes.git

chmod +x ./WhiteSur-gtk-theme/install.sh
chmod +x  ./WhiteSur-gtk-theme/tweaks.sh
chmod +x  ./WhiteSur-icon-theme/install.sh
chmod +x  ./WhiteSur-kde/install.sh
chmod +x  ./grub2-themes/install.sh

sudo ./WhiteSur-gtk-theme/install.sh -r

sudo ./WhiteSur-kde/install.sh
sudo ./WhiteSur-icon-theme/install.sh -r -u
sudo ./grub2-themes/install.sh -r -t tela


# First step clean default icons & themes
echo '#################################################################'###########
cd /usr/share/icons
sudo rm -rf Adwaita
sudo rm -rf breeze
sudo rm -rf breeze_cursors
sudo rm -rf breeze-dark
sudo rm -rf Breeze_Snow
sudo rm -rf Humanity
sudo rm -rf Humanity-Dark
sudo rm -rf Oxygen_Black
sudo rm -rf Oxygen_Blue
sudo rm -rf Oxygen_White
sudo rm -rf Oxygen_Yellow
sudo rm -rf Oxygen_Zion
sudo rm -rf ubuntu-mono-light
sudo rm -rf WhiteSur
sudo rm -rf WhiteSur-cursors
sudo rm -rf WhiteSur-dark
sudo rm -rf WhiteSur-light
sudo rm -rf WhiteSur-green
sudo rm -rf WhiteSur-green-dark
sudo rm -rf WhiteSur-grey
sudo rm -rf WhiteSur-grey-dark
sudo rm -rf WhiteSur-nord
sudo rm -rf WhiteSur-nord-dark
sudo rm -rf WhiteSur-orange
sudo rm -rf WhiteSur-orange-dark
sudo rm -rf WhiteSur-pink
sudo rm -rf WhiteSur-pink-dark
sudo rm -rf WhiteSur-purple
sudo rm -rf WhiteSur-purple-dark
sudo rm -rf WhiteSur-red
sudo rm -rf WhiteSur-red-dark
sudo rm -rf WhiteSur-yellow
sudo rm -rf WhiteSur-yellow-dark
cd -

cd /usr/share/themes
sudo rm -rf Breeze
sudo rm -rf Breeze-Dark
sudo rm -rf WhiteSur-Dark
sudo rm -rf WhiteSurDark-Dark
sudo rm -rf WhiteSurDark-Dark-grey
sudo rm -rf WhiteSurDark-Dark-solid-alt-grey
sudo rm -rf WhiteSurDark-Dark-solid-grey
sudo rm -rf WhiteSurDark-Dark-alt-grey
sudo rm -rf WhiteSur-Dark-hdpi
sudo rm -rf WhiteSur-Dark-solid
sudo rm -rf WhiteSur-Dark-solid-green
sudo rm -rf WhiteSur-Dark-xhdpi
sudo rm -rf WhiteSur-Dark-Light
sudo rm -rf WhiteSur-Light
sudo rm -rf WhiteSur-Light-solid
sudo rm -rf KvAdapta
sudo rm -rf KvAmbiance
sudo rm -rf KvAmbience
sudo rm -rf KvArc
sudo rm -rf KvArcDark
sudo rm -rf KvBeige
sudo rm -rf KvBrown
sudo rm -rf KvCurvesLight
sudo rm -rf KvCyan
sudo rm -rf KvDarkRed
sudo rm -rf KvFlatLight
sudo rm -rf KvGnomeAlt
sudo rm -rf KvGnomeDark
sudo rm -rf KvGnomish
sudo rm -rf KvGray
sudo rm -rf KvRoughGlass
sudo rm -rf KvSimplicity
sudo rm -rf KvSimplicityDark
cd -

sudo rm -rf $HOME/.themes
sudo rm -rf $HOME/.icons
sudo rm -rf $HOME/.local/share/icons/WhiteSur
sudo rm -rf $HOME/.local/share/icons/WhiteSur-dark
sudo rm -rf $HOME/.local/share/icons/WhiteSur-light
sudo rm -rf $HOME/.local/share/icons/WhiteSur-cursors

rm -rf ./WhiteSur-gtk-theme
rm -rf ./WhiteSur-icon-theme
rm -rf ./WhiteSur-kde
rm -rf ./grub2-themes/

echo '#########################################################################'
