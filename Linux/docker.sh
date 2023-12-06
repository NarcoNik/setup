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
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt -y remove $pkg; done
sudo apt -y remove --purge \
  docker docker.io \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  containerd \
  docker-buildx-plugin \
  docker-compose-plugin \
  runc \
  docker-ce-rootless-extras \
  docker-compose
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf ~/.docker
sudo rm -rf /usr/local/bin/com.docker.cli
cd /bin
sudo rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker \
  docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh \
  dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
cd -

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

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# exit
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R

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
