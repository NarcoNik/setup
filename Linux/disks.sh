#### Mount disks
echo '#################################################################'
sudo fdisk -l
sudo findmnt --verify --verbose
lsblk -f

sudo chown -R $USER PATH/*

kate /etc/fstab
sudo bash -c \
"cat << EOF > /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>        <dump> <pass>
UUID=10be2a1f-0371-44e0-80d9-be41f9f74981 /               ext4   errors=remount-ro    0      1
UUID=5A67-70C3                            /boot/efi       vfat   umask=0077           0      1
UUID=8A34B39934B3872B                     /mnt/Documents  ntfs   defaults,rw,realtime 0      0
UUID=94a06914-b3f6-4d2e-9cca-23b32d8f0a9a none            swap   sw                   0      0
EOF"
echo '#################################################################'

echo '#### Restore network-manager or another package'
echo '#################################################################'
ls /var/cache/apt/archives/

sudo dpkg -i libnm0_1.42.4-1ubuntu2_amd64.deb
sudo dpkg -i libnm0_1.42.4-1ubuntu2_i386.deb
sudo dpkg -i network-manager_1.42.4-1ubuntu2_amd64.deb

sudo service NetworkManager restart
sudo systemctl restart NetworkManager
sudo systemctl daemon-reload
sudo ifconfig wlo1 up
sudo iwconfig wlo1 essid Zeniko
sudo ./ssu/ssu.sh
sudo iwconfig wlo1 essid zeniko && sudo dhclient wlo1
sudo su
sudo iwconfig wlo1 essid zeniko && sudo dhclient wlo1
rfkill unblock all

# This device appears to be connected to a network but is unable to reach the internet.
# https://linux-hardware.org/?probe=6027d9f940
sudo mkdir /mnt/ubuntu && sudo mount /dev/nvme1n1p5 /mnt/ubuntu
sudo mount --bind /dev /mnt/ubuntu/dev
sudo mount --bind /proc /mnt/ubuntu/proc
sudo mount --bind /sys /mnt/ubuntu/sys
sudo cp /etc/resolv.conf /mnt/ubuntu/etc/resolv.conf
sudo chroot /mnt/ubuntu

apt -y update && \
  apt -y upgrade && \
  apt -y autoremove --purge && \
  apt -y autoclean && \
  apt -y --fix-broken install
apt -y install --reinstall kubuntu-desktop plasma-nm \
  network-manager network-manager-vpnc network-manager-gnome net-tools

rfkill unblock all
lspci -knn | grep Net -A2
update-pciids
lshw -c net

# https://community.intel.com/t5/Wireless/Problem-using-802-11r-FT-on-Ubuntu-AX200/td-p/1233573
ethtool -i wlo1 | grep firmware
# firmware-version: 83.e8f84e98.0 so-a0-gf-a0-83.uc
rfkill unblock wifi
service NetworkManager stop
# killall wpa_supplicant
iw wlo1 set type monitor
ifconfig wlo1 up
iw wlo1 set freq 2412
# tcpdump -i wlo1 -w capture.pcap
service NetworkManager start
systemctl restart NetworkManager
apt install -y hw-probe
hw-probe -all -upload

wget https://downloadmirror.intel.com/26735/ssu_3.0.0.2_tar.gz
mkdir /home/msi/ssu && tar -xf ssu_3.0.0.2_tar.gz -C /home/msi/ssu
/home/msi/ssu/ssu.sh
modinfo iwlwifi
lsmod | grep iwlwifi
dmesg | grep iwlwifi

wget https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi-ty-59.601f3a66.0.tgz
tar -xf iwlwifi-ty-59.601f3a66.0.tgz -C /home/msi
sudo cp /home/msi/iwlwifi-ty-59.601f3a66.0/iwlwifi-ty-a0-gf-a0-59.ucode /lib/firmware

sudo modprobe iwlwifi
lspci -nnk | grep 0280 -A3
rfkill list all
lsmod | grep iwl
sudo dmesg | grep iwl
sudo dmesg | grep ASSERT
exit
reboot

# # All firmware of Intel
# # https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
# wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-20231211.tar.gz
# tar -xf linux-firmware-20231211.tar.gz
# sudo cp ./linux-firmware-20231211/*.ucode /lib/firmware/
# sudo ./linux-firmware-20231211/copy-firmware.sh /lib/firmware --ignore-duplicates

# wget https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/snapshot/linux-firmware-iwlwifi-fw-2023-12-21.tar.gz
# tar -xf linux-firmware-iwlwifi-fw-2023-12-21.tar.gz
# sudo cp ./linux-firmware-iwlwifi-fw-2023-12-21/*.ucode /lib/firmware/
# sudo ./linux-firmware-iwlwifi-fw-2023-12-21/copy-firmware.sh /lib/firmware --ignore-duplicates
echo '#################################################################'

echo '#### Swap install'
echo '#################################################################'
sudo swapon --show
free -h
df -h
sudo fallocate -l 32G /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile                                 none            swap   sw                   0      0' | sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.vfs_cache_pressure=50
sudo tee -a /etc/sysctl.conf <<< \
"vm.swappiness=10
vm.vfs_cache_pressure=50"
echo '#################################################################'

echo '#### Grub2 install'
echo '#################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer \
  && sudo apt update -y \
  && sudo apt install grub-customizer \
  && sudo grub-customizer

for pkg in grub-common grub-customizer grub-efi grub-efi-amd64-bin grub-efi-amd64-signed grub-gfxpayload-lists grub-pc grub-pc-bin grub2-common; do sudo apt -y remove --purge $pkg; done

sudo apt -y install grub-customizer

sudo apt install -y grub-efi efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-install /dev/nvme1n1p1
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo update-grub --output=/boot/grub/grub.cfg
sudo grub-install /dev/nvme1n1
kate /boot/grub/grub.cfg

sudo apt-add-repository -y ppa:yannubuntu/boot-repair && \
  sudo apt update -y && sudo apt install -y boot-repair && sudo boot-repair

sudo dpkg --configure -a
sudo apt install -fy
sudo apt purge --allow-remove-essential -y grub-com*
sudo apt purge --allow-remove-essential -y grub2-com*
sudo apt purge --allow-remove-essential -y shim-signed
sudo apt purge --allow-remove-essential -y grub-common:*
sudo apt purge --allow-remove-essential -y grub2-common:*

sudo apt -y update && sudo apt install -y ubuntu-desktop xorg dbus-x11 \
  xfce4 xfce4-goodies x11-xserver-utils

sudo apt -y update && sudo apt -y upgrade && \
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y && \
  sudo apt -y update && sudo apt install -y kde-plasma-desktop

cat /etc/sddm.conf
echo -e "[General]\nInputMethod=" | sudo tee -a /etc/sddm.conf
echo '#################################################################'

echo '#### Mac'
echo '#################################################################'
sudo mount -t fat32 -o rw,realtime /dev/sda2 /mnt/MacOS
sudo mount -o rw UUID=2023-05-31-19-32-03-00 /mnt/MacOS

sudo add-apt-repository universe \
  && sudo apt update -y \
  && sudo apt install dmg2img \
  && dmg2img -v -i /path/to/image_file.dmg -o /path/to/image_file.iso

sudo dd if=/path/to/image_file.iso of=/dev/sdd

dd if=image.dmg of=/dev/sdb bs=16M status=progress

sudo dd if=/mnt/Documents/Ventura.iso of=/dev/nvme0n1p2
for windows dd if=\\.\d:\Ventura.iso of=\\.\p:
echo '#################################################################'
