//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wishbone_uvc_cfg_top.sv
// Developer  : Elsys EE
// Date       : 12.9.2019
// Description: Re-arranged
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WISHBONE_UVC_CFG_TOP_SV
`define WISHBONE_UVC_CFG_TOP_SV

class wishbone_uvc_cfg_top extends uvm_object;
    
  // UVC configuration
  wishbone_uvc_cfg m_wishbone_uvc_cfg;
  
  // registration macro
  `uvm_object_utils_begin(wishbone_uvc_cfg_top)
    `uvm_field_object(m_wishbone_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
    
  // constructor
  extern function new(string name = "wishbone_uvc_cfg_top");
  
endclass : wishbone_uvc_cfg_top

// constructor
function wishbone_uvc_cfg_top::new(string name = "wishbone_uvc_cfg_top");
  super.new(name);
  
  // create UVC configuration
  m_wishbone_uvc_cfg = wishbone_uvc_cfg::type_id::create("m_wishbone_uvc_cfg");
endfunction : new

`endif // WISHBONE_UVC_CFG_TOP_SV
