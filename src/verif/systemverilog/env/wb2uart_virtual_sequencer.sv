//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_sequencer.sv
// Developer  : Aleksandar Komazec
// Date       : 23.09.2019
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQUENCER_SV
`define WB2UART_VIRTUAL_SEQUENCER_SV

class wb2uart_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils (wb2uart_virtual_sequencer)

  function new (string name = "wb2uart_virtual_sequencer", uvm_component parent);
    super.new (name, parent);
    `uvm_info(get_type_name(), "m_wb2uart_virtual_sequencer has been started", UVM_HIGH)
  endfunction

  // configuration instance
  wb2uart_top_cfg m_cfg;

  // Declare handles to wishbone and uart sequencers
  wishbone_uvc_sequencer       m_wishbone_seqr;
  uart_uvc_sequencer           m_uart_seqr;

  extern virtual function void build_phase(uvm_phase phase);
endclass

// build phase
function void wb2uart_virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  m_cfg     = wb2uart_top_cfg::type_id::create("m_cfg");

endfunction : build_phase

`endif // WB2UART_VIRTUAL_SEQUENCER_SV