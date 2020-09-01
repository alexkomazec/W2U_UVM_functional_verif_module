//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_top_cfg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_TOP_CFG_SV
`define WB2UART_TOP_CFG_SV

class wb2uart_top_cfg extends uvm_object;

  // UVC configuration
  uart_uvc_cfg     m_uart_uvc_cfg;
  wishbone_uvc_cfg m_wishbone_uvc_cfg;

  // registration macro
  `uvm_object_utils_begin(wb2uart_top_cfg)
    `uvm_field_object(m_uart_uvc_cfg,     UVM_ALL_ON)
    `uvm_field_object(m_wishbone_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  // constructor
  extern function new(string name = "wb2uart_top_cfg");

endclass : wb2uart_top_cfg

// constructor
function wb2uart_top_cfg::new(string name = "wb2uart_top_cfg");
  super.new(name);
  // create UVC configuration
  m_uart_uvc_cfg     = uart_uvc_cfg::type_id::create("m_uart_uvc_cfg");
  m_wishbone_uvc_cfg = wishbone_uvc_cfg::type_id::create("wishbone_uvc_cfg");
endfunction : new

`endif // WB2UART_TOP_CFG_SV
