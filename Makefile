GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %cpp
	g++ $(GPPPARAMS) -m32 -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld ${LDPARAMS} -s -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin