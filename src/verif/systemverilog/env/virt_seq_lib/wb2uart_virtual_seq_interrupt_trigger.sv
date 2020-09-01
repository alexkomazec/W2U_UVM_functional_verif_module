//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_seq_interrupt_trigger.sv
// Developer  : Aleksandar Komazec
// Date       : 2.10.2019
// Description:
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQ_INTERRUPT_TRIGGER_SV
`define WB2UART_VIRTUAL_SEQ_INTERRUPT_TRIGGER_SV

class wb2uart_virtual_seq_interrupt_trigger extends wb2uart_virtual_sequence_base;
  `uvm_object_utils (wb2uart_virtual_seq_interrupt_trigger)

  function new (string name = "wb2uart_virtual_seq_interrupt_trigger");
    super.new (name);
  endfunction

  // items
  wishbone_uvc_seq_master   m_wb_seq;
  uart_uvc_item             rx_item;

  // virtual sequence
    wb2uart_virtual_seq_dut_config m_vseq;

  task body();
    m_vseq = wb2uart_virtual_seq_dut_config::type_id::create( .name("m_vseq"), .contxt( get_full_name()));
    assert(m_vseq.randomize());
    m_vseq.start(p_sequencer);

  endtask
endclass

`endif // WB2UART_VIRTUAL_SEQ_INTERRUPT_TRIGGER_SV