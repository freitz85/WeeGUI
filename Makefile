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
  CA65=$(CC65_HOME)/bin/ca65
else
  CL65=cl65
endif

ifdef OS 
  RM = del /Q
else
  RM = rm -f
endif

AC=AppleCommander.jar
ADDR=0x4000
ADDRDEMO=0x6000

PGM=weegui
DEMO=asmdemo
CDEMO=cdemo

all: $(DEMO) $(PGM) $(CDEMO) 

$(DEMO):
	$(CL65) -t apple2enh -C apple2enh-asm.cfg --start-addr $(ADDRDEMO) -l $(DEMO).lst -m $(DEMO).map $(DEMO).s
	java -jar $(AC) -d $(PGM).dsk $(DEMO)
	java -jar $(AC) -p $(PGM).dsk $(DEMO) BIN $(ADDRDEMO) < $(DEMO)
	$(RM) $(DEMO)
	$(RM) $(DEMO).o

$(PGM):
	$(CL65) -t apple2enh -C apple2enh-asm.cfg --start-addr $(ADDR) -l $(PGM).lst -m $(PGM).map $(PGM).s
	java -jar $(AC) -d $(PGM).dsk $(PGM)
	java -jar $(AC) -p $(PGM).dsk $(PGM) BIN $(ADDR) < $(PGM)
#	$(RM) $(PGM)
#	$(RM) $(PGM).o
#	osascript V2Make.scpt $(PROJECT_DIR) $(DEMO) $(PGM)

$(CDEMO):
	$(CA65) -t apple2enh weegui.s -l $(PGM).lst
	$(CL65) -t apple2enh -C apple2enh-weegui.cfg -l $(CDEMO).lst -m $(CDEMO).map $(CDEMO).c weegui.o
	java -jar $(AC) -d $(PGM).dsk $(CDEMO)
	java -jar $(AC) -as $(PGM).dsk $(CDEMO) < $(CDEMO)
	$(RM) $(CDEMO)
	$(RM) *.o

clean:
	$(RM) $(CDEMO)
	$(RM) $(DEMO)
	$(RM) $(PGM)
	$(RM) *.o
	$(RM) *.lst
	$(RM) *.map
