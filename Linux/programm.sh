echo 'Install programm'
echo '######################################################################'

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt -y update
sudo apt -y install grub-customizer telegram solc ethereum

sudo apt -y install flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.usebottles.bottles net.rpcs3.RPCS3 \
  com.heroicgameslauncher.hgl com.playonlinux.PlayOnLinux4 tv.kodi.Kodi \
  org.videolan.VLC net.lutris.Lutris com.discordapp.Discord com.microsoft.Edge \
  com.valvesoftware.Steam com.visualstudio.code io.github.mimbrero.WhatsAppDesktop\
  org.gimp.GIMP com.anydesk.Anydesk org.kde.krita com.github.wwmm.easyeffects \
  com.github.wwmm.pulseeffects org.gnome.Maps org.libreoffice.LibreOffice \
  io.github.shiftey.Desktop

flatpak update
flatpak upgrade
flatpak list

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p "$HOME"/.local/share/trusted.gpg.d
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

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

echo 'Installing Wine'
echo '######################################################################'
sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu lunar main" | \
  sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null
sudo apt -y update
sudo apt -y install --install-recommends winehq-stable
# wine winecfg
# wine clock

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


# sudo apt install nvidia-driver-535 nvidia-dkms-535



# sudo apt install nvidia-driver-470 nvidia-dkms-470
# wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.223.02/NVIDIA-Linux-x86_64-470.223.02.run
# sudo sh NVIDIA-Linux-x86_64-470.223.02.run
# rm -rf NVIDIA-Linux-x86_64-470.223.02.run
