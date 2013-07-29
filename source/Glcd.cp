#line 1 "E:/diploma/glcd_final/Glcd.c"
#line 1 "e:/diploma/glcd_final/ks0108.h"
#line 13 "e:/diploma/glcd_final/ks0108.h"
void GLCD_Initalize(void);
void GLCD_WriteData(unsigned char);
void GLCD_WriteCommand(unsigned char, unsigned char);
void GLCD_ClearScreen(void);
void GLCD_GoTo(unsigned char, unsigned char);
void GLCD_WriteString(char *);
void GLCD_WriteChar(char );
unsigned char GLCD_ReadData(void);
void GLCD_Bitmap(code const unsigned char *, unsigned char, unsigned char, unsigned char, unsigned char);
void GLCD_SetPixel(unsigned char x, unsigned char y, unsigned char color);
#line 1 "e:/diploma/glcd_final/graphic.h"
void GLCD_Rectangle(unsigned char x, unsigned char y, unsigned char b, unsigned char a);
void GLCD_Circle(unsigned char cx, unsigned char cy ,unsigned char radius);
void GLCD_Line(unsigned int X1,unsigned int Y1,unsigned int X2,unsigned int Y2);
#line 1 "e:/diploma/glcd_final/bitmap.h"
#line 9 "e:/diploma/glcd_final/bitmap.h"
code unsigned char const picture[] = {
 0, 0, 0, 0, 4, 10, 58, 62, 122, 210, 208, 208, 208, 208, 208, 48, 188,
 60, 172, 172, 246, 247, 255, 110, 254, 190, 126, 126, 92, 152, 96, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128,
 128, 128, 128, 0, 129, 129, 141, 143, 136, 192, 80, 208, 200, 8, 8, 140,
 12, 58, 58, 71, 130, 135, 0, 161, 208, 112, 240, 160, 166, 166, 153, 139,
 142, 141, 143, 15, 27, 23, 23, 27, 15, 15, 143, 190, 187, 191, 159, 204,
 140, 143, 246, 246, 246, 230, 189, 255, 177, 189, 238, 195, 76, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 24, 28, 222, 126, 123, 57, 63, 125, 120, 15,
 15, 3, 3, 65, 193, 225, 193, 192, 192, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 99, 29, 153,
 192, 66, 199, 132, 132, 133, 135, 0, 0, 128, 80, 120, 81, 113, 118, 126,
 63, 31, 22, 227, 253, 248, 224, 192, 193, 194, 194, 194, 195, 129, 0, 1,
 131, 131, 191, 191, 230, 234, 234, 188, 248, 241, 195, 66, 71, 129, 133, 133,
 174, 255, 255, 247, 255, 255, 254, 254, 255, 251, 253, 210, 208, 0, 0, 0,
 0, 0, 0, 32, 60, 52, 247, 254, 241, 245, 239, 255, 188, 182, 254, 252,
 230, 243, 233, 247, 151, 153, 255, 247, 243, 223, 221, 252, 120, 120, 248, 104,
 120, 248, 112, 112, 48, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 16, 16, 16, 16, 16, 16,
 16, 16, 16, 31, 31, 31, 31, 17, 17, 17, 17, 17, 17, 17, 18, 18,
 25, 25, 44, 15, 31, 63, 63, 111, 127, 58, 63, 119, 119, 255, 191, 53,
 22, 31, 11, 31, 31, 47, 63, 63, 255, 207, 255, 255, 47, 37, 0, 0,
 0, 0, 0, 0, 0, 32, 251, 255, 255, 255, 255, 255, 131, 129, 193, 227,
 227, 51, 55, 229, 199, 7, 15, 11, 27, 31, 28, 56, 240, 96, 96, 97,
 97, 97, 97, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96,
 96, 96, 96, 96, 96, 224, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96,
 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96,
 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96,
 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 97, 99,
 98, 102, 108, 248, 240, 96, 96, 0, 255, 255, 255, 255, 0, 0, 0, 0,
 0, 0, 0, 2, 23, 29, 33, 33, 255, 255, 255, 255, 167, 167, 58, 24,
 120, 248, 232, 121, 123, 122, 158, 144, 0, 252, 158, 159, 127, 96, 128, 14,
 10, 10, 10, 10, 10, 10, 14, 0, 0, 0, 14, 10, 10, 10, 10, 10,
 14, 14, 0, 0, 128, 255, 248, 232, 192, 192, 254, 254, 254, 34, 34, 34,
 34, 34, 34, 254, 34, 34, 34, 34, 34, 34, 34, 254, 254, 254, 50, 0,
 0, 0, 254, 130, 186, 58, 58, 98, 98, 98, 98, 2, 254, 0, 0, 0,
 254, 254, 254, 254, 34, 34, 34, 34, 254, 254, 34, 34, 34, 34, 34, 254,
 254, 254, 224, 127, 255, 194, 222, 126, 255, 255, 255, 255, 0, 0, 0, 0,
 0, 0, 0, 0, 128, 128, 128, 96, 191, 255, 127, 255, 255, 225, 195, 207,
 140, 137, 8, 8, 8, 8, 25, 63, 59, 11, 79, 79, 73, 233, 254, 168,
 160, 160, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
 32, 32, 32, 60, 63, 39, 47, 63, 63, 125, 73, 9, 225, 64, 72, 120,
 120, 120, 121, 73, 65, 77, 81, 25, 121, 73, 121, 49, 113, 73, 73, 200,
 200, 120, 127, 80, 81, 64, 64, 64, 80, 80, 240, 224, 127, 24, 152, 144,
 201, 233, 249, 249, 56, 136, 8, 144, 241, 121, 120, 160, 248, 240, 112, 9,
 121, 63, 127, 120, 104, 77, 76, 124, 255, 255, 255, 255, 248, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 3, 3, 3, 6, 6, 12, 12, 24, 24, 16, 48, 32, 96, 96, 192,
 192, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 2,
 6, 6, 0, 0, 4, 0, 0, 2, 2, 34, 98, 98, 208, 209, 145, 145,
 16, 16, 16, 8, 8, 8, 4, 6, 2, 1, 1, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 128, 128, 192, 192, 224, 224, 248, 231, 239, 255, 119, 67, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 128, 128, 0, 192, 192, 192, 192, 192, 192, 192,
 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 64, 64, 64, 64,
 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 96, 64,
 64, 65, 65, 99, 99, 98, 102, 102, 108, 108, 120, 120, 120, 112, 112, 32,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
 1, 3, 2, 6, 6, 12, 12, 24, 24, 48, 48, 48, 48, 48, 48, 48,
 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48,
 48, 48, 48, 48, 48, 48, 48, 16, 16, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

};
#line 6 "E:/diploma/glcd_final/Glcd.c"
sbit DRIVE_A at RC0_bit;
sbit DRIVE_B at RC1_bit;
sbit DRIVE_A_Direction at TRISC0_bit;
sbit DRIVE_B_Direction at TRISC1_bit;
const char READ_X_CHANNEL = 0;
const char READ_Y_CHANNEL = 1;


const unsigned int ADC_THRESHOLD = 900;
unsigned int x_coord, y_coord, x_coord_old, y_coord_old, x_coord_diff, y_coord_diff;
long x_coord128, y_coord64;
int cal_x_min, cal_y_min, cal_x_max, cal_y_max;
unsigned short in_menu;
#line 70 "E:/diploma/glcd_final/Glcd.c"
code const char demotext[] = "***** CONCLUZII *****                     * Prezentarea unui   mediu de programare  integrat extrem de   puternic, in limbaj  C, pentru            microcontrolere.     ---------------------                     * Prezentarea kituluide dezvoltare folosita interfetelor sale  specifice si a       functiilor oferite.  ---------------------                     * Realizarea unei    biblioteci grafice cepermite folosirea    unui ecran grafic    KS0108 impreuna cu unmicrocontroler PIC.  Cu mici modificari   aceasta biblioteca   poate fi folosita si cu alte              microcontrolere si inalte medii de        programare C.        ---------------------                     * Realizarea unui    program de conversie a imaginilor din     format .bmp de orice dimensiune in        formatul 128x64      pixeli monocrom,     cerut de afisajul    grafic KS0108,       program care ruleaza pe un calculator     compatibil PC,       permitand folosirea  lor in cadrul        aplicatiilor cu      microcontroler.      ---------------------";


char PressDetect() {
 unsigned adc_rd;
 char result;

 DRIVE_A = 0;
 DRIVE_B = 0;
 Delay_ms(5);
 adc_rd = ADC_Read(READ_Y_CHANNEL);
 result = (adc_rd > ADC_THRESHOLD);

 Delay_ms(2);
 adc_rd = ADC_Read(READ_Y_CHANNEL);
 result = result & (adc_rd > ADC_THRESHOLD);
 return result;
}


unsigned int GetX() {
 unsigned int result;

 DRIVE_A = 1;
 DRIVE_B = 0;
 Delay_ms(5);
 result = ADC_Read(READ_X_CHANNEL);
 return result;
}


unsigned int GetY() {
 unsigned int result;

 DRIVE_A = 0;
 DRIVE_B = 1;
 Delay_ms(5);
 result = ADC_Read(READ_Y_CHANNEL);
 return result;
}


void Calibrate() {
 GLCD_ClearScreen();
 Glcd_SetPixel(0,63,1);
 GLCD_GoTo(10,6);
 GLCD_WriteString("Atingeti punctul");
 while (!PressDetect());


 cal_x_min = GetX() - 10;
 cal_y_min = GetY() - 10;
 Delay_ms(1000);
 GLCD_ClearScreen();
 Glcd_SetPixel(127,0,1);
 GLCD_GoTo(30,1);
 GLCD_WriteString("Atingeti punctul");
 while (!PressDetect()) ;
 cal_x_max = GetX() + 5;
 cal_y_max = GetY() + 5;
 Delay_ms(1000);
}


void Initialize() {

 DRIVE_A_Direction = 0;
 DRIVE_B_Direction = 0;
 ANSEL = 3;
 ANSELH = 0;
 TRISA = 3;
 C1ON_bit = 0;
 C2ON_bit = 0;
 GLCD_Initalize();
}


void main_menu() {

 GLCD_ClearScreen();

 GLCD_Rectangle(8,22,50,11);
 GLCD_GoTo(11,3);
 GLCD_WriteString("Bitmap");

 GLCD_Rectangle(68,22,50,11);
 GLCD_GoTo(71,3);
 GLCD_WriteString("Text");

 GLCD_GoTo(11,5);
 GLCD_WriteString("Proiect de licenta");
 GLCD_GoTo(5,6);
 GLCD_WriteString("Vulcan Silviu - 2009");
}



void images() {

 GLCD_ClearScreen();
 GLCD_Bitmap(picture,0,0,128,64);
 while (!PressDetect());
}



void list_text() {
 unsigned short pos,rand;
 unsigned int i,dimtext;

 GLCD_ClearScreen();
 dimtext = (sizeof(demotext) / sizeof(demotext[1])) - 1;

 pos = 0;
 rand = 0;
 GLCD_GoTo(0,0);
 for (i = 0; i < dimtext; i++) {
 if (pos == 21) {
 if (rand < 7 ) rand++;
 else {
 while (!PressDetect());
 rand = 0;
 GLCD_ClearScreen();
 }
 pos = 0;
 GLCD_GoTo(0,rand);
 }
 GLCD_WriteChar(demotext[i]);
 pos++;
 }
 while (!PressDetect());
}


void main() {

 Initialize();
 Calibrate();
 x_coord_old = 0;
 y_coord_old = 0;
 main_menu();
 in_menu = 1;
 while (1) {
 if (!in_menu) {
 main_menu();
 in_menu = 1;
 }
 if (PressDetect()) {


 x_coord = GetX() - cal_x_min;
 y_coord = GetY() - cal_y_min;


 x_coord_diff = abs(x_coord - x_coord_old);
 y_coord_diff = abs(y_coord - y_coord_old);
 x_coord_old = x_coord;
 y_coord_old = y_coord;

 if ( (x_coord_diff>50) || (y_coord_diff>50) )
 continue;
 x_coord128 = (x_coord * 128l) / (cal_x_max - cal_x_min);
 y_coord64 = (64 -(y_coord *64) / (cal_y_max - cal_y_min));

 if ((x_coord128 < 0) || (x_coord128 > 127))
 continue;
 if ((y_coord64 < 0) || (y_coord64 > 63))
 continue;
#line 240 "E:/diploma/glcd_final/Glcd.c"
 if ((x_coord128 > 8) && (x_coord128 < 58) && (y_coord64 > 22) && (y_coord64 < 33)) {
 in_menu = 0;
 images();
 }
#line 246 "E:/diploma/glcd_final/Glcd.c"
 if ((x_coord128 > 68) && (x_coord128 < 118) && (y_coord64 > 22) && (y_coord64 < 33)) {
 in_menu = 0;
 list_text();
 }
 }
 }
}
