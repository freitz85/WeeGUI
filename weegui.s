;
;  gui.s
;  Top level management routines
;
;  Created by Quinn Dunki on 8/15/14.
;  Copyright (c) 2014 One Girl, One Laptop Productions. All rights reserved.
;


.segment "WEEGUI"
;.org $4000

; Common definitions

.include "zeropage.s"
.include "switches.s"
.include "macros.s"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main entry point. BRUN will land here.
main:
	jsr WGInit
	rts				; Don't add any bytes here!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WGDispatch
; The dispatcher for calling the assembly-language API from assembly programs
; X: API call number
; P0-3,Y: Parameters to call, as needed
WGDispatch:
	jmp (WGEntryPointTable,x)

; Entry point jump table
WGEntryPointTable:
.addr WGClearScreen
.addr WGDesktop
.addr WGSetCursor
.addr WGSetGlobalCursor
.addr WGSyncGlobalCursor
.addr WGPlot
.addr WGPrint
.addr WGFillRect
.addr WGStrokeRect
.addr WGFancyRect
.addr WGPaintView
.addr WGViewPaintAll
.addr WGEraseViewContents
.addr WGCreateView
.addr WGCreateCheckbox
.addr WGCreateButton
.addr WGViewSetTitle
.addr WGViewSetAction
.addr WGSelectView
.addr WGViewFromPoint
.addr WGViewFocus
.addr WGViewUnfocus
.addr WGViewFocusNext
.addr WGViewFocusPrev
.addr WGViewFocusAction
.addr WGPendingViewAction
.addr WGPendingClick
.addr WGScrollX
.addr WGScrollXBy
.addr WGScrollY
.addr WGScrollYBy
.addr WGEnableMouse
.addr WGDisableMouse
.addr WGDeleteView
.addr WGEraseView
.addr WGExit
.addr WGCreateProgress
.addr WGSetState
.addr WGViewSetRawTitle
.addr WGSetContentWidth
.addr WGSetContentHeight
.addr WGStrokeRoundRect
.addr WGCreateRadio
.addr WGResetAll
.addr WGGetState
.addr WGPendingClick
.addr WGClearPendingClick
.addr WGResetView

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WGInit
; Initialization. Should be called once at app startup

_WGInit:
	SAVE_AXY
	jsr		WG80
	RESTORE_AXY
	jmp		WGResetAll

WGInit:
	SAVE_AXY

	; Protect us from Applesoft by setting up HIMEM
;	lda #$3f		; 4000  (really 3fff)
;	sta LINNUMH
;	lda #$ff
;	sta LINNUML
;	jsr SETHI

	jsr WG80				; Enter 80-col text mode
	jsr WGInitApplesoft		; Set up Applesoft API

	RESTORE_AXY

	jmp WGResetAll


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WGResetAll
; Reset all views and strings. Called from WGInit during app startup.
; Can also be called at any time to "start over" with no views.
; (Does not clear screen or repaint.)
;
WGResetAll:
	SAVE_AXY

	ldy #15			; Clear our block allocators
WGInit_clearMemLoop:
	tya
	asl
	asl
	asl
	asl
	tax
	stz WG_VIEWRECORDS+2,x
	stz WG_STRINGS,x
	dey
	bpl WGInit_clearMemLoop

	lda #$ff
	sta WG_PENDINGACTIONVIEW
	sta WG_FOCUSVIEW

	RESTORE_AXY
	rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WGExit
; Cleanup Should be called once at app shutdown
;
_WGExit:			; void WGExit(void);
WGExit:
	pha

	lda #CHAR_NORMAL
	sta INVERSE

	; Restore HIMEM to ProDOS default
;	lda #$96
;	sta LINNUMH
;	stz LINNUML
;	jsr SETHI

	; Remove ourselves from ProDOS memory map
;	lda #%00001111
;	trb MEMBITMAP + $0f
;	lda #$ff
;	trb MEMBITMAP + $10
;	trb MEMBITMAP + $11
;	lda #%11111100
;	trb MEMBITMAP + $12

	pla
	rts
	

_WGGet:				; byte WGGet(void);
	lda $c000
	bpl :+			; no key pressed
	sta $c010
	and #$7f		; mask high bit
:	ldx #0
	rts


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WG80
; Enables 80 column mode (and enhanced video firmware)
WG80:
	pha

	lda #$a0
	jsr $c300
	
	SETSWITCH TEXTON
	SETSWITCH PAGE2OFF
	SETSWITCH COL80ON
	SETSWITCH STORE80ON

	pla
	rts


; Code modules
.include "utility.s"
.include "painting.s"
.include "rects.s"
.include "views.s"
.include "mouse.s"
.include "mouse_gs.s"
.include "applesoft.s"
.include "memory.s"
.include "c_interface.s"


; Suppress some linker warnings - Must be the last thing in the file
.SEGMENT "HGR"
