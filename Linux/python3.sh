echo '#### Installing Python3'
echo '#################################################################'
if [[ $(which --version) && $(python3 --version) && $(pip3 --version) ]]; then
   echo 'Python3 installed, continue...'
else
   echo 'Python3 NOT installed, continue...'
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove

sudo apt -y install cpu-checker python3-pip python3-dev python3-virtualenv \
  software-properties-common python3 python3-full build-essential zlib1g-dev \
  libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev \
  libffi-dev wget

modprobe kvm
modprobe kvm_intel
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm msi

cd /tmp
wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
tar -xf Python-3.11.0.tgz
cd Python-3.11.0
./configure --enable-optimizations
sudo make install
cd ~
python3 --version
pip3 --version

sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove
echo '#### Python3 installed'
echo '#################################################################'
fi
