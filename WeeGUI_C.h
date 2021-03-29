#ifndef WEEGUI_H
#define WEEGUI_H

typedef unsigned char byte;
typedef enum { STYLE_FRAMELESS=0, STYLE_PLAIN, STYLE_DECORATED } style_t;

// View routines
void WGCreateView(byte viewID, style_t style, byte xPos, byte yPos, 
				  byte width, byte height, byte contentWidth, byte contentHeight);
void WGCreateCheckbox(byte ViewID, byte xPos, byte yPos, byte* label);
void WGCreateRadio(byte viewID, byte xPos, byte yPos, byte* label);
void WGCreateProgress(byte viewID, byte xPos, byte yPos, byte width);
void WGCreateButton(byte viewID, byte xPos, byte yPos, byte width, 
					void (*callback)(void), byte* label);
void WGDeleteView(void);
void WGSelectView(byte viewID);
byte WGGetSel(void);
void WGPendingViewAction(void);
unsigned WGPendingClick(void);
void WGClearPendingClick(void);
void WGViewFocus(void);
void WGViewUnfocus(void);
void WGFocusNext(void);
void WGFocusPrev(void);
void WGViewFocusAction(void);
void WGPaintView(void);
void WGViewPaintAll(void);
void WGEraseViewContents(void);
void WGEraseView(void);
void WGViewSetTitle(byte* title);
void WGViewSetAction(void (*callback)(void));
byte WGViewFromPoint(byte xPos, byte yPos);
void WGSetState(byte value);
byte WGGetState(void);
void WGViewSetRawTitle(byte raw);

// Cursor routines
void WGSetCursor(byte xPos, byte yPos);
void WGSetGlobalCursor(byte xPos, byte yPos);
void WGSyncGlobalCursor(void);

// Scrolling routines
void WGScrollX(byte x);
void WGScrollY(byte y);
void WGScroll(byte xPos, byte yPos);
void WGScrollXBy(byte xOffset);
void WGScrollYBy(byte yOffset);
void WGScrollBy(byte xOffset, byte yOffset);
void WGViewWidth(byte width);
void WGViewHeight(byte height);
void WGViewSize(byte width, byte height);

// Drawing routines
void WGClearScreen(void);
void WGDesktop(void);
void WGPlot(byte character);
void WGPrint(byte* string);
void WGStrokeRect(byte xPos, byte yPos, byte width, byte height);
void WGStrokeRoundRect(byte xPos, byte yPos, byte width, byte height);
void WGFillRect(byte xPos, byte yPos, byte width, byte height, byte fillChar);
void WGFancyRect(byte xPos, byte yPos, byte width, byte height);

// Mouse & keyboard routines
void WGEnableMouse(void);
void WGDisableMouse(void);
byte WGGet(void);

// Miscellaneous routines
void WGExit(void);
void WGReset(void);
void WGResetView(void);

#endif