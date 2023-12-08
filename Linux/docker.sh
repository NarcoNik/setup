echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker-compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
#### Install DOCKER and setting him for work with NVIDIA in docker-compose
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian
# https://github.com/NVIDIA/nvidia-docker/issues/838
# https://yudanta.github.io/posts/nvidia-docker-and-docker-compose-enabled/

# First uninstall another version Docker
for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-compose docker-compose-v2 docker-ce-rootless-extras podman-docker containerd runc; do sudo apt -y remove --purge $pkg; done
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
sudo apt -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  gnupg-agent \
  software-properties-common \
  lsb-release \
  openssl \
  nginx
sudo apt -y clean

# Add Docker's official GPG key:
sudo rm -rf /etc/apt/trusted.gpg.d/docker.gpg
sudo rm -rf /etc/apt/trusted.gpg.d/*.gpg~
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo apt-key fingerprint 0EBFCD88

# Add the Docker repository to Apt sources:
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install docker & docker-compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
# # Add the Docker repository to Apt sources
# # Install docker & docker-compose
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh ./get-docker.sh # // --dry-run

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R

# Enabling docker services & restart systemctl
sudo systemctl enable --now docker docker.socket containerd
sudo systemctl restart docker

# wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.0-amd64.deb
# sudo apt -y remove --purge ./docker-desktop-4.26.0-amd64.deb
# sudo apt -y install ./docker-desktop-4.26.0-amd64.deb
# sudo systemctl start docker-desktop
# sudo rm -rf ./docker-desktop-4.26.0-amd64.deb

echo 'alias docker-compose="docker compose"' >> ~/.bashrc

docker-compose version
docker --version
docker version

# docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi

# sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# dockerd-rootless-setuptool.sh install --force
