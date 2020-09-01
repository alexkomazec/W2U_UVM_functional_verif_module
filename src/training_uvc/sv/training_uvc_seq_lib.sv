//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_seq_lib.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_SEQ_LIB_SV
`define TRAINING_UVC_SEQ_LIB_SV

class training_uvc_seq extends uvm_sequence #(training_uvc_item);
  
  // registration macro
  `uvm_object_utils(training_uvc_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(training_uvc_sequencer)
  
  // fields
  // TODO TODO TODO
  
  // constraints
  // TODO TODO TODO
  
  // constructor
  extern function new(string name = "training_uvc_seq");
  // body task
  extern virtual task body();

endclass : training_uvc_seq

// constructor
function training_uvc_seq::new(string name = "training_uvc_seq");
  super.new(name);
endfunction : new

// body task
task training_uvc_seq::body();
  req = training_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
  // TODO TODO TODO
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);

endtask : body

`endif // TRAINING_UVC_SEQ_LIB_SV
