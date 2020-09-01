//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_env.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_ENV_SV
`define UART_UVC_ENV_SV

class uart_uvc_env extends uvm_env;

  // registration macro
  `uvm_component_utils(uart_uvc_env)

  // configuration instance
  uart_uvc_cfg m_cfg;

  // agents instances
  uart_uvc_tx_agent m_tx_agent;
  uart_uvc_rx_agent m_rx_agent;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);

endclass : uart_uvc_env

// constructor
function uart_uvc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void uart_uvc_env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // get configuration
  if(!uvm_config_db #(uart_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set agents configurations
  uvm_config_db#(uart_uvc_agent_cfg)::set(this, "m_tx_agent", "m_cfg", m_cfg.m_tx_agent_cfg);
  uvm_config_db#(uart_uvc_agent_cfg)::set(this, "m_rx_agent", "m_cfg", m_cfg.m_rx_agent_cfg);

  // create agents
  m_tx_agent = uart_uvc_tx_agent::type_id::create("m_tx_agent", this);
  m_rx_agent = uart_uvc_rx_agent::type_id::create("m_rx_agent", this);
endfunction : build_phase

`endif // UART_UVC_ENV_SV
