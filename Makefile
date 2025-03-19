C_FILES=./kernel.c ./shell/console.c ./shell/device/keyboard/keyboard.c ./shell/device/portmap/portmap.c 
O_FILES=${C_FILES:.c=.o}

all: qemu_launch

qemu_launch: os.bin
	qemu-system-i386 -drive format=raw,file=$<,index=0,if=floppy
os.bin: boot.bin kernel.bin
	cat $^ > $@
boot.bin: boot.asm
	nasm $< -f bin -o $@
kernel.bin: kernel-entry.o ${O_FILES}
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary
kernel-entry.o: kernel-entry.elf
		nasm $< -f elf -o $@
${O_FILES}: kernel.c
	gcc -Iinclude -fno-pie -m32 -ffreestanding -c ${@:.o=.c} -o $@
clean:
	$(RM) *.o *.bin
	find . -name \*.o | xargs --no-run-if-empty rm