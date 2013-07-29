
_GLCD_Delay:
;ks0108library.c,22 :: 		void GLCD_Delay(void)
;ks0108library.c,25 :: 		nop;
	NOP
;ks0108library.c,27 :: 		}
	RETURN
; end of _GLCD_Delay

_GLCD_InitializePorts:
;ks0108library.c,31 :: 		void GLCD_InitializePorts(void)
;ks0108library.c,33 :: 		KS0108_CTRL_PORT |= (KS0108_CS1 | KS0108_CS2 | KS0108_CS3);
	MOVLW      48
	IORWF      PORTB+0, 1
;ks0108library.c,34 :: 		KS0108_CTRL_DIR &= ~(KS0108_CS1 | KS0108_CS2 | KS0108_CS3 | KS0108_RS | KS0108_RW | KS0108_EN);
	MOVLW      200
	ANDWF      TRISB+0, 1
;ks0108library.c,35 :: 		}
	RETURN
; end of _GLCD_InitializePorts

_GLCD_EnableController:
;ks0108library.c,39 :: 		void GLCD_EnableController(unsigned char controller)
;ks0108library.c,41 :: 		switch(controller){
	GOTO       L_GLCD_EnableController0
;ks0108library.c,42 :: 		case 0 : KS0108_CTRL_PORT &= ~KS0108_CS1; break;
L_GLCD_EnableController2:
	BCF        PORTB+0, 5
	GOTO       L_GLCD_EnableController1
;ks0108library.c,43 :: 		case 1 : KS0108_CTRL_PORT &= ~KS0108_CS2; break;
L_GLCD_EnableController3:
	BCF        PORTB+0, 4
	GOTO       L_GLCD_EnableController1
;ks0108library.c,44 :: 		case 2 : KS0108_CTRL_PORT &= ~KS0108_CS3; break;
L_GLCD_EnableController4:
	BCF        PORTB+0, 5
	GOTO       L_GLCD_EnableController1
;ks0108library.c,45 :: 		}
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
;ks0108library.c,46 :: 		}
	RETURN
; end of _GLCD_EnableController

_GLCD_DisableController:
;ks0108library.c,50 :: 		void GLCD_DisableController(unsigned char controller)
;ks0108library.c,52 :: 		switch(controller){
	GOTO       L_GLCD_DisableController5
;ks0108library.c,53 :: 		case 0 : KS0108_CTRL_PORT |= KS0108_CS1; break;
L_GLCD_DisableController7:
	BSF        PORTB+0, 5
	GOTO       L_GLCD_DisableController6
;ks0108library.c,54 :: 		case 1 : KS0108_CTRL_PORT |= KS0108_CS2; break;
L_GLCD_DisableController8:
	BSF        PORTB+0, 4
	GOTO       L_GLCD_DisableController6
;ks0108library.c,55 :: 		case 2 : KS0108_CTRL_PORT |= KS0108_CS3; break;
L_GLCD_DisableController9:
	BSF        PORTB+0, 5
	GOTO       L_GLCD_DisableController6
;ks0108library.c,56 :: 		}
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
;ks0108library.c,57 :: 		}
	RETURN
; end of _GLCD_DisableController

_GLCD_ReadStatus:
;ks0108library.c,61 :: 		unsigned char GLCD_ReadStatus(unsigned char controller)
;ks0108library.c,64 :: 		KS0108_DATA_DIR = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;ks0108library.c,65 :: 		KS0108_CTRL_PORT |= KS0108_RW;
	BSF        PORTB+0, 1
;ks0108library.c,66 :: 		KS0108_CTRL_PORT &= ~KS0108_RS;
	BCF        PORTB+0, 0
;ks0108library.c,67 :: 		GLCD_EnableController(controller);
	MOVF       FARG_GLCD_ReadStatus_controller+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	CALL       _GLCD_EnableController+0
;ks0108library.c,68 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 2
;ks0108library.c,69 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108library.c,70 :: 		status = KS0108_DATA_PIN;
	MOVF       PORTB+0, 0
	MOVWF      GLCD_ReadStatus_status_L0+0
;ks0108library.c,71 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 2
;ks0108library.c,72 :: 		GLCD_DisableController(controller);
	MOVF       FARG_GLCD_ReadStatus_controller+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	CALL       _GLCD_DisableController+0
;ks0108library.c,73 :: 		return status;
	MOVF       GLCD_ReadStatus_status_L0+0, 0
	MOVWF      R0+0
;ks0108library.c,74 :: 		}
	RETURN
; end of _GLCD_ReadStatus

_GLCD_WriteCommand:
;ks0108library.c,78 :: 		void GLCD_WriteCommand(unsigned char commandToWrite, unsigned char controller)
;ks0108library.c,80 :: 		while(GLCD_ReadStatus(controller)&DISPLAY_STATUS_BUSY);
L_GLCD_WriteCommand10:
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_ReadStatus_controller+0
	CALL       _GLCD_ReadStatus+0
	BTFSS      R0+0, 7
	GOTO       L_GLCD_WriteCommand11
	GOTO       L_GLCD_WriteCommand10
L_GLCD_WriteCommand11:
;ks0108library.c,81 :: 		KS0108_DATA_DIR = 0x00;
	CLRF       TRISB+0
;ks0108library.c,82 :: 		KS0108_CTRL_PORT &= ~(KS0108_RW | KS0108_RS);
	MOVLW      252
	ANDWF      PORTB+0, 1
;ks0108library.c,83 :: 		GLCD_EnableController(controller);
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_EnableController_controller+0
	CALL       _GLCD_EnableController+0
;ks0108library.c,84 :: 		KS0108_DATA_PORT = commandToWrite;
	MOVF       FARG_GLCD_WriteCommand_commandToWrite+0, 0
	MOVWF      PORTB+0
;ks0108library.c,85 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 2
;ks0108library.c,86 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108library.c,87 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 2
;ks0108library.c,88 :: 		GLCD_DisableController(controller);
	MOVF       FARG_GLCD_WriteCommand_controller+0, 0
	MOVWF      FARG_GLCD_DisableController_controller+0
	CALL       _GLCD_DisableController+0
;ks0108library.c,89 :: 		}
	RETURN
; end of _GLCD_WriteCommand

_GLCD_ReadData:
;ks0108library.c,93 :: 		unsigned char GLCD_ReadData(void)
;ks0108library.c,96 :: 		while(GLCD_ReadStatus(screen_x / 64)&DISPLAY_STATUS_BUSY);
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
;ks0108library.c,97 :: 		KS0108_DATA_DIR = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;ks0108library.c,98 :: 		KS0108_CTRL_PORT |= (KS0108_RW | KS0108_RS);
	MOVLW      3
	IORWF      PORTB+0, 1
;ks0108library.c,99 :: 		GLCD_EnableController(screen_x / 64);
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
;ks0108library.c,101 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 2
;ks0108library.c,102 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108library.c,103 :: 		date = KS0108_DATA_PIN;
	MOVF       PORTB+0, 0
	MOVWF      GLCD_ReadData_date_L0+0
;ks0108library.c,104 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 2
;ks0108library.c,105 :: 		GLCD_DisableController(screen_x / 64);
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
;ks0108library.c,106 :: 		screen_x++;
	INCF       _screen_x+0, 1
;ks0108library.c,107 :: 		return date;
	MOVF       GLCD_ReadData_date_L0+0, 0
	MOVWF      R0+0
;ks0108library.c,108 :: 		}
	RETURN
; end of _GLCD_ReadData

_GLCD_WriteData:
;ks0108library.c,112 :: 		void GLCD_WriteData(unsigned char dataToWrite)
;ks0108library.c,114 :: 		while(GLCD_ReadStatus(screen_x / 64)&DISPLAY_STATUS_BUSY);
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
;ks0108library.c,115 :: 		KS0108_DATA_DIR = 0x00;
	CLRF       TRISB+0
;ks0108library.c,116 :: 		KS0108_CTRL_PORT &= ~KS0108_RW;
	BCF        PORTB+0, 1
;ks0108library.c,117 :: 		KS0108_CTRL_PORT |= KS0108_RS;
	BSF        PORTB+0, 0
;ks0108library.c,118 :: 		KS0108_DATA_PORT = dataToWrite;
	MOVF       FARG_GLCD_WriteData_dataToWrite+0, 0
	MOVWF      PORTB+0
;ks0108library.c,119 :: 		GLCD_EnableController(screen_x / 64);
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
;ks0108library.c,120 :: 		KS0108_CTRL_PORT |= KS0108_EN;
	BSF        PORTB+0, 2
;ks0108library.c,121 :: 		GLCD_Delay();
	CALL       _GLCD_Delay+0
;ks0108library.c,122 :: 		KS0108_CTRL_PORT &= ~KS0108_EN;
	BCF        PORTB+0, 2
;ks0108library.c,123 :: 		GLCD_DisableController(screen_x / 64);
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
;ks0108library.c,124 :: 		screen_x++;
	INCF       _screen_x+0, 1
;ks0108library.c,125 :: 		}
	RETURN
; end of _GLCD_WriteData

_GLCD_ReadByteFromROMMemory:
;ks0108library.c,129 :: 		unsigned char GLCD_ReadByteFromROMMemory(char * ptr)
;ks0108library.c,131 :: 		return *(ptr);
	MOVF       FARG_GLCD_ReadByteFromROMMemory_ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
;ks0108library.c,132 :: 		}
	RETURN
; end of _GLCD_ReadByteFromROMMemory
