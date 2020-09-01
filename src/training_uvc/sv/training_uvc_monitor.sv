//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_monitor.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_MONITOR_SV
`define TRAINING_UVC_MONITOR_SV

class training_uvc_monitor extends uvm_monitor;
  
  // registration macro
  `uvm_component_utils(training_uvc_monitor)
  
  // analysis port
  uvm_analysis_port #(training_uvc_item) m_aport;
  
  // virtual interface reference
  virtual interface training_uvc_if m_vif;
  
  // configuration reference
  training_uvc_agent_cfg m_cfg;
  
  // monitor item
  training_uvc_item m_item;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // handle reset
  extern virtual task handle_reset();
  // collect item
  extern virtual task collect_item();
  // print item
  extern virtual function void print_item(training_uvc_item item);

  // coverage fields 
  // TODO TODO TODO
  
  // coverage groups
  // TODO TODO TODO

endclass : training_uvc_monitor

// constructor
function training_uvc_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  // TODO TODO TODO create cover groups
endfunction : new

// build phase
function void training_uvc_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // create port
  m_aport = new("m_aport", this);
  
  // create item
  m_item = training_uvc_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task training_uvc_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin
    fork : run_phase_fork_block
      begin
        handle_reset();
      end
      begin
        collect_item();    
      end
    join_any // run_phase_fork_block
    disable fork;
  end
endtask : run_phase

// handle reset
task training_uvc_monitor::handle_reset();
  // wait reset assertion
  // TODO TODO TODO remove next line if necessary
  @(posedge m_vif.PRESETn);

  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)
endtask : handle_reset

// collect item
task training_uvc_monitor::collect_item();  
  // wait until reset is de-asserted
  // TODO TODO TODO
  `uvm_info(get_type_name(), "Reset de-asserted. Starting to collect items...", UVM_HIGH)
  
  forever begin    
    // wait signal change
    // TODO TODO TODO remove next line if necessary
    @(posedge m_vif.PCLK);
    
    // collect item
    // TODO TODO TODO
    
    // print item
    // TODO TODO TODO

    // sample coverage 
    // TODO TODO TODO
    
    // write analysis port
    m_aport.write(m_item);    
  end // forever begin  
endtask : collect_item

// print item
function void training_uvc_monitor::print_item(training_uvc_item item);
  `uvm_info(get_type_name(), $sformatf("Item collected: \n%s", item.sprint()), UVM_HIGH)
endfunction : print_item

`endif // TRAINING_UVC_MONITOR_SV
