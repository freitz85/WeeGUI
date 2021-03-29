#include "WeeGUI_C.h"
#include <apple2enh.h>

#define HELP_VIEW	0
#define MAIN_VIEW	1
#define BTN_OPEN	2
#define BTN_CLOSE	3
#define CHK_PARLOR	4
#define CHK_LOUNGE	5
#define CHK_BEDROOM 6
#define BTN_QUIT	7

void help(void);
void openGarage(void);
void closeGarage(void);
void quit(void);

int main(void)
{
	byte action = 0;

	// "brun weegui"

	WGDesktop();
	WGCreateView(HELP_VIEW, STYLE_DECORATED, 2, 15, 76, 7, 76, 40);
	WGViewSetTitle("Help");
	WGViewSetAction(help);
	help();

	WGFillRect(0, 0, 80, 13, 160);
	WGCreateView(MAIN_VIEW, STYLE_PLAIN, 1, 1, 78, 11, 78, 11);
	WGCreateButton(BTN_OPEN, 4, 3, 21, openGarage, "Open Garage");
	WGCreateButton(BTN_CLOSE, 4, 5, 21, closeGarage, "Close Garage");

	WGSelectView(BTN_OPEN);
	WGSetCursor(40, 1);
	WGPrint("\x53\x53\x53");
	/* INVERSE */
	WGPrint(" Lighting: ");
	/* NORMAL */
	WGPrint("\x53\x53\x53");

	WGCreateCheckbox(CHK_PARLOR, 42, 4, "Parlor");
	WGCreateCheckbox(CHK_LOUNGE, 42, 6, "Lounge");
	WGCreateCheckbox(CHK_BEDROOM, 42, 8, "Bedroom");
	openGarage();

	WGCreateButton(BTN_QUIT, 71, 1, 8, quit, "Quit");
	WGSelectView(HELP_VIEW);
	WGEnableMouse();

	while(action != 113)
	{
		WGPendingViewAction();
		action = WGGet();

		switch(action)
		{
		case 113: 		// q
			quit(); 
			break;

		case CH_CURS_UP:
			WGScrollBy(0, 1);
			help();
			break;

		case CH_CURS_DOWN:
			WGScrollBy(0, -1);
			help();
			break;

		case CH_ESC:
			WGFocusPrev();
			break;

		case 9:
			WGFocusNext();
			break;

		case CH_ENTER:
			WGViewFocusAction();
			break;
		}
	}

	return 0;
}

void help(void)
{
	WGSelectView(HELP_VIEW);
	WGEraseViewContents();
	
	WGSetCursor(2, 1);
	WGPrint("Welcome to the SuperAutoMat6000 home automation system.");

	WGSetCursor(0, 3);
	WGPrint("Use the buttons and checkboxes above to achieve the perfect " \
			"mood for any occasion. Frequent use may cause heartburn. " \
			"Do not look into laser with remaining eye.");
	WGPrint(" Note that this is a really long, pintless block of meaningless " \
			"text, but at least you can scroll it!");
	WGPrint(" Darn good thing too, because it doesn't fit in the " \
			"allotted space here.");

	WGSetCursor(8, 9);
	WGPrint("(c)2015 OmniCorp. All rights reserved."); 
}

void openGarage(void)
{
	WGSelectView(BTN_OPEN);
	WGSetCursor(4, 8);
	WGPrint("Garage door is open  ");
}

void closeGarage(void)
{
	WGSelectView(BTN_CLOSE);
	WGSetCursor(4, 8);
	WGPrint("Garage door is closed");
}

void quit(void)
{
	WGDisableMouse();
	WGExit();
	/* HOME */
}
