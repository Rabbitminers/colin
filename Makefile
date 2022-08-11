GCCPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -fno-stack-protector
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o gdt.o kernel.o

%.o: %.cpp
	gcc $(GCCPARAMS) -c -o $@ $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

mykernel.iso: mykernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp mykernel.bin iso/boot/mykernel.bin
	echo 'set timeout=0'                      > iso/boot/grub/grub.cfg
	echo 'set default=0'                     >> iso/boot/grub/grub.cfg
	echo ''                                  >> iso/boot/grub/grub.cfg
	echo 'menuentry "My Operating System" {' >> iso/boot/grub/grub.cfg
	echo '  multiboot /boot/mykernel.bin'    >> iso/boot/grub/grub.cfg
	echo '  boot'                            >> iso/boot/grub/grub.cfg
	echo '}'                                 >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=mykernel.iso iso
	rm -rf iso

run: mykernel.iso
	(killall VirtualBox && sleep 1) || true
	VirtualBox --startvm 'My Operating System' &

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

testgdt:
	g++ -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -c gdt.cpp -m32 -o gdt.o

testbuild:
	g++ -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -fno-stack-protector -c kernel.cpp -m32 -o kernel.o

run: mykernel.iso
	VBoxManage controlvm "Colin" poweroff || echo "No Instance Running"
	sleep 2
	VBoxManage startvm "Colin"

stop: mykernel.iso
	VBoxManage controlvm "Colin" poweroff || echo "No Instance Running"
