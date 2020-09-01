//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_sequencer.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_SEQUENCER_SV
`define UART_UVC_SEQUENCER_SV

class uart_uvc_sequencer extends uvm_sequencer #(uart_uvc_item);

  // registration macro
  `uvm_component_utils(uart_uvc_sequencer)

  // configuration reference
  uart_uvc_agent_cfg m_cfg;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);

endclass : uart_uvc_sequencer

// constructor
function uart_uvc_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void uart_uvc_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

`endif // UART_UVC_SEQUENCER_SV
