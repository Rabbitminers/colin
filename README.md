# colin
A simple operating system written in C++ and assembly

# Installation
(on bare metal using the GRUB boatloader - not reccomended currently)

First clone the repository
```
git clone https://github.com/Rabbitminers/colin/
cd colin
```
Then compile the kernel and loader, before linking them into a using the makefile
```
make kernel.o // requires g++
make loader.o // requires as
make mykernel.bin
```
Then install the kernel to /boot/
```
make install
```
Open the GRUB config and add the following code **above** ### BEGIN /etc/grub.d/30_uefi-firmware ### 
```
## BEGIN COLIN ###

menuentry `colin` {
  multiboot /boot/mykernel.bin
  boot
}

## END COLIN ###
```
The operating system is now installed, reboot your system, while it is loading press shift to open GRUB boot menu from there select colin and enjoy!
