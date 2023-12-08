echo '#### Installing Docker'
echo '######################################################################'
if [[ $(which docker) && $(docker --version) && $(docker-compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
# First uninstall another version Docker
for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-compose-plugin docker-ce-rootless-extras podman-docker containerd containerd.io runc; do sudo apt -y remove --purge $pkg; done
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
# sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker & docker-compose
sudo apt -y update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Add all rules for docker
sudo gpasswd -a $USER docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" ~/.docker -R

# Enabling docker services & restart systemctl
sudo systemctl enable --now \
  docker.service \
  docker.socket \
  containerd.service
sudo systemctl restart docker

docker-compose version
docker --version
docker version

bash -c \
"cat << EOF > ~/.docker/config.json
{
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "c2xhd2Vla3E6ZGNrcl9wYXRfeUpoR2pvdFpiWUJKTHZRSWNScTNQMjd5Q2hj"
                }
        },
        "currentContext": "default",
        "plugins": {
                "-x-cli-hints": {
                        "enabled": "true"
                }
        }
EOF"

# docker network create traefik-public
echo '#### Docker installed'
echo '######################################################################'
fi

# sudo apt -y install dbus-user-session uidmap docker-ce-rootless-extras
# dockerd-rootless-setuptool.sh install --force
