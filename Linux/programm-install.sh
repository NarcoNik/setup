echo '\nInstall programm'
echo '######################################################################\n'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
rm microsoft.gpg
rm -rf /etc/apt/sources.list.d/microsoft-edge-dev.list
apt -y update
apt install -y microsoft-edge-stable

# Download the PowerShell package file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
# Install the PowerShell package
sudo dpkg -i powershell_7.4.0-1.deb_amd64.deb
# Resolve missing dependencies and finish the install (if necessary)
apt install -f
# Delete the downloaded package file
rm powershell_7.4.0-1.deb_amd64.deb

# Download the Discord package file
wget https://dl.discordapp.net/apps/linux/0.0.36/discord-0.0.36.deb
# Install the Discord package
sudo dpkg -i discord-0.0.36.deb
# Resolve missing dependencies and finish the install (if necessary)
apt install -f
# Delete the downloaded package file
rm discord-0.0.36.deb

apt -y --fix-broken install

# Download the Discord package file
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
# Install the Discord package
sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb
# Resolve missing dependencies and finish the install (if necessary)
apt install -f
# Delete the downloaded package file
rm GitHubDesktop-linux-3.1.1-linux1.deb


add-apt-repository -y ppa:atareao/telegram
apt -y update
apt -y install telegram

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm list-remote
nvm install lts/iron
nvm list
npm install -g npm@latest
nvm use lts/iron
npm i -g yarn \
  prettier \
  eslint \
  nodemon \
  solc \
  serve \
  create-react-app

groupadd npm
usermod -aG npm $USER
newgrp npm
npm --version

add-apt-repository -y ppa:ethereum/ethereum
apt -y update
apt -y install solc

# TODO for deleting nodejs
# apt remove --purge nodejs npm
# rm -rf /etc/apt/sources.list.d/nodesource.list
# rm -rf /etc/apt/keyrings/nodesource.gpg

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt -y update
apt -y install code
apt -y --fix-broken install

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p "$HOME"/.local/share/keyrings
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

echo '\nInstalling Nvidia & other graphics drivers'
echo '######################################################################\n'
# echo blacklist nouveau | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# echo options nouveau modeset=0 | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
update-initramfs -u

add-apt-repository -y ppa:graphics-drivers/ppa
apt -y update
apt install -y nvidia-settings libvulkan1
ubuntu-drivers list
ubuntu-drivers install

echo '\nInstalling Bluetooth Audio for AirPods'
echo '######################################################################\n'
apt -y install 'bluez*' blueman
modprobe btusb
tee -a /etc/bluetooth/main.conf <<< \
"
AutoEnable=true

ControllerMode = bredr
"
/etc/init.d/bluetooth restart
systemctl restart bluetooth

add-apt-repository -y ppa:pipewire-debian/pipewire-upstream
apt -y update
apt -y install pulseaudio-utils \
  pipewire \
  pipewire-pulse \
  pipewire-tests \
  pipewire-locales \
  gstreamer1.0-pipewire \
  libspa-0.2-bluetooth \
  libspa-0.2-jack \
  pipewire-audio-client-libraries
systemctl disable --global pulseaudio
systemctl enable --global pipewire-pulse
pactl info | grep "Server Name"

echo '\nAll programm installed'
echo '######################################################################\n'
