//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_if.sv
// Developer  : Aleksandar Komazec
// Date       : 9.9.2019
// Description: Signals are added
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_IF_SV
`define UART_UVC_IF_SV

interface uart_uvc_if(input clock, input reset);

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // signals
  logic txrx;

  // assertions
  txrx_knwn_chk:assert property 
  (@(posedge clock)
  disable iff(reset ===  1)
  reset === 0 |=>  (!$isunknown(txrx))  until reset === 1);

endinterface : uart_uvc_if

`endif // UART_UVC_IF_SV
