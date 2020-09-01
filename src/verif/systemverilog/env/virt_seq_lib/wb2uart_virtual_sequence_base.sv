//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_sequence_base.sv
// Developer  : Aleksandar Komazec
// Date       : 23.09.2019
// Description:
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQUENCE_BASE_SV
`define WB2UART_VIRTUAL_SEQUENCE_BASE_SV

class wb2uart_virtual_sequence_base extends uvm_sequence;
  `uvm_object_utils (wb2uart_virtual_sequence_base)
  `uvm_declare_p_sequencer (wb2uart_virtual_sequencer)

  //Fields
  rand bit [WB_ADDR_WIDTH_P - 1 : 0] addr[$];
  rand bit [WB_DAT_WIDTH_P  - 1 : 0] dat[$];
  rand bit [3:0]                     sel[$];
  rand read_write_t                  cmd[$];
  rand int                           stb_delay[$];
  rand tgc_t mode_cycle;
  rand int num_phase_in_block;

  extern virtual task time_out(int t);
  extern virtual task body();
  function new (string name = "wb2uart_virtual_sequence_base");
    super.new (name);
  endfunction

endclass

  task wb2uart_virtual_sequence_base::body();
      fork
        time_out(5000000);
      join_none
  endtask:body

task wb2uart_virtual_sequence_base::time_out(int t);
  #(t*1ms);
  $finish();
endtask : time_out

`endif // WB2UART_VIRTUAL_SEQUENCE_BASE_SV