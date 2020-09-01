//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_top_cfg.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TOP_CFG_SV
`define UART_UVC_TOP_CFG_SV

class uart_uvc_top_cfg extends uvm_object;

  // UVC configuration
  uart_uvc_cfg m_uart_uvc_cfg;

  // registration macro
  `uvm_object_utils_begin(uart_uvc_top_cfg)
    `uvm_field_object(m_uart_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  // constructor
  extern function new(string name = "uart_uvc_top_cfg");

endclass : uart_uvc_top_cfg

// constructor
function uart_uvc_top_cfg::new(string name = "uart_uvc_top_cfg");
  super.new(name);

  // create UVC configuration
  m_uart_uvc_cfg = uart_uvc_cfg::type_id::create("m_uart_uvc_cfg");
endfunction : new

`endif // UART_UVC_TOP_CFG_SV
