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
wget https://dl.discordapp.net/apps/linux/0.0.39/discord-0.0.39.deb
# Install the Discord package
sudo dpkg -i discord-0.0.39.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt install -f
# Delete the downloaded package file
sudo rm -rf discord-0.0.39.deb

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

# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# sudo apt -y update
# sudo apt -y install google-chrome-stable

# # Download the RemixIDE package file
# wget https://github.com/ethereum/remix-desktop/releases/download/v1.3.6/remix-ide_1.3.6_amd64.deb
# # Install the RemixIDE package
# sudo dpkg -i remix-ide_1.3.6_amd64.deb
# # Resolve missing dependencies and finish the install (if necessary)
# sudo apt install -f
# # Delete the downloaded package file
# sudo rm -rf remix-ide_1.3.6_amd64.deb

sudo add-apt-repository -y ppa:atareao/telegram
sudo apt -y update
sudo apt -y install telegram

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm ls-remote
nvm install v18.12.0
nvm install v14.15.1
nvm ls
nvm use v18.12.0

# sudo gpasswd -a $USER npm
# sudo usermod -aG npm $USER
sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R

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
sudo apt install -y

sudo apt install -y \
   nvidia-settings \
   libvulkan1 \
   pkg-config \
   linux-headers-$(uname -r)
sudo apt-cache policy linux-headers-$(uname -r)
ubuntu-drivers list --gpgpu
sudo ubuntu-drivers install nvidia:535

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
# sudo dpkg -i cuda-keyring_1.1-1_all.deb
# sudo apt -y install cuda-drivers
# sudo rm -f cuda-keyring_1.1-1_all.deb

# wget https://us.download.nvidia.com/XFree86/Linux-x86_64/535.146.02/NVIDIA-Linux-x86_64-535.146.02.run
# sudo sh NVIDIA-Linux-x86_64-535.146.02.run
# rm -rf NVIDIA-Linux-x86_64-535.146.02.run
# sudo update-initramfs -u

nvidia-smi

echo '######################################################################'

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
sudo apt -y install pulseaudio-utils \
  pipewire \
  pipewire-pulse \
  pipewire-tests \
  gstreamer1.0-pipewire \
  libspa-0.2-bluetooth \
  libspa-0.2-jack \
  pipewire-audio-client-libraries
sudo systemctl disable --global pulseaudio
sudo systemctl enable --global pipewire-pulse
pactl info | grep "Server Name"

# echo '######################################################################'

# echo 'Installing Wine & Safari'
# echo '######################################################################'
# cd ~
# sudo dpkg --add-architecture i386
# sudo mkdir -pm755 /etc/apt/keyrings
# sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
# sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/lunar/winehq-lunar.sources
# sudo apt update
# sudo apt install --install-recommends winehq-stable

# mkdir -p ~/build/safari
# cd ~/build/safari

# wget http://appldnld.apple.com/Safari5/041-5487.20120509.INU8B/SafariSetup.exe
# wine SafariSetup.exe

# echo "deb [trusted=yes] https://apt.fury.io/kurtosis-tech/ /" | sudo tee /etc/apt/sources.list.d/kurtosis.list
# sudo apt update
# sudo apt install kurtosis-cli

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
# # blacklist nouveau | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# # options nouveau modeset=0 | tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo update-initramfs -u
# ubuntu-drivers list
# sudo ubuntu-drivers install

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nvidia-driver-545_545.23.08-0ubuntu1_amd64.deb
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nvidia-dkms-545_545.23.08-0ubuntu1_amd64.deb


# sudo apt install nvidia-driver-535 nvidia-driver-535-server nvidia-dkms-535
# wget https://us.download.nvidia.com/XFree86/Linux-x86_64/535.146.02/NVIDIA-Linux-x86_64-535.146.02.run
# sudo sh NVIDIA-Linux-x86_64-535.146.02.run
# rm -rf NVIDIA-Linux-x86_64-535.146.02.run



# lspci | grep -i nvidia
# sudo apt -y install linux-headers-$(uname -r)
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
# sudo dpkg -i cuda-keyring_1.1-1_all.deb
# sudo apt update

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-archive-keyring.gpg
# sudo install -D -o root -g root -m 644 cuda-archive-keyring.gpg /etc/apt/trusted.gpg.d/cuda-archive-keyring.gpg
# echo "deb [signed-by=/etc/apt/trusted.gpg.d/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda-ubuntu2204-x86_64.list

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
# sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600

# sudo apt -y install cuda-drivers
# rm -rf cuda-keyring_1.1-1_all.deb
# rm -rf cuda-archive-keyring.gpg




# sudo apt install nvidia-driver-470 nvidia-dkms-470
# wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.223.02/NVIDIA-Linux-x86_64-470.223.02.run
# sudo sh NVIDIA-Linux-x86_64-470.223.02.run
# rm -rf NVIDIA-Linux-x86_64-470.223.02.run
