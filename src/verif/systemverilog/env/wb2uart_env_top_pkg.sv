//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_env_top_pkg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_ENV_TOP_PKG_SV
`define WB2UART_ENV_TOP_PKG_SV

package wb2uart_env_top_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import wishbone_uvc_pkg::*;
import uart_uvc_pkg::*;

`include "wb2uart_common.sv"
`include "wb2uart_top_cfg.sv"
`include "wb2uart_virtual_sequencer.sv"
`include "wb2uart_scoreboard.sv"
`include "wb2uart_env_top.sv"
`include "virt_seq_lib/wb2uart_virtual_sequence_lib.sv"

endpackage : wb2uart_env_top_pkg

`endif // WB2UART_PKG_SV
