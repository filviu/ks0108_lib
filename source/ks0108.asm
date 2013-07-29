
_GLCD_Initalize:
;ks0108.c,8 :: 		void GLCD_Initalize(void) {
;ks0108.c,10 :: 		GLCD_InitalizePorts();
	CALL       _GLCD_InitalizePorts+0
;ks0108.c,11 :: 		GLCD_WriteCommand((DISPLAY_ON_CMD | ON), 0);
	MOVLW      63
	MOVWF      FARG_GLCD_WriteCommand+0
	CLRF       FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,12 :: 		GLCD_WriteCommand((DISPLAY_ON_CMD | ON), 1);
	MOVLW      63
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVLW      1
	MOVWF      FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,13 :: 		GLCD_WriteCommand((DISPLAY_ON_CMD | ON), 2);
	MOVLW      63
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVLW      2
	MOVWF      FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,14 :: 		}
	RETURN
; end of _GLCD_Initalize

_GLCD_GoTo:
;ks0108.c,17 :: 		void GLCD_GoTo(unsigned char x, unsigned char y) {
;ks0108.c,21 :: 		screen_x = x;
	MOVF       FARG_GLCD_GoTo_x+0, 0
	MOVWF      _screen_x+0
;ks0108.c,22 :: 		screen_y = y;
	MOVF       FARG_GLCD_GoTo_y+0, 0
	MOVWF      _screen_y+0
;ks0108.c,23 :: 		for(i = 0; i < KS0108_SCREEN_WIDTH/64; i++) {
	CLRF       GLCD_GoTo_i_L0+0
L_GLCD_GoTo0:
	MOVLW      2
	SUBWF      GLCD_GoTo_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_GoTo1
;ks0108.c,24 :: 		GLCD_WriteCommand(DISPLAY_SET_Y | 0,i);
	MOVLW      64
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVF       GLCD_GoTo_i_L0+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,25 :: 		GLCD_WriteCommand(DISPLAY_SET_X | y,i);
	MOVLW      184
	IORWF      FARG_GLCD_GoTo_y+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVF       GLCD_GoTo_i_L0+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,26 :: 		GLCD_WriteCommand(DISPLAY_START_LINE | 0,i);
	MOVLW      192
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVF       GLCD_GoTo_i_L0+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	CALL       _GLCD_WriteCommand+0
;ks0108.c,23 :: 		for(i = 0; i < KS0108_SCREEN_WIDTH/64; i++) {
	INCF       GLCD_GoTo_i_L0+0, 1
;ks0108.c,27 :: 		}
	GOTO       L_GLCD_GoTo0
L_GLCD_GoTo1:
;ks0108.c,28 :: 		GLCD_WriteCommand(DISPLAY_SET_Y | (x % 64), (x / 64));
	MOVLW      64
	MOVWF      R4+0
	MOVF       FARG_GLCD_GoTo_x+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      64
	IORWF      R0+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVLW      6
	MOVWF      R0+0
	MOVF       FARG_GLCD_GoTo_x+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVF       R0+0, 0
L__GLCD_GoTo22:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_GoTo23
	RRF        FARG_GLCD_WriteCommand+0, 1
	BCF        FARG_GLCD_WriteCommand+0, 7
	ADDLW      255
	GOTO       L__GLCD_GoTo22
L__GLCD_GoTo23:
	CALL       _GLCD_WriteCommand+0
;ks0108.c,29 :: 		GLCD_WriteCommand(DISPLAY_SET_X | y, (x / 64));
	MOVLW      184
	IORWF      FARG_GLCD_GoTo_y+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVLW      6
	MOVWF      R0+0
	MOVF       FARG_GLCD_GoTo_x+0, 0
	MOVWF      FARG_GLCD_WriteCommand+0
	MOVF       R0+0, 0
L__GLCD_GoTo24:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_GoTo25
	RRF        FARG_GLCD_WriteCommand+0, 1
	BCF        FARG_GLCD_WriteCommand+0, 7
	ADDLW      255
	GOTO       L__GLCD_GoTo24
L__GLCD_GoTo25:
	CALL       _GLCD_WriteCommand+0
;ks0108.c,30 :: 		}
	RETURN
; end of _GLCD_GoTo

_GLCD_ClearScreen:
;ks0108.c,33 :: 		void GLCD_ClearScreen(void) {
;ks0108.c,37 :: 		for(j = 0; j < KS0108_SCREEN_HEIGHT/8; j++) {
	CLRF       GLCD_ClearScreen_j_L0+0
L_GLCD_ClearScreen3:
	MOVLW      8
	SUBWF      GLCD_ClearScreen_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_ClearScreen4
;ks0108.c,38 :: 		GLCD_GoTo(0,j);
	CLRF       FARG_GLCD_GoTo_x+0
	MOVF       GLCD_ClearScreen_j_L0+0, 0
	MOVWF      FARG_GLCD_GoTo_y+0
	CALL       _GLCD_GoTo+0
;ks0108.c,39 :: 		for(i = 0; i < KS0108_SCREEN_WIDTH; i++)
	CLRF       GLCD_ClearScreen_i_L0+0
L_GLCD_ClearScreen6:
	MOVLW      128
	SUBWF      GLCD_ClearScreen_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_ClearScreen7
;ks0108.c,40 :: 		GLCD_WriteData(0x00);
	CLRF       FARG_GLCD_WriteData+0
	CALL       _GLCD_WriteData+0
;ks0108.c,39 :: 		for(i = 0; i < KS0108_SCREEN_WIDTH; i++)
	INCF       GLCD_ClearScreen_i_L0+0, 1
;ks0108.c,40 :: 		GLCD_WriteData(0x00);
	GOTO       L_GLCD_ClearScreen6
L_GLCD_ClearScreen7:
;ks0108.c,37 :: 		for(j = 0; j < KS0108_SCREEN_HEIGHT/8; j++) {
	INCF       GLCD_ClearScreen_j_L0+0, 1
;ks0108.c,41 :: 		}
	GOTO       L_GLCD_ClearScreen3
L_GLCD_ClearScreen4:
;ks0108.c,42 :: 		}
	RETURN
; end of _GLCD_ClearScreen

_GLCD_WriteChar:
;ks0108.c,45 :: 		void GLCD_WriteChar(char charToWrite) {
;ks0108.c,49 :: 		charToWrite -= 32;
	MOVLW      32
	SUBWF      FARG_GLCD_WriteChar_charToWrite+0, 1
;ks0108.c,50 :: 		for(i = 0; i < 5; i++)
	CLRF       GLCD_WriteChar_i_L0+0
	CLRF       GLCD_WriteChar_i_L0+1
L_GLCD_WriteChar9:
	MOVLW      128
	XORWF      GLCD_WriteChar_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_WriteChar26
	MOVLW      5
	SUBWF      GLCD_WriteChar_i_L0+0, 0
L__GLCD_WriteChar26:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_WriteChar10
;ks0108.c,51 :: 		GLCD_WriteData(font5x7[charToWrite * 5 + i]);
	MOVF       FARG_GLCD_WriteChar_charToWrite+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       GLCD_WriteChar_i_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       GLCD_WriteChar_i_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVLW      font5x7_font5x7+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(font5x7_font5x7+0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_GLCD_WriteData+0
	CALL       _GLCD_WriteData+0
;ks0108.c,50 :: 		for(i = 0; i < 5; i++)
	INCF       GLCD_WriteChar_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       GLCD_WriteChar_i_L0+1, 1
;ks0108.c,51 :: 		GLCD_WriteData(font5x7[charToWrite * 5 + i]);
	GOTO       L_GLCD_WriteChar9
L_GLCD_WriteChar10:
;ks0108.c,52 :: 		GLCD_WriteData(0x00);
	CLRF       FARG_GLCD_WriteData+0
	CALL       _GLCD_WriteData+0
;ks0108.c,53 :: 		}
	RETURN
; end of _GLCD_WriteChar

_GLCD_WriteString:
;ks0108.c,56 :: 		void GLCD_WriteString(char * stringToWrite) {
;ks0108.c,58 :: 		while(*stringToWrite)
L_GLCD_WriteString12:
	MOVF       FARG_GLCD_WriteString_stringToWrite+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_WriteString13
;ks0108.c,59 :: 		GLCD_WriteChar(*stringToWrite++);
	MOVF       FARG_GLCD_WriteString_stringToWrite+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_GLCD_WriteChar_charToWrite+0
	CALL       _GLCD_WriteChar+0
	INCF       FARG_GLCD_WriteString_stringToWrite+0, 1
	GOTO       L_GLCD_WriteString12
L_GLCD_WriteString13:
;ks0108.c,60 :: 		}
	RETURN
; end of _GLCD_WriteString

_GLCD_SetPixel:
;ks0108.c,63 :: 		void GLCD_SetPixel(unsigned char x, unsigned char y, unsigned char color) {
;ks0108.c,67 :: 		GLCD_GoTo(x, (y / 8));
	MOVF       FARG_GLCD_SetPixel_x+0, 0
	MOVWF      FARG_GLCD_GoTo_x+0
	MOVF       FARG_GLCD_SetPixel_y+0, 0
	MOVWF      FARG_GLCD_GoTo_y+0
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	CALL       _GLCD_GoTo+0
;ks0108.c,68 :: 		tmp = GLCD_ReadData();
	CALL       _GLCD_ReadData+0
	MOVF       R0+0, 0
	MOVWF      GLCD_SetPixel_tmp_L0+0
;ks0108.c,69 :: 		GLCD_GoTo(x, (y / 8));
	MOVF       FARG_GLCD_SetPixel_x+0, 0
	MOVWF      FARG_GLCD_GoTo_x+0
	MOVF       FARG_GLCD_SetPixel_y+0, 0
	MOVWF      FARG_GLCD_GoTo_y+0
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	CALL       _GLCD_GoTo+0
;ks0108.c,70 :: 		tmp = GLCD_ReadData();
	CALL       _GLCD_ReadData+0
	MOVF       R0+0, 0
	MOVWF      GLCD_SetPixel_tmp_L0+0
;ks0108.c,71 :: 		GLCD_GoTo(x, (y / 8));
	MOVF       FARG_GLCD_SetPixel_x+0, 0
	MOVWF      FARG_GLCD_GoTo_x+0
	MOVF       FARG_GLCD_SetPixel_y+0, 0
	MOVWF      FARG_GLCD_GoTo_y+0
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	RRF        FARG_GLCD_GoTo_y+0, 1
	BCF        FARG_GLCD_GoTo_y+0, 7
	CALL       _GLCD_GoTo+0
;ks0108.c,72 :: 		if (color == 1)
	MOVF       FARG_GLCD_SetPixel_color+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_GLCD_SetPixel14
;ks0108.c,73 :: 		tmp |= (1 << (y % 8));
	MOVLW      8
	MOVWF      R4+0
	MOVF       FARG_GLCD_SetPixel_y+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__GLCD_SetPixel27:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_SetPixel28
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__GLCD_SetPixel27
L__GLCD_SetPixel28:
	MOVF       R0+0, 0
	IORWF      GLCD_SetPixel_tmp_L0+0, 1
	GOTO       L_GLCD_SetPixel15
L_GLCD_SetPixel14:
;ks0108.c,75 :: 		tmp &= ~(1 << (y % 8));
	MOVLW      8
	MOVWF      R4+0
	MOVF       FARG_GLCD_SetPixel_y+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__GLCD_SetPixel29:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_SetPixel30
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__GLCD_SetPixel29
L__GLCD_SetPixel30:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      GLCD_SetPixel_tmp_L0+0, 1
L_GLCD_SetPixel15:
;ks0108.c,76 :: 		GLCD_WriteData(tmp);
	MOVF       GLCD_SetPixel_tmp_L0+0, 0
	MOVWF      FARG_GLCD_WriteData+0
	CALL       _GLCD_WriteData+0
;ks0108.c,77 :: 		}
	RETURN
; end of _GLCD_SetPixel

_GLCD_Bitmap:
;ks0108.c,81 :: 		unsigned char y, unsigned char dx, unsigned char dy) {
;ks0108.c,86 :: 		pos = 0;
	CLRF       GLCD_Bitmap_pos_L0+0
	CLRF       GLCD_Bitmap_pos_L0+1
;ks0108.c,87 :: 		for(j = 0; j < dy / 8; j++) {
	CLRF       GLCD_Bitmap_j_L0+0
L_GLCD_Bitmap16:
	MOVF       FARG_GLCD_Bitmap_dy+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	MOVF       R1+0, 0
	SUBWF      GLCD_Bitmap_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Bitmap17
;ks0108.c,88 :: 		GLCD_GoTo(x,y + j);
	MOVF       FARG_GLCD_Bitmap_x+0, 0
	MOVWF      FARG_GLCD_GoTo_x+0
	MOVF       GLCD_Bitmap_j_L0+0, 0
	ADDWF      FARG_GLCD_Bitmap_y+0, 0
	MOVWF      FARG_GLCD_GoTo_y+0
	CALL       _GLCD_GoTo+0
;ks0108.c,89 :: 		for(i = 0; i < dx; i++)
	CLRF       GLCD_Bitmap_i_L0+0
L_GLCD_Bitmap19:
	MOVF       FARG_GLCD_Bitmap_dx+0, 0
	SUBWF      GLCD_Bitmap_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Bitmap20
;ks0108.c,90 :: 		GLCD_WriteData(bmp[pos++]);
	MOVF       GLCD_Bitmap_pos_L0+0, 0
	ADDWF      FARG_GLCD_Bitmap_bmp+0, 0
	MOVWF      R0+0
	MOVF       FARG_GLCD_Bitmap_bmp+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Bitmap_pos_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_GLCD_WriteData+0
	CALL       _GLCD_WriteData+0
	INCF       GLCD_Bitmap_pos_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       GLCD_Bitmap_pos_L0+1, 1
;ks0108.c,89 :: 		for(i = 0; i < dx; i++)
	INCF       GLCD_Bitmap_i_L0+0, 1
;ks0108.c,90 :: 		GLCD_WriteData(bmp[pos++]);
	GOTO       L_GLCD_Bitmap19
L_GLCD_Bitmap20:
;ks0108.c,87 :: 		for(j = 0; j < dy / 8; j++) {
	INCF       GLCD_Bitmap_j_L0+0, 1
;ks0108.c,91 :: 		}
	GOTO       L_GLCD_Bitmap16
L_GLCD_Bitmap17:
;ks0108.c,92 :: 		}
	RETURN
; end of _GLCD_Bitmap
