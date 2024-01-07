sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove

#### update kernel
echo '######################################################################'
sudo uname -mrs
sudo add-apt-repository-y ppa:cappelikan/ppa \
  && sudo apt install -y mainline
echo 'press ALT+F2 and paste Ubuntu Mainline Kernel Installer'
sudo update-grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo reboot

sudo uname -a
sudo apt list --installed | egrep "linux-image|linux-headers"
# sudo dpkg --list | egrep "linux-image|linux-headers"
# sudo apt purge linux-image-4.15.0-66-generic linux-headers-4.15.0-91-generic

sudo apt -y update \
  && sudo apt search linux-image-*| more \
  && sudo apt search linux-image-5.19.0-28*

sudo apt install -y linux-headers-5.19.0-28-generic
sudo apt install -y linux-modules-5.19.0-28-generic
sudo apt install -y linux-image-5.19.0-28-generic
sudo apt install -y linux-modules-extra-5.19.0-28-generic

dpkg --list | grep linux-image

sudo reboot
uname -r

sudo apt remove --purge linux-image-5.15.0-43-generic
echo '######################################################################'
