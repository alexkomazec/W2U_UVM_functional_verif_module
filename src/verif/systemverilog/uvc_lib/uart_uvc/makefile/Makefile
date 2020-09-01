#------------------------------------------------------------------------------
# Copyright (c) 2019 Elsys Eastern Europe
# All rights reserved.
#------------------------------------------------------------------------------
# File name  : Makefile
# Developer  : Aleksandar Komazec
# Date       : 
# Description: 
# Notes      : 
#
#------------------------------------------------------------------------------

# options

BASE_DIR = $(CURDIR)/..

SIM = irun

INCDIRS = -incdir $(BASE_DIR)/sv \
          -incdir $(BASE_DIR)/example \

PACKAGES =  $(BASE_DIR)/sv/uart_uvc_pkg.sv \
				$(BASE_DIR)/example/uart_uvc_top_env_pkg.sv \
				$(BASE_DIR)/example/uart_uvc_test_pkg.sv

TEST_NAME = "test_uart_uvc_example"

SEED = random

TOP_FILE = $(BASE_DIR)/example/uart_uvc_tb_top.sv

TCL_FILE = uart_uvc_top_env.tcl

VERBOSITY = UVM_HIGH

OPTIONS = +UVM_VERBOSITY=$(VERBOSITY) \
          +UVM_TESTNAME=$(TEST_NAME) \
          -svseed $(SEED) \
          -access rwc \
          -timescale 1ns/1ns \
          -v93 \
	  $(TOP_FILE)

RUN_TCL = +tcl+$(TCL_FILE)

COVERAGE_OPTIONS = -coverage all \
                   -covoverwrite

DEBUG_OPTIONS = -linedebug \
                -uvmlinedebug

# targets
run_gui : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(RUN_TCL) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS) -gui

run_batch : 
	$(SIM) $(INCDIRS) $(PACKAGES) $(OPTIONS) $(COVERAGE_OPTIONS) $(DEBUG_OPTIONS)
    
clean :	
	rm -rf INCA* *.key *.log *.diag waves* cov_work *.err .simvis* *.history
