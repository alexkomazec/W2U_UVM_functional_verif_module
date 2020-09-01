//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_env_top_pkg.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_ENV_TOP_PKG_SV
`define TRAINING_UVC_ENV_TOP_PKG_SV

package training_uvc_env_top_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import training_uvc_pkg::*;

// include env files
`include "training_uvc_cfg_top.sv"
`include "training_uvc_env_top.sv"

endpackage : training_uvc_env_top_pkg

`endif // TRAINING_UVC_ENV_TOP_PKG_SV
