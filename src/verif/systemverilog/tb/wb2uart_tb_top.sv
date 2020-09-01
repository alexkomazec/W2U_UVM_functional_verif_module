//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_tb_top.sv
// Developer  : Aleksandar Komazec
// Date       : 
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_TB_TOP_SV
`define WB2UART_TB_TOP_SV

// define timescale
`timescale 1ns/10ps

module wb2uart_tb_top;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // import test package
  import wb2uart_test_pkg::*;

  // Wishbone signals
  reg  [4:0]  wb_addr_tb;
  reg  [31:0] wb_data_m2s_tb;
  reg  [3:0]  wb_sel_tb;
  reg         wb_we_tb;
  reg         wb_stb_tb;
  reg         wb_cyc_tb;

  wire [31:0] wb_data_s2m_tb;
  wire        wb_ack_tb;

  // UART design internal signal
  reg         intterrupt_tb;
 //reg         baud_rate_tb;
  wire        stx_pad_o_tb;
  reg         srx_pad_o_tb;

  // signals
  reg rst_tb;
  reg clk_wb_tb;
  reg clk_uart_tb;

   // UART interface instance
  uart_uvc_if uart_interface_tx_inst(clk_uart_tb, rst_tb);
  uart_uvc_if uart_interface_rx_inst(clk_uart_tb, rst_tb);

  // WISHBONE interface instance
  wishbone_uvc_if wishbone_uvc_if_inst(clk_wb_tb, rst_tb);

  assign wb_addr_tb                        = wishbone_uvc_if_inst.addr;
  assign wb_data_m2s_tb                    = wishbone_uvc_if_inst.dat_m2s;
  assign wb_sel_tb                         = wishbone_uvc_if_inst.sel;
  assign wb_we_tb                          = wishbone_uvc_if_inst.we;
  assign wb_stb_tb                         = wishbone_uvc_if_inst.stb;
  assign wb_cyc_tb                         = wishbone_uvc_if_inst.cyc;

  assign wishbone_uvc_if_inst.dat_s2m      = wb_data_s2m_tb;
  assign wishbone_uvc_if_inst.ack          = wb_ack_tb;

  assign srx_pad_o_tb                      = uart_interface_tx_inst.txrx;
  assign uart_interface_rx_inst.txrx       = stx_pad_o_tb;

 //assign dut.int_o                         = intterrupt_tb; 4.58 
 // assign dut.baud_o                      = baud_rate_tb;

  // DUT instance
  uart_top dut (
    .wb_rst_i   (rst_tb),
    .wb_clk_i   (clk_wb_tb),
    .wb_adr_i   (wb_addr_tb),
    .wb_dat_i   (wb_data_m2s_tb),
    .wb_sel_i   (wb_sel_tb),
    .wb_we_i    (wb_we_tb),
    .wb_stb_i   (wb_stb_tb),
    .wb_cyc_i   (wb_cyc_tb),
    .wb_dat_o   (wb_data_s2m_tb),
    .wb_ack_o   (wb_ack_tb),

    .int_o      (intterrupt_tb),
    //.baud_o     (baud_rate_tb),

    .stx_pad_o  (stx_pad_o_tb),
    .srx_pad_i  (srx_pad_o_tb)
  );

 // configure UVC's virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual uart_uvc_if)::set(uvm_root::get(),     "uvm_test_top.m_wb2uart_env_top.m_uart_uvc_env.m_tx_agent", "m_vif",  uart_interface_tx_inst);
    uvm_config_db#(virtual uart_uvc_if)::set(uvm_root::get(),     "uvm_test_top.m_wb2uart_env_top.m_uart_uvc_env.m_rx_agent", "m_vif",  uart_interface_rx_inst);
    uvm_config_db#(virtual wishbone_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_wb2uart_env_top.m_wishbone_uvc_env.m_agent","m_vif", wishbone_uvc_if_inst);
  end

  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    rst_tb <= 1'b1;
    clk_wb_tb <= 1'b0;
    clk_uart_tb <= 1'b0;
    #501 rst_tb <= 1'b0;
  end

  // generate clock
  always begin : clock_uart_gen_block
    #2170ns clk_uart_tb <= ~clk_uart_tb;
  end

  // generate clock
  always begin : clock_wb_gen_block
    #135.5ns clk_wb_tb <= ~clk_wb_tb;
  end
  
  // timeformat
  initial begin : time_format_blovk
    $timeformat(-9,0,"ns",1);
  end
  
  // run test
  initial begin : run_test_block
    run_test();
  end

endmodule : wb2uart_tb_top

`endif // WB2UART_TB_TOP_SV
