//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_cfg.sv
// Developer  : Aleksandar Komazec
// Date       : 9.9.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_CFG_SV
`define UART_UVC_CFG_SV

class uart_uvc_cfg extends uvm_object;

  // agents configurations
  uart_uvc_agent_cfg m_tx_agent_cfg;
  uart_uvc_agent_cfg m_rx_agent_cfg;

  // registration macro
  `uvm_object_utils_begin(uart_uvc_cfg)
    `uvm_field_object(m_tx_agent_cfg, UVM_ALL_ON)
    `uvm_field_object(m_rx_agent_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  // constructor
  extern function new(string name = "uart_uvc_cfg");

endclass : uart_uvc_cfg

// constructor
function uart_uvc_cfg::new(string name = "uart_uvc_cfg");
  super.new(name);

  // create agents configurations
  m_tx_agent_cfg = uart_uvc_agent_cfg::type_id::create("m_tx_agent_cfg");
  m_rx_agent_cfg = uart_uvc_agent_cfg::type_id::create("m_rx_agent_cfg");
endfunction : new

`endif // UART_UVC_CFG_SV
