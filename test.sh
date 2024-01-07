echo '\n#### Installing Docker'
echo '######################################################################\n'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...\n'
else
echo 'Docker NOT installed, continue...\n'
# dockerd-rootless-setuptool.sh uninstall --force
# First uninstall another version docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt -y remove $pkg; done
apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
rm -rf /home/$USER/.docker
groupdel docker
cd /bin
rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
cd -

apt -y update \
  && apt -y upgrade \
  && apt -y autoclean \
  && apt -y autoremove

curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

apt -y install dbus-user-session uidmap docker-ce-rootless-extras
systemctl disable --now docker.service docker.socket
dockerd-rootless-setuptool.sh install --force
systemctl enable --now docker.service docker.socket
systemctl daemon-reload
docker network create traefik-public

apt -y update \
  && apt -y upgrade \
  && apt -y autoclean \
  && apt -y autoremove
# docker-compose up -d --build
fi


# apt -y install \
#   ca-certificates \
#   curl \
#   gnupg \
#   lsb-release \
#   nginx \
#   openssl \
#   && apt -y clean
# ## Add Docker's official GPG key:
# install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# chmod a+r /etc/apt/keyrings/docker.gpg

# # Add the repository to Apt sources:
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   tee /etc/apt/sources.list.d/docker.list > /dev/null
# apt update

# apt -y install \
#   docker-ce \
#   docker-ce-cli \
#   containerd.io \
#   docker-buildx-plugin \
#   docker-compose-plugin





# dockerd-rootless-setuptool.sh uninstall --force
# cd /bin
# rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
# cd -
