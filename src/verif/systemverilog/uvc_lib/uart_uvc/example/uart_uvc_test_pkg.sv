//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_test_pkg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TEST_PKG_SV
`define UART_UVC_TEST_PKG_SV

package uart_uvc_test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import uart_uvc_pkg::*;

// import env package
import uart_uvc_top_env_pkg::*;

// include tests
`include "test_uart_uvc_base.sv"
`include "test_uart_uvc_example.sv"

endpackage : uart_uvc_test_pkg

`endif // UART_UVC_TEST_PKG_SV
