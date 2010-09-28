SHELL=/bin/sh
MAKE=make
CUR_DIR=$(shell pwd)
home=$(CUR_DIR)/..

all:   install


.PHONY install:
install:
	(\
	mkdir ~/bin;\
	cp ../../bin/* ~/bin;\
	chmod 755 ~/bin/* ;\
	sudo cp -r ../../etc   /   ;\
	sudo apt-get  install -y flashplugin-nonfree 
	sudo apt-get  install -y ubuntu-restricted-extras
	sudo apt-get  install -y emacs
	sudo apt-get  install -y xemacs21
	sudo apt-get  install -y subversion
	sudo apt-get  install -y tkdiff
	sudo apt-get  install -y build-essential
	sudo apt-get  install -y fxload
	sudo apt-get  install -y libftdi-dev
	sudo apt-get  install -y xutils-dev
	sudo apt-get  install -y bison
	sudo apt-get  install -y flex
	sudo apt-get  install -y texinfo
	sudo apt-get  install -y libncurses5-dev
	sudo apt-get  install -y gtkterm
	sudo apt-get  install -y gtkwave
	sudo apt-get  install -y gperf
	sudo apt-get  install -y geda
	sudo apt-get  install -y sdcc
	sudo apt-get  install -y ghdl
	sudo apt-get  install -y csh
	sudo apt-get  install -y eclipse
	sudo apt-get  install -y k3b
	sudo apt-get  install -y gitk
	sudo apt-get  install -y git-gui
	sudo apt-get  install -y perl-tk
	)


