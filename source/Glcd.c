#include "ks0108.h"
#include "graphic.h"
#include "bitmap.h"

// Conexiunile ecranului tactil
sbit DRIVE_A at RC0_bit;
sbit DRIVE_B at RC1_bit;
sbit DRIVE_A_Direction at TRISC0_bit;
sbit DRIVE_B_Direction at TRISC1_bit;
const char READ_X_CHANNEL = 0;     // READ X analog 0
const char READ_Y_CHANNEL = 1;     // READ Y analog 1

// Variabile globale
const unsigned int ADC_THRESHOLD = 900; // threshold detect 
unsigned int x_coord, y_coord, x_coord_old, y_coord_old, x_coord_diff, y_coord_diff;
long         x_coord128, y_coord64;     
int          cal_x_min, cal_y_min, cal_x_max, cal_y_max;  // calibration constants
unsigned short in_menu;

// demo text
code const char demotext[] = "\
***** OS KS0108 *****\
                     \
* Have fun using     \
this open source     \
graphics library     \
details at           \
sgvulcan.com         \
		     \
---------------------\
                     \
* tested on easypic5 \
---------------------";


char PressDetect() {
  unsigned adc_rd;
  char result;
  // Detectie apasare
  DRIVE_A = 0;         // DRIVEA = 0 
  DRIVE_B = 0;         // DRIVEB = 0 
  Delay_ms(5);
  adc_rd = ADC_Read(READ_Y_CHANNEL);
  result = (adc_rd > ADC_THRESHOLD);   
  // debounce, repeat read after 2ms
  Delay_ms(2);
  adc_rd = ADC_Read(READ_Y_CHANNEL);
  result = result & (adc_rd > ADC_THRESHOLD);
  return result;
}


unsigned int GetX() {
  unsigned int result;
  //citeste X
  DRIVE_A = 1;          // DRIVEA = 1 
  DRIVE_B = 0;          // DRIVEB = 0 
  Delay_ms(5);
  result = ADC_Read(READ_X_CHANNEL);      // read X (INF.)
  return result;
}


unsigned int GetY() {
  unsigned int result;
  //citeste Y
  DRIVE_A = 0;          // DRIVEA = 0 
  DRIVE_B = 1;          // DRIVEB = 1 
  Delay_ms(5);
  result = ADC_Read(READ_Y_CHANNEL);      // read X (STANGA)
  return result;
}

// calibrating function
void Calibrate() {
  GLCD_ClearScreen();
  Glcd_SetPixel(0,63,1);
  GLCD_GoTo(10,6);
  GLCD_WriteString("Atingeti punctul");
  while (!PressDetect());
  // calibration constants
  // compensate for the nonlinearity of the touch screen
  cal_x_min = GetX() - 10;
  cal_y_min = GetY() - 10;
  Delay_ms(1000);
  GLCD_ClearScreen();
  Glcd_SetPixel(127,0,1);
  GLCD_GoTo(30,1);
  GLCD_WriteString("press the point");
  while (!PressDetect()) ;
  cal_x_max = GetX() + 5;
  cal_y_max = GetY() + 5;
  Delay_ms(1000);
}

// functie de initializare
void Initialize() {

  DRIVE_A_Direction = 0;       //  DRIVE_A output
  DRIVE_B_Direction = 0;       // DRIVE_B output
  ANSEL  = 3;                  // AN0 and AN1 analog in
  ANSELH = 0;                  // rest of AN are digital i/o
  TRISA  = 3;
  C1ON_bit = 0;                // turn off comparators
  C2ON_bit = 0;
  GLCD_Initalize();            // 
}

// draw main menu
void main_menu() {

     GLCD_ClearScreen();

     GLCD_Rectangle(8,22,50,11);
     GLCD_GoTo(11,3);
     GLCD_WriteString("Bitmap");

     GLCD_Rectangle(68,22,50,11);
     GLCD_GoTo(71,3);
     GLCD_WriteString("Text");

     GLCD_GoTo(11,5);
     GLCD_WriteString("by:");
     GLCD_GoTo(5,6);
     GLCD_WriteString("Vulcan Silviu - 2009");
}

// draw bitmap
// return to main menu on push
void images() {

     GLCD_ClearScreen();
     GLCD_Bitmap(picture,0,0,128,64);
     while (!PressDetect());
}

// list the demo text
// new page on press
void list_text() {
  unsigned short pos,rand;
  unsigned int i,dimtext;

  GLCD_ClearScreen();
  dimtext = (sizeof(demotext) / sizeof(demotext[1])) - 1;
  // 21 columns and 8 rows available
  pos = 0;
  rand = 0;
  GLCD_GoTo(0,0);
  for (i = 0; i < dimtext; i++)  {
      if (pos == 21) { // new row
         if (rand < 7 ) rand++;
         else {
              while (!PressDetect()); // wait for press
              rand = 0;
              GLCD_ClearScreen();
              }
         pos = 0;
         GLCD_GoTo(0,rand);
      }
      GLCD_WriteChar(demotext[i]);
      pos++;
  }
  while (!PressDetect());  // return to main menu after press
}


void main() {                       

  Initialize();
  Calibrate();
  x_coord_old = 0;
  y_coord_old = 0;
  main_menu();  
  in_menu = 1; 
  while (1) {    // main loop
        if (!in_menu) { // draw menu on return from functions
           main_menu();
           in_menu = 1;
        }
        if (PressDetect()) {
           // read X-Y after detecting a press
           // convedrt to 128x64 space
           x_coord = GetX() - cal_x_min;
           y_coord = GetY() - cal_y_min;
           //  GetX and GetY on pen lift
           x_coord_diff = abs(x_coord - x_coord_old); // compare with the old
           y_coord_diff = abs(y_coord - y_coord_old);
           x_coord_old = x_coord;                     // save the old
           y_coord_old = y_coord;
           // ignore reading if the difference is too big
           if ( (x_coord_diff>50) || (y_coord_diff>50) )
              continue;
           x_coord128 = (x_coord * 128l) / (cal_x_max - cal_x_min);
           y_coord64 = (64 -(y_coord *64) / (cal_y_max - cal_y_min));
           // ignore if outside the screen
           if ((x_coord128 < 0) || (x_coord128 > 127))
              continue;
           if ((y_coord64 < 0) || (y_coord64 > 63))
              continue;
           // images button
           if ((x_coord128 > 8) && (x_coord128 < 58) && (y_coord64 > 22) \
                           && (y_coord64 < 33)) {
              in_menu = 0;
              images();
           }
           // Text button
           if ((x_coord128 > 68) && (x_coord128 < 118) &&                \
                           (y_coord64 > 22) && (y_coord64 < 33)) {
              in_menu = 0;
              list_text();
           }
       }
  }
}
