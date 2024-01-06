echo 'Install programm'
echo '######################################################################'

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt -y update
sudo apt -y install grub-customizer solc ethereum telegram

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# sudo sh -c '# "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
sudo echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
sudo rm -rf microsoft.gpg
# sudo rm -rf /etc/apt/sources.list.d/microsoft-edge-dev.list
sudo apt -y update
sudo apt -y install microsoft-edge-stable
sudo apt -y --fix-broken install

# Download the packages file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
wget https://dl.discordapp.net/apps/linux/0.0.39/discord-0.0.39.deb
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb

sudo chmod +x ./powershell_7.4.0-1.deb_amd64.deb ./discord-0.0.39.deb \
  ./GitHubDesktop-linux-3.1.1-linux1.deb ./anydesk_6.1.1-1_amd64.deb

sudo apt -y install ./powershell_7.4.0-1.deb_amd64.deb ./discord-0.0.39.deb \
  ./GitHubDesktop-linux-3.1.1-linux1.deb ./anydesk_6.1.1-1_amd64.deb

sudo apt -y --fix-broken install
sudo apt install -f
sudo systemctl daemon-reload

sudo rm -rf powershell_7.4.0-1.deb_amd64.deb
sudo rm -rf discord-0.0.39.deb
sudo rm -rf GitHubDesktop-linux-3.1.1-linux1.deb
sudo rm -rf anydesk_6.1.1-1_amd64.deb

# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# sudo apt -y update
# sudo apt -y install google-chrome-stable

# TODO for deleting nodejs
# sudo apt remove --purge nodejs npm
# sudo rm -rf /etc/apt/sources.list.d/nodesource.list
# sudo rm -rf /etc/apt/trusted.gpg.d/nodesource.gpg

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm ls-remote
nvm install v18.12.0
nvm install v14.15.1
nvm ls
nvm use v18.12.0
sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
npm i -g yarn prettier eslint nodemon serve dotenv create-react-app

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
sudo add-apt-repository ppa:graphics-drivers/ppa && \
  sudo dpkg --add-architecture i386 && \
  sudo apt -y update && \
  sudo apt -y install nvidia-driver-535 nvidia-dkms-535 nvidia-settings \
  build-essential libvulkan1 libvulkan1:i386
# nvidia-smi

echo 'Installing Bluetooth Audio for AirPods'
echo '######################################################################'
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
sudo apt -y install pulseaudio-utils pipewire pipewire-pulse \
  pipewire-tests gstreamer1.0-pipewire libspa-0.2-bluetooth \
  libspa-0.2-jack pipewire-audio-client-libraries
sudo systemctl disable --global pulseaudio
sudo systemctl enable --global pipewire-pulse
pactl info | grep "Server Name"

echo 'Installing Wine'
echo '######################################################################'
sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu lunar main" | \
  sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt -y update
sudo apt -y install --install-recommends winehq-stable
# wine winecfg
# wine clock

sudo apt -y install flatpak gnome-software-plugin-flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

wget https://github.com/lutris/lutris/releases/download/v0.5.14/lutris_0.5.14_all.deb
sudo dpkg -i lutris_0.5.14_all.deb
sudo apt install -f
sudo rm -f lutris_0.5.14_all.deb

echo 'All programm installed'
echo '######################################################################'





# sudo apt -y remove --purge nvidia-*
# sudo apt -y remove --purge libnvidia-*
# sudo rm /etc/X11/xorg.conf
# sudo rm /etc/modprobe.d/nvidia.conf
# sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo rm /etc/systemd/system/nvidia-persistenced.service
# echo 'nouveau' | sudo tee -a /etc/modules

# echo 'Installing Nvidia & other graphics drivers'
# echo '######################################################################'

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nvidia-driver-545_545.23.08-0ubuntu1_amd64.deb
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nvidia-dkms-545_545.23.08-0ubuntu1_amd64.deb

# sudo apt install nvidia-driver-470 nvidia-dkms-470
# wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.223.02/NVIDIA-Linux-x86_64-470.223.02.run
# sudo sh NVIDIA-Linux-x86_64-470.223.02.run
# rm -rf NVIDIA-Linux-x86_64-470.223.02.run
