//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_agent_cfg.sv
// Developer  : Aleksandar Komazec
// Date       : 9.9.2019
// Description: UART config field are added
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_AGENT_CFG_SV
`define UART_UVC_AGENT_CFG_SV

class uart_uvc_agent_cfg extends uvm_object;

  // configuration fields
  uvm_active_passive_enum m_is_active = UVM_ACTIVE;
  bit m_has_checks;
  bit m_has_coverage;

  number_of_bits_e m_number_of_data_bits;
  stop_bits_e      m_number_of_stop_bits;
  parity_e         m_parity_enable;
  type_of_parity_e m_parity_type;
  baud_rate_e      m_baud_rate;


  // registration macro
  `uvm_object_utils_begin(uart_uvc_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_ALL_ON)
    `uvm_field_enum(number_of_bits_e,        m_number_of_data_bits, UVM_ALL_ON)
    `uvm_field_enum(stop_bits_e,             m_number_of_stop_bits, UVM_ALL_ON)
    `uvm_field_enum(parity_e,                m_parity_enable, UVM_ALL_ON)
    `uvm_field_enum(type_of_parity_e,        m_parity_type, UVM_ALL_ON)
    `uvm_field_enum(baud_rate_e,             m_baud_rate, UVM_ALL_ON)

    `uvm_field_int(m_has_checks,             UVM_ALL_ON)
    `uvm_field_int(m_has_coverage,           UVM_ALL_ON)


  `uvm_object_utils_end

  // constructor
  extern function new(string name = "uart_uvc_agent_cfg");

endclass : uart_uvc_agent_cfg

// constructor
function uart_uvc_agent_cfg::new(string name = "uart_uvc_agent_cfg");
  super.new(name);
endfunction : new

`endif // UART_UVC_AGENT_CFG_SV
