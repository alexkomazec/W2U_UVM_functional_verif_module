//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_tb_top.sv
// Developer  : Aleksandar Komazec
// Date       : 11.9.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TB_TOP_SV
`define UART_UVC_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module uart_uvc_tb_top;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // import test package
  import uart_uvc_test_pkg::*;

  // signals
  reg reset;
  reg clock;

  // UVC interface instance
  uart_uvc_if uart_uvc_if_inst(clock, reset);

 // configure UVC's virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual uart_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent", "m_vif", uart_uvc_if_inst);
    uvm_config_db#(virtual uart_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_uart_uvc_top_env.m_uart_uvc_env.m_rx_agent", "m_vif", uart_uvc_if_inst);
  end

  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    reset <= 1'b1;
    clock <= 1'b0;
    #501 reset <= 1'b0;
  end

  // generate clock
  always begin : clock_gen_block
    #2170ns clock <= ~clock;
  end

  // run test
  initial begin : run_test_block
    run_test();
  end

endmodule : uart_uvc_tb_top

`endif // UART_UVC_TB_TOP_SV
