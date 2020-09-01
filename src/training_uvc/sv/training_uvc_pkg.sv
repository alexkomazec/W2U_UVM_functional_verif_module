//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_pkg.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_PKG_SV
`define TRAINING_UVC_PKG_SV

`include "training_uvc_if.sv"

package training_uvc_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "training_uvc_common.sv"
`include "training_uvc_agent_cfg.sv"
`include "training_uvc_cfg.sv"
`include "training_uvc_item.sv"
`include "training_uvc_driver.sv"
`include "training_uvc_sequencer.sv"
`include "training_uvc_monitor.sv"
`include "training_uvc_cov.sv"
`include "training_uvc_agent.sv"
`include "training_uvc_env.sv"
`include "training_uvc_seq_lib.sv"

endpackage : training_uvc_pkg

`endif // TRAINING_UVC_PKG_SV
