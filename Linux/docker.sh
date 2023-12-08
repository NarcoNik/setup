echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
# First uninstall another version Docker
sudo apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt -y update
sudo apt -y install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  nginx \
  openssl \
  && sudo apt -y clean \
  && sudo rm -rf /var/lib/apt/lists/* \
  && sudo mkdir -p /etc/apt/keyrings

# curl https://get.docker.com | sh
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Install docker & docker-compose
sudo apt -y update
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R
# Enabling docker services & restart systemctl
sudo systemctl restart docker
docker-compose version
docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi


# echo '#### Installing Docker'
# echo '######################################################################'
# if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
#    echo 'Docker installed, continue...'
# else
# echo 'Docker NOT installed, continue...'
# # First uninstall another version Docker
# for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt -y remove --purge $pkg; done
# sudo rm -rf /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-lunar.list
# sudo rm -rf /etc/apt/sources.list.d/docker.list
# sudo rm -rf /var/lib/docker
# sudo rm -rf /var/lib/containerd
# sudo rm -rf ~/.docker
# sudo rm -rf /usr/local/bin/com.docker.cli
# cd /bin
# sudo rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker \
#   docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh \
#   dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
# cd -

# modprobe kvm
# modprobe kvm_intel  # Intel processors
# modprobe kvm_amd    # AMD processors
# kvm-ok
# lsmod | grep kvm
# ls -al /dev/kvm
# sudo usermod -aG kvm $USER

# sudo apt -y update \
#   && sudo apt -y upgrade \
#   && sudo apt -y autoremove \
#   && sudo apt -y autoclean

# sudo apt -y install \
#   apt-transport-https \
#   ca-certificates \
#   curl \
#   gnupg \
#   gnupg-agent \
#   software-properties-common \
#   lsb-release \
#   openssl \
#   nginx
# sudo apt -y clean

# # Add Docker's official GPG key:
# sudo rm -rf /etc/apt/trusted.gpg.d/docker.gpg
# sudo rm -rf /etc/apt/trusted.gpg.d/*.gpg~
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
# sudo apt-key fingerprint 0EBFCD88

# # Add the Docker repository to Apt sources:
# sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# # Install docker & docker-compose
# sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
# # curl -fsSL https://get.docker.com -o get-docker.sh
# # sudo sh ./get-docker.sh # // --dry-run
# # rm -rf ./get-docker.sh

# # Add all rules for docker
# sudo gpasswd -a $USER docker
# sudo usermod -aG docker $USER
# sudo chown "$USER":"$USER" ~/.docker -R

# # Enabling docker services & restart systemctl
# sudo systemctl enable --now docker.service docker.socket containerd.service
# sudo systemctl restart docker
# # echo 'alias docker-compose="docker compose"' >> ~/.bashrc
# # docker network create traefik-public
# echo '#### Docker installed'
# echo '######################################################################'
# fi

# # sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# # dockerd-rootless-setuptool.sh install --force
