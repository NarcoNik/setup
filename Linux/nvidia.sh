echo 'Installing Nvidia & other graphics drivers'
echo '#################################################################'
sudo add-apt-repository ppa:graphics-drivers/ppa && \
  sudo dpkg --add-architecture i386 && \
  sudo apt -y update

sudo apt reinstall xserver-xorg-video-nouveau
sudo apt -y install linux-headers-$(uname -r) gcc make acpid dkms \
  libglvnd-core-dev libglvnd0 libglvnd-dev libc-dev freeglut3-dev \
  libx11-dev libxmu-dev libxi-dev libglu1-mesa-dev libfreeimage-dev \
  libglfw3-dev
sudo apt-key del 7fa2af80
sudo apt -y install cuda
sudo apt -y install nvidia-driver-545 nvidia-dkms-545 nvidia-settings \
  libvulkan1 libvulkan1:i386

systemctl status nvidia-persistenced
sudo systemctl enable nvidia-persistenced
cat /proc/driver/nvidia/version

update-alternatives --display cuda
sudo update-alternatives --config cuda
# sudo add-apt-repository ppa:bumblebee/stable
# sudo apt update
# sudo apt install --no-install-recommends bumblebee

# Error running 32-bit applications on a 64-bit system
# apt-cache policy libgl1-mesa-glx:i386
# sudo apt install --reinstall bumblebee-nvidia
# sudo update-alternatives --config i386-linux-gnu_gl_conf
# sudo ldconfig

# nvidia-smi

# For remove all nvidia drivers
# sudo apt -y remove --purge nvidia-*
# sudo apt -y remove --purge libnvidia-*
# sudo rm /etc/X11/xorg.conf
# sudo rm /etc/modprobe.d/nvidia.conf
# sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo rm /etc/systemd/system/nvidia-persistenced.service
# echo 'nouveau' | sudo tee -a /etc/modules
