//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_uart_uvc_base.sv
// Developer  : Aleksandar Komazec
// Date       : 11.09.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef TEST_UART_UVC_BASE_SV
`define TEST_UART_UVC_BASE_SV

class test_uart_uvc_base extends uvm_test;

  // registration macro
  `uvm_component_utils(test_uart_uvc_base)

  // component instance
  uart_uvc_top_env m_uart_uvc_top_env;

  // configuration instance
  uart_uvc_top_cfg m_cfg;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // end_of_elaboration phase
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // set default configuration
  extern virtual function void set_default_configuration();

endclass : test_uart_uvc_base 

// constructor
function test_uart_uvc_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void test_uart_uvc_base::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create component
  m_uart_uvc_top_env = uart_uvc_top_env::type_id::create("m_uart_uvc_top_env", this);

  // create and set configuration
  m_cfg = uart_uvc_top_cfg::type_id::create("m_cfg", this);
  set_default_configuration();

  // set configuration in DB
  uvm_config_db#(uart_uvc_top_cfg)::set(this, "m_uart_uvc_top_env", "m_cfg", m_cfg);

  // enable monitor item recording
  set_config_int("*", "recording_detail", 1);

  // define verbosity
  uvm_top.set_report_verbosity_level_hier(UVM_HIGH);
endfunction : build_phase

// end_of_elaboration phase
function void test_uart_uvc_base::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // allow additional time before stopping
  uvm_test_done.set_drain_time(this, 10us);
endfunction : end_of_elaboration_phase

// set default configuration
function void test_uart_uvc_base::set_default_configuration();
  // define default configuration
  // configuration for tx agent
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_is_active     = UVM_ACTIVE;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_has_checks    = 1;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_has_coverage  = 1;

  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;


  // configuration for rx agent
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_has_checks    = 1;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_has_coverage  = 1;

  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;

endfunction : set_default_configuration

`endif // TEST_UART_UVC_BASE_SV
