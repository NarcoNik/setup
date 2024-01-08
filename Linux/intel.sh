echo '#### Installing Intel gpu drivers'
echo '#################################################################'
# https://www.intel.com/content/www/us/en/download/747008/intel-arc-graphics-driver-ubuntu.html
wget -qO - https://repositories.intel.com/gpu/intel-graphics.key | \
  sudo gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg
echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu jammy client" | \
  sudo tee /etc/apt/sources.list.d/intel-gpu-jammy.list

sudo apt -y update && \
  sudo apt -y upgrade && \
  sudo apt -y autoremove --purge && \
  sudo apt -y autoclean && \
  sudo apt -y --fix-broken install

sudo apt -y install \
  intel-opencl-icd intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1 libmfxgen1 libvpl2 \
  libegl-mesa0 libegl1-mesa libegl1-mesa-dev libgbm1 libgl1-mesa-dev libgl1-mesa-dri \
  libglapi-mesa libgles2-mesa-dev libglx-mesa0 libigdgmm12 libxatracker2 mesa-va-drivers \
  mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vainfo hwinfo clinfo

sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install \
  udev mesa-va-drivers:i386 mesa-common-dev:i386 mesa-vulkan-drivers:i386 \
  libd3dadapter9-mesa-dev:i386 libegl1-mesa:i386 libegl1-mesa-dev:i386 \
  libgbm-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev:i386 \
  libgles2-mesa:i386 libgles2-mesa-dev:i386 libosmesa6:i386 \
  libosmesa6-dev:i386 libwayland-egl1-mesa:i386 libxatracker2:i386 \
  libxatracker-dev:i386 mesa-vdpau-drivers:i386 libva-x11-2:i386

sudo apt -y install \
  libigc-dev intel-igc-cm libigdfcl-dev level-zero-dev libigfxcmrt-dev \
  level-zero-dev gawk dkms linux-headers-$(uname -r) libc6-dev intel-fw-gpu
#   intel-fw-gpu intel-platform-vsec-dkms intel-platform-cse-dkms
echo '#################################################################'
