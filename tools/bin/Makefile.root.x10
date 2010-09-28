SHELL=/bin/sh
MAKE=make

VPP_NAME=vppreproc


CUR_DIR=$(shell pwd)
VAR_DIR=$(CUR_DIR)/variants
SRC_DIR=$(CUR_DIR)/verilog
GEN_DIR=$(CUR_DIR)/gen






################################################################################
# Build rtl code
################################################################################

prepare_dirs:
	@if [ ! -d $(GEN_DIR) ]; then mkdir -p $(GEN_DIR);mkdir $(GEN_DIR)/syn;mkdir $(GEN_DIR)/sim; fi


build_fsm: prepare_dirs
	@for COMP in `ls $(CUR_DIR)/fzm`; do \
	echo "################################################"; \
	echo; \
	echo "FSM : $$COMP ####"; echo; \
	perl ~/bin/fizzim.pl -encoding onehot -terse < ./fzm/$$COMP >   $(SRC_DIR)/$$COMP.v;\
	done; \







build_hw:   build_fsm
	@echo
	@for VARIANT in       `ls $(VAR_DIR)`;      do \
	echo "################################################################################"; \
	echo; \
	echo "Building: $$VARIANT ####"; echo; \
	cp    $(VAR_DIR)/$$VARIANT/$(DEF_FILE) $(DEF_FILE); \
	cp   ../doc/copyright.v    $(GEN_DIR)/sim/$$VARIANT.v ; \
	$(VPP_NAME) --simple       $(DEF_FILE)      $(SRC_DIR)/*.v >> $(GEN_DIR)/sim/$$VARIANT.v  ; \
	cp   ../doc/copyright.v    $(GEN_DIR)/syn/$$VARIANT.v ; \
	$(VPP_NAME) --simple -DSYNTHESIS $(DEF_FILE) $(SRC_DIR)/*.v >> $(GEN_DIR)/syn/$$VARIANT.v  ; \
	rm    $(DEF_FILE); \
	done; \


################################################################################
# Build software
################################################################################

.PHONY asm_6502:
asm_6502: 
	(\
	echo "#################################################################"; \
	echo; \
	echo "assembling: $(code)    ####"; echo; \
	crasm $(code).asm -o $(code).hex > $(code).lst; \
	hex2abs16 $(code); \
	hex2abs   $(code); \
	hex2abs_split $(code); \
	)


.PHONY asm_pic:
asm_pic: 
	(\
	echo "#################################################################"; \
	echo; \
	echo "assembling: $(code)    ####"; echo; \
	gpasm $(code).asm -o $(code).hex > $(code).lst; \
	hex2abs12 $(code); \
	)


################################################################################
# run simulation suite
################################################################################


.PHONY clean_sims:
clean_sims:
	(\
	rm -f $(CUR_DIR)/../out/*;\
	rm -f $(CUR_DIR)/../log/*;\
	 )


.PHONY run_sims:
run_sims:   clean_sims
	@for VARIANT_PROG in `ls $(CUR_DIR)/../run`; do \
	echo "################################################################################"; \
	echo; \
	echo "Simulating: $$VARIANT_PROG ####"; echo; \
	cd   $(CUR_DIR)/../run/$$VARIANT_PROG/;\
	echo "include ../../../../../bin/Makefile.root" > Makefile;\
	echo -n "test=" >> Makefile;\
	echo    $$VARIANT_PROG >> Makefile;\
	make sim;\
	done; \


.PHONY sim:
sim:
	(\
	iverilog -D VCD ../../bench/verilog/TestBench;\
	./a.out  | tee ./${test}_sim.log ;\
	mv *.log ../../log;\
	mv   TestBench.vcd ../../out/${test}.vcd ;\
	rm a.out;\
	 )




.PHONY group_build_fpgas:
group_build_fpgas:   
	@for COMP in `ls $(CUR_DIR)/../ip`; do \
	echo "################################################"; \
	echo; \
	echo "Synthesising: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../ip/$$COMP/bin;\
	make build_fpgas;\
	done; \








.PHONY build_fpgas:
build_fpgas:   
	@for COMP in `ls $(CUR_DIR)/../syn`; do \
	echo "################################################"; \
	echo; \
	echo "Synthesising: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../syn/$$COMP/;\
	make fpga;\
	done; \






PHONY: fpga
fpga:
	(\
	rm -r xilinx;\
	mkdir xilinx;\
	cd xilinx;\
	echo "run -ifn ../filelist   -ifmt mixed -top " $(board)_$(Design) " -ofn "  $(board)_$(Design)".ngc -ofmt NGC  -p "  $(Part) "-opt_mode Speed -opt_level 1" > Xst;\
	xst -ifn ./Xst -ofn $(board)_$(Design).log;\
	ngdbuild -uc ../target/Pad_Ring.ucf $(board)_$(Design);\
	map  -p  $(Part)  -cm area -pr b -k 4 -c 100 -o $(board)_$(Design)_map.ncd $(board)_$(Design).ngd $(board)_$(Design).pcf;\
	par -w  -ol std -t 1 $(board)_$(Design)_map.ncd $(board)_$(Design).ncd $(board)_$(Design).pcf ;\
	trce -e 3 -s 5 -xml $(board)_$(Design) $(board)_$(Design).ncd -o $(board)_$(Design).twr $(board)_$(Design).pcf -ucf ../target/Pad_Ring.ucf ;\
	bitgen -f ../target/jtag.ut  $(board)_$(Design).ncd;\
	mv $(board)_$(Design).bit Board_Design_jtag.bit ;\
	impact -batch ../debug/impact_bat   ;\
	)








.PHONY group_composite:
group_composite: 
	@for COMP in `ls $(CUR_DIR)/../ip`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../ip/$$COMP/bin;\
	make comp_lnk;\
	done; \





.PHONY group_build_hw:
group_build_hw: group_start_hw
	@for COMP in `ls $(CUR_DIR)/../ip`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../ip/$$COMP/rtl;\
	echo "include ../../../bin/Makefile.root" > Makefile;\
	echo -n "DEF_FILE=" >> Makefile;\
	echo -n $$COMP >> Makefile;\
	echo  "_defines.v" >> Makefile;\
	make build_hw;\
	done; \



.PHONY group_start_hw:
group_start_hw: 
	@for CHILD in `ls $(CUR_DIR)/../children`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$CHILD ####"; echo; \
	cd   $(CUR_DIR)/../children/$$CHILD/bin;\
	${MAKE} group_build_hw;\
	done; \




.PHONY group_build_sw:
group_build_sw: group_start_sw
	@for COMP in `ls $(CUR_DIR)/../sw`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../sw/$$COMP;\
	make all;\
	done; \


.PHONY group_start_sw:
group_start_sw: 
	@for CHILD in `ls $(CUR_DIR)/../children`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$CHILD ####"; echo; \
	cd   $(CUR_DIR)/../children/$$CHILD/bin;\
	${MAKE} group_build_sw;\
	done; \



.PHONY group_run_sims:
group_run_sims: 
	@for COMP in `ls $(CUR_DIR)/../ip`; do \
	echo "################################################"; \
	echo; \
	echo "Linking: $$COMP ####"; echo; \
	cd   $(CUR_DIR)/../ip/$$COMP/sim/bin;\
	make run_sims;\
	done; \




