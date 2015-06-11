#ifndef I2C_DISPLAY_H__
#define I2C_DISPLAY_H__
// bare-bones driver for interfacing with the SSD1306 OLED display via I2C
// not fully featured, just demonstrates basic operation
// note that resetting the PIC does not perform a reset on the OLED display, only power cycling does

#define WIDTH 128 //display width in bits
#define HEIGHT 64 //display height, in bits

void display_init(); // initialize I2C2

void display_command(unsigned char cmd); // issue a command to the display

void display_draw();                       // draw the buffer in the display

void display_clear();                     // clear the display

void display_pixel_set(int row, int col, int val); // set the pixel at the given row and column

int display_pixel_get(int row, int col);  // get the pixel at the given row and column

void display_text(char *message, int row_cur, int col_cur); //writes characters to the screen

void display_arrow(int x_val, int y_val);        //draws arrow to screen

#endif