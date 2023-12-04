echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
# dockerd-rootless-setuptool.sh uninstall --force
# First uninstall another version docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt -y remove $pkg; done
sudo apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /home/$USER/.docker
sudo groupdel docker
cd /bin
sudo rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
cd -

sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove

curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
sudo systemctl disable --now docker.service docker.socket
dockerd-rootless-setuptool.sh install --force
sudo systemctl enable --now docker.service docker.socket
sudo systemctl daemon-reload

docker network create traefik-public

sudo rm -rf ./get-docker.sh
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove
# docker-compose up -d --build
echo '#### Docker installed'
echo '######################################################################'
fi
