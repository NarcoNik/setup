echo 'Install WhiteSur KDE, GTK & ICON theme'
echo '#################################################################'
sudo add-apt-repository -y ppa:papirus/papirus
# sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo apt update
sudo apt dist-upgrade
sudo apt -y install \
  qt5-style-kvantum qt5-style-kvantum-themes sassc libglib2.0-dev-bin \
  imagemagick dialog optipng x11-apps make extra-cmake-modules \
  qtdeclarative5-dev libqt5x11extras5-dev libx11-dev libkf5plasma-dev \
  libkf5iconthemes-dev  libkf5windowsystem-dev libkf5declarative-dev \
  libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev \
  gettext libkf5wayland-dev git libkf5archive-dev libkf5notifications-dev \
  libwayland-dev libxcb-util0-dev libsm-dev libkf5crash-dev kirigami2-dev \
  libkf5newstuff-dev libxcb-shape0-dev libxcb-randr0-dev libx11-xcb-dev \
  libqt5waylandclient5-dev libwayland-client0 plasma-wayland-protocols \
  qtwayland5-dev-tools
#   latte-dock

cd ~
git clone https://github.com/vinceliuice/grub2-themes.git
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/Monterey-kde.git
git clone https://github.com/vinceliuice/McMojave-kde.git
# git clone https://github.com/micheleg/dash-to-dock.git

sudo chmod +x ./grub2-themes/install.sh
sudo chmod +x ./WhiteSur-gtk-theme/install.sh
sudo chmod +x ./WhiteSur-gtk-theme/tweaks.sh
sudo chmod +x ./WhiteSur-icon-theme/install.sh
sudo chmod +x ./Monterey-kde/install.sh
sudo chmod +x ./McMojave-kde/sddm/install.sh

# make -C dash-to-dock install

sudo ./grub2-themes/install.sh -t whitesur -i whitesur -s 2k -b
./WhiteSur-gtk-theme/install.sh -o normal -c Dark -t all \
  -p 30 -m -N mojave -l --black --darker
./WhiteSur-icon-theme/install.sh -t default --alternative --bold
./WhiteSur-gtk-theme/tweaks.sh -o normal -c Dark -t blue \
  -b /mnt/Disk_D/CRYPTO/setup/Linux/theme/wallpaper/background.jpg
#    -g default
sudo ./McMojave-kde/sddm/install.sh
sudo ./Monterey-kde/install.sh
cd -
sudo cp -r ~/setup/Linux/theme/wallpaper/* /usr/share/backgrounds/
# wallpapers / backgrounds
sudo cp -r /mnt/Disk_D/CRYPTO/setup/Linux/theme/wallpaper/* /usr/share/wallpapers/
echo 'Install done'
echo '#################################################################'
echo 'Remove files'
echo '#################################################################'

sudo rm -rf ./grub2-themes
sudo rm -rf ./WhiteSur-gtk-theme
sudo rm -rf ./WhiteSur-icon-theme
sudo rm -rf ./dash-to-dock
sudo rm -rf ./McMojave-kde
sudo rm -rf ./Monterey-kde
sudo rm -rf ./_build
sudo rm -rf ./dist

cd /usr/share/icons
sudo rm -rf Humanity
sudo rm -rf Humanity-Dark
sudo rm -rf Oxygen_Black
sudo rm -rf Oxygen_Blue
sudo rm -rf Oxygen_White
sudo rm -rf Oxygen_Yellow
sudo rm -rf Oxygen_Zion
cd ~

echo '#################################################################'
echo 'Read'
echo '# https://www.linuxuprising.com/2020/10/whitesur-macos-big-sur-like-gtk-gnome.html'
echo '# https://www.youtube.com/watch?v=DX_gQTQLUZc'
echo 'Install Widgets'
echo '# Application Tittle, Plasma Drawer, tiled menu, latte spacer'
echo '# latte separator, Inline clock, big sur inline battery'
echo '#################################################################'
echo "Remove done"
echo '#################################################################'

# Widgets
# Application Tittle
# Plasma Drawer
# tiled menu
# latte spacer separator
# Inline clock
# big sur inline battery

# install Latte Dock
# sudo add-apt-repository ppa:kubuntu-ppa/backports
# sudo apt update
# sudo apt dist-upgrade
# sudo apt -y install \
#   cmake extra-cmake-modules qtdeclarative5-dev libqt5x11extras5-dev libx11-dev \
#   libkf5iconthemes-dev libkf5plasma-dev libkf5windowsystem-dev libkf5declarative-dev \
#   libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev gettext \
#   libkf5wayland-dev git libkf5archive-dev libkf5notifications-dev libwayland-dev  \
#   libxcb-util0-dev libsm-dev libkf5crash-dev libkf5newstuff-dev libxcb-shape0-dev \
#   libxcb-randr0-dev libx11-xcb-dev kirigami2-dev libqt5waylandclient5-dev \
#   libwayland-client0 plasma-wayland-protocols qtwayland5-dev-tools

# git clone https://github.com/KDE/latte-dock.git && \
#   chmod +x ./latte-dock/install.sh && \
#   sudo ./latte-dock/install.sh && rm -rf ./latte-dock

# https://www.pling.com/p/1399346

# sudo apt -y install gnome-tweaks gnome-shell-extensions && sudo gnome-tweaks
