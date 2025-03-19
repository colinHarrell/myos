[bits 16]
[org 0x7c00]

KERNEL_ADDRESS equ 0x1000
mov [BOOT_DRIVE], DL
mov bp, 0x9000
mov sp, bp

call kernel_load
mov BX, DISK_SUCCESS_MESSAGE
call print_string
jmp switch_to_32bit
jmp done

%include "gdt.asm"

kernel_load:
	pusha
	mov AH, 0x02
	mov AL, [NUM_SECTORS]
	mov BX, KERNEL_ADDRESS
	mov CH, 0x00
	mov CL, 0x02
	mov DH, 0x00
	mov DL, [BOOT_DRIVE]
	int 13h
	jc disk_read_error
	cmp AL, [NUM_SECTORS]
	jne disk_sector_error
	popa
	ret
disk_read_error:
	mov BX, DISK_READ_ERROR_MESSAGE
	call print_string
	jmp done
disk_sector_error:
	mov BX, DISK_SECTOR_ERROR_MESSAGE
	call print_string
	jmp done


print_string:
	pusha
	mov AH, 0x0e
print_loop:
	mov AL, [BX]
	cmp AL, 0x00
	je done_print
	int 10h
	add BX, 1
	jmp print_loop
done_print:
	popa
	ret

done:
	jmp $


switch_to_32bit:
	cli
	lgdt [gdt]
	mov EAX, CR0
	or eax, 0x01
	mov CR0, EAX
	jmp 0x08:begin_32bit

[bits 32]
begin_32bit:
	mov AX, 0x10
	mov SS, AX
	mov DS, AX
	mov ES, AX
	mov FS, AX
	mov GS, AX
	mov ebp, 0x90000
	mov esp, ebp
	jmp KERNEL_ADDRESS


NUM_SECTORS db 0x19
DISK_SUCCESS_MESSAGE db "Read succeeded, continuing", 0
DISK_READ_ERROR_MESSAGE db "Problem with disk read", 0
DISK_SECTOR_ERROR_MESSAGE db "Read and requested sectors differ", 0
BOOT_DRIVE db 0
times 510 - ($-$$) db 0
dw 0xaa55
