#include "keyboard.h"

uint8_t scan(void) { 
    uint8_t brk; 
    static uint8_t key = 0;
    uint8_t scan = inb(0x60); 

    brk = scan & 0x80; 
    scan = scan & 0x7f;
 
    if (brk) { 
        return key = 0; 
    } else if (scan != key) { 
        return key = scan; 
    } else { 
        return 0; 
    } 
} 