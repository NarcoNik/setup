sudo apt-get install linux-headers-$(uname -r)
sudo apt-key del 7fa2af80

# sudo apt install nvidia-driver-535 nvidia-dkms-535
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/535.146.02/NVIDIA-Linux-x86_64-535.146.02.run
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-3 nvidia-gds nvidia-kernel-open-535 \
  cuda-drivers cuda-drivers-535

sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf <<<
"
blacklist nouveau
options nouveau modeset=0"

sudo update-initramfs -u
sudo reboot
sudo sh NVIDIA-Linux-x86_64-535.146.02.run
rm -rf NVIDIA-Linux-x86_64-535.146.02.run

sudo nvidia-xconfig
export PATH=/usr/local/cuda-12.3/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

systemctl status nvidia-persistenced
sudo systemctl enable nvidia-persistenced
/lib/udev/rules.d/40-vm-hotadd.rules
/usr/bin/nvidia-persistenced --verbose
cat /proc/driver/nvidia/version
setenforce 0

sudo apt-get install -y g++ freeglut3-dev build-essential libx11-dev \
    libxmu-dev libxi-dev libglu1-mesa-dev libfreeimage-dev libglfw3-dev

update-alternatives --display cuda
sudo update-alternatives --config cuda
sudo add-apt-repository ppa:bumblebee/stable
sudo apt-get update
sudo apt-get install --no-install-recommends bumblebee

# Error running 32-bit applications on a 64-bit system
apt-cache policy libgl1-mesa-glx:i386
sudo apt-get install --reinstall bumblebee-nvidia
sudo update-alternatives --config i386-linux-gnu_gl_conf
sudo ldconfig
