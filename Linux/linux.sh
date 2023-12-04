echo 'Installing everything you need...\n'

echo '\nFirst update all packages'
echo '######################################################################\n'

# echo cdfecdfe | sudo -S
apt -y update \
  && apt -y upgrade \
  && apt -y autoremove \
  && apt -y autoclean \
  && apt -y --fix-broken install \
  && apt -y dist-upgrade

echo '\nAll packages updated'
echo '######################################################################\n'
echo '\nInstall new usless packages'
echo '######################################################################\n'

apt install -y nodejs \
  npm \
  nano \
  mc \
  linux-firmware \
  inxi \
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

systemctl daemon-reload
dpkg --configure -a

add-apt-repository -y ppa:danielrichter2007/grub-customizer
apt -y update
apt -y install grub-customizer

# wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
dpkg -i ./libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
apt -y --fix-broken install

echo '\nAll new usless packages installed successfully'
echo '######################################################################\n'
chmod 755 ./programm-install.sh
./programm-install.sh

chmod 755 ./docker-install.sh
./docker-install.sh

chmod 755 ./python-install.sh
./python-install.sh

echo '\nSet autocomlete bash'
echo '######################################################################\n'

# sudo tee -a /etc/fstab <<< \
# "
# # UUID=<uuid>                             <mount point> <FSType> <FSOptions>        <dump> <pass>
# UUID=8A34B39934B3872B                     /mnt/Documents  ntfs   defaults,rw,realtime 0      0
# UUID=9A34BC1034BBECFF                     /mnt/Windows    ntfs   defaults,ro          0      0
# "

# sudo tee -a /etc/inputrc <<< \
# "
# # paste after all text
# set show-all-if-ambiguous On
# "\e[A": history-search-backward
# "\e[B": history-search-forward
# "

apt -y update \
  && apt -y upgrade \
  && apt -y autoremove \
  && apt -y autoclean

echo '\nEnded'

# sudo reboot
# 127.0.0.1 testingme.ru
# sudo service apache2 stop
# sudo service mysql stop


# sudo dpkg -i virtualbox-7.0_7.0.8-156879~Ubuntu~jammy_amd64.deb
# sudo dpkg -i docker-desktop-4.16.1-amd64.deb
# sudo dpkg -i anydesk_6.2.1-1_amd64.deb
# sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb


#   apache2 \
#   mysql-server \
#   nginx \


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


# sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh
# sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
# source ~/.bashrc
# nvm list-remote
# nvm install stable
# nvm list
# npm install -g npm@latest
# nvm use stable
# npm i -g yarn \
#   prettier \
#   eslint \
#   nodemon \
#   serve \
#   create-react-app


# ganache
# sudo apt -y update \
#   && apt -y upgrade \
#   && apt -y install wget \
#   libgtk-3-dev \
#   libfuse-dev \
#   libgtkextra-dev \
#   libgconf2-dev \
#   libnss3 libasound2 \
#   libxtst-dev \
#   libxss1 \
#   libx11-6 \
#   libx11-xcb-dev
# wget https://github.com/trufflesuite/ganache-ui/releases/download/v2.7.1/ganache-2.7.1-linux-x86_64.AppImage
# chmod a+x ganache-2.7.1-linux-x86_64.AppImage
# ./ganache-2.7.1-linux-x86_64.AppImage
