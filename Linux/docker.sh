echo '#### Installing Docker'
echo '#################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
sudo apt-get install -y gnome-terminal
modprobe kvm
modprobe kvm_intel  # Intel processors
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm $USER && sudo groupadd docker
sudo apt-get clean

# Add Docker's official GPG key:
sudo apt-get update
sudo install -m 0755 -d /etc/apt/trusted.gpg.d

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo chmod a+r /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo apt-key fingerprint 0EBFCD88
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  # docker.io containerd runc docker-compose

sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker ${USER}
newgrp docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

sudo systemctl enable --now \
  docker docker.service containerd containerd.service && \
  sudo systemctl daemon-reload && systemctl status docker.service
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc
echo '#### Docker installed'
echo '#################################################################'
fi

# wget https://github.com/DockStation/dockstation/releases/download/v1.5.1/dockstation_1.5.1_amd64.deb
# sudo apt-get install -y ./dockstation_1.5.1_amd64.deb
# sudo apt-get install -y -f
# sudo rm -rf ./dockstation_1.5.1_amd64.deb

# $(lsb_release -cs)

# echo 'alias docker-compose="docker compose"' >> ~/.bashrc

# for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-compose-plugin docker-ce-rootless-extras podman-docker containerd runc docker-buildx-plugin; do sudo apt-get remove --purge -y $pkg; done
# rm -rf ~/.docker
# sudo rm -rf /etc/apt/sources.list.d/docker.list
# sudo rm -rf /usr/local/bin/com.docker.cli
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
