//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_wishbone_uvc_example_block_trans.sv
// Developer  : Elsys EE
// Date       : 2.09.2019
// Description: Added slave sequence as a thread
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_WISHBONE_UVC_EXAMPLE_BLOCK_TRANS_SV
`define TEST_WISHBONE_UVC_EXAMPLE_BLOCK_TRANS_SV

// example test
class test_wishbone_uvc_example_block_trans extends test_wishbone_uvc_base;
  
  // registration macro
  `uvm_component_utils(test_wishbone_uvc_example_block_trans)
  
  // Fields
  // --------------------------------------------------------------------
  
  // Mode field.
  // If this field = STANDARD_SINGLE_E, number_of_phase_test must be 1
  // If this field = STANDARD_BLOCK_E, number_of_phase_test must be higher than 1
  tgc_t modes = STANDARD_BLOCK_E;
  
  // Number of transaction items that can be transferd in simulation time
  int num_of_trans = 10;
  
  //Number of phases in a transaction
  int number_of_phase_test = 10;
  
  // sequences
  wishbone_uvc_seq_master m_seq;
  wishbone_uvc_seq_slave s_seq;

  // constructor
  extern function new(string name, uvm_component parent);
  
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  
  // set default configuration
  extern function void set_default_configuration();
  
endclass : test_wishbone_uvc_example_block_trans

// constructor
function test_wishbone_uvc_example_block_trans::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// run phase
task test_wishbone_uvc_example_block_trans::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  uvm_test_done.raise_objection(this, get_type_name());    

  m_seq = wishbone_uvc_seq_master::type_id::create("m_seq", this);
  s_seq = wishbone_uvc_seq_slave::type_id::create("s_seq", this);

  for (int o=0; o<num_of_trans; o++) begin
    if(!m_seq.randomize() with{ 
      mode_cycle     == modes;
      num_phase_in_block == number_of_phase_test;
  
      stb_delay.size()   == number_of_phase_test;
      foreach(stb_delay[i]){
        stb_delay[i]     == 5;
      }

      dat.size()     == number_of_phase_test;
      foreach(dat[j]){
        dat[j]           == 7;
      }

      addr.size() == number_of_phase_test;
      foreach(addr[k]){
        addr[k]          == 9;
      } 
        }) begin
          `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
  
  
    if(!s_seq.randomize() with{ 

      mode_cycle               == modes;
      num_phase_in_block       == number_of_phase_test;
      acknowledge_delay.size() == number_of_phase_test;
      foreach(acknowledge_delay[i]){
        acknowledge_delay[i]   == 3;
      }
      dat.size()               == number_of_phase_test;
      foreach(dat[j]){
        dat[j]                 == j;
      }
      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
    end

    fork : master_slave_fork_sequence
      begin
        m_seq.start(m_wishbone_uvc_env_top.m_wishbone_uvc_env.m_agent.m_sequencer);
      end

      begin
        s_seq.start(m_wishbone_uvc_env_top.m_wishbone_uvc_env.s_agent.m_sequencer);
      end
  join // master_slave_fork_sequence

  end

  uvm_test_done.drop_objection(this, get_type_name());
  `uvm_info(get_type_name(), "TEST FINISHED", UVM_FULL)
endtask : run_phase

// set default configuration
function void test_wishbone_uvc_example_block_trans::set_default_configuration();
  super.set_default_configuration();

endfunction : set_default_configuration

`endif // TEST_WISHBONE_UVC_EXAMPLE_BLOCK_TRANS_SV
