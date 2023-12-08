echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker-compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
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
  lsb-release \
  openssl \
  nginx
sudo apt -y clean

# # Add the Docker repository to Apt sources
# # Install docker & docker-compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh # // --dry-run

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R

# Enabling docker services & restart systemctl
sudo systemctl enable --now docker docker.socket containerd
sudo systemctl restart docker
# echo 'alias docker-compose="docker compose"' >> ~/.bashrc
# docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi

# sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# dockerd-rootless-setuptool.sh install --force
