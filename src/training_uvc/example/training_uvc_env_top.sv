//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_env_top.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_ENV_TOP_SV
`define TRAINING_UVC_ENV_TOP_SV

class training_uvc_env_top extends uvm_env;
  
  // registration macro
  `uvm_component_utils(training_uvc_env_top)

  // configuration reference
  training_uvc_cfg_top m_cfg;
    
  // component instance
  training_uvc_env m_training_uvc_env;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : training_uvc_env_top

// constructor
function training_uvc_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void training_uvc_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(training_uvc_cfg_top)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(training_uvc_cfg)::set(this, "m_training_uvc_env", "m_cfg", m_cfg.m_training_uvc_cfg);

  // create component
  m_training_uvc_env = training_uvc_env::type_id::create("m_training_uvc_env", this);
endfunction : build_phase

`endif // TRAINING_UVC_ENV_TOP_SV
