SHELL=/bin/sh
MAKE=make
CUR_DIR=$(shell pwd)
home=$(CUR_DIR)
design=socgen


all: run_sims build_fpgas check_sims check_fpgas



.PHONY build_soc:
build_soc: 
	(\
	rm -r work  ;\
	find . | grep "~" | xargs rm $1 ;\
	${home}/tools/bin/soc_link   ;\
	 )


.PHONY build_hw:
build_hw: 
	(\
	${home}/tools/bin/soc_builder;\
	 )




.PHONY build_sw:
build_sw: build_hw
	@for PROJECT in `ls $(CUR_DIR)/work`; do \
	echo "################################################"; \
	echo "build_sw: $$PROJECT ####"; echo; \
	cd ${home}/work/$$PROJECT/bin;\
	${MAKE} group_build_sw;\
	done; \

.PHONY run_sims:
run_sims: build_sw
	@for PROJECT in `ls $(CUR_DIR)/work`; do \
	echo "################################################"; \
	echo "run_sims: $$PROJECT ####"; echo; \
	cd ${home}/work/$$PROJECT/bin;\
	${MAKE} group_run_sims;\
	done; \

.PHONY build_fpgas:
build_fpgas:
	@for PROJECT in `ls $(CUR_DIR)/work`; do \
	echo "################################################"; \
	echo "build_fpgas: $$PROJECT ####"; echo; \
	cd ${home}/work/$$PROJECT/bin;\
	${MAKE} group_build_fpgas;\
	done; \





.PHONY check_sims:
check_sims:   
	@for COMP in `ls $(CUR_DIR)/work`; do \
	echo "*******************************************************************************************";\
	echo " number of $$COMP sims run";\
	find ./work/$$COMP  | grep dut| grep -v children| grep -v cov | wc -l;\
	echo " number of sims that finished";\
	find ./work/$$COMP  | grep _sim.log | xargs grep PASSED $1    | wc -l ;\
	echo " number of warnings";\
	find ./work/$$COMP  | grep _sim.log | xargs grep WARNING $1   | wc -l ;\
	echo " number of errors";\
	find ./work/$$COMP  | grep _sim.log | xargs grep ERROR $1     | wc -l ;\
	echo " Code Coverage";\
	echo " number of warnings";\
	find ./work/$$COMP  | grep _cov.log | xargs grep WARNING $1  ;\
	echo " number of errors";\
	find ./work/$$COMP  | grep _cov.log | xargs grep ERROR $1    ;\
	done; 


.PHONY check_fpgas:
check_fpgas: 
	(\
	cd ${home}/work  ;\
	echo " number of fpgas";\
	find . | grep def_file | grep -v children | grep -v .svn | wc -l   ;\
	echo " number that finished";\
	find . | grep Board_Design_jtag.bit | wc -l ;\
	 )






















