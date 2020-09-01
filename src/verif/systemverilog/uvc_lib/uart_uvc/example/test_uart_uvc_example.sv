//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_uart_uvc_example.sv
// Developer  : Aleksandar Komazec
// Date       : 11.9.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef TEST_UART_UVC_EXAMPLE_SV
`define TEST_UART_UVC_EXAMPLE_SV

// example test
class test_uart_uvc_example extends test_uart_uvc_base;
  // fields
  int num_of_trans = 3;
  bit [8:0]      m_data;
  parity_valid_e m_parity_valid;

  // registration macro
  `uvm_component_utils(test_uart_uvc_example)

  // sequences
  uart_uvc_tx_seq m_tx_seq;

  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();

endclass : test_uart_uvc_example

// constructor
function test_uart_uvc_example::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// run phase
task test_uart_uvc_example::run_phase(uvm_phase phase);
  super.run_phase(phase);

  uvm_test_done.raise_objection(this, get_type_name());

  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_1200_E;

  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_1200_E;

  `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)

  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == GOOD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end

  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SIX_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SIX_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_2400_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_2400_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = NO_PARITY_E;

 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
 
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == BAD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
 
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SEVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SEVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = EVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_4800_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_4800_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == BAD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end

  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_9600_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_9600_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)

  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == GOOD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end

  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_19200_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_19200_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
 
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_data == o;
      m_parity_valid == BAD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
 
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SIX_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SIX_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_38400_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_38400_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == GOOD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
  
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = SEVEN_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = SEVEN_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == BAD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
  
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = EIGHT_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_57600_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = ONE_AND_HALF_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = NO_PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == GOOD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
 
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_data_bits = FIVE_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_type         = ODD_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_baud_rate           = BAUD_RATE_115200_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_number_of_stop_bits = TWO_E;
  m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable       = PARITY_E;
  m_cfg.m_uart_uvc_cfg.m_rx_agent_cfg.m_parity_enable       = PARITY_E;
  
 `uvm_info(get_type_name(), $sformatf("Config from test: \n%s", m_cfg.sprint()), UVM_HIGH)
  
  for (int o  = 0;  o  < num_of_trans; o++) begin
    m_tx_seq = uart_uvc_tx_seq::type_id::create("m_tx_seq", this);
    if(!m_tx_seq.randomize() with {
      m_parity_valid == BAD_PARITY_E;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_tx_seq.start(m_uart_uvc_top_env.m_uart_uvc_env.m_tx_agent.m_sequencer);
  end
  
  uvm_test_done.drop_objection(this, get_type_name());
endtask : run_phase

// set default configuration
function void test_uart_uvc_example::set_default_configuration();
  super.set_default_configuration();
  // redefine configuration

endfunction : set_default_configuration

`endif // TEST_UART_UVC_EXAMPLE_SV
