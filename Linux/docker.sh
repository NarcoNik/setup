echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
#### Install DOCKER and setting him for work with NVIDIA in docker-compose
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian
# https://github.com/NVIDIA/nvidia-docker/issues/838
# https://yudanta.github.io/posts/nvidia-docker-and-docker-compose-enabled/

# First uninstall another version Docker
for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras podman-docker containerd containerd.io runc; do sudo apt -y remove --purge $pkg; done
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf ~/.docker
sudo rm -rf /usr/local/bin/com.docker.cli
cd /bin
sudo rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker \
  docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh \
  dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
cd -
sudo rm -rf /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-lunar.list
sudo rm -rf /etc/apt/sources.list.d/docker.list

modprobe kvm
modprobe kvm_intel  # Intel processors
modprobe kvm_amd    # AMD processors
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm $USER

# Update cash
sudo apt -y update
# Install another packages for using Docker
sudo apt -y install \
  ca-certificates \
  curl \
  gnupg \
  gnupg-agent \
  apt-transport-https \
  lsb-release \
  openssl \
  nginx \
  software-properties-common
sudo apt -y clean

sudo rm -rf /etc/apt/trusted.gpg.d/docker.gpg
# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo apt-key fingerprint 0EBFCD88

# Add the Docker repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu lunar stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker & docker-compose
sudo apt -y update
sudo apt -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose \
  docker-buildx-plugin

# # Add the Docker repository to Apt sources
# # Install docker & docker-compose
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh ./get-docker.sh # // --dry-run

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# exit
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R

wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.0-amd64.deb
sudo apt -y install ./docker-desktop-4.26.0-amd64.deb
sudo systemctl start docker-desktop
sudo rm -rf ./docker-desktop-4.26.0-amd64.deb

# Enabling docker services & restart systemctl
sudo systemctl enable --now \
  docker.service \
  docker.socket \
  containerd.service \
  docker-desktop
sudo systemctl daemon-reload

# Update & aupgrade all packages
sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove

docker-compose version
docker --version
docker version
# docker network create traefik-public

echo '#### Docker installed'
echo '######################################################################'
fi

# sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# dockerd-rootless-setuptool.sh install --force
