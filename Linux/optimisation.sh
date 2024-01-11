# curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

sudo dpkg --configure -a
sudo apt -y install -f
sudo apt --fix-broken install
cat /proc/version

sudo sed -i s/quiet\ splash/quiet\ splash\ intel_pstate=enable/g /etc/default/grub
sudo update-grub

touch ~/.config/plasma-workspace/env/kwin.sh
chmod +x ~/.config/plasma-workspace/env/kwin.sh

echo "export __GL_THREADED_OPTIMIZATIONS=1" >> ~/.profile
echo "export _GL_SHADER_DISK_CACHE=1" >> ~/.profile
echo "export ENABLE_VKBASALT=1" >> ~/.profile
echo "export KWIN_TRIPLE_BUFFER=1" >> ~/.config/plasma-workspace/env/kwin.sh
echo "export __GL_YIELD=USLEEP" >> ~/.config/plasma-workspace/env/kwin.sh
echo "export __GL_MaxFramesAllowed=1" >> ~/.config/plasma-workspace/env/kwin.sh

sudo reboot

# dpkg --list | grep `uname -r`
# srp linux-headers-*.*.*-*-liquorix-* linux-image-*.*.*-*-liquorix-* \
#  linux-image-liquorix-* linux-headers-liquorix-* && supd
