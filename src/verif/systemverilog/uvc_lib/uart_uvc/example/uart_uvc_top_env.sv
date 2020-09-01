//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_top_env.sv
// Developer  : Aleksandar Komazec
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TOP_ENV_SV
`define UART_UVC_TOP_ENV_SV

class uart_uvc_top_env extends uvm_env;

  // registration macro
  `uvm_component_utils(uart_uvc_top_env)

  // configuration reference
  uart_uvc_top_cfg m_cfg;

  // component instance
  uart_uvc_env m_uart_uvc_env;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);

endclass : uart_uvc_top_env

// constructor
function uart_uvc_top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void uart_uvc_top_env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // get configuration
  if(!uvm_config_db #(uart_uvc_top_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(uart_uvc_cfg)::set(this, "m_uart_uvc_env", "m_cfg", m_cfg.m_uart_uvc_cfg);

  // create component
  m_uart_uvc_env = uart_uvc_env::type_id::create("m_uart_uvc_env", this);
endfunction : build_phase

`endif // UART_UVC_TOP_ENV_SV
