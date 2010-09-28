SHELL=/bin/sh
MAKE=make

VPP_NAME=vppreproc


################################################################################
# set up coverage
################################################################################



.PHONY build_cdd:
build_cdd:  
	echo "################################################################################"; \
	echo; \
	$(VPP_NAME) --noline --noblank  -DSYNTHESIS     ../../bench/verilog/TestBench.cov  > mrisc.v ;\
	covered score -i TB.dut    -t mrisc  -I ./ -v ./mrisc.v -o mrisc.cdd 2> mrisc_cov.log | tee >> mrisc_cov.log ;\
	echo "################################################################################"; \

################################################################################
# score coverage from vcd
################################################################################



.PHONY score_cov:
score_cov:  
	echo "################################################################################"; \
	echo " Scoring ${$TEST}     ";\
	covered score  -cdd mrisc.cdd -vcd ../../out/$(TEST).vcd  2>> sco_cov.log | tee >> sco_cov.log ;\






################################################################################
# run coverage report
################################################################################



.PHONY report_cov:
report_cov:  
	echo "################################################################################"; \
	covered report    -cdd mrisc.cdd 2> rep_cov.log | tee >> rep_cov.log ;\
