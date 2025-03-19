#include "console.h"
#include <stdint.h>

    char* const VGA_BUFFER = (char*) 0xb8000; // Pointer to the memory address of 
                                              // our VGA Buffer 
    VGA_Color terminal_font_color = LIGHT_GRAY; // Default font color will be light gray 
    VGA_Color terminal_background_color = BLACK; // Default background color is black 
    int terminal_position = 0; // keeps track of where the next print statement should go 

    void update_cursor() {
    uint16_t cursor_position = terminal_position >> 1; 
    outb(0x3D4, 0x0F); 
    outb(0x3D5, (uint8_t) (cursor_position)); 
    outb(0x3D4, 0x0E); 
    outb(0x3D5, (uint8_t) (cursor_position >> 8)); 
}

    void clear_terminal() { 
    for (int i=0; i < VGA_HEIGHT*VGA_WIDTH*2; i+=2) { // for every character 
        VGA_BUFFER[i] = 0; // remove the character 
        VGA_BUFFER[i+1] = 0x07;  // and store a light gray color as the style, 
                                 // which is the default VGA_BEHAVIOR
        
    } 
    update_cursor();
} 

    void set_terminal_font_color(VGA_Color col) { 
    terminal_font_color = col; 
} 

    void set_terminal_background_color(VGA_Color col) { 
    terminal_background_color = col; 
} 

    void print_character(char c) { 
    print_character_with_color(c, terminal_background_color, terminal_font_color); 
}

    void print_line_with_color(char* str, VGA_Color bg_color, VGA_Color font_color) { 
    print_string_with_color(str, bg_color, font_color); 
    print_character_with_color('\n', bg_color, font_color); 
}

    void print_string_with_color(char* str, VGA_Color bg_color, VGA_Color font_color) { 
    for (int i=0; str[i] != '\0'; i++) { 
        print_character_with_color(str[i], bg_color, font_color); 
    } 
}

    void print_string(char* str)
    {
        print_string_with_color(str, terminal_background_color, terminal_font_color);
    }

    void print_character_with_color(char c, VGA_Color bg_color, VGA_Color font_color) { 
    // First we have to check to see if we were given a special new line character 
    if (c == '\n') { 
    // When we get a newline character, you must reset the terminal_position variable 
    // such that it is now equal to the NEXT multiple of 160. 
        terminal_position = ((terminal_position/160) + 1 )* 160;   
    // I leave this to you - determine how to get to the next multiple of 160; 
    update_cursor(); 
        return; 
    } 

    // Otherwise, at this point, we want to place the character 
    // with the appropriate font values into the buffer. We can do that by using
    VGA_BUFFER[terminal_position++] = c; 
    
    //Next, compute the style byte. The style byte takes the form of 4 bits 
    //of bg color followed by 4 bits of font color. 
    VGA_BUFFER[terminal_position++] = (bg_color << 4) | font_color; 
} 





    