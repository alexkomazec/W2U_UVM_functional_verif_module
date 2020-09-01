//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_top_env_pkg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TOP_ENV_PKG_SV
`define UART_UVC_TOP_ENV_PKG_SV

package uart_uvc_top_env_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import uart_uvc_pkg::*;

// include env files
`include "uart_uvc_top_cfg.sv"
`include "uart_uvc_top_env.sv"

endpackage : uart_uvc_top_env_pkg

`endif // UART_UVC_TOP_ENV_PKG_SV
