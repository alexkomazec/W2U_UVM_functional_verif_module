//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_training_uvc_example.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_TRAINING_UVC_EXAMPLE_SV
`define TEST_TRAINING_UVC_EXAMPLE_SV

// example test
class test_training_uvc_example extends test_training_uvc_base;
  
  // registration macro
  `uvm_component_utils(test_training_uvc_example)
  
  // fields
  int num_of_trans = 10;

  // sequences
  training_uvc_seq m_seq;

  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();
  
endclass : test_training_uvc_example

// constructor
function test_training_uvc_example::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// run phase
task test_training_uvc_example::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  uvm_test_done.raise_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST STARTED", UVM_LOW)

  m_seq = training_uvc_seq::type_id::create("m_seq", this);

  for (int i=0; i<num_of_trans; i++) begin
    if(!m_seq.randomize()) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_seq.start(m_training_uvc_env_top.m_training_uvc_env.m_agent.m_sequencer);
  end
      
  uvm_test_done.drop_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST FINISHED", UVM_LOW)
endtask : run_phase

// set default configuration
function void test_training_uvc_example::set_default_configuration();
  super.set_default_configuration();
  
  // redefine configuration
  // TODO TODO TODO ???
endfunction : set_configuration

`endif // TEST_TRAINING_UVC_EXAMPLE_SV
