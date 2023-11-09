echo Installing everything you need...

echo "update all packages"
echo "####################################################################################"

echo cdfecdfe | sudo -S sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoremove \
  && sudo apt -y autoclean \
  && sudo apt -y --fix-broken install \
  && sudo apt -y dist-upgrade

echo "All packages updated"
echo "####################################################################################"

echo "Install new usless packages"
echo "####################################################################################"

sudo apt install -y nodejs \
  mc \
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
  unzip \
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
  apache2 \
  mysql-server \
  nginx \
  vim \
  kate \
  sweeper \
  gparted \
  pavucontrol \
  wireguard \
  network-manager \
  network-manager-vpnc \
  network-manager-gnome \
  net-tools \
  kubuntu-restricted-extras \
  vlc

sudo a2enmod rewrite

sudo systemctl daemon-reload
sudo dpkg --configure -a

sudo service mysql start
sudo mysql -uroot -p

SELECT user, authentication_string, plugin, host FROM mysql.user WHERE user="root";
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
exit

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo bash -c \
"cat << EOF > /etc/apt/sources.list.d/danielrichter2007-ubuntu-grub-customizer-jammy.list
deb https://ppa.launchpadcontent.net/danielrichter2007/grub-customizer/ubuntu/ jammy main
# deb-src https://ppa.launchpadcontent.net/danielrichter2007/grub-customizer/ubuntu/ jammy main
EOF" \
  && sudo apt -y update \
  && sudo apt -y install grub-customizer
# wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo apt -y --fix-broken install

echo "All new usless packages installed successfully"
echo "####################################################################################"

echo "Install programm"
echo "####################################################################################"

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
sudo rm microsoft.gpg
sudo rm -r /etc/apt/sources.list.d/microsoft-edge-dev.list
sudo apt update \
  && sudo apt install microsoft-edge-stable

sudo dpkg -i powershell_7.3.4-1.deb_amd64.deb
sudo dpkg -i discord-0.0.24.deb
sudo dpkg -i mucommander_1.1.0-1_amd64.deb
sudo apt -y update && sudo apt -y upgrade

sudo add-apt-repository -y ppa:atareao/telegram
sudo apt -y update && sudo apt -y install telegram

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm list-remote
nvm install lts/Iron
nvm list
npm install -g npm@latest
nvm use v20.9.0
npm i -g yarn \
  prettier \
  eslint \
  nodemon \
  serve \
  eslint-plugin-simple-import-sort \
  eslint-plugin-import prettier \
  eslint-plugin-unused-imports \
  eslint-plugin-prettier \
  eslint-plugin-html \
  eslint-config-airbnb-base \
  eslint-config-prettier

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update \
  && sudo apt install code
sudo apt -y --fix-broken install

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
sudo mkdir -p "$HOME"/.local/share/keyrings
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

echo "All programm installed"
echo "####################################################################################"

echo "Set autocomlete bash"
echo "####################################################################################"

echo "kate /etc/inputrc
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward"
echo "Ended"

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/testingme.ru.conf

# sudo nano /etc/apache2/sites-available/testingme.ru.conf
sudo bash -c \
"cat << EOF > /etc/apache2/sites-available/testingme.ru.conf
<VirtualHost *:80>
        ServerAdmin webmaster@testingme.ru
        ServerName testingme.ru
        ServerAlias www.testingme.ru
    DocumentRoot /mnt/d/CRYPTO/testingme.ru/build/
    <Directory /mnt/d/CRYPTO/testingme.ru/build/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

sudo service apache2 start
sudo service mysql start

sudo a2ensite testingme.ru.conf
sudo systemctl reload apache2
# 127.0.0.1 testingme.ru

# sudo service apache2 stop
# sudo service mysql stop


# sudo dpkg -i virtualbox-7.0_7.0.8-156879~Ubuntu~jammy_amd64.deb
# sudo dpkg -i docker-desktop-4.16.1-amd64.deb
# sudo dpkg -i anydesk_6.2.1-1_amd64.deb
# sudo dpkg -i discord-0.0.24.deb
# sudo dpkg -i docker-desktop-4.16.1-amd64.deb
# sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb
