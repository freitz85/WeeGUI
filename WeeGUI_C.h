#ifndef WEEGUI_H
#define WEEGUI_H

typedef unsigned char byte;

#define STYLE_FRAMELESS			0
#define STYLE_PLAIN				1
#define STYLE_DECORATED			2

#define FEATURE_CONTENT			0x00
#define FEATURE_SCROLL_UP		0x10
#define FEATURE_SCROLL_DOWN 	0x20
#define FEATURE_SCROLL_LEFT 	0x30
#define FEATURE_SCROLL_RIGHT	0x40

void WGInit(void);

// View routines
void __cdecl__ WGCreateView(byte viewID, byte style, byte xPos, byte yPos, 
				  byte width, byte height, byte contentWidth, byte contentHeight);
void __cdecl__ WGCreateCheckbox(byte ViewID, byte xPos, byte yPos, byte* label);
void __cdecl__ WGCreateRadio(byte viewID, byte xPos, byte yPos, byte* label);
void __cdecl__ WGCreateProgress(byte viewID, byte xPos, byte yPos, byte width);
void __cdecl__ WGCreateButton(byte viewID, byte xPos, byte yPos, byte width, 
					void (*callback)(void), byte* label);
void WGDeleteView(void);
void __fastcall__ WGSelectView(byte viewID);
//byte WGGetSel(void);
void WGPendingViewAction(void);
unsigned WGPendingClick(void);
void WGClearPendingClick(void);
void WGViewFocus(void);
void WGViewUnfocus(void);
void WGViewFocusNext(void);
void WGViewFocusPrev(void);
void WGViewFocusAction(void);
void WGPaintView(void);
void WGViewPaintAll(void);
void WGEraseViewContents(void);
void WGEraseView(void);
void __cdecl__ WGViewSetTitle(byte* title);
void __cdecl__ WGViewSetAction(void (*callback)(void));
byte __cdecl__ WGViewFromPoint(byte xPos, byte yPos);
void __fastcall__ WGSetState(byte value);
byte WGGetState(void);
void __fastcall__ WGViewSetRawTitle(byte raw);

// Cursor routines
void __cdecl__ WGSetCursor(byte xPos, byte yPos);
void __cdecl__ WGSetGlobalCursor(byte xPos, byte yPos);
void WGSyncGlobalCursor(void);

// Scrolling routines
void __fastcall__ WGScrollX(byte x);
void __fastcall__ WGScrollY(byte y);
void __cdecl__ WGScroll(byte xPos, byte yPos);
void __fastcall__ WGScrollXBy(byte xOffset);
void __fastcall__ WGScrollYBy(byte yOffset);
void __cdecl__ WGScrollBy(byte xOffset, byte yOffset);
void __fastcall__ WGSetContentWidth(byte width);
void __fastcall__ WGSetContentHeight(byte height);
//void WGViewSize(byte width, byte height);

// Drawing routines
void WGClearScreen(void);
void WGDesktop(void);
void __fastcall__ WGPlot(byte character);
void __cdecl__ WGPrint(byte* string);
void __cdecl__ WGStrokeRect(byte xPos, byte yPos, byte width, byte height);
void __cdecl__ WGStrokeRoundRect(byte xPos, byte yPos, byte width, byte height);
void __cdecl__ WGFillRect(byte xPos, byte yPos, byte width, byte height, byte fillChar);
void __cdecl__ WGFancyRect(byte xPos, byte yPos, byte width, byte height);

// Mouse & keyboard routines
void WGEnableMouse(void);
void WGDisableMouse(void);
byte WGGet(void);

// Miscellaneous routines
void WGExit(void);
//void WGReset(void);
void WGResetView(void);

#endif