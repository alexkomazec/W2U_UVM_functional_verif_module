//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_if.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_IF_SV
`define TRAINING_UVC_IF_SV

interface training_uvc_if(input PCLK, input PRESETn);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals
  logic [31:0] PADDR;
  logic        PWRITE;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
  logic        PREADY;
  
  // assertions
  // TODO TODO TODO
  
endinterface : training_uvc_if

`endif // TRAINING_UVC_IF_SV
