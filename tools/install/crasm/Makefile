SHELL=/bin/sh
MAKE=make
CUR_DIR=$(shell pwd)
home=$(CUR_DIR)/..

all:   crasm

.PHONY crasm:
crasm: 
	(\
	cvs -d:pserver:anonymous@crasm.cvs.sourceforge.net:/cvsroot/crasm login;\
	cvs -z3 -d:pserver:anonymous@crasm.cvs.sourceforge.net:/cvsroot/crasm co -P crasm;\
	cd crasm;\
	make all;\
	cp src/crasm ~/bin;\
	)


