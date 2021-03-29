; WeeGUI C interface

		.export			_WGLoadLibrary
		.export			_WGClearScreen		
		.export			_WGDesktop			
		.export			_WGSetCursor			
		.export			_WGSetGlobalCursor	
		.export			_WGSyncGlobalCursor	
		.export			_WGPlot				
		.export			_WGPrint				
		.export			_WGFillRect			
		.export			_WGStrokeRect		
		.export			_WGFancyRect			
		.export			_WGPaintView			
		.export			_WGViewPaintAll		
		.export			_WGEraseViewContents	
		.export			_WGCreateView		
		.export			_WGCreateCheckbox	
		.export			_WGCreateButton		
		.export			_WGViewSetTitle		
		.export			_WGViewSetAction		
		.export			_WGSelectView		
		.export			_WGViewFromPoint		
		.export			_WGViewFocus			
		.export			_WGViewUnfocus		
		.export			_WGViewFocusNext		
		.export			_WGViewFocusPrev		
		.export			_WGViewFocusAction	
		.export			_WGPendingViewAction	
;		.export			_WGPendingView		
		.export			_WGScrollX			
		.export			_WGScrollXBy			
		.export			_WGScrollY			
		.export			_WGScrollYBy			
		.export			_WGScroll
		.export			_WGScrollBy
		.export			_WGEnableMouse		
		.export			_WGDisableMouse		
		.export			_WGDeleteView		
		.export			_WGEraseView			
		.export			_WGExit				
		.export			_WGCreateProgress	
		.export			_WGSetState			
		.export			_WGViewSetRawTitle	
		.export			_WGSetContentWidth	
		.export			_WGSetContentHeight	
		.export			_WGStrokeRoundRect	
		.export			_WGCreateRadio		
;		.export			_WGResetAll			
		.export			_WGGetState			
		.export			_WGPendingClick		
		.export			_WGClearPendingClick	
		.export			_WGResetView	
		.export			_WGGet		

;        .import         COUT

;        .segment        "LOWCODE"

.macro	GET2
		pla
		sta 	PARAM1
		pla
		sta 	PARAM0
.endmacro

.macro	GET4
		pla
		sta 	PARAM3
		pla
		sta 	PARAM2
		pla
		sta 	PARAM1
		pla
		sta 	PARAM0
.endmacro

.macro	GETPTR
		pla
		sta 	PARAM0
		pla
		sta 	PARAM1
.endmacro

INBUF			= $0200
DOSCMD			= $be03


_WGLoadLibrary:
		ldx #0
		ldy #0
@0:		lda brunCmdLine,x
		beq @1
		sta INBUF,y
		inx
		iny
		bra @0
@1:		jsr DOSCMD

_WGClearScreen:
		jmp		WGClearScreen

_WGDesktop:
		jmp		WGDesktop

_WGSetCursor:
		GET2
		jmp		WGSetCursor

_WGSetGlobalCursor:
		GET2
		jmp		WGSetGlobalCursor

_WGSyncGlobalCursor:
		jmp		WGSyncGlobalCursor

_WGPlot:		; __fastcall__
		jmp		WGPlot

_WGPrint:
		GETPTR
		jmp		WGPrint

_WGFillRect:
		ply
		GET4
		jmp		WGFillRect

_WGStrokeRect:
		GET4
		jmp		WGStrokeRect

_WGFancyRect:
		GET4
		jmp		WGFancyRect

_WGPaintView:
		jmp		WGPaintView

_WGViewPaintAll:
		jmp		WGViewPaintAll

_WGEraseViewContents:
		jmp		WGEraseViewContents

_WGCreateView:
		lda		#<parameterList
		sta 	PARAM0
		lda 	#>parameterList
		sta 	PARAM1
		pla
		sta 	parameterList+7
		pla
		sta 	parameterList+6
		pla
		sta 	parameterList+5
		pla
		sta 	parameterList+4
		pla
		sta 	parameterList+3
		pla
		sta 	parameterList+2
		pla
		sta 	parameterList+1
		pla
		sta 	parameterList
		jmp		WGCreateView

_WGCreateCheckbox:
		lda		#<parameterList
		sta 	PARAM0
		lda 	#>parameterList
		sta 	PARAM1
		pla
		sta 	parameterList+4
		pla
		sta 	parameterList+3
		pla
		sta 	parameterList+2
		pla
		sta 	parameterList+1
		pla
		sta 	parameterList
		jmp		WGCreateCheckbox

_WGCreateButton:
		lda		#<parameterList
		sta 	PARAM0
		lda 	#>parameterList
		sta 	PARAM1
		pla
		sta 	parameterList+7
		pla
		sta 	parameterList+6
		pla
		sta 	parameterList+5
		pla
		sta 	parameterList+4
		pla
		sta 	parameterList+3
		pla
		sta 	parameterList+2
		pla
		sta 	parameterList+1
		pla
		sta 	parameterList
		jmp		WGCreateButton

_WGViewSetTitle:
		GETPTR
		jmp		WGViewSetTitle

_WGViewSetAction:
		GETPTR
		jmp		WGViewSetAction

_WGSelectView:	; __fastcall__
		jmp		WGSelectView

_WGViewFromPoint:
		GET2
		jsr		WGViewFromPoint
		ldx 	#0
		rts

_WGViewFocus:
		jmp		WGViewFocus

_WGViewUnfocus:
		jmp		WGViewUnfocus

_WGViewFocusNext:
		jmp		WGViewFocusNext

_WGViewFocusPrev:
		jmp		WGViewFocusPrev

_WGViewFocusAction:
		jmp		WGViewFocusAction

_WGPendingViewAction:
		jmp		WGPendingViewAction

;_WGPendingView:
;		jmp		WGPendingView

_WGScrollX:		; __fastcall__
		jmp		WGScrollX

_WGScrollXBy:	; __fastcall__
		jmp		WGScrollXBy

_WGScrollY:		; __fastcall__
		jmp		WGScrollY

_WGScrollYBy:	; __fastcall__
		jmp		WGScrollYBy

_WGScroll:
		pla
		jsr		WGScrollY
		pla
		jmp		WGScrollX

_WGScrollBy:
		pla
		jsr		WGScrollYBy
		pla
		jmp		WGScrollXBy

_WGEnableMouse:
		jmp		WGEnableMouse

_WGDisableMouse:
		jmp		WGDisableMouse

_WGDeleteView:
		jmp		WGDeleteView

_WGEraseView:
		jmp		WGEraseView

_WGExit:
		jmp		WGExit

_WGCreateProgress:
		lda		#<parameterList
		sta 	PARAM0
		lda 	#>parameterList
		sta 	PARAM1
		pla
		sta 	parameterList+3
		pla
		sta 	parameterList+2
		pla
		sta 	parameterList+1
		pla
		sta 	parameterList
		jmp		WGCreateProgress

_WGSetState:	; __fastcall__
		sta 	PARAM0
		jmp		WGSetState

_WGViewSetRawTitle:	; __fastcall__
		sta 	PARAM0
		jmp		WGViewSetRawTitle

_WGSetContentWidth: ; __fastcall__
		jmp		WGSetContentWidth

_WGSetContentHeight: ; __fastcall__
		jmp		WGSetContentHeight

_WGStrokeRoundRect:
		GET4
		jmp		WGStrokeRoundRect

_WGCreateRadio:
		lda		#<parameterList
		sta 	PARAM0
		lda 	#>parameterList
		sta 	PARAM1
		pla
		sta 	parameterList+4
		pla
		sta 	parameterList+3
		pla
		sta 	parameterList+2
		pla
		sta 	parameterList+1
		pla
		sta 	parameterList
		jmp		WGCreateRadio

;_WGResetAll:
;		ldx		#WGResetAll
;		jsr		WeeGUI
;		rts

_WGGetState:
		jsr		WGGetState
		lda		PARAM0
		ldx		#0
		rts

_WGPendingClick:
		jsr		WGPendingClick
		phy
		txa
		plx
		rts

_WGClearPendingClick:
		jmp		WGClearPendingClick

_WGResetView:
		jmp		WGResetView

_WGGet:
		lda 	KBD
		ldx		#0
		rts

parameterList:
		.byte	0,0,0,0,0,0,0,0

brunCmdLine:
		.byte "BRUN weegui",$8d,0
