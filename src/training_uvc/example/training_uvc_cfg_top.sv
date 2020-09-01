//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_cfg_top.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_CFG_TOP_SV
`define TRAINING_UVC_CFG_TOP_SV

class training_uvc_cfg_top extends uvm_object;
    
  // UVC configuration
  training_uvc_cfg m_training_uvc_cfg;
  
  // registration macro
  `uvm_object_utils_begin(training_uvc_cfg_top)
    `uvm_field_object(m_training_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
    
  // constructor
  extern function new(string name = "training_uvc_cfg_top");
  
endclass : training_uvc_cfg_top

// constructor
function training_uvc_cfg_top::new(string name = "training_uvc_cfg_top");
  super.new(name);
  
  // create UVC configuration
  m_training_uvc_cfg = training_uvc_cfg::type_id::create("m_training_uvc_cfg");
endfunction : new

`endif // TRAINING_UVC_CFG_TOP_SV
