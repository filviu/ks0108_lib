
_GLCD_Delay:
;ks0108-pic16.c,30 :: 		void GLCD_Delay(void) {
;ks0108-pic16.c,33 :: 		nop;
	NOP
;ks0108-pic16.c,35 :: 		}
	RETURN
; end of _GLCD_Delay

_GLCD_InitalizePorts:
;ks0108-pic16.c,38 :: 		void GLCD_InitalizePorts(void) {
;ks0108-pic16.c,40 :: 		KS0108_CTRL_PORT |= (KS0108_CS1 | KS0108_CS2 | KS0108_CS3 | KS0108_RST);
	MOVLW      35
	IORWF      PORTB+0, 1
;ks0108-pic16.c,42 :: 		KS0108_CTRL_DIR &= ~(KS0108_CS1 | KS0108_CS2 | KS0108_RST | KS0108_RS | KS0108_RW | KS0108_EN);
	MOVLW      192
	ANDWF      TRISB+0, 1
;ks0108-pic16.c,43 :: 		}
	RETURN
; end of _GLCD_InitalizePorts

_GLCD_EnableController:
;ks0108-pic16.c,46 :: 		void GLCD_EnableController(unsigned char controller) {
;ks0108-pic16.c,48 :: 		switch(controller){
	GOTO       L_GLCD_EnableController0
;ks0108-pic16.c,49 :: 		case 0 : KS0108_CTRL_PORT &= ~KS0108_CS1; break;
L_GLCD_EnableController2:
	BCF        PORTB+0, 0
	GOTO       L_GLCD_EnableController1
;ks0108-pic16.c,50 :: 		case 1 : KS0108_CTRL_PORT &= ~KS0108_CS2; break;
L_GLCD_EnableController3:
	BCF        PORTB+0, 1
	GOTO       L_GLCD_EnableController1
;ks0108-pic16.c,51 :: 		case 2 : KS0108_CTRL_PORT &= ~KS0108_CS3; break;
L_GLCD_EnableController4:
	BCF        PORTB+0, 0
	GOTO       L_GLCD_EnableController1
;ks0108-pic16.c,52 :: 		}
L_GLCD_EnableController0:
	MOVF       FARG_GLCD_EnableController_controller+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_EnableController2
	MOVF       FARG_GLCD_EnableController_controller+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_EnableController3
	MOVF       FARG_GLCD_EnableController_controller+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_EnableController4
L_GLCD_EnableController1:
;ks0108-pic16.c,53 :: 		}
	RETURN
; end of _GLCD_EnableController

_GLCD_DisableController:
;ks0108-pic16.c,56 :: 		void GLCD_DisableController(unsigned char controller) {
;ks0108-pic16.c,57 :: 		switch(controller){
	GOTO       L_GLCD_DisableController5
;ks0108-pic16.c,58 :: 		case 0 : KS0108_CTRL_PORT |= KS0108_CS1; break;
L_GLCD_DisableController7:
	BSF        PORTB+0, 0
	GOTO       L_GLCD_DisableController6
;ks0108-pic16.c,59 :: 		case 1 : KS0108_CTRL_PORT |= KS0108_CS2; break;
L_GLCD_DisableController8:
	BSF        PORTB+0, 1
	GOTO       L_GLCD_DisableController6
;ks0108-pic16.c,60 :: 		case 2 : KS0108_CTRL_PORT |= KS0108_CS3; break;
L_GLCD_DisableController9:
	BSF        PORTB+0, 0
	GOTO       L_GLCD_DisableController6
;ks0108-pic16.c,61 :: 		}
L_GLCD_DisableController5:
	MOVF       FARG_GLCD_DisableController_controller+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_DisableController7
	MOVF       FARG_GLCD_DisableController_controller+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_DisableController8
	MOVF       FARG_GLCD_DisableController_controller+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_GLCD_DisableController9
L_GLCD_DisableController6:
;ks0108-pic16.c,62 :: 		}
	RETURN
; end of _GLCD_DisableController

_GLCD_ReadStatus:
;ks0108-pic16.c,65 :: 		unsigned char GLCD_ReadStatus(unsigned char controller) {
;ks0108-pic16.c,69 :: 		KS0108_DATA_DIR = 0xFF;
	MOVLW      255
	MOVWF      TRISD+0
;ks0108-pic16.c,70 :: 		KS0108_CTRL_PORT |= KS0108_RW;
	BSF        PORTB+0, 3
;ks0108-pic16.c,71 :: 		KS0108_CTRL_PORT &= ~KS0108_RS;
	BCF        PORTB+0, 2
;ks0108-pic16.c,72 :: 		GLCD_EnableController(controller);
	MOVF       FARG_GLCD_ReadStatus_controller+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	CALL       _GLCD_EnableController+0
;ks0108-pic16.c,73 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 4
;ks0108-pic16.c,74 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108-pic16.c,75 :: 		status = KS0108_DATA_PIN;
	MOVF       PORTD+0, 0
	MOVWF      GLCD_ReadStatus_status_L0+0
;ks0108-pic16.c,76 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 4
;ks0108-pic16.c,77 :: 		GLCD_DisableController(controller);
	MOVF       FARG_GLCD_ReadStatus_controller+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	CALL       _GLCD_DisableController+0
;ks0108-pic16.c,78 :: 		return status;
	MOVF       GLCD_ReadStatus_status_L0+0, 0
	MOVWF      R0+0
;ks0108-pic16.c,79 :: 		}
	RETURN
; end of _GLCD_ReadStatus

_GLCD_WriteCommand:
;ks0108-pic16.c,82 :: 		void GLCD_WriteCommand(unsigned char commandToWrite, unsigned char controller) {
;ks0108-pic16.c,84 :: 		while(GLCD_ReadStatus(controller)&DISPLAY_STATUS_BUSY);
L_GLCD_WriteCommand10:
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_ReadStatus_controller+0
	CALL       _GLCD_ReadStatus+0
	BTFSS      R0+0, 7
	GOTO       L_GLCD_WriteCommand11
	GOTO       L_GLCD_WriteCommand10
L_GLCD_WriteCommand11:
;ks0108-pic16.c,85 :: 		KS0108_DATA_DIR = 0x00;
	CLRF       TRISD+0
;ks0108-pic16.c,86 :: 		KS0108_CTRL_PORT &= ~(KS0108_RW | KS0108_RS);
	MOVLW      243
	ANDWF      PORTB+0, 1
;ks0108-pic16.c,87 :: 		GLCD_EnableController(controller);
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	CALL       _GLCD_EnableController+0
;ks0108-pic16.c,88 :: 		KS0108_DATA_PORT = commandToWrite;
	MOVF       FARG_GLCD_WriteCommand_commandToWrite+0, 0
	MOVWF      PORTD+0
;ks0108-pic16.c,89 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 4
;ks0108-pic16.c,90 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108-pic16.c,91 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 4
;ks0108-pic16.c,92 :: 		GLCD_DisableController(controller);
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	CALL       _GLCD_DisableController+0
;ks0108-pic16.c,93 :: 		}
	RETURN
; end of _GLCD_WriteCommand

_GLCD_ReadData:
;ks0108-pic16.c,96 :: 		unsigned char GLCD_ReadData(void) {
;ks0108-pic16.c,99 :: 		while(GLCD_ReadStatus(screen_x / 64)&DISPLAY_STATUS_BUSY);
L_GLCD_ReadData12:
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_ReadStatus_controller+0
	MOVF       R0+0, 0
L__GLCD_ReadData16:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_ReadData17
	RRF        FARG_GLCD_ReadStatus_controller+0, 1
	BCF        FARG_GLCD_ReadStatus_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_ReadData16
L__GLCD_ReadData17:
	CALL       _GLCD_ReadStatus+0
	BTFSS      R0+0, 7
	GOTO       L_GLCD_ReadData13
	GOTO       L_GLCD_ReadData12
L_GLCD_ReadData13:
;ks0108-pic16.c,100 :: 		KS0108_DATA_DIR = 0xFF;
	MOVLW      255
	MOVWF      TRISD+0
;ks0108-pic16.c,101 :: 		KS0108_CTRL_PORT |= (KS0108_RW | KS0108_RS);
	MOVLW      12
	IORWF      PORTB+0, 1
;ks0108-pic16.c,102 :: 		GLCD_EnableController(screen_x / 64);
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	MOVF       R0+0, 0
L__GLCD_ReadData18:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_ReadData19
	RRF        FARG_GLCD_EnableController_controller+0, 1
	BCF        FARG_GLCD_EnableController_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_ReadData18
L__GLCD_ReadData19:
	CALL       _GLCD_EnableController+0
;ks0108-pic16.c,104 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 4
;ks0108-pic16.c,105 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108-pic16.c,106 :: 		date = KS0108_DATA_PIN;
	MOVF       PORTD+0, 0
	MOVWF      GLCD_ReadData_date_L0+0
;ks0108-pic16.c,107 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 4
;ks0108-pic16.c,108 :: 		GLCD_DisableController(screen_x / 64);
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	MOVF       R0+0, 0
L__GLCD_ReadData20:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_ReadData21
	RRF        FARG_GLCD_DisableController_controller+0, 1
	BCF        FARG_GLCD_DisableController_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_ReadData20
L__GLCD_ReadData21:
	CALL       _GLCD_DisableController+0
;ks0108-pic16.c,109 :: 		screen_x++;
	INCF       _screen_x+0, 1
;ks0108-pic16.c,110 :: 		return date;
	MOVF       GLCD_ReadData_date_L0+0, 0
	MOVWF      R0+0
;ks0108-pic16.c,111 :: 		}
	RETURN
; end of _GLCD_ReadData

_GLCD_WriteData:
;ks0108-pic16.c,114 :: 		void GLCD_WriteData(unsigned char dataToWrite) {
;ks0108-pic16.c,116 :: 		while(GLCD_ReadStatus(screen_x / 64)&DISPLAY_STATUS_BUSY);
L_GLCD_WriteData14:
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_ReadStatus_controller+0
	MOVF       R0+0, 0
L__GLCD_WriteData22:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_WriteData23
	RRF        FARG_GLCD_ReadStatus_controller+0, 1
	BCF        FARG_GLCD_ReadStatus_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_WriteData22
L__GLCD_WriteData23:
	CALL       _GLCD_ReadStatus+0
	BTFSS      R0+0, 7
	GOTO       L_GLCD_WriteData15
	GOTO       L_GLCD_WriteData14
L_GLCD_WriteData15:
;ks0108-pic16.c,117 :: 		KS0108_DATA_DIR = 0x00;
	CLRF       TRISD+0
;ks0108-pic16.c,118 :: 		KS0108_CTRL_PORT &= ~KS0108_RW;
	BCF        PORTB+0, 3
;ks0108-pic16.c,119 :: 		KS0108_CTRL_PORT |= KS0108_RS;
	BSF        PORTB+0, 2
;ks0108-pic16.c,120 :: 		KS0108_DATA_PORT = dataToWrite;
	MOVF       FARG_GLCD_WriteData_dataToWrite+0, 0
	MOVWF      PORTD+0
;ks0108-pic16.c,121 :: 		GLCD_EnableController(screen_x / 64);
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	MOVF       R0+0, 0
L__GLCD_WriteData24:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_WriteData25
	RRF        FARG_GLCD_EnableController_controller+0, 1
	BCF        FARG_GLCD_EnableController_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_WriteData24
L__GLCD_WriteData25:
	CALL       _GLCD_EnableController+0
;ks0108-pic16.c,122 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 4
;ks0108-pic16.c,123 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108-pic16.c,124 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 4
;ks0108-pic16.c,125 :: 		GLCD_DisableController(screen_x / 64);
	MOVLW      6
	MOVWF      R0+0
	MOVF       _screen_x+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	MOVF       R0+0, 0
L__GLCD_WriteData26:
	BTFSC      STATUS+0, 2
	GOTO       L__GLCD_WriteData27
	RRF        FARG_GLCD_DisableController_controller+0, 1
	BCF        FARG_GLCD_DisableController_controller+0, 7
	ADDLW      255
	GOTO       L__GLCD_WriteData26
L__GLCD_WriteData27:
	CALL       _GLCD_DisableController+0
;ks0108-pic16.c,126 :: 		screen_x++;
	INCF       _screen_x+0, 1
;ks0108-pic16.c,127 :: 		}
	RETURN
; end of _GLCD_WriteData
