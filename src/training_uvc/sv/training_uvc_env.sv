//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_env.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_ENV_SV
`define TRAINING_UVC_ENV_SV

class training_uvc_env extends uvm_env;
  
  // registration macro
  `uvm_component_utils(training_uvc_env)  
  
  // configuration instance
  training_uvc_cfg m_cfg;  

  // agent instance
  training_uvc_agent m_agent;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : training_uvc_env

// constructor
function training_uvc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void training_uvc_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(training_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // create agent
  m_agent = training_uvc_agent::type_id::create("m_agent", this);

  // set agent configuration
  uvm_config_db#(training_uvc_agent_cfg)::set(this, "m_agent", "m_cfg", m_cfg.m_agent_cfg);
endfunction : build_phase

`endif // TRAINING_UVC_ENV_SV
