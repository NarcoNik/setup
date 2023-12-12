#### Mount disks
echo '######################################################################'
sudo fdisk -l
sudo mount -o rw UUID=0E7A-1BF7 /boot/efi
sudo mount -t ntfs -o rw,realtime /dev/nvme1n1p2 /mnt/Linux && sudo chmod 0777 /mnt/Documents

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

sudo chown -R slaweekq /Windows
sudo chown -R slaweekq /mnt/Documents
sudo chown -R slaweekq /mnt/Linux

kate /etc/fstab
# sudo kate /etc/mtab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>        <dump> <pass>
UUID=b2569fde-a4e2-46c9-b4b6-35ef22b6ad1f /               ext4   errors=remount-ro    0      1
UUID=2200-9AEC                            /boot/efi       vfat   umask=0077           0      1
UUID=8A34B39934B3872B                     /mnt/Documents  ntfs   defaults,rw,realtime 0      0
UUID=6C2404B024047F78                     /mnt/Windows    ntfs   defaults,ro          0      0



sudo fdisk -l
sudo findmnt --verify --verbose
lsblk -f

sudo hdparm -r0 /dev/nvme1n1p1
sudo hdparm -r0 /dev/nvme1n1p2

# mount | grep 'mnt'
# sudo umount /mnt/Linux
# cat /etc/fstab
# sudo blkid -c /dev/null

sudo mount -t ntfs -o rw,realtime /dev/nvme1n1p2 /mnt/Linux
sudo umount /deb/nvme1n1p2
sudo ntfsfix /deb/nvme1n1p2
sudo mount -t ntfs -o remove_hiberfile /dev/nvme1n1p2 /mnt/Linux

echo '######################################################################'



#### Grub2 install
echo '######################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer \
  && sudo apt update -y \
  && sudo apt install grub-customizer \
  && sudo grub-customizer

sudo gparted
sudo mkdir /boot/efi
sudo mount /dev/nvme0n1p1 /mnt/boot/efi
sudo mount /dev/nvme0n1p5 /mnt
sudo mount /dev /mnt/dev
sudo mount /proc /mnt/proc
sudo mount /sys /mnt/sys


sudo apt install -y grub-efi efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-install /dev/nvme1n1p1
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo update-grub --output=/boot/grub/grub.cfg
sudo grub-install /dev/nvme1n1
kate /boot/grub/grub.cfg

sudo apt-add-repository -y ppa:yannubuntu/boot-repair \
  && sudo apt update -y \
  && sudo apt install -y boot-repair \
  && sudo boot-repair


sudo apt -y update \
  && sudo apt install -y ubuntu-desktop \
  xfce4 \
  xfce4-goodies \
  xorg \
  dbus-x11 \
  x11-xserver-utils

sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo add-apt-repository ppa:kubuntu-ppa/backports -y \
  && sudo apt -y update \
  && sudo apt install -y kde-plasma-desktop

cat /etc/sddm.conf
echo -e "[General]\nInputMethod=" | sudo tee -a /etc/sddm.conf

echo '######################################################################'
