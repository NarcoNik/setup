echo 'Uninstall WhiteSur KDE, GTK & ICON theme'
echo '########################################################################'

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-kde.git

chmod +x ./WhiteSur-gtk-theme/install.sh
chmod +x  ./WhiteSur-gtk-theme/tweaks.sh
chmod +x  ./WhiteSur-icon-theme/install.sh
chmod +x  ./WhiteSur-kde/install.sh

./WhiteSur-gtk-theme/install.sh -o normal -c Dark -a alt -t blue \
  -p 30 -m -N mojave -l --black --darker -r
./WhiteSur-icon-theme/install.sh -t default --alternative --bold -r
sudo ./WhiteSur-gtk-theme/tweaks.sh -g default -o normal -c Dark -t blue \
  -b /mnt/Disk_D/CRYPTO/setup/Linux/theme/wallpaper/background.jpg -r

sudo ./WhiteSur-kde/install.sh -r

# First step clean default icons & themes
echo '#################################################################'###########
cd /usr/share/icons
sudo rm -rf Humanity Humanity-Dark Oxygen_Black Oxygen_Blue Oxygen_White \
  Oxygen_Yellow Oxygen_Zion WhiteSur WhiteSur-cursors WhiteSur-dark \
  WhiteSur-light WhiteSur-green WhiteSur-green-dark WhiteSur-grey \
  WhiteSur-grey-dark WhiteSur-nord WhiteSur-nord-dark WhiteSur-orange \
  WhiteSur-orange-dark WhiteSur-pink WhiteSur-pink-dark WhiteSur-purple \
  WhiteSur-purple-dark  WhiteSur-red WhiteSur-red-dark  WhiteSur-yellow  \
  WhiteSur-yellow-dark
cd -

cd /usr/share/themes
sudo rm -rf WhiteSur-Dark WhiteSurDark-Dark WhiteSurDark-Dark-grey \
  WhiteSurDark-Dark-solid-alt-grey WhiteSurDark-Dark-solid-grey \
  WhiteSurDark-Dark-alt-grey WhiteSur-Dark-hdpi WhiteSur-Dark-solid \
  WhiteSur-Dark-solid-green WhiteSur-Dark-xhdpi WhiteSur-Dark-Light \
  WhiteSur-Light WhiteSur-Light-solid KvAdapta KvAmbiance KvAmbience \
  KvArc KvArcDark KvBeige KvBrown KvCurvesLight KvCyan KvDarkRed \
  KvFlatLight KvGnomeAlt KvGnomeDark KvGnomish KvGray KvRoughGlass \
  KvSimplicity KvSimplicityDark
cd -

sudo rm -rf ~/.themes ~/.icons ~/.local/share/icons/WhiteSur*

rm -rf ./WhiteSur-gtk-theme
rm -rf ./WhiteSur-icon-theme
rm -rf ./WhiteSur-kde
echo '#########################################################################'
