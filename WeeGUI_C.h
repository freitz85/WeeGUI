#ifndef WEEGUI_H
#define WEEGUI_H

typedef unsigned char byte;

#define FEATURE_CONTENT			0x00
#define FEATURE_SCROLL_UP		0x10
#define FEATURE_SCROLL_DOWN 	0x20
#define FEATURE_SCROLL_LEFT 	0x30
#define FEATURE_SCROLL_RIGHT	0x40

typedef enum { STYLE_FRAMELESS = 0x00, STYLE_PLAIN = 0x01, STYLE_DECORATED = 0x02 } style_t;

typedef struct 
{
	byte viewId;
	style_t style;
	byte xPos;
	byte yPos;
	byte width;
	byte height;
	byte contentWidth;
	byte contentHeight;
} createViewParam_t;

typedef struct
{
	byte viewId;
	byte xpos;
	byte ypos;
	char* pLabel;
} createCheckboxParam_t, createRadioParam_t;

typedef struct 
{
	byte viewId;
	byte xPos;
	byte yPos;
	byte width;
} createProgressParam_t;

typedef struct
{
	byte viewID;
	byte xPos;
	byte yPos;
	byte width;
	void (*pfnCallback)(void);
	char* pLabel;
} createButtonParam_t;


void WGInit(void);

// View routines
void __fastcall__ WGCreateView(createViewParam_t* pParams);
void __fastcall__ WGCreateCheckbox(createCheckboxParam_t* pParams);
void __fastcall__ WGCreateRadio(createRadioParam_t* pParams);
void __fastcall__ WGCreateProgress(createProgressParam_t* pParams);
void __fastcall__ WGCreateButton(createButtonParam_t* pParams);
void WGDeleteView(void);
void __fastcall__ WGSelectView(byte viewId);
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
void __fastcall__ WGViewSetTitle(char* pTitle);
void __fastcall__ WGViewSetAction(void (*pfnCallback)(void));
byte __fastcall__ WGViewFromPoint(byte xPos, byte yPos);
void __fastcall__ WGSetState(byte value);
byte WGGetState(void);
void __fastcall__ WGViewSetRawTitle(byte raw);

// Cursor routines
void __fastcall__ WGSetCursor(byte xPos, byte yPos);
void __fastcall__ WGSetGlobalCursor(byte xPos, byte yPos);
void WGSyncGlobalCursor(void);

// Scrolling routines
void __fastcall__ WGScrollX(byte x);
void __fastcall__ WGScrollY(byte y);
//void __fastcall__ WGScroll(byte xPos, byte yPos);
void __fastcall__ WGScrollXBy(byte xOffset);
void __fastcall__ WGScrollYBy(byte yOffset);
//void __fastcall__ WGScrollBy(byte xOffset, byte yOffset);
void __fastcall__ WGSetContentWidth(byte width);
void __fastcall__ WGSetContentHeight(byte height);
//void WGViewSize(byte width, byte height);

// Drawing routines
void WGClearScreen(void);
void WGDesktop(void);
void __fastcall__ WGPlot(char character);
void __fastcall__ WGPrint(char* pString);	// TODO overflow bit
void __fastcall__ WGStrokeRect(byte xPos, byte yPos, byte width, byte height);
void __fastcall__ WGStrokeRoundRect(byte xPos, byte yPos, byte width, byte height);
void __fastcall__ WGFillRect(byte xPos, byte yPos, byte width, byte height, byte fillChar);
void __fastcall__ WGFancyRect(byte xPos, byte yPos, byte width, byte height);

// Mouse & keyboard routines
void WGEnableMouse(void);
void WGDisableMouse(void);
byte WGGet(void);

// Miscellaneous routines
void WGExit(void);
//void WGReset(void);
void WGResetView(void);

#endif
