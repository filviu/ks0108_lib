#line 1 "E:/diploma/glcd_final/ks0108-pic16.c"
#line 27 "E:/diploma/glcd_final/ks0108-pic16.c"
extern unsigned char screen_x, screen_y;


void GLCD_Delay(void) {

 asm {
 nop;
 }
}


void GLCD_InitalizePorts(void) {

  PORTB  |= ( (1 << 0)  |  (1 << 1)  |  (1 << 0)  |  (1 << 5) );

  TRISB  &= ~( (1 << 0)  |  (1 << 1)  |  (1 << 5)  |  (1 << 2)  |  (1 << 3)  |  (1 << 4) );
}


void GLCD_EnableController(unsigned char controller) {

 switch(controller){
 case 0 :  PORTB  &= ~ (1 << 0) ; break;
 case 1 :  PORTB  &= ~ (1 << 1) ; break;
 case 2 :  PORTB  &= ~ (1 << 0) ; break;
 }
}


void GLCD_DisableController(unsigned char controller) {
 switch(controller){
 case 0 :  PORTB  |=  (1 << 0) ; break;
 case 1 :  PORTB  |=  (1 << 1) ; break;
 case 2 :  PORTB  |=  (1 << 0) ; break;
 }
}


unsigned char GLCD_ReadStatus(unsigned char controller) {

unsigned char status;

  TRISD  = 0xFF;
  PORTB  |=  (1 << 3) ;
  PORTB  &= ~ (1 << 2) ;
 GLCD_EnableController(controller);
  PORTB  |=  (1 << 4) ;
 GLCD_Delay();
 status =  PORTD ;
  PORTB  &= ~ (1 << 4) ;
 GLCD_DisableController(controller);
 return status;
}


void GLCD_WriteCommand(unsigned char commandToWrite, unsigned char controller) {

 while(GLCD_ReadStatus(controller)& 0x80 );
  TRISD  = 0x00;
  PORTB  &= ~( (1 << 3)  |  (1 << 2) );
 GLCD_EnableController(controller);
  PORTD  = commandToWrite;
  PORTB  |=  (1 << 4) ;
 GLCD_Delay();
  PORTB  &= ~ (1 << 4) ;
 GLCD_DisableController(controller);
}


unsigned char GLCD_ReadData(void) {

 unsigned char date;
 while(GLCD_ReadStatus(screen_x / 64)& 0x80 );
  TRISD  = 0xFF;
  PORTB  |= ( (1 << 3)  |  (1 << 2) );
 GLCD_EnableController(screen_x / 64);

  PORTB  |=  (1 << 4) ;
 GLCD_Delay();
 date =  PORTD ;
  PORTB  &= ~ (1 << 4) ;
 GLCD_DisableController(screen_x / 64);
 screen_x++;
 return date;
}


void GLCD_WriteData(unsigned char dataToWrite) {

 while(GLCD_ReadStatus(screen_x / 64)& 0x80 );
  TRISD  = 0x00;
  PORTB  &= ~ (1 << 3) ;
  PORTB  |=  (1 << 2) ;
  PORTD  = dataToWrite;
 GLCD_EnableController(screen_x / 64);
  PORTB  |=  (1 << 4) ;
 GLCD_Delay();
  PORTB  &= ~ (1 << 4) ;
 GLCD_DisableController(screen_x / 64);
 screen_x++;
}
