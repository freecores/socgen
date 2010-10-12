SHELL=/bin/sh
MAKE=make
CUR_DIR=$(shell pwd)
home=$(CUR_DIR)/..

all:   install


.PHONY install:
install:
	(\
	mkdir ~/bin;\
	chmod 755 ./bin/* ;\
	cp ./bin/* ~/bin;\
	sudo cp -r ./etc/udev   /etc   ;\
	sudo apt-get  install -y fxload;\
	sudo apt-get  install -y urjtag;\
	sudo apt-get  install -y libftdi-dev;\
	)


