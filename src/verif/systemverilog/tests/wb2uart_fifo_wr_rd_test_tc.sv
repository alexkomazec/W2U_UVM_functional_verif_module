//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_fifo_wr_rd_test_tc.sv
// Developer  : Aleksandar Komazec
// Date       : 2.10.2019
// Description: 
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_FIFO_WR_RD_TEST_TC_SV
`define WB2UART_FIFO_WR_RD_TEST_TC_SV

// example test
class wb2uart_fifo_wr_rd_test_tc extends wb2uart_test_base;

  // registration macro
  `uvm_component_utils(wb2uart_fifo_wr_rd_test_tc)

  // virtual sequence
  wb2uart_virtual_seq_fifo_wr_rd m_vseq;

  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();

endclass : wb2uart_fifo_wr_rd_test_tc

// constructor
function wb2uart_fifo_wr_rd_test_tc::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// run phase
task wb2uart_fifo_wr_rd_test_tc::run_phase(uvm_phase phase);
  super.run_phase(phase);
  uvm_test_done.raise_objection(this, get_type_name());

  m_vseq = wb2uart_virtual_seq_fifo_wr_rd::type_id::create( .name("m_vseq"), .contxt( get_full_name()));
  assert(m_vseq.randomize());
  m_vseq.start(m_wb2uart_env_top.m_virt_seqr);

  uvm_test_done.drop_objection(this, get_type_name());
endtask : run_phase

// set default configuration
function void wb2uart_fifo_wr_rd_test_tc::set_default_configuration();
  super.set_default_configuration();
  // redefine configuration
endfunction : set_default_configuration

`endif // TEST_UART_UVC_EXAMPLE_SV
