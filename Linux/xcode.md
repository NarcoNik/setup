4. macOS Virtual Machine As usual, one way to run macOS apps on Linux is via a virtual machine (VM). With virtualization software like
   VirtualBox, we can set up a macOS VM.

Similarly, QEMU is a virtual machine emulator and virtualizer. Using QEMU alongside KVM natively applies the virtual machine on the Linux
kernel.

4.1. Install QEMU and KVM To demonstrate, we’ll use the macOS-Simple-KVM project to set up a simple macOS VM in QEMU/KVM setup. For this
setup, the Linux system must have:

qemu python3 pip KVM modules Notably, we can install these requirements on Debian-based systems using the package installer:

$ sudo apt install qemu-system qemu-utils python3 python3-pip Reading package lists... Done Building dependency tree Reading state
information... Done ... Copy However, we can follow the guide on the project documentation to install these requirements on other Linux
distributions.

4.2. Download the Project Kit Next, let’s set up the Linux KVM to run macOS. First, we’ll download the project archive to our home directory
(~):

$ cd ~ $ wget https://github.com/foxlet/macOS-Simple-KVM/archive/refs/heads/master.zip Copy Then, using the unzip command-line utility on
the terminal, let’s extract the contents of the file:

$ unzip master.zip Copy We now have the ~/macOS-Simple-KVM-master directory.

4.3. Download the Installation Media First, to simplify the management of the macOS VM, let’s create a folder for the virtual machine:

$ mkdir ~/Linux_KVM Copy Next, let’s move our project directory to the new directory:

$ mv ~/macOS-Simple-KVM-master/ ~/Linux_KVM/macOS-Simple-KVM-master Copy Further, we’ll proceed to download installation media for macOS in
our project directory. First, let’s change to the macOS-Simple-KVM-master directory:

$ cd ~/Linux_KVM/macOS-Simple-KVM-master Copy Now, let’s download installation media for macOS:

$ ./jumpstart.sh Requirement already satisfied: requests /usr/lib/python3/dist-packages (from -r requirements .txt (line 1)) (2.23.0) ...
Archive successfully decompressed as ~/Linux_KVM/macOS-Simple-KVM-master/BaseSystem.img Copy By default, the
macOS-Simple-KVM-master/jumpstart.sh script downloads the macOS Catalina installation image.

4.4. Create a Virtual Hard Disk Following the download of the base system image, we can proceed to create a virtual hard disk. This disk is
the location where we’ll install the macOS.

Now, we’ll use the qemu-img utility to create the virtual hard disk:

$ qemu-img create -f qcow2 MyDisk.qcow2 20G formatting 'MyDisk.qcow2', fmt=qcow2 size=673847625632 cluster_size=65536 lazy_refcounts=off
refcount bits=16 Copy Here, qemu-img creates a virtual disk using the create subcommand and the -f flag. Also, the virtual disk has the name
MyDisk.qcow2 in the qcow2 format with an estimated size of 64GB.

Next, let’s append the command to use the disk to the ~/macOS-Simple-KVM-master/basic.sh script:

    -drive id=SystemDisk,if=none,file=MyDisk.qcow2 \
    -device ide-hd,bus=sata.4,drive=SystemDisk \

Copy At this point, we have a VM ready for macOS installation.

4.5. Install macOS Now, to install the macOS, let’s run the basic.sh script file in the terminal:

$ ./basic.sh Copy In essence, this command will display the initial installation screen of the macOS operating system. Note the difference
in resolution between the host and guest. Then, we’ll press Enter and continue with the installation process:

Booting into the macOS installer Upon completing the installation, we should have a screen like the one below running on QEMU:

macOS Desktop

Now, we can proceed to download and install Xcode on the virtual machine.

4.6. Install Xcode In general, to download Xcode on our virtual machine, there are a few steps to complete:

Go to the Apple developer website’s download section (which requires an Apple ID) Select and download our preferred Xcode version Xcode X.X
in the .xip format Select and download the respective command-line tools as Command Line Tools for Xcode X.X in the .dmg format Install the
command-line tools Finally, we can install Xcode from the command line:

$ xcode-select --install Copy Lastly, we can proceed to open Xcode from the Applications folder. However, Xcode may prompt us to install
additional required components:

Additional Xcode Components We’ll click install. This installation can take a few minutes. Finally, we can proceed to Xcode:

Additional Xcode components Importantly, this method of running macOS is subject to Apple’s legal terms and conditions.

xmodmap -e 'keycode 13 = e'

xmodmap - <<EOF clear e add e = e EOF
