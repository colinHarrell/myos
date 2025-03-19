gdt_null_segment:
	dq 0x0
gdt_code_segment:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data_segment:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:

gdt:
	dw gdt_end - gdt_null_segment - 1
	dd gdt_null_segment
