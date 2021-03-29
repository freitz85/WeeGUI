#
#  Makefile
#  WeeGUI
#
#  Created by Quinn Dunki on 8/15/14.
#  One Girl, One Laptop Productions
#  http://www.quinndunki.com
#  http://www.quinndunki.com/blondihacks
#


ifdef CC65_HOME
  CL65=$(CC65_HOME)/bin/cl65
else
  CL65=cl65
endif

AC=AppleCommander.jar
ADDR=0x4000
ADDRDEMO=0x6000

PGM=weegui
DEMO=asmdemo
CDEMO=cdemo

all: $(CDEMO) $(DEMO) $(PGM)

$(CDEMO):
	$(CL65) -t apple2enh -C apple2enh-asm.cfg --start-addr $(ADDRDEMO) -l $(CDEMO).lst -m $(CDEMO).map $(CDEMO).c
	java -jar $(AC) -d $(PGM).dsk $(CDEMO)
	java -jar $(AC) -p $(PGM).dsk $(CDEMO) BIN $(ADDRDEMO) < $(CDEMO)
	rm -f $(CDEMO)
	rm -f $(CDEMO).o

$(DEMO):
	$(CL65) -t apple2enh -C apple2enh-asm.cfg --start-addr $(ADDRDEMO) -l $(DEMO).lst -m $(DEMO).map $(DEMO).s
	java -jar $(AC) -d $(PGM).dsk $(DEMO)
	java -jar $(AC) -p $(PGM).dsk $(DEMO) BIN $(ADDRDEMO) < $(DEMO)
	rm -f $(DEMO)
	rm -f $(DEMO).o

$(PGM):
	$(CL65) -t apple2enh -C apple2enh-asm.cfg --start-addr $(ADDR) -l $(PGM).lst -m $(PGM).map $(PGM).s
	java -jar $(AC) -d $(PGM).dsk $(PGM)
	java -jar $(AC) -p $(PGM).dsk $(PGM) BIN $(ADDR) < $(PGM)
	rm -f $(PGM)
	rm -f $(PGM).o
#	osascript V2Make.scpt $(PROJECT_DIR) $(DEMO) $(PGM)

clean:
	rm -f $(CDEMO)
	rm -f $(DEMO)
	rm -f $(PGM)
	rm -f *.o
	rm -f *.lst
	rm -f *.map
