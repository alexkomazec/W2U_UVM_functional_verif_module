//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_sequencer.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_SEQUENCER_SV
`define TRAINING_UVC_SEQUENCER_SV

class training_uvc_sequencer extends uvm_sequencer #(training_uvc_item);
  
  // registration macro
  `uvm_component_utils(training_uvc_sequencer)
    
  // configuration reference
  training_uvc_agent_cfg m_cfg;
  
  // constructor    
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : training_uvc_sequencer

// constructor
function training_uvc_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void training_uvc_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

`endif // TRAINING_UVC_SEQUENCER_SV
