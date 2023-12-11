echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
# First uninstall another version Docker
sudo apt -y remove --purge docker docker.io containerd runc docker-compose
sudo apt -y remove --purge docker docker.io containerd runc
modprobe kvm
modprobe kvm_intel  # Intel processors
modprobe kvm_amd    # AMD processors
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm $USER
# Update cash
sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoremove \
  && sudo apt -y autoclean
# Install another packages for using Docker
sudo apt -y install apt-transport-https ca-certificates curl \
  software-properties-common gnupg lsb-release openssl nginx
sudo apt -y clean
# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg -y --dearmour -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo apt-key fingerprint 0EBFCD88
# Add the Docker repository to Apt sources:
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Install docker & docker-compose
apt-cache policy docker-ce
sudo apt -y install docker docker.io containerd runc docker-compose
# sudo apt install docker-ce docker-ce-cli docker-compose containerd.io
# Add all rules for docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker ${USER}
sudo chown "$USER":"$USER" ~/.docker -R
su - ${USER} && groups && sudo usermod -aG docker ${USER} && exit
# Enabling docker services & restart systemctl
sudo systemctl enable --now docker.service docker.socket containerd.service
sudo systemctl daemon-reload
# echo 'alias docker-compose="docker compose"' >> ~/.bashrc
# docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi

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

# sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh ./get-docker.sh # // --dry-run
# rm -rf ./get-docker.sh
