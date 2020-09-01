#------------------------------------------------------------------------------
# Copyright (c) 2018 Elsys Eastern Europe
# All rights reserved.
#------------------------------------------------------------------------------
# File name  : Makefile
# Developer  : Elsys EE
# Date       : 
# Description: 
# Notes      : 
#
#------------------------------------------------------------------------------

BASE_DIR = $(HOME)/internship/internship_current/dv/intern1/training_uvc

# options
SIM = irun

INCDIRS = -incdir $(BASE_DIR)/sv \
          -incdir $(BASE_DIR)/example \

PACKAGES =  $(BASE_DIR)/sv/training_uvc_pkg.sv \
				$(BASE_DIR)/example/training_uvc_env_top_pkg.sv \
				$(BASE_DIR)/example/training_uvc_test_pkg.sv

TEST_NAME = "test_training_uvc_example"

SEED = random

TOP_FILE = $(BASE_DIR)/example/training_uvc_tb_top.sv

TCL_FILE = probe.tcl

VERBOSITY = UVM_LOW

OPTIONS = +UVM_VERBOSITY=$(VERBOSITY) \
          +UVM_TESTNAME=$(TEST_NAME) \
          -svseed $(SEED) \
          -access rwc \
          -timescale 1ns/1ns \
          -v93 \
          $(BASE_DIR)/rtl/dut_dummy.v \
          $(TOP_FILE)

COVERAGE_OPTIONS = -coverage all \
                   -covoverwrite

DEBUG_OPTIONS = -linedebug \
                -uvmlinedebug

RUN_TCL = +tcl+$(TCL_FILE)

# targets
run_gui : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) -gui

run_batch : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) $(RUN_TCL)
    
clean :	
	rm -rf INCA* *.key *.log *.diag default* cov_work *.err .simvis* *.history *xcelium*
	
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
	@echo "          clean        - Remove all simulation files"
	@echo ""
	@echo "  Variables:"
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
	@echo "**********************************************************"
	@echo ""

