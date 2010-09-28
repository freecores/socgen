SHELL=/bin/sh
MAKE=make
VARIANT=serial_rcvr
VPP_NAME=vppreproc



################################################################################
# set up coverage
################################################################################



.PHONY build_cdd:
build_cdd:  
	echo "################################################################################"; \
	echo; \
	$(VPP_NAME) --noline --noblank  -DSYNTHESIS     ../../bench/verilog/TestBench.cov  > $(VARIANT).v ;\
	covered score -i TB.dut  -t $(VARIANT)  -I ./ -v ./$(VARIANT).v -o $(VARIANT).cdd 2> $(VARIANT)_cov.log | tee >> $(VARIANT)_cov.log ;\
	echo "################################################################################"; \


################################################################################
# score coverage from vcd
################################################################################



.PHONY score_cov:
score_cov:  
	echo "################################################################################"; \
	echo " Scoring ${$TEST}     ";\
	covered score  -cdd $(VARIANT).cdd -vcd ../../out/$(TEST).vcd  2>> $(VARIANT)_sco_cov.log | tee >> $(VARIANT)_sco_cov.log ;\



################################################################################
# run coverage report
################################################################################



.PHONY report_cov:
report_cov:  
	echo "################################################################################"; \
	covered report    -cdd $(VARIANT).cdd 2> $(VARIANT)_rep_cov.log | tee >> $(VARIANT)_rep_cov.log ;\
