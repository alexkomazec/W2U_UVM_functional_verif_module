//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : training_uvc_tb_top.sv
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_TB_TOP_SV
`define TRAINING_UVC_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module training_uvc_tb_top;
  
  `include "uvm_macros.svh"  
  import uvm_pkg::*;
  
  // import test package
  import training_uvc_test_pkg::*;
      
  // signals
  reg         PRESETn_tb;
  reg         PCLK_tb;
  reg  [31:0] PADDR_tb;
  reg         PWRITE_tb;
  reg  [31:0] PWDATA_tb;
  wire [31:0] PRDATA_tb;
  wire        PREADY_tb;
  
  // UVC interface instance
  training_uvc_if training_uvc_if_inst(PCLK_tb, PRESETn_tb);

  assign PADDR_tb                    = training_uvc_if_inst.PADDR;
  assign PWRITE_tb                   = training_uvc_if_inst.PWRITE;
  assign PWDATA_tb                   = training_uvc_if_inst.PWDATA;
  assign training_uvc_if_inst.PREADY = PREADY_tb;
  assign training_uvc_if_inst.PRDATA = PRDATA_tb;

  // DUT instance
  dut_dummy dut (
    .PRESETn (PRESETn_tb),
    .PCLK    (PCLK_tb),
    .PADDR   (PADDR_tb),
    .PWRITE  (PWRITE_tb),
    .PWDATA  (PWDATA_tb),
    .PRDATA  (PRDATA_tb),
    .PREADY  (PREADY_tb)
  );
  
  // configure virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual training_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_training_uvc_env_top.m_training_uvc_env.m_agent", "m_vif", training_uvc_if_inst);
  end
    
  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    PRESETn_tb <= 1'b0;
    PCLK_tb <= 1'b1;
    #501 PRESETn_tb <= 1'b1;
  end
  
  // generate clock
  always begin : clock_gen_block
    #50 PCLK_tb <= ~PCLK_tb;
  end
  
  // run test
  initial begin : run_test_block
    run_test();
  end
  
endmodule : training_uvc_tb_top

`endif // TRAINING_UVC_TB_TOP_SV
