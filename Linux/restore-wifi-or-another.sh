
echo '#### Restore network-manager or another package'
echo '#################################################################'
ls /var/cache/apt/archives/
tar -xf ./wifi.tar.gz
cd wifi

sudo dpkg -i \
  libnm0_1.42.4-1ubuntu2_amd64.deb libnm0_1.42.4-1ubuntu2_i386.deb \
  libndp0_1.8-1fakesync1_amd64.deb libteamdctl0_1.31-1build2_amd64.deb \
  network-manager_1.42.4-1ubuntu2_amd64.deb
sudo cp ./iwlwifi/*.ucode /lib/firmware
sudo ./ssu.sh

sudo service NetworkManager restart
sudo systemctl restart NetworkManager
sudo systemctl daemon-reload
sudo ifconfig wlo1 up
sudo iwconfig wlo1 essid Zeniko
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

modinfo iwlwifi
lsmod | grep iwlwifi
dmesg | grep iwlwifi
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
