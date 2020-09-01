//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wishbone_uvc_env_top.sv
// Developer  : Elsys EE
// Date       : 12.8.2019
// Description: Re-arranged
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WISHBONE_UVC_ENV_TOP_SV
`define WISHBONE_UVC_ENV_TOP_SV

class wishbone_uvc_env_top extends uvm_env;

  // registration macro
  `uvm_component_utils(wishbone_uvc_env_top)

  // configuration reference
  wishbone_uvc_cfg_top m_cfg;

  // component instance
  wishbone_uvc_env m_wishbone_uvc_env;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);

endclass : wishbone_uvc_env_top

// constructor
function wishbone_uvc_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void wishbone_uvc_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // get configuration
  if(!uvm_config_db #(wishbone_uvc_cfg_top)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(wishbone_uvc_cfg)::set(this, "m_wishbone_uvc_env", "m_cfg", m_cfg.m_wishbone_uvc_cfg);

  // create component
  m_wishbone_uvc_env = wishbone_uvc_env::type_id::create("m_wishbone_uvc_env", this);
endfunction : build_phase

`endif // WISHBONE_UVC_ENV_TOP_SV
