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
echo '######################################################################'\n###########
cd /usr/share/icons
sudo rm -r Adwaita
sudo rm -r breeze
sudo rm -r breeze_cursors
sudo rm -r breeze-dark
sudo rm -r Breeze_Snow
sudo rm -r Humanity
sudo rm -r Humanity-Dark
sudo rm -r Oxygen_Black
sudo rm -r Oxygen_Blue
sudo rm -r Oxygen_White
sudo rm -r Oxygen_Yellow
sudo rm -r Oxygen_Zion
sudo rm -r ubuntu-mono-light
sudo rm -r WhiteSur
sudo rm -r WhiteSur-cursors
sudo rm -r WhiteSur-dark
sudo rm -r WhiteSur-light
sudo rm -r WhiteSur-green
sudo rm -r WhiteSur-green-dark
sudo rm -r WhiteSur-grey
sudo rm -r WhiteSur-grey-dark
sudo rm -r WhiteSur-nord
sudo rm -r WhiteSur-nord-dark
sudo rm -r WhiteSur-orange
sudo rm -r WhiteSur-orange-dark
sudo rm -r WhiteSur-pink
sudo rm -r WhiteSur-pink-dark
sudo rm -r WhiteSur-purple
sudo rm -r WhiteSur-purple-dark
sudo rm -r WhiteSur-red
sudo rm -r WhiteSur-red-dark
sudo rm -r WhiteSur-yellow
sudo rm -r WhiteSur-yellow-dark
cd -

cd /usr/share/themes
sudo rm -r Breeze
sudo rm -r Breeze-Dark
sudo rm -r WhiteSur-Dark
sudo rm -r WhiteSurDark-Dark
sudo rm -r WhiteSurDark-Dark-grey
sudo rm -r WhiteSurDark-Dark-solid-alt-grey
sudo rm -r WhiteSurDark-Dark-solid-grey
sudo rm -r WhiteSurDark-Dark-alt-grey
sudo rm -r WhiteSur-Dark-hdpi
sudo rm -r WhiteSur-Dark-solid
sudo rm -r WhiteSur-Dark-solid-green
sudo rm -r WhiteSur-Dark-xhdpi
sudo rm -r WhiteSur-Dark-Light
sudo rm -r WhiteSur-Light
sudo rm -r WhiteSur-Light-solid
sudo rm -r KvAdapta
sudo rm -r KvAmbiance
sudo rm -r KvAmbience
sudo rm -r KvArc
sudo rm -r KvArcDark
sudo rm -r KvBeige
sudo rm -r KvBrown
sudo rm -r KvCurvesLight
sudo rm -r KvCyan
sudo rm -r KvDarkRed
sudo rm -r KvFlatLight
sudo rm -r KvGnomeAlt
sudo rm -r KvGnomeDark
sudo rm -r KvGnomish
sudo rm -r KvGray
sudo rm -r KvRoughGlass
sudo rm -r KvSimplicity
sudo rm -r KvSimplicityDark
cd -

sudo rm -r $HOME/.themes
sudo rm -r $HOME/.icons
sudo rm -r $HOME/.local/share/icons/WhiteSur
sudo rm -r $HOME/.local/share/icons/WhiteSur-dark
sudo rm -r $HOME/.local/share/icons/WhiteSur-light
sudo rm -r $HOME/.local/share/icons/WhiteSur-cursors

rm -r ./WhiteSur-gtk-theme
rm -r ./WhiteSur-icon-theme
rm -r ./WhiteSur-kde
rm -r ./grub2-themes/

echo '#########################################################################\n'
