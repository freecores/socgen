SHELL=/bin/sh
MAKE=make
CUR_DIR=$(shell pwd)
home=$(CUR_DIR)/..

all:   msp430

.PHONY msp430:
msp430: 
	(\
	svn co https://mspgcc4.svn.sourceforge.net/svnroot/mspgcc4;\
	cd mspgcc4;\
	sudo sh buildgcc.sh;\
	)


