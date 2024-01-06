echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
# First uninstall another version Docker
for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-compose-plugin docker-ce-rootless-extras podman-docker containerd runc docker-buildx-plugin; do sudo apt -y remove --purge $pkg; done
rm -rf $HOME/.docker
sudo rm /usr/local/bin/com.docker.cli
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
sudo apt -y install ca-certificates curl gnupg apt-transport-https lsb-release \
  software-properties-common gnupg
sudo apt -y clean
# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo apt-key fingerprint 0EBFCD88
# Add the Docker repository to Apt sources:
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu jammy stable"
# Install docker & docker-compose
apt-cache policy docker-ce
sudo apt -y install docker.io containerd runc docker-compose
# add all rules for user in docker group
sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker ${USER}
sudo chown "$USER":"$USER" ~/.docker -R
# su - ${USER} && groups && sudo usermod -aG docker ${USER} && exit && \
sudo systemctl enable --now docker docker.socket containerd && \
  sudo systemctl daemon-reload

wget https://github.com/DockStation/dockstation/releases/download/v1.5.1/dockstation_1.5.1_amd64.deb
sudo apt-get -y install ./dockstation_1.5.1_amd64.deb
sudo apt install -f
sudo rm -rf ./dockstation_1.5.1_amd64.deb
# echo 'alias docker-compose="docker compose"' >> ~/.bashrc
# docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi

# sudo rm -rf /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-lunar.list
# sudo rm -rf /etc/apt/sources.list.d/docker.list
# sudo rm -rf /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
# sudo rm -rf /etc/apt/keyrings/docker.gpg
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
# sudo sh ./get-docker.sh --dry-run
# rm -rf ./get-docker.sh


# install docker desktop
# sudo apt-get -y install gnome-terminal
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg
# wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-amd64.deb
# sudo dpkg -i ./docker-desktop-4.26.1-amd64.deb
# rm -rf ./docker-desktop-4.26.1-amd64.deb
# gpg --generate-key
# pass init <your_generated_gpg-id_public_key>
# pass init 999C51E658F56983A2717BC60B7202C027D6D570
# systemctl --user start docker-desktop
# systemctl --user enable docker-desktop
