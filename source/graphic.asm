
_GLCD_Rectangle:
;graphic.c,5 :: 		void GLCD_Rectangle(unsigned char x, unsigned char y, unsigned char b, unsigned char a)
;graphic.c,9 :: 		for (j = 0; j < a; j++) {
	CLRF       GLCD_Rectangle_j_L0+0
L_GLCD_Rectangle0:
	MOVF       FARG_GLCD_Rectangle_a+0, 0
	SUBWF      GLCD_Rectangle_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Rectangle1
;graphic.c,10 :: 		GLCD_SetPixel(x, y + j, color);
	MOVF       FARG_GLCD_Rectangle_x+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Rectangle_j_L0+0, 0
	ADDWF      FARG_GLCD_Rectangle_y+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,11 :: 		GLCD_SetPixel(x + b - 1, y + j, color);
	MOVF       FARG_GLCD_Rectangle_b+0, 0
	ADDWF      FARG_GLCD_Rectangle_x+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	DECF       FARG_GLCD_SetPixel_x+0, 1
	MOVF       GLCD_Rectangle_j_L0+0, 0
	ADDWF      FARG_GLCD_Rectangle_y+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,9 :: 		for (j = 0; j < a; j++) {
	INCF       GLCD_Rectangle_j_L0+0, 1
;graphic.c,12 :: 		}
	GOTO       L_GLCD_Rectangle0
L_GLCD_Rectangle1:
;graphic.c,14 :: 		for (j = 0; j < b; j++)        {
	CLRF       GLCD_Rectangle_j_L0+0
L_GLCD_Rectangle3:
	MOVF       FARG_GLCD_Rectangle_b+0, 0
	SUBWF      GLCD_Rectangle_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Rectangle4
;graphic.c,15 :: 		GLCD_SetPixel(x + j, y, color);
	MOVF       GLCD_Rectangle_j_L0+0, 0
	ADDWF      FARG_GLCD_Rectangle_x+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       FARG_GLCD_Rectangle_y+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,16 :: 		GLCD_SetPixel(x + j, y + a - 1, color);
	MOVF       GLCD_Rectangle_j_L0+0, 0
	ADDWF      FARG_GLCD_Rectangle_x+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       FARG_GLCD_Rectangle_a+0, 0
	ADDWF      FARG_GLCD_Rectangle_y+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	DECF       FARG_GLCD_SetPixel_y+0, 1
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,14 :: 		for (j = 0; j < b; j++)        {
	INCF       GLCD_Rectangle_j_L0+0, 1
;graphic.c,17 :: 		}
	GOTO       L_GLCD_Rectangle3
L_GLCD_Rectangle4:
;graphic.c,18 :: 		}
	RETURN
; end of _GLCD_Rectangle

_GLCD_Circle:
;graphic.c,21 :: 		void GLCD_Circle(unsigned char cx, unsigned char cy ,unsigned char radius)
;graphic.c,24 :: 		x = radius;
	MOVF       FARG_GLCD_Circle_radius+0, 0
	MOVWF      GLCD_Circle_x_L0+0
	CLRF       GLCD_Circle_x_L0+1
;graphic.c,25 :: 		y = 0;
	CLRF       GLCD_Circle_y_L0+0
	CLRF       GLCD_Circle_y_L0+1
;graphic.c,26 :: 		xchange = 1 - 2 * radius;
	MOVF       FARG_GLCD_Circle_radius+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	SUBLW      1
	MOVWF      GLCD_Circle_xchange_L0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       GLCD_Circle_xchange_L0+1
	SUBWF      GLCD_Circle_xchange_L0+1, 1
;graphic.c,27 :: 		ychange = 1;
	MOVLW      1
	MOVWF      GLCD_Circle_ychange_L0+0
	MOVLW      0
	MOVWF      GLCD_Circle_ychange_L0+1
;graphic.c,28 :: 		radiusError = 0;
	CLRF       GLCD_Circle_radiusError_L0+0
	CLRF       GLCD_Circle_radiusError_L0+1
;graphic.c,29 :: 		while(x >= y-1)
L_GLCD_Circle6:
	MOVLW      1
	SUBWF      GLCD_Circle_y_L0+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      GLCD_Circle_y_L0+1, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      GLCD_Circle_x_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Circle23
	MOVF       R1+0, 0
	SUBWF      GLCD_Circle_x_L0+0, 0
L__GLCD_Circle23:
	BTFSS      STATUS+0, 0
	GOTO       L_GLCD_Circle7
;graphic.c,31 :: 		GLCD_SetPixel(cx+x, cy+y, color);
	MOVF       GLCD_Circle_x_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_y_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,32 :: 		GLCD_SetPixel(cx-x, cy+y, color);
	MOVF       GLCD_Circle_x_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_y_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,33 :: 		GLCD_SetPixel(cx-x, cy-y, color);
	MOVF       GLCD_Circle_x_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_y_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,34 :: 		GLCD_SetPixel(cx+x, cy-y, color);
	MOVF       GLCD_Circle_x_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_y_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,35 :: 		GLCD_SetPixel(cx+y, cy+x, color);
	MOVF       GLCD_Circle_y_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_x_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,36 :: 		GLCD_SetPixel(cx-y, cy+x, color);
	MOVF       GLCD_Circle_y_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_x_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,37 :: 		GLCD_SetPixel(cx-y, cy-x, color);
	MOVF       GLCD_Circle_y_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_x_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,38 :: 		GLCD_SetPixel(cx+y, cy-x, color);
	MOVF       GLCD_Circle_y_L0+0, 0
	ADDWF      FARG_GLCD_Circle_cx+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Circle_x_L0+0, 0
	SUBWF      FARG_GLCD_Circle_cy+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,39 :: 		y++;
	INCF       GLCD_Circle_y_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       GLCD_Circle_y_L0+1, 1
;graphic.c,40 :: 		radiusError += ychange;
	MOVF       GLCD_Circle_ychange_L0+0, 0
	ADDWF      GLCD_Circle_radiusError_L0+0, 0
	MOVWF      R3+0
	MOVF       GLCD_Circle_radiusError_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Circle_ychange_L0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      GLCD_Circle_radiusError_L0+0
	MOVF       R3+1, 0
	MOVWF      GLCD_Circle_radiusError_L0+1
;graphic.c,41 :: 		ychange += 2;
	MOVLW      2
	ADDWF      GLCD_Circle_ychange_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       GLCD_Circle_ychange_L0+1, 1
;graphic.c,42 :: 		if ( 2*radiusError + xchange > 0 )
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       GLCD_Circle_xchange_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Circle_xchange_L0+1, 0
	MOVWF      R2+1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Circle24
	MOVF       R2+0, 0
	SUBLW      0
L__GLCD_Circle24:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Circle8
;graphic.c,44 :: 		x--;
	MOVLW      1
	SUBWF      GLCD_Circle_x_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       GLCD_Circle_x_L0+1, 1
;graphic.c,45 :: 		radiusError += xchange;
	MOVF       GLCD_Circle_xchange_L0+0, 0
	ADDWF      GLCD_Circle_radiusError_L0+0, 1
	MOVF       GLCD_Circle_xchange_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Circle_radiusError_L0+1, 1
;graphic.c,46 :: 		xchange += 2;
	MOVLW      2
	ADDWF      GLCD_Circle_xchange_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       GLCD_Circle_xchange_L0+1, 1
;graphic.c,47 :: 		}
L_GLCD_Circle8:
;graphic.c,48 :: 		}
	GOTO       L_GLCD_Circle6
L_GLCD_Circle7:
;graphic.c,49 :: 		}
	RETURN
; end of _GLCD_Circle

_GLCD_Line:
;graphic.c,52 :: 		void GLCD_Line(unsigned int X1,unsigned int Y1,unsigned int X2,unsigned int Y2)
;graphic.c,58 :: 		Dx = (X2-X1);
	MOVF       FARG_GLCD_Line_X1+0, 0
	SUBWF      FARG_GLCD_Line_X2+0, 0
	MOVWF      R2+0
	MOVF       FARG_GLCD_Line_X1+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_GLCD_Line_X2+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      GLCD_Line_Dx_L0+0
	MOVF       R2+1, 0
	MOVWF      GLCD_Line_Dx_L0+1
;graphic.c,59 :: 		Dy = (Y2-Y1);
	MOVF       FARG_GLCD_Line_Y1+0, 0
	SUBWF      FARG_GLCD_Line_Y2+0, 0
	MOVWF      R0+0
	MOVF       FARG_GLCD_Line_Y1+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_GLCD_Line_Y2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      GLCD_Line_Dy_L0+0
	MOVF       R0+1, 0
	MOVWF      GLCD_Line_Dy_L0+1
;graphic.c,61 :: 		TwoDx = Dx + Dx;
	MOVF       R2+0, 0
	ADDWF      R2+0, 0
	MOVWF      GLCD_Line_TwoDx_L0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      GLCD_Line_TwoDx_L0+1
;graphic.c,62 :: 		TwoDy = Dy + Dy;
	MOVF       R0+0, 0
	ADDWF      R0+0, 0
	MOVWF      GLCD_Line_TwoDy_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      GLCD_Line_TwoDy_L0+1
;graphic.c,64 :: 		CurrentX = X1;
	MOVF       FARG_GLCD_Line_X1+0, 0
	MOVWF      GLCD_Line_CurrentX_L0+0
	MOVF       FARG_GLCD_Line_X1+1, 0
	MOVWF      GLCD_Line_CurrentX_L0+1
;graphic.c,65 :: 		CurrentY = Y1;
	MOVF       FARG_GLCD_Line_Y1+0, 0
	MOVWF      GLCD_Line_CurrentY_L0+0
	MOVF       FARG_GLCD_Line_Y1+1, 0
	MOVWF      GLCD_Line_CurrentY_L0+1
;graphic.c,67 :: 		Xinc = 1;
	MOVLW      1
	MOVWF      GLCD_Line_Xinc_L0+0
	MOVLW      0
	MOVWF      GLCD_Line_Xinc_L0+1
;graphic.c,68 :: 		Yinc = 1;
	MOVLW      1
	MOVWF      GLCD_Line_Yinc_L0+0
	MOVLW      0
	MOVWF      GLCD_Line_Yinc_L0+1
;graphic.c,70 :: 		if(Dx < 0)
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line25
	MOVLW      0
	SUBWF      R2+0, 0
L__GLCD_Line25:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Line9
;graphic.c,72 :: 		Xinc = -1;
	MOVLW      255
	MOVWF      GLCD_Line_Xinc_L0+0
	MOVLW      255
	MOVWF      GLCD_Line_Xinc_L0+1
;graphic.c,73 :: 		Dx = -Dx;
	MOVF       GLCD_Line_Dx_L0+0, 0
	SUBLW      0
	MOVWF      GLCD_Line_Dx_L0+0
	MOVF       GLCD_Line_Dx_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       GLCD_Line_Dx_L0+1
	SUBWF      GLCD_Line_Dx_L0+1, 1
;graphic.c,74 :: 		TwoDx = -TwoDx;
	MOVF       GLCD_Line_TwoDx_L0+0, 0
	SUBLW      0
	MOVWF      GLCD_Line_TwoDx_L0+0
	MOVF       GLCD_Line_TwoDx_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       GLCD_Line_TwoDx_L0+1
	SUBWF      GLCD_Line_TwoDx_L0+1, 1
;graphic.c,75 :: 		}
L_GLCD_Line9:
;graphic.c,77 :: 		if (Dy < 0)
	MOVLW      128
	XORWF      GLCD_Line_Dy_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line26
	MOVLW      0
	SUBWF      GLCD_Line_Dy_L0+0, 0
L__GLCD_Line26:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Line10
;graphic.c,79 :: 		Yinc = -1;
	MOVLW      255
	MOVWF      GLCD_Line_Yinc_L0+0
	MOVLW      255
	MOVWF      GLCD_Line_Yinc_L0+1
;graphic.c,80 :: 		Dy = -Dy;
	MOVF       GLCD_Line_Dy_L0+0, 0
	SUBLW      0
	MOVWF      GLCD_Line_Dy_L0+0
	MOVF       GLCD_Line_Dy_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       GLCD_Line_Dy_L0+1
	SUBWF      GLCD_Line_Dy_L0+1, 1
;graphic.c,81 :: 		TwoDy = -TwoDy;
	MOVF       GLCD_Line_TwoDy_L0+0, 0
	SUBLW      0
	MOVWF      GLCD_Line_TwoDy_L0+0
	MOVF       GLCD_Line_TwoDy_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       GLCD_Line_TwoDy_L0+1
	SUBWF      GLCD_Line_TwoDy_L0+1, 1
;graphic.c,82 :: 		}
L_GLCD_Line10:
;graphic.c,84 :: 		GLCD_SetPixel(X1,Y1, color);
	MOVF       FARG_GLCD_Line_X1+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       FARG_GLCD_Line_Y1+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,86 :: 		if ((Dx != 0) || (Dy != 0))
	MOVLW      0
	XORWF      GLCD_Line_Dx_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line27
	MOVLW      0
	XORWF      GLCD_Line_Dx_L0+0, 0
L__GLCD_Line27:
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line22
	MOVLW      0
	XORWF      GLCD_Line_Dy_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line28
	MOVLW      0
	XORWF      GLCD_Line_Dy_L0+0, 0
L__GLCD_Line28:
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line22
	GOTO       L_GLCD_Line13
L__GLCD_Line22:
;graphic.c,89 :: 		if (Dy <= Dx)
	MOVLW      128
	XORWF      GLCD_Line_Dx_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      GLCD_Line_Dy_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line29
	MOVF       GLCD_Line_Dy_L0+0, 0
	SUBWF      GLCD_Line_Dx_L0+0, 0
L__GLCD_Line29:
	BTFSS      STATUS+0, 0
	GOTO       L_GLCD_Line14
;graphic.c,91 :: 		TwoDxAccumulatedError = 0;
	CLRF       GLCD_Line_TwoDxAccumulatedError_L0+0
	CLRF       GLCD_Line_TwoDxAccumulatedError_L0+1
;graphic.c,92 :: 		do
L_GLCD_Line15:
;graphic.c,94 :: 		CurrentX += Xinc;
	MOVF       GLCD_Line_Xinc_L0+0, 0
	ADDWF      GLCD_Line_CurrentX_L0+0, 1
	MOVF       GLCD_Line_Xinc_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_CurrentX_L0+1, 1
;graphic.c,95 :: 		TwoDxAccumulatedError += TwoDy;
	MOVF       GLCD_Line_TwoDy_L0+0, 0
	ADDWF      GLCD_Line_TwoDxAccumulatedError_L0+0, 0
	MOVWF      R1+0
	MOVF       GLCD_Line_TwoDxAccumulatedError_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_TwoDy_L0+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      GLCD_Line_TwoDxAccumulatedError_L0+0
	MOVF       R1+1, 0
	MOVWF      GLCD_Line_TwoDxAccumulatedError_L0+1
;graphic.c,96 :: 		if(TwoDxAccumulatedError > Dx)
	MOVLW      128
	XORWF      GLCD_Line_Dx_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line30
	MOVF       R1+0, 0
	SUBWF      GLCD_Line_Dx_L0+0, 0
L__GLCD_Line30:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Line17
;graphic.c,98 :: 		CurrentY += Yinc;
	MOVF       GLCD_Line_Yinc_L0+0, 0
	ADDWF      GLCD_Line_CurrentY_L0+0, 1
	MOVF       GLCD_Line_Yinc_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_CurrentY_L0+1, 1
;graphic.c,99 :: 		TwoDxAccumulatedError -= TwoDx;
	MOVF       GLCD_Line_TwoDx_L0+0, 0
	SUBWF      GLCD_Line_TwoDxAccumulatedError_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       GLCD_Line_TwoDxAccumulatedError_L0+1, 1
	MOVF       GLCD_Line_TwoDx_L0+1, 0
	SUBWF      GLCD_Line_TwoDxAccumulatedError_L0+1, 1
;graphic.c,100 :: 		}
L_GLCD_Line17:
;graphic.c,101 :: 		GLCD_SetPixel(CurrentX,CurrentY, color);
	MOVF       GLCD_Line_CurrentX_L0+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Line_CurrentY_L0+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,102 :: 		}while (CurrentX != X2);
	MOVF       GLCD_Line_CurrentX_L0+1, 0
	XORWF      FARG_GLCD_Line_X2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line31
	MOVF       FARG_GLCD_Line_X2+0, 0
	XORWF      GLCD_Line_CurrentX_L0+0, 0
L__GLCD_Line31:
	BTFSS      STATUS+0, 2
	GOTO       L_GLCD_Line15
;graphic.c,103 :: 		}
	GOTO       L_GLCD_Line18
L_GLCD_Line14:
;graphic.c,106 :: 		TwoDyAccumulatedError = 0;
	CLRF       GLCD_Line_TwoDyAccumulatedError_L0+0
	CLRF       GLCD_Line_TwoDyAccumulatedError_L0+1
;graphic.c,107 :: 		do
L_GLCD_Line19:
;graphic.c,109 :: 		CurrentY += Yinc;
	MOVF       GLCD_Line_Yinc_L0+0, 0
	ADDWF      GLCD_Line_CurrentY_L0+0, 1
	MOVF       GLCD_Line_Yinc_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_CurrentY_L0+1, 1
;graphic.c,110 :: 		TwoDyAccumulatedError += TwoDx;
	MOVF       GLCD_Line_TwoDx_L0+0, 0
	ADDWF      GLCD_Line_TwoDyAccumulatedError_L0+0, 0
	MOVWF      R1+0
	MOVF       GLCD_Line_TwoDyAccumulatedError_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_TwoDx_L0+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      GLCD_Line_TwoDyAccumulatedError_L0+0
	MOVF       R1+1, 0
	MOVWF      GLCD_Line_TwoDyAccumulatedError_L0+1
;graphic.c,111 :: 		if(TwoDyAccumulatedError>Dy)
	MOVLW      128
	XORWF      GLCD_Line_Dy_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line32
	MOVF       R1+0, 0
	SUBWF      GLCD_Line_Dy_L0+0, 0
L__GLCD_Line32:
	BTFSC      STATUS+0, 0
	GOTO       L_GLCD_Line21
;graphic.c,113 :: 		CurrentX += Xinc;
	MOVF       GLCD_Line_Xinc_L0+0, 0
	ADDWF      GLCD_Line_CurrentX_L0+0, 1
	MOVF       GLCD_Line_Xinc_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      GLCD_Line_CurrentX_L0+1, 1
;graphic.c,114 :: 		TwoDyAccumulatedError -= TwoDy;
	MOVF       GLCD_Line_TwoDy_L0+0, 0
	SUBWF      GLCD_Line_TwoDyAccumulatedError_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       GLCD_Line_TwoDyAccumulatedError_L0+1, 1
	MOVF       GLCD_Line_TwoDy_L0+1, 0
	SUBWF      GLCD_Line_TwoDyAccumulatedError_L0+1, 1
;graphic.c,115 :: 		}
L_GLCD_Line21:
;graphic.c,116 :: 		GLCD_SetPixel(CurrentX,CurrentY, color);
	MOVF       GLCD_Line_CurrentX_L0+0, 0
	MOVWF      FARG_GLCD_SetPixel_x+0
	MOVF       GLCD_Line_CurrentY_L0+0, 0
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;graphic.c,117 :: 		}while (CurrentY != Y2);
	MOVF       GLCD_Line_CurrentY_L0+1, 0
	XORWF      FARG_GLCD_Line_Y2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__GLCD_Line33
	MOVF       FARG_GLCD_Line_Y2+0, 0
	XORWF      GLCD_Line_CurrentY_L0+0, 0
L__GLCD_Line33:
	BTFSS      STATUS+0, 2
	GOTO       L_GLCD_Line19
;graphic.c,118 :: 		}
L_GLCD_Line18:
;graphic.c,119 :: 		}
L_GLCD_Line13:
;graphic.c,120 :: 		}
	RETURN
; end of _GLCD_Line
