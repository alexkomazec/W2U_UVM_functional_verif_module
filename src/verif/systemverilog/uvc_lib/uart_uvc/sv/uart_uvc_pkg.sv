//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_pkg.sv
// Developer  : Aleksandar Komazec
// Date       : 11.9.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_PKG_SV
`define UART_UVC_PKG_SV

`include "uart_uvc_if.sv"

package uart_uvc_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "uart_uvc_common.sv"
`include "uart_uvc_agent_cfg.sv"
`include "uart_uvc_cfg.sv"
`include "uart_uvc_item.sv"
`include "uart_uvc_tx_driver.sv"
`include "uart_uvc_sequencer.sv"
`include "uart_uvc_monitor.sv"
`include "uart_uvc_tx_agent.sv"
`include "uart_uvc_rx_agent.sv"
`include "uart_uvc_env.sv"
`include "uart_uvc_tx_seq_lib.sv"


endpackage : uart_uvc_pkg

`endif // UART_UVC_PKG_SV
