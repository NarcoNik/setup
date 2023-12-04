echo '\n#### Installing Python3'
echo '######################################################################\n'
if [[ $(python3 --version) && $(pip3 --version) ]]; then
   echo Python3 installed, continue...\n
else
apt -y update \
  && apt -y upgrade \
  && apt -y autoclean \
  && apt -y autoremove

apt -y install \
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

modprobe kvm
modprobe kvm_intel
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
usermod -aG kvm msi

cd /tmp
wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
tar -xf Python-3.11.0.tgz
cd Python-3.11.0
./configure --enable-optimizations
make install
python3 --version
pip3 --version
cd ~

apt -y update \
  && apt -y upgrade \
  && apt -y autoclean \
  && apt -y autoremove
fi
echo '\n#### Python3 installed'
echo '######################################################################\n'
