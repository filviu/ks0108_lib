
_PressDetect:
;Glcd.c,73 :: 		char PressDetect() {
;Glcd.c,77 :: 		DRIVE_A = 0;         // DRIVEA = 0 (STANGA oprit DREAPTA oprit SUP. pornit)
	BCF        RC0_bit+0, 0
;Glcd.c,78 :: 		DRIVE_B = 0;         // DRIVEB = 0 (INF. oprit)
	BCF        RC1_bit+0, 1
;Glcd.c,79 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_PressDetect0:
	DECFSZ     R13+0, 1
	GOTO       L_PressDetect0
	DECFSZ     R12+0, 1
	GOTO       L_PressDetect0
	NOP
	NOP
;Glcd.c,80 :: 		adc_rd = ADC_Read(READ_Y_CHANNEL);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;Glcd.c,81 :: 		result = (adc_rd > ADC_THRESHOLD);      // unu logic daca este detectat
	MOVF       R0+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__PressDetect46
	MOVF       R0+0, 0
	SUBLW      132
L__PressDetect46:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      PressDetect_result_L0+0
;Glcd.c,83 :: 		Delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_PressDetect1:
	DECFSZ     R13+0, 1
	GOTO       L_PressDetect1
	DECFSZ     R12+0, 1
	GOTO       L_PressDetect1
	NOP
;Glcd.c,84 :: 		adc_rd = ADC_Read(READ_Y_CHANNEL);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;Glcd.c,85 :: 		result = result & (adc_rd > ADC_THRESHOLD);
	MOVF       R0+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__PressDetect47
	MOVF       R0+0, 0
	SUBLW      132
L__PressDetect47:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R2+0
	MOVF       R2+0, 0
	ANDWF      PressDetect_result_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PressDetect_result_L0+0
;Glcd.c,86 :: 		return result;
;Glcd.c,87 :: 		}
	RETURN
; end of _PressDetect

_GetX:
;Glcd.c,90 :: 		unsigned int GetX() {
;Glcd.c,93 :: 		DRIVE_A = 1;          // DRIVEA = 1 (STANGA pornit DREAPTA pornit SUP. oprit)
	BSF        RC0_bit+0, 0
;Glcd.c,94 :: 		DRIVE_B = 0;          // DRIVEB = 0 (INF. oprit)
	BCF        RC1_bit+0, 1
;Glcd.c,95 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_GetX2:
	DECFSZ     R13+0, 1
	GOTO       L_GetX2
	DECFSZ     R12+0, 1
	GOTO       L_GetX2
	NOP
	NOP
;Glcd.c,96 :: 		result = ADC_Read(READ_X_CHANNEL);      // Citeste X (INF.)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;Glcd.c,97 :: 		return result;
;Glcd.c,98 :: 		}
	RETURN
; end of _GetX

_GetY:
;Glcd.c,101 :: 		unsigned int GetY() {
;Glcd.c,104 :: 		DRIVE_A = 0;          // DRIVEA = 0 STANGA oprit DREAPTA oprit SUP. pornit)
	BCF        RC0_bit+0, 0
;Glcd.c,105 :: 		DRIVE_B = 1;          // DRIVEB = 1 (INF. pornit)
	BSF        RC1_bit+0, 1
;Glcd.c,106 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_GetY3:
	DECFSZ     R13+0, 1
	GOTO       L_GetY3
	DECFSZ     R12+0, 1
	GOTO       L_GetY3
	NOP
	NOP
;Glcd.c,107 :: 		result = ADC_Read(READ_Y_CHANNEL);      // Citeste X (STANGA)
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;Glcd.c,108 :: 		return result;
;Glcd.c,109 :: 		}
	RETURN
; end of _GetY

_Calibrate:
;Glcd.c,112 :: 		void Calibrate() {
;Glcd.c,113 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,114 :: 		Glcd_SetPixel(0,63,1);
	CLRF       FARG_GLCD_SetPixel_x+0
	MOVLW      63
	MOVWF      FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;Glcd.c,115 :: 		GLCD_GoTo(10,6);
	MOVLW      10
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      6
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,116 :: 		GLCD_WriteString("Atingeti punctul");
	MOVLW      ?lstr1_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,117 :: 		while (!PressDetect());
L_Calibrate4:
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Calibrate5
	GOTO       L_Calibrate4
L_Calibrate5:
;Glcd.c,120 :: 		cal_x_min = GetX() - 10;
	CALL       _GetX+0
	MOVLW      10
	SUBWF      R0+0, 0
	MOVWF      _cal_x_min+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      _cal_x_min+1
;Glcd.c,121 :: 		cal_y_min = GetY() - 10;
	CALL       _GetY+0
	MOVLW      10
	SUBWF      R0+0, 0
	MOVWF      _cal_y_min+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      _cal_y_min+1
;Glcd.c,122 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Calibrate6:
	DECFSZ     R13+0, 1
	GOTO       L_Calibrate6
	DECFSZ     R12+0, 1
	GOTO       L_Calibrate6
	DECFSZ     R11+0, 1
	GOTO       L_Calibrate6
	NOP
	NOP
;Glcd.c,123 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,124 :: 		Glcd_SetPixel(127,0,1);
	MOVLW      127
	MOVWF      FARG_GLCD_SetPixel_x+0
	CLRF       FARG_GLCD_SetPixel_y+0
	MOVLW      1
	MOVWF      FARG_GLCD_SetPixel_color+0
	CALL       _GLCD_SetPixel+0
;Glcd.c,125 :: 		GLCD_GoTo(30,1);
	MOVLW      30
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      1
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,126 :: 		GLCD_WriteString("Atingeti punctul");
	MOVLW      ?lstr2_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,127 :: 		while (!PressDetect()) ;
L_Calibrate7:
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Calibrate8
	GOTO       L_Calibrate7
L_Calibrate8:
;Glcd.c,128 :: 		cal_x_max = GetX() + 5;
	CALL       _GetX+0
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      _cal_x_max+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _cal_x_max+1
;Glcd.c,129 :: 		cal_y_max = GetY() + 5;
	CALL       _GetY+0
	MOVLW      5
	ADDWF      R0+0, 0
	MOVWF      _cal_y_max+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _cal_y_max+1
;Glcd.c,130 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Calibrate9:
	DECFSZ     R13+0, 1
	GOTO       L_Calibrate9
	DECFSZ     R12+0, 1
	GOTO       L_Calibrate9
	DECFSZ     R11+0, 1
	GOTO       L_Calibrate9
	NOP
	NOP
;Glcd.c,131 :: 		}
	RETURN
; end of _Calibrate

_Initialize:
;Glcd.c,134 :: 		void Initialize() {
;Glcd.c,136 :: 		DRIVE_A_Direction = 0;       // Configureaza DRIVE_A ca pin de iesire
	BCF        TRISC0_bit+0, 0
;Glcd.c,137 :: 		DRIVE_B_Direction = 0;       // Configureaza DRIVE_B ca pin de iesire
	BCF        TRISC1_bit+0, 1
;Glcd.c,138 :: 		ANSEL  = 3;                  // Configureaza AN0 si AN1 ca intrari analogice
	MOVLW      3
	MOVWF      ANSEL+0
;Glcd.c,139 :: 		ANSELH = 0;                  // Restul pinilor AN sunt intrari/iesiri digitale
	CLRF       ANSELH+0
;Glcd.c,140 :: 		TRISA  = 3;
	MOVLW      3
	MOVWF      TRISA+0
;Glcd.c,141 :: 		C1ON_bit = 0;                // Dezactiveaza comparatoarele
	BCF        C1ON_bit+0, 7
;Glcd.c,142 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, 7
;Glcd.c,143 :: 		GLCD_Initalize();            // Initializeaza ecranul grafic
	CALL       _GLCD_Initalize+0
;Glcd.c,144 :: 		}
	RETURN
; end of _Initialize

_main_menu:
;Glcd.c,147 :: 		void main_menu() {
;Glcd.c,149 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,151 :: 		GLCD_Rectangle(8,22,50,11);
	MOVLW      8
	MOVWF      FARG_GLCD_Rectangle_x+0
	MOVLW      22
	MOVWF      FARG_GLCD_Rectangle_y+0
	MOVLW      50
	MOVWF      FARG_GLCD_Rectangle_b+0
	MOVLW      11
	MOVWF      FARG_GLCD_Rectangle_a+0
	CALL       _GLCD_Rectangle+0
;Glcd.c,152 :: 		GLCD_GoTo(11,3);
	MOVLW      11
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      3
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,153 :: 		GLCD_WriteString("Bitmap");
	MOVLW      ?lstr3_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,155 :: 		GLCD_Rectangle(68,22,50,11);
	MOVLW      68
	MOVWF      FARG_GLCD_Rectangle_x+0
	MOVLW      22
	MOVWF      FARG_GLCD_Rectangle_y+0
	MOVLW      50
	MOVWF      FARG_GLCD_Rectangle_b+0
	MOVLW      11
	MOVWF      FARG_GLCD_Rectangle_a+0
	CALL       _GLCD_Rectangle+0
;Glcd.c,156 :: 		GLCD_GoTo(71,3);
	MOVLW      71
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      3
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,157 :: 		GLCD_WriteString("Text");
	MOVLW      ?lstr4_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,159 :: 		GLCD_GoTo(11,5);
	MOVLW      11
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      5
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,160 :: 		GLCD_WriteString("Proiect de licenta");
	MOVLW      ?lstr5_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,161 :: 		GLCD_GoTo(5,6);
	MOVLW      5
	MOVWF      FARG_GLCD_GoTo+0
	MOVLW      6
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,162 :: 		GLCD_WriteString("Vulcan Silviu - 2009");
	MOVLW      ?lstr6_Glcd+0
	MOVWF      FARG_GLCD_WriteString+0
	CALL       _GLCD_WriteString+0
;Glcd.c,163 :: 		}
	RETURN
; end of _main_menu

_images:
;Glcd.c,167 :: 		void images() {
;Glcd.c,169 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,170 :: 		GLCD_Bitmap(picture,0,0,128,64);
	MOVLW      _picture+0
	MOVWF      FARG_GLCD_Bitmap+0
	MOVLW      hi_addr(_picture+0
	MOVWF      FARG_GLCD_Bitmap+1
	CLRF       FARG_GLCD_Bitmap+0
	CLRF       FARG_GLCD_Bitmap+0
	MOVLW      128
	MOVWF      FARG_GLCD_Bitmap+0
	MOVLW      64
	MOVWF      FARG_GLCD_Bitmap+0
	CALL       _GLCD_Bitmap+0
;Glcd.c,171 :: 		while (!PressDetect());
L_images10:
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_images11
	GOTO       L_images10
L_images11:
;Glcd.c,172 :: 		}
	RETURN
; end of _images

_list_text:
;Glcd.c,176 :: 		void list_text() {
;Glcd.c,180 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,181 :: 		dimtext = (sizeof(demotext) / sizeof(demotext[1])) - 1;
	MOVLW      5
	MOVWF      list_text_dimtext_L0+0
	MOVLW      4
	MOVWF      list_text_dimtext_L0+1
;Glcd.c,183 :: 		pos = 0;
	CLRF       list_text_pos_L0+0
;Glcd.c,184 :: 		rand = 0;
	CLRF       list_text_rand_L0+0
;Glcd.c,185 :: 		GLCD_GoTo(0,0);
	CLRF       FARG_GLCD_GoTo+0
	CLRF       FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,186 :: 		for (i = 0; i < dimtext; i++)  {
	CLRF       list_text_i_L0+0
	CLRF       list_text_i_L0+1
L_list_text12:
	MOVF       list_text_dimtext_L0+1, 0
	SUBWF      list_text_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__list_text48
	MOVF       list_text_dimtext_L0+0, 0
	SUBWF      list_text_i_L0+0, 0
L__list_text48:
	BTFSC      STATUS+0, 0
	GOTO       L_list_text13
;Glcd.c,187 :: 		if (pos == 21) { // rand nou
	MOVF       list_text_pos_L0+0, 0
	XORLW      21
	BTFSS      STATUS+0, 2
	GOTO       L_list_text15
;Glcd.c,188 :: 		if (rand < 7 ) rand++;
	MOVLW      7
	SUBWF      list_text_rand_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_list_text16
	INCF       list_text_rand_L0+0, 1
	GOTO       L_list_text17
L_list_text16:
;Glcd.c,190 :: 		while (!PressDetect()); // asteapta o apasare
L_list_text18:
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_list_text19
	GOTO       L_list_text18
L_list_text19:
;Glcd.c,191 :: 		rand = 0;
	CLRF       list_text_rand_L0+0
;Glcd.c,192 :: 		GLCD_ClearScreen();
	CALL       _GLCD_ClearScreen+0
;Glcd.c,193 :: 		}
L_list_text17:
;Glcd.c,194 :: 		pos = 0;
	CLRF       list_text_pos_L0+0
;Glcd.c,195 :: 		GLCD_GoTo(0,rand);
	CLRF       FARG_GLCD_GoTo+0
	MOVF       list_text_rand_L0+0, 0
	MOVWF      FARG_GLCD_GoTo+0
	CALL       _GLCD_GoTo+0
;Glcd.c,196 :: 		}
L_list_text15:
;Glcd.c,197 :: 		GLCD_WriteChar(demotext[i]);
	MOVF       list_text_i_L0+0, 0
	ADDLW      _demotext+0
	MOVWF      R0+0
	MOVLW      hi_addr(_demotext+0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      list_text_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_GLCD_WriteChar+0
	CALL       _GLCD_WriteChar+0
;Glcd.c,198 :: 		pos++;
	INCF       list_text_pos_L0+0, 1
;Glcd.c,186 :: 		for (i = 0; i < dimtext; i++)  {
	INCF       list_text_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       list_text_i_L0+1, 1
;Glcd.c,199 :: 		}
	GOTO       L_list_text12
L_list_text13:
;Glcd.c,200 :: 		while (!PressDetect());  // Dupa apasare revine in meniul principal
L_list_text20:
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_list_text21
	GOTO       L_list_text20
L_list_text21:
;Glcd.c,201 :: 		}
	RETURN
; end of _list_text

_main:
;Glcd.c,204 :: 		void main() {
;Glcd.c,206 :: 		Initialize();
	CALL       _Initialize+0
;Glcd.c,207 :: 		Calibrate();
	CALL       _Calibrate+0
;Glcd.c,208 :: 		x_coord_old = 0;
	CLRF       _x_coord_old+0
	CLRF       _x_coord_old+1
;Glcd.c,209 :: 		y_coord_old = 0;
	CLRF       _y_coord_old+0
	CLRF       _y_coord_old+1
;Glcd.c,210 :: 		main_menu(); // dupa calibrare trece in meniul principal
	CALL       _main_menu+0
;Glcd.c,211 :: 		in_menu = 1; //
	MOVLW      1
	MOVWF      _in_menu+0
;Glcd.c,212 :: 		while (1) {    // Bucla principala
L_main22:
;Glcd.c,213 :: 		if (!in_menu) { // daca se revine dintr-o functie deseneaza meniul
	MOVF       _in_menu+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;Glcd.c,214 :: 		main_menu();
	CALL       _main_menu+0
;Glcd.c,215 :: 		in_menu = 1;
	MOVLW      1
	MOVWF      _in_menu+0
;Glcd.c,216 :: 		}
L_main24:
;Glcd.c,217 :: 		if (PressDetect()) {
	CALL       _PressDetect+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
;Glcd.c,220 :: 		x_coord = GetX() - cal_x_min;
	CALL       _GetX+0
	MOVF       _cal_x_min+0, 0
	SUBWF      R0+0, 0
	MOVWF      _x_coord+0
	MOVF       _cal_x_min+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      _x_coord+1
;Glcd.c,221 :: 		y_coord = GetY() - cal_y_min;
	CALL       _GetY+0
	MOVF       _cal_y_min+0, 0
	SUBWF      R0+0, 0
	MOVWF      _y_coord+0
	MOVF       _cal_y_min+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      _y_coord+1
;Glcd.c,224 :: 		x_coord_diff = abs(x_coord - x_coord_old); // compara cu coord. vechi
	MOVF       _x_coord_old+0, 0
	SUBWF      _x_coord+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       _x_coord_old+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _x_coord+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      _x_coord_diff+0
	MOVF       R0+1, 0
	MOVWF      _x_coord_diff+1
;Glcd.c,225 :: 		y_coord_diff = abs(y_coord - y_coord_old);
	MOVF       _y_coord_old+0, 0
	SUBWF      _y_coord+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       _y_coord_old+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _y_coord+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      _y_coord_diff+0
	MOVF       R0+1, 0
	MOVWF      _y_coord_diff+1
;Glcd.c,226 :: 		x_coord_old = x_coord;                     // salveaza coord. vechi
	MOVF       _x_coord+0, 0
	MOVWF      _x_coord_old+0
	MOVF       _x_coord+1, 0
	MOVWF      _x_coord_old+1
;Glcd.c,227 :: 		y_coord_old = y_coord;
	MOVF       _y_coord+0, 0
	MOVWF      _y_coord_old+0
	MOVF       _y_coord+1, 0
	MOVWF      _y_coord_old+1
;Glcd.c,229 :: 		if ( (x_coord_diff>50) || (y_coord_diff>50) )
	MOVF       _x_coord_diff+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVF       _x_coord_diff+0, 0
	SUBLW      50
L__main49:
	BTFSS      STATUS+0, 0
	GOTO       L__main45
	MOVF       _y_coord_diff+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       _y_coord_diff+0, 0
	SUBLW      50
L__main50:
	BTFSS      STATUS+0, 0
	GOTO       L__main45
	GOTO       L_main28
L__main45:
;Glcd.c,230 :: 		continue;
	GOTO       L_main22
L_main28:
;Glcd.c,231 :: 		x_coord128 = (x_coord * 128l) / (cal_x_max - cal_x_min);
	MOVLW      7
	MOVWF      R0+0
	MOVF       _x_coord+0, 0
	MOVWF      R6+0
	MOVF       _x_coord+1, 0
	MOVWF      R6+1
	CLRF       R6+2
	CLRF       R6+3
	MOVF       R0+0, 0
L__main51:
	BTFSC      STATUS+0, 2
	GOTO       L__main52
	RLF        R6+0, 1
	RLF        R6+1, 1
	RLF        R6+2, 1
	RLF        R6+3, 1
	BCF        R6+0, 0
	ADDLW      255
	GOTO       L__main51
L__main52:
	MOVF       _cal_x_min+0, 0
	SUBWF      _cal_x_max+0, 0
	MOVWF      R4+0
	MOVF       _cal_x_min+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _cal_x_max+1, 0
	MOVWF      R4+1
	MOVF       R6+0, 0
	MOVWF      R0+0
	MOVF       R6+1, 0
	MOVWF      R0+1
	MOVF       R6+2, 0
	MOVWF      R0+2
	MOVF       R6+3, 0
	MOVWF      R0+3
	MOVLW      0
	BTFSC      R4+1, 7
	MOVLW      255
	MOVWF      R4+2
	MOVWF      R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _x_coord128+0
	MOVF       R0+1, 0
	MOVWF      _x_coord128+1
	MOVF       R0+2, 0
	MOVWF      _x_coord128+2
	MOVF       R0+3, 0
	MOVWF      _x_coord128+3
;Glcd.c,232 :: 		y_coord64 = (64 -(y_coord *64) / (cal_y_max - cal_y_min));
	MOVLW      6
	MOVWF      R0+0
	MOVF       _y_coord+0, 0
	MOVWF      R2+0
	MOVF       _y_coord+1, 0
	MOVWF      R2+1
	MOVF       R0+0, 0
L__main53:
	BTFSC      STATUS+0, 2
	GOTO       L__main54
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__main53
L__main54:
	MOVF       _cal_y_min+0, 0
	SUBWF      _cal_y_max+0, 0
	MOVWF      R4+0
	MOVF       _cal_y_min+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _cal_y_max+1, 0
	MOVWF      R4+1
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	SUBLW      64
	MOVWF      _y_coord64+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _y_coord64+1
	SUBWF      _y_coord64+1, 1
	MOVLW      0
	MOVWF      _y_coord64+2
	MOVWF      _y_coord64+3
;Glcd.c,234 :: 		if ((x_coord128 < 0) || (x_coord128 > 127))
	MOVLW      128
	XORWF      _x_coord128+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      0
	SUBWF      _x_coord128+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      0
	SUBWF      _x_coord128+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      0
	SUBWF      _x_coord128+0, 0
L__main55:
	BTFSS      STATUS+0, 0
	GOTO       L__main44
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x_coord128+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       _x_coord128+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       _x_coord128+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       _x_coord128+0, 0
	SUBLW      127
L__main56:
	BTFSS      STATUS+0, 0
	GOTO       L__main44
	GOTO       L_main31
L__main44:
;Glcd.c,235 :: 		continue;
	GOTO       L_main22
L_main31:
;Glcd.c,236 :: 		if ((y_coord64 < 0) || (y_coord64 > 63))
	MOVLW      128
	XORWF      _y_coord64+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	SUBWF      _y_coord64+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	SUBWF      _y_coord64+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	SUBWF      _y_coord64+0, 0
L__main57:
	BTFSS      STATUS+0, 0
	GOTO       L__main43
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _y_coord64+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       _y_coord64+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       _y_coord64+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       _y_coord64+0, 0
	SUBLW      63
L__main58:
	BTFSS      STATUS+0, 0
	GOTO       L__main43
	GOTO       L_main34
L__main43:
;Glcd.c,237 :: 		continue;
	GOTO       L_main22
L_main34:
;Glcd.c,240 :: 		&& (y_coord64 < 33)) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x_coord128+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _x_coord128+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _x_coord128+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _x_coord128+0, 0
	SUBLW      8
L__main59:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
	MOVLW      128
	XORWF      _x_coord128+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      0
	SUBWF      _x_coord128+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      0
	SUBWF      _x_coord128+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      58
	SUBWF      _x_coord128+0, 0
L__main60:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _y_coord64+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _y_coord64+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _y_coord64+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _y_coord64+0, 0
	SUBLW      22
L__main61:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
	MOVLW      128
	XORWF      _y_coord64+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      0
	SUBWF      _y_coord64+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      0
	SUBWF      _y_coord64+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      33
	SUBWF      _y_coord64+0, 0
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
L__main42:
;Glcd.c,241 :: 		in_menu = 0;
	CLRF       _in_menu+0
;Glcd.c,242 :: 		images();
	CALL       _images+0
;Glcd.c,243 :: 		}
L_main37:
;Glcd.c,246 :: 		(y_coord64 > 22) && (y_coord64 < 33)) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x_coord128+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVF       _x_coord128+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVF       _x_coord128+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVF       _x_coord128+0, 0
	SUBLW      68
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
	MOVLW      128
	XORWF      _x_coord128+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      0
	SUBWF      _x_coord128+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      0
	SUBWF      _x_coord128+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      118
	SUBWF      _x_coord128+0, 0
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _y_coord64+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _y_coord64+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _y_coord64+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _y_coord64+0, 0
	SUBLW      22
L__main65:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
	MOVLW      128
	XORWF      _y_coord64+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      0
	SUBWF      _y_coord64+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      0
	SUBWF      _y_coord64+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      33
	SUBWF      _y_coord64+0, 0
L__main66:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
L__main41:
;Glcd.c,247 :: 		in_menu = 0;
	CLRF       _in_menu+0
;Glcd.c,248 :: 		list_text();
	CALL       _list_text+0
;Glcd.c,249 :: 		}
L_main40:
;Glcd.c,250 :: 		}
L_main25:
;Glcd.c,251 :: 		}
	GOTO       L_main22
;Glcd.c,252 :: 		}
	GOTO       $+0
; end of _main
