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
sudo apt remove --purge \
  docker \
  docker.io \
  containerd \
  runc \
  docker-compose
sudo apt remove --purge \
  docker \
  docker.io \
  containerd \
  runc
# Update cash
sudo apt -y update
# Install another packages for using Docker
sudo apt -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  gnupg \
  lsb-release \
  openssl \
  nginx \
  software-properties-common
# Get trusted gpg key for Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo apt-key fingerprint 0EBFCD88
# Add Docker repositories
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Install docker & docker-compose
sudo apt -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose
# Add all rules for docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
exit
sudo chown "$USER":"$USER" ~/.docker -R
# Enabling docker services & restart systemctl
sudo systemctl enable --now \
  docker.service \
  docker.socket \
  containerd.service
sudo systemctl daemon-reload
# Update & aupgrade all packages
sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove

# docker network create traefik-public

echo '#### Docker installed'
echo '######################################################################'
fi






# sudo apt -y install \
#   ca-certificates \
#   curl \
#   gnupg \
#   lsb-release \
#   nginx \
#   openssl
# sudo apt -y clean
# sudo rm -rf /var/lib/apt/lists/*
# sudo mkdir -p /etc/apt/keyrings

# # Add Docker's official GPG key:
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg

# # Add the repository to Apt sources:
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# sudo apt -y update
# sudo apt -y install \
#   docker-ce \
#   docker-ce-cli \
#   containerd.io \
#   docker-buildx-plugin \
#   docker-compose-plugin

# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# exit
# docker compose version

# sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# dockerd-rootless-setuptool.sh install --force
