echo 'Install programm'
echo '######################################################################'

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt -y update
sudo apt -y install grub-customizer

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# sudo sh -c '# "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
sudo echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
sudo rm -rf microsoft.gpg
# sudo rm -rf /etc/apt/sources.list.d/microsoft-edge-dev.list
sudo apt -y update
sudo apt -y install microsoft-edge-stable

# Download the PowerShell package file
wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
# Install the PowerShell package
sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb

sudo apt -y --fix-broken install

# Download the PowerShell package file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
# Install the PowerShell package
sudo dpkg -i powershell_7.4.0-1.deb_amd64.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf powershell_7.4.0-1.deb_amd64.deb

# Download the Discord package file
wget https://dl.discordapp.net/apps/linux/0.0.36/discord-0.0.36.deb
# Install the Discord package
sudo dpkg -i discord-0.0.36.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf discord-0.0.36.deb

sudo apt -y --fix-broken install

# Download the GitHub Desktop package file
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
# Install the GitHub Desktop package
sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf GitHubDesktop-linux-3.1.1-linux1.deb

# Download the AnyDesk package file
wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
# Install the AnyDesk package
sudo dpkg -i anydesk_6.1.1-1_amd64.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf anydesk_6.1.1-1_amd64.deb
sudo systemctl daemon-reload

sudo add-apt-repository -y ppa:atareao/telegram
sudo apt -y update
sudo apt -y install telegram

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm ls-remote
nvm install lts/iron
nvm ls
nvm use lts/iron
nvm install-latest-npm

nvm install v18.12.0
nvm use v18.12.0
nvm install-latest-npm

nvm install v14.15.1
nvm use v14.15.1
nvm install-latest-npm

sudo gpasswd -a $USER npm
sudo usermod -aG npm $USER
sudo chown "$USER":"$USER" ~/.npm -R

npm i -g yarn \
  prettier \
  eslint \
  nodemon \
  serve \
  dotenv \
  create-react-app

sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt -y update
sudo apt -y install solc ethereum

# TODO for deleting nodejs
# sudo apt remove --purge nodejs npm
# sudo rm -rf /etc/apt/sources.list.d/nodesource.list
# sudo rm -rf /etc/apt/trusted.gpg.d/nodesource.gpg

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/packages.microsoft.gpg
sudo echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo rm -f packages.microsoft.gpg

sudo apt -y update
sudo apt -y install code
sudo apt -y --fix-broken install

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p "$HOME"/.local/share/trusted.gpg.d
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

echo 'Installing Nvidia & other graphics drivers'
echo '######################################################################'
# # blacklist nouveau | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# # options nouveau modeset=0 | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u

sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt -y update
sudo apt install -y nvidia-settings libvulkan1
ubuntu-drivers list
sudo ubuntu-drivers install
sudo apt -y install linux-headers-$(uname -r)

echo 'Installing Bluetooth Audio for AirPods'
echo '######################################################################'
sudo apt -y install 'bluez*' blueman
modprobe btusb
sudo tee -a /etc/bluetooth/main.conf <<< \
"
AutoEnable=true

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

# echo "deb [trusted=yes] https://apt.fury.io/kurtosis-tech/ /" | sudo tee /etc/apt/sources.list.d/kurtosis.list
# sudo apt update
# sudo apt install kurtosis-cli

echo 'All programm installed'
echo '######################################################################'
