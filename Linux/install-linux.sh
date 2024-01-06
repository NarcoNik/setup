echo 'Installing everything you need...'

echo 'First update all packages'
echo '######################################################################'

sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove
sudo apt -y --fix-broken install
  # && sudo apt -y dist-upgrade
sudo timedatectl set-local-rtc 1

echo 'All packages updated'
echo '######################################################################'
echo 'Install new usless packages'
echo '######################################################################'

sudo apt install -y nodejs npm nano openssh-client inxi curl zip \
  cpu-x dpkg gpg software-properties-common rar unrar nmon cmake \
  apt-transport-https wget make build-essential libssl-dev unzip \
  p7zip-full nload wireguard gparted sweeper conmon ca-certificates \
  gnupg lsb-release g++ hardinfo hwinfo gcc-multilib p7zip-rar \
  ppa-purge bash-completion ubuntu-restricted-extras clang xz-utils \
  network-manager network-manager-vpnc network-manager-gnome net-tools \
  snap snapd
sudo systemctl daemon-reload
sudo dpkg --configure -a
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

echo 'All new useless packages installed successfully'
echo '######################################################################'
sudo chmod +x ./git.sh
./git.sh
sudo chmod +x ./programm.sh
./programm.sh
# sudo chmod +x ./python3.sh
# ./python3.sh
sudo chmod +x ./docker.sh
./docker.sh

echo 'Set autocomlete bash'
echo '######################################################################'
sudo tee -a /etc/inputrc <<< \
"
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward"

sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove
sudo apt -y autoclean
gpg --generate-key
echo 'pass init 35E637FD3D4AF581E338DBC11D3E110D4315F230
systemctl --user start docker-desktop'
curl -L https://foundry.paradigm.xyz | bash
echo 'Ended'

# search package name
# dpkg -l | grep name


# sudo reboot
# 127.0.0.1 testingme.ru
# sudo service apache2 stop
# sudo service mysql stop


#   apache2
#   mysql-server
#   nginx


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
# sudo sudo apt -y update
# sudo apt -y upgrade
# sudo apt -y install wget \
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
