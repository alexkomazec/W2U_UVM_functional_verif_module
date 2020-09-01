//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_cfg.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_CFG_SV
`define TRAINING_UVC_CFG_SV

class training_uvc_cfg extends uvm_object;
  
  // agent configuration
  training_uvc_agent_cfg m_agent_cfg;
  
  // registration macro
  `uvm_object_utils_begin(training_uvc_cfg)
    `uvm_field_object(m_agent_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "training_uvc_cfg");
    
endclass : training_uvc_cfg

// constructor
function training_uvc_cfg::new(string name = "training_uvc_cfg");
  super.new(name);
  
  // create agent configuration
  m_agent_cfg = training_uvc_agent_cfg::type_id::create("m_agent_cfg");
endfunction : new

`endif // TRAINING_UVC_CFG_SV
