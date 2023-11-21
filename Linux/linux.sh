echo Installing everything you need...\n

echo \nFirst update all packages
echo '######################################################################'\n

echo cdfecdfe | sudo -S sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoremove \
  && sudo apt -y autoclean \
  && sudo apt -y --fix-broken install \
  && sudo apt -y dist-upgrade

echo \nAll packages updated
echo '######################################################################'\n
echo \nInstall new usless packages
echo '######################################################################'\n

sudo apt install -y nodejs \
  mc \
  nano \
  linux-firmware \
  inxi \
  npm \
  curl \
  cpu-x \
  dpkg \
  gpg \
  software-properties-common \
  apt-transport-https \
  wget \
  make \
  build-essential \
  libssl-dev \
  libcurl4-gnutls-dev \
  libexpat1-dev \
  gettext \
  unzip \
  p7zip-rar \
  p7zip-full \
  rar \
  unrar \
  zip \
  nmon \
  nload \
  conmon \
  ca-certificates \
  gnupg \
  lsb-release \
  cmake \
  g++ \
  zlib1g-dev \
  hardinfo \
  hwinfo \
  ppa-purge \
  bash-completion \
  ubuntu-restricted-extras \
  clang \
  xz-utils \
  gcc-multilib \
  kate \
  sweeper \
  gparted \
  wireguard \
  network-manager \
  network-manager-vpnc \
  network-manager-gnome \
  net-tools \
  vlc
#   apache2 \
#   mysql-server \
#   nginx \
#   pavucontrol \  kubuntu-restricted-extras \


sudo systemctl daemon-reload
sudo dpkg --configure -a

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt -y update
sudo apt -y install grub-customizer

# wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo dpkg -i ./libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo apt -y --fix-broken install

echo \nAll new usless packages installed successfully
echo '######################################################################'\n
echo \nInstall programm
echo '######################################################################'\n

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
sudo rm microsoft.gpg
sudo rm -r /etc/apt/sources.list.d/microsoft-edge-dev.list
sudo apt -y update
sudo apt install -y microsoft-edge-stable

sudo dpkg -i powershell_7.3.4-1.deb_amd64.deb
sudo dpkg -i discord-0.0.35.deb
sudo apt -y --fix-broken install
sudo dpkg -i discord-0.0.35.deb
# sudo dpkg -i mucommander_1.1.0-1_amd64.deb
sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb

sudo add-apt-repository -y ppa:atareao/telegram
sudo apt -y update
sudo apt -y install telegram

sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm list-remote
nvm install lts/Iron
nvm list
sudo npm install -g npm@latest
nvm use v20.9.0
sudo npm i -g yarn \
  prettier \
  eslint \
  nodemon \
  create-react-app \
  serve

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt -y update
sudo apt -y install code
sudo apt -y --fix-broken install

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
sudo mkdir -p "$HOME"/.local/share/keyrings
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

echo \nInstalling wine
echo '######################################################################'\n

sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/lunar/winehq-lunar.sources
sudo apt -y update
sudo apt install -y --install-recommends winehq-stable

echo \nInstalling lutris
echo '######################################################################'\n

sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt -y update
sudo apt -y install lutris

echo \nInstalling Nvidia & other graphics drivers
echo '######################################################################'\n

# echo blacklist nouveau | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# echo options nouveau modeset=0 | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u

sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt -y update
sudo apt install -y nvidia-settings \
  libvulkan1 \
  libvulkan1:i386

sudo ubuntu-drivers list
sudo ubuntu-drivers install
# sudo ubuntu-drivers install nvidia:525

sudo chmod +x ./docker-install.sh
sudo ./docker-install.sh

echo \nInstalling Bluetooth Audio for AirPods
echo '######################################################################'\n

sudo apt -y install 'bluez*' blueman
modprobe btusb
sudo tee -a /etc/bluetooth/main.conf <<< \
"
ControllerMode = bredr
"
sudo /etc/init.d/bluetooth restart
sudo systemctl restart bluetooth

sudo add-apt-repository -y ppa:pipewire-debian/pipewire-upstream
sudo apt -y update
sudo apt -y install pulseaudio-utils \
  pipewire \
  pipewire-pulse \
  pipewire-tests \
  pipewire-locales \
  gstreamer1.0-pipewire \
  libspa-0.2-bluetooth \
  libspa-0.2-jack \
  pipewire-audio-client-libraries
sudo systemctl disable --global pulseaudio
sudo systemctl enable --global pipewire-pulse
pactl info | grep "Server Name"

echo \nAll programm installed
echo '######################################################################'\n

# sudo a2enmod rewrite
# sudo service mysql start
# sudo mysql -uroot -p

# SELECT user, authentication_string, plugin, host FROM mysql.user WHERE user="root";
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
# FLUSH PRIVILEGES;
# exit

# sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/testingme.ru.conf
#
# # sudo nano /etc/apache2/sites-available/testingme.ru.conf
# sudo bash -c \
# "cat << EOF > /etc/apache2/sites-available/testingme.ru.conf
# <VirtualHost *:80>
#         ServerAdmin webmaster@testingme.ru
#         ServerName testingme.ru
#         ServerAlias www.testingme.ru
#     DocumentRoot /mnt/d/CRYPTO/testingme.ru/build/
#     <Directory /mnt/d/CRYPTO/testingme.ru/build/>
#         Options Indexes FollowSymLinks
#         AllowOverride All
#         Require all granted
#     </Directory>
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>
# EOF"
#
# sudo service apache2 start
# sudo service mysql start
#
# sudo a2ensite testingme.ru.conf
# sudo systemctl reload apache2

echo \nSet autocomlete bash
echo '######################################################################'\n

sudo tee -a /etc/fstab <<< \
"
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>        <dump> <pass>
UUID=8A34B39934B3872B                     /mnt/Documents  ntfs   defaults,rw,realtime 0      0
UUID=9A34BC1034BBECFF                     /mnt/Windows    ntfs   defaults,ro          0      0
"

sudo tee -a /etc/inputrc <<< \
"
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward
"

sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoremove \
  && sudo apt -y autoclean

echo \n"Ended"

sudo reboot
# 127.0.0.1 testingme.ru
# sudo service apache2 stop
# sudo service mysql stop


# sudo dpkg -i virtualbox-7.0_7.0.8-156879~Ubuntu~jammy_amd64.deb
# sudo dpkg -i docker-desktop-4.16.1-amd64.deb
# sudo dpkg -i anydesk_6.2.1-1_amd64.deb
# sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb
