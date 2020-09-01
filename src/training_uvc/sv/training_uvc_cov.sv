//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_cov.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_COV_SV
`define TRAINING_UVC_COV_SV

class training_uvc_cov extends uvm_subscriber #(training_uvc_item);
  
  // registration macro
  `uvm_component_utils(training_uvc_cov)
  
  // configuration reference
  training_uvc_agent_cfg m_cfg;
  
  // coverage fields 
  // TODO TODO TODO
  
  // coverage groups
  // TODO TODO TODO
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(training_uvc_item t);

endclass : training_uvc_cov

// constructor
function training_uvc_cov::new(string name, uvm_component parent);
  super.new(name, parent);
	// TODO TODO TODO
endfunction : new

// analysis implementation port function
function void training_uvc_cov::write(training_uvc_item t);
	// TODO TODO TODO
endfunction : write

`endif // TRAINING_UVC_COV_SV
