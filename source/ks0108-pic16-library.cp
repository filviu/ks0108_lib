#line 1 "E:/diploma/libtestscratch/ks0108-pic16-library.c"
#line 18 "E:/diploma/libtestscratch/ks0108-pic16-library.c"
extern unsigned char screen_x, screen_y;



void GLCD_Delay(void)
{
 asm{
 nop;
 }
}



void GLCD_InitializePorts(void)
{
 PORTB  |= ( (1 << 5)  |  (1 << 4)  |  (1 << 5) );
 TRISB  &= ~( (1 << 5)  |  (1 << 4)  |  (1 << 5)  |  (1 << 0)  |  (1 << 1)  |  (1 << 2) );
}



void GLCD_EnableController(unsigned char controller)
{
switch(controller){
 case 0 :  PORTB  &= ~ (1 << 5) ; break;
 case 1 :  PORTB  &= ~ (1 << 4) ; break;
 case 2 :  PORTB  &= ~ (1 << 5) ; break;
 }
}



void GLCD_DisableController(unsigned char controller)
{
switch(controller){
 case 0 :  PORTB  |=  (1 << 5) ; break;
 case 1 :  PORTB  |=  (1 << 4) ; break;
 case 2 :  PORTB  |=  (1 << 5) ; break;
 }
}



unsigned char GLCD_ReadStatus(unsigned char controller)
{
unsigned char status;
 TRISB  = 0xFF;
 PORTB  |=  (1 << 1) ;
 PORTB  &= ~ (1 << 0) ;
GLCD_EnableController(controller);
 PORTB  |=  (1 << 2) ;
GLCD_Delay();
status =  PORTB ;
 PORTB  &= ~ (1 << 2) ;
GLCD_DisableController(controller);
return status;
}



void GLCD_WriteCommand(unsigned char commandToWrite, unsigned char controller)
{
while(GLCD_ReadStatus(controller)& 0x80 );
 TRISB  = 0x00;
 PORTB  &= ~( (1 << 1)  |  (1 << 0) );
GLCD_EnableController(controller);
 PORTB  = commandToWrite;
 PORTB  |=  (1 << 2) ;
GLCD_Delay();
 PORTB  &= ~ (1 << 2) ;
GLCD_DisableController(controller);
}



unsigned char GLCD_ReadData(void)
{
unsigned char date;
while(GLCD_ReadStatus(screen_x / 64)& 0x80 );
 TRISB  = 0xFF;
 PORTB  |= ( (1 << 1)  |  (1 << 0) );
GLCD_EnableController(screen_x / 64);

 PORTB  |=  (1 << 2) ;
GLCD_Delay();
date =  PORTB ;
 PORTB  &= ~ (1 << 2) ;
GLCD_DisableController(screen_x / 64);
screen_x++;
return date;
}



void GLCD_WriteData(unsigned char dataToWrite)
{
while(GLCD_ReadStatus(screen_x / 64)& 0x80 );
 TRISB  = 0x00;
 PORTB  &= ~ (1 << 1) ;
 PORTB  |=  (1 << 0) ;
 PORTB  = dataToWrite;
GLCD_EnableController(screen_x / 64);
 PORTB  |=  (1 << 2) ;
GLCD_Delay();
 PORTB  &= ~ (1 << 2) ;
GLCD_DisableController(screen_x / 64);
screen_x++;
}



unsigned char GLCD_ReadByteFromROMMemory(char * ptr)
{
 return *(ptr);
}
