//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_test_pkg.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_TEST_PKG_SV
`define TRAINING_UVC_TEST_PKG_SV

package training_uvc_test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import training_uvc_pkg::*;

// import env package
import training_uvc_env_top_pkg::*;

// include tests
`include "test_training_uvc_base.sv"
`include "test_training_uvc_example.sv"

endpackage : training_uvc_test_pkg

`endif // TRAINING_UVC_TEST_PKG_SV
