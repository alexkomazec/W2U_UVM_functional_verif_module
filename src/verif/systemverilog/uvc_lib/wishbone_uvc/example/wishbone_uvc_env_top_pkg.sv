//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wishbone_uvc_env_top_pkg.sv
// Developer  : Elsys EE
// Date       : 12.8.2019
// Description: Re-arranged 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WISHBONE_UVC_ENV_TOP_PKG_SV
`define WISHBONE_UVC_ENV_TOP_PKG_SV

package wishbone_uvc_env_top_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import wishbone_uvc_pkg::*;

// include env files
`include "wishbone_uvc_cfg_top.sv"
`include "wishbone_uvc_env_top.sv"

endpackage : wishbone_uvc_env_top_pkg

`endif // TRAINING_UVC_ENV_TOP_PKG_SV
