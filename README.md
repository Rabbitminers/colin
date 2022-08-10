# colin
A simple operating system written in C++ and assembly

# Installation

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
You must now decide how you want to install colin. It can either be virtualized through software such as virtual box or installed on bare metal using the GRUB boatloader

## (1 - Through virtual box)

installation tutorial using virtual box although almost any virtualization software should work but the instructions may differ

Create a bootable iso from the kernel binary you just created - this requires xorriso which you may need to install if you havent already
```
make mykernel.iso
```
Now you can open virtual box click new fill out the name and make sure to set the type to **other** and the version to **other/unknown** and NOT other/unknown (64-bit). You can leave the memory size at the default 64Mb of RAM as currently the OS is very small.
You do not need a virtual hard disk currently however this is likely to change in the future. This will create a virtual machine but it has nothing to boot from so right click it from the list of VM's and open Settings. Navigate to storage and select the empty optical drive in the drop down menu to the right select "Choose a disk file...". Select the ISO and colin should be succesfully installed, enjoy!



## (2 - on bare metal using the GRUB boatloader - not reccomended currently)

install the kernel to /boot/
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
