#------------------------------------------------------------------------------
# Copyright (c) 2017 Elsys Eastern Europe
# All rights reserved.
#------------------------------------------------------------------------------
# File name  : Makefile
# Developer  : Milan Bjelobrk
# Date       : 
# Description: 
# Notes      : 
#
#------------------------------------------------------------------------------

#------------------------------
# Common variables
#------------------------------
PROJECT_NAME      = wb2uart
BASE_DIR          = $(CURDIR)/..
BASE_VE_DIR       = $(BASE_DIR)/verif/systemverilog
BASE_UVC_DIR      = $(BASE_VE_DIR)/uvc_lib
RTL_DIR           = $(BASE_DIR)/rtl

#------------------------------
# Variables for simulation run
#------------------------------
TEST_NAME       = wb2uart_register_access_test_tc
SEED            = random
GUI_TCL_FILE    = WB2UART.tcl
BATCH_TCL_FILE  = probe.tcl
VERBOSITY       = UVM_HIGH
TOP_FILE        = $(BASE_DIR)/verif/systemverilog/tb/wb2uart_tb_top.sv

#------------------------------
# Variables for regression run
#------------------------------
TEST_LIST       = tests
TEST_LIST_PATH  = $(BASE_DIR)/makefile
REGRESS_DIR     = $(BASE_DIR)/makefile/regression_folder

#------------------------------
# Other variables and options
#-------------------------------
SIM = irun

INCDIRS = -incdir $(BASE_UVC_DIR)/wishbone_uvc/sv \
	  -incdir $(BASE_UVC_DIR)/uart_uvc/sv \
          -incdir $(BASE_VE_DIR)/env \
	  -incdir $(BASE_VE_DIR)/env/virt_seq_lib \
          -incdir $(BASE_VE_DIR)/tb \
          -incdir $(BASE_VE_DIR)/tests \
          -incdir $(RTL_DIR)/verilog


PACKAGES =  $(BASE_UVC_DIR)/wishbone_uvc/sv/wishbone_uvc_pkg.sv \
	    $(BASE_UVC_DIR)/uart_uvc/sv/uart_uvc_pkg.sv \
            $(BASE_VE_DIR)/env/wb2uart_env_top_pkg.sv \
            $(BASE_VE_DIR)/tests/wb2uart_test_pkg.sv

RTL_FILES = rtl.files

OPTIONS = +UVM_VERBOSITY=$(VERBOSITY) \
          -sv \
          -svseed $(SEED) \
          -access rwc \
          -v93 \
          -timescale 1ns/1ns \
          -vlog_ext +.vh \
          -file $(RTL_FILES) \
          $(TOP_FILE)

RUN_GUI_TCL = +tcl+$(BASE_DIR)/work/$(GUI_TCL_FILE)

RUN_BATCH_TCL = +tcl+$(BASE_DIR)/work/$(BATCH_TCL_FILE)

COVERAGE_OPTIONS = -coverage all \
                   -covoverwrite

DEBUG_OPTIONS = -linedebug \
                -uvmlinedebug

#-----------------------------------------------------------
# "Function" for running regression used by target run_regr
#-----------------------------------------------------------
define func_run_regression
	@echo `(date +%d_%m_%y___%H_%M_%S)` > .tmp_time_file;\
	$(eval current_regression = "regression_`cat .tmp_time_file`")
	@mkdir -p $(REGRESS_DIR)/$(current_regression)

	@echo
	@echo "**********************************************************"
	@echo "*   RUNNING REGRESSION:  $(current_regression)"
	@echo "**********************************************************"
	@echo "REGRESSION FOLDER LOCATION:"
	@echo "  $(REGRESS_DIR)/$(current_regression)"
	@echo
	@echo "START RUNNING TESTS..."
	@echo

	@sed '/^\s*$$/d' $1 > $(REGRESS_DIR)/.tmp_no_empty_lines.vsif

	@while read -r line; do \
		echo "$$line" > $(REGRESS_DIR)/.tmp_file;\
		$(eval test_info = `cat $(REGRESS_DIR)/.tmp_file | sed 's/ //g' | sed 's/{count.*//'`) \
		$(eval num_of_runs_info = `cat $(REGRESS_DIR)/.tmp_file | sed 's/ //g' | sed 's/.*{count//' | sed 's/;}.*//'`) \
		echo "Running test(s): $(test_info)"; \
		for n in $$(seq 1 $(num_of_runs_info)); do \
			echo "run $$n of $(num_of_runs_info)"; \
			mkdir -p $(REGRESS_DIR)/$(current_regression)/runs/regr_$(test_info)_run_$$n ; \
			cd $(REGRESS_DIR)/$(current_regression)/runs/regr_$(test_info)_run_$$n ; \
			$(SIM) -q $(INCDIRS) $(PACKAGES) $(OPTIONS) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) +UVM_TESTNAME=$(test_info) > /dev/null; \
			echo "`grep 'SVSEED set randomly from command line:' ./irun.log | sed 's/^.*: //'`" > $(REGRESS_DIR)/.tmp_seed_info_file; \
			mv ../`pwd . | sed 's/^.*\///'` ../`pwd . | sed 's/^.*\///'`_seed_`cat $(REGRESS_DIR)/.tmp_seed_info_file`; \
			cd $(BASE_DIR)/makefile ; \
		done; \
	done <"$(REGRESS_DIR)/.tmp_no_empty_lines.vsif"
endef

#------------------------------
# Setting default target
#------------------------------
.DEFAULT_GOAL := help

#------------------------------
# targets
#------------------------------
run_gui : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(RUN_GUI_TCL) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) +UVM_TESTNAME=$(TEST_NAME) -gui

run_batch : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(RUN_BATCH_TCL) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) +UVM_TESTNAME=$(TEST_NAME)
    
clean :	
	rm -rf INCA* *.key *.log *.diag *.shm cov_work *.err .simvis* *.history *xcelium.d*

clean_regr :	
	rm -rf $(REGRESS_DIR)
test_help :
	@echo "TEST_NAME can be"
	@echo "wb2uart_register_access_test_tc"

run_regr :
	$(call func_run_regression,$(TEST_LIST_PATH)/$(TEST_LIST).vsif)
	@echo
	@echo "FINISHED RUNNING TESTS"
	@$(BASE_DIR)/makefile/chk_regr_result.sh $(REGRESS_DIR)/$(current_regression)
	@echo
	@echo "REGRESSION RESULT LOG LOCATION:"
	@echo "$(REGRESS_DIR)/$(current_regression)/regression_result.log"
	@echo
	@echo "MERGING COVERAGE..."
	@imc -nostdout -execcmd "merge $(REGRESS_DIR)/$(current_regression)/runs/regr_*/cov_work/scope/test* -out $(REGRESS_DIR)/$(current_regression)/regr_coverage -overwrite"
	@imc -nostdout -execcmd "load -run $(REGRESS_DIR)/$(current_regression)/regr_coverage; report_metrics -out $(REGRESS_DIR)/$(current_regression)/regr_coverage_report -detail -both -kind expand -overwrite"
	@rm imc.* mdv.log
	@echo
	@echo "MERGING COVERAGE DONE. COVERAGE REPORT LOCATION:"
	@echo "For IMC     : $(REGRESS_DIR)/$(current_regression)/regr_coverage"
	@echo "For FIREFOX : $(REGRESS_DIR)/$(current_regression)/regr_coverage_report/index.html"
	@echo
	@echo "**********************************************************"
	@echo "*   REGRESSION FINISHED:  $(current_regression)"
	@echo "**********************************************************"
	@echo
	@rm $(REGRESS_DIR)/.tmp_file .tmp_time_file $(REGRESS_DIR)/.tmp_no_empty_lines.vsif $(REGRESS_DIR)/.tmp_seed_info_file

help :
	@echo ""
	@echo "**********************************************************"
	@echo "*                 MAKEFILE HELP MENU"
	@echo "**********************************************************"
	@echo "  Usage:"
	@echo "          make [Target1 Target2 Target3 ...] [Variable1=<set_value> Variable2=<set_value> Variable3=<set_value> ...]"
	@echo ""
	@echo "  Targets:"
	@echo "          help         - Opens help menu. Help menu will also be opened if no target is specified"
	@echo "          run_batch    - Run simulation in BATCH mode"
	@echo "          run_gui      - Run simulation in GUI mode"
	@echo "          run_regr     - Run regression using tests from *.vsif file"
	@echo "          clean        - Remove all simulation files"
	@echo "          clean_regr   - Remove all regression files"
	@echo ""
	@echo "  Variables:"
	@echo "          PROJECT_NAME - Current name of the project/UVC"
	@echo "                         Current Value: $(PROJECT_NAME)"
	@echo "          BASE_DIR     - Base directory of project/UVC"
	@echo "                         Current Value: $(BASE_DIR)"
	@echo "          TEST_NAME    - Name of the test to be runed"
	@echo "                         Current Value: $(TEST_NAME)"
	@echo "          TOP_FILE     - Location and name of test-bench file"
	@echo "                         Current Value: $(TOP_FILE)"
	@echo "          SEED         - Test seed number"
	@echo "                         Current Value: $(SEED)"
	@echo "          VERBOSITY    - Message verbosity level"
	@echo "                         Current Value: $(VERBOSITY)"
	@echo "          TCL_FILE     - Name of TCL file used for simulation"
	@echo "                         Current Value: $(TCL_FILE)"
	@echo "          TEST_LIST    - Absolute path to and name of VSIF file"
	@echo "                         Current Value: $(TEST_LIST)"
	@echo "          REGRESS_DIR  - Absolute path to and name of regression results folder"
	@echo "                         Current Value: $(REGRESS_DIR)"
	@echo "**********************************************************"
	@echo ""

