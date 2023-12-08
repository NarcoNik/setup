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

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/trusted.gpg.d
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
sudo chmod a+r /etc/apt/trusted.gpg.d/docker.gpg
sudo apt-key fingerprint 0EBFCD88

# Add the Docker repository to Apt sources:
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

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
