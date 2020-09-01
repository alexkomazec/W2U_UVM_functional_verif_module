//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_item.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_ITEM_SV
`define UART_UVC_ITEM_SV

class uart_uvc_item extends uvm_sequence_item;

  // item fields
  rand bit [8:0]      m_data;
  rand parity_valid_e m_parity_valid;
       bit            m_parity;

  // registration macro
  `uvm_object_utils_begin(uart_uvc_item)
    `uvm_field_int(m_data, UVM_ALL_ON)
    `uvm_field_enum(parity_valid_e, m_parity_valid, UVM_DEFAULT)
    `uvm_field_int(m_parity, UVM_ALL_ON)
  `uvm_object_utils_end

  // constraints
  constraint m_data_c{
    soft m_data >0;
  }

  constraint m_parity_valid_c{
    soft m_parity_valid == GOOD_PARITY_E;
  }

  // constructor
  extern function new(string name = "uart_uvc_item");
 
endclass : uart_uvc_item

// constructor
function uart_uvc_item::new(string name = "uart_uvc_item");
  super.new(name);
endfunction : new

`endif // UART_UVC_ITEM_SV
