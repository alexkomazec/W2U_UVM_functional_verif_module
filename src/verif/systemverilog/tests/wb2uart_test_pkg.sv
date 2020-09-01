//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_test_pkg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_TEST_PKG_SV
`define WB2UART_TEST_PKG_SV

package wb2uart_test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import uart_uvc_pkg::*;

// import env package
import wb2uart_env_top_pkg::*;

// include tests
`include "wb2uart_test_base.sv"
`include "wb2uart_register_access_test_tc.sv"
`include "wb2uart_interrupt_trigger_test_tc.sv"
`include "wb2uart_fifo_wr_rd_test_tc.sv"

endpackage : wb2uart_test_pkg

`endif // WB2UART_TEST_PKG_SV
