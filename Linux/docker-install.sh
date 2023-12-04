
echo \n'#### Installing Python3'
echo '######################################################################'\n
if [[ $(python3 --version) && $(pip3 --version) ]]; then
   echo Python3 installed, continue...\n
else
sudo apt -y install \
  cpu-checker \
  python3-pip \
  python3-dev \
  python3-virtualenv \
  software-properties-common \
  python3 \
  python3-full \
  build-essential \
  zlib1g-dev \
  libncurses5-dev \
  libgdbm-dev \
  libnss3-dev \
  libssl-dev \
  libreadline-dev \
  libffi-dev wget

modprobe kvm \
  && modprobe kvm_intel \
  && kvm-ok \
  && lsmod | grep kvm \
  && ls -al /dev/kvm \
  && sudo usermod -aG kvm msi

cd /tmp \
  && wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz \
  && tar -xf Python-3.11.0.tgz \
  && cd Python-3.11.0 \
  && ./configure --enable-optimizations \
  && sudo make install \
  && python3 --version \
  && pip3 --version \
  && cd ~

sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
fi

echo \n'#### Installing Docker'
echo '######################################################################'\n
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo Docker installed, continue...\n
else
# sudo apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
# sudo rm -rf /var/lib/docker
# sudo rm -rf /var/lib/containerd

sudo apt -y update \
  && sudo apt -y install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  nginx \
  openssl \
  && sudo apt -y clean \
  && sudo rm -rf /var/lib/apt/lists/* \
  && sudo mkdir -p /etc/apt/keyrings


# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -y update \
  && sudo apt -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
docker compose version
fi

sudo docker network create traefik-public

# sudo docker-compose up -d --build
