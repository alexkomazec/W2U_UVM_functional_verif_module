//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_item.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_ITEM_SV
`define TRAINING_UVC_ITEM_SV

class training_uvc_item extends uvm_sequence_item;
  
  // item fields
  rand int dummy;   // TODO: declare needed fields instead of dummy one 
  
  // registration macro
  // TODO: register needed fields instead of dummy one
  `uvm_object_utils_begin(training_uvc_item)
    `uvm_field_int(dummy, UVM_DEFAULT)
  `uvm_object_utils_end
  
  // constraints
  // TODO TODO TODO

  // constructor  
  extern function new(string name = "training_uvc_item");
  
endclass : training_uvc_item

// constructor
function training_uvc_item::new(string name = "training_uvc_item");
  super.new(name);
endfunction : new

`endif // TRAINING_UVC_ITEM_SV
