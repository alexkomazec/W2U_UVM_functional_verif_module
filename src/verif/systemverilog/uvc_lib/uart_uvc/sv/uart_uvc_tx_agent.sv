//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_tx_agent.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TX_AGENT_SV
`define UART_UVC_TX_AGENT_SV

class uart_uvc_tx_agent extends uvm_agent;

  // registration macro
  `uvm_component_utils(uart_uvc_tx_agent)

  // analysis port
  uvm_analysis_port #(uart_uvc_item) m_aport;

  // virtual interface reference
  virtual interface uart_uvc_if m_vif;

  // configuration reference
  uart_uvc_agent_cfg m_cfg;

  // components instances
  uart_uvc_tx_driver m_driver;
  uart_uvc_sequencer m_sequencer;
  uart_uvc_monitor m_monitor;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // connect phase
  extern virtual function void connect_phase(uvm_phase phase);
  // print configuration
  extern virtual function void print_cfg();

endclass : uart_uvc_tx_agent

// constructor
function uart_uvc_tx_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void uart_uvc_tx_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create ports
  m_aport = new("m_aport", this);

  // get interface
  if(!uvm_config_db#(virtual uart_uvc_if)::get(this, "", "m_vif", m_vif)) begin
    `uvm_fatal(get_type_name(), "Failed to get virtual interface from config DB!")
  end

  // get configuration
  if(!uvm_config_db #(uart_uvc_agent_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end else begin
    print_cfg();
  end

  // create components
  if (m_cfg.m_is_active == UVM_ACTIVE) begin
    m_driver = uart_uvc_tx_driver::type_id::create("m_driver", this);
    m_sequencer = uart_uvc_sequencer::type_id::create("m_sequencer", this);
  end
  m_monitor = uart_uvc_monitor::type_id::create("m_monitor", this);

endfunction : build_phase

// connect phase
function void uart_uvc_tx_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  // connect ports
  if (m_cfg.m_is_active == UVM_ACTIVE) begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  end
  m_monitor.m_aport.connect(m_aport);

  // assign interface
  if (m_cfg.m_is_active == UVM_ACTIVE) begin
    m_driver.m_vif = m_vif;
  end
  m_monitor.m_vif = m_vif;
  // assign configuration
  if (m_cfg.m_is_active == UVM_ACTIVE) begin
    m_driver.m_cfg = m_cfg;
    m_sequencer.m_cfg = m_cfg;
  end
  m_monitor.m_cfg = m_cfg;
endfunction : connect_phase

// print configuration
function void uart_uvc_tx_agent::print_cfg();
  `uvm_info(get_type_name(), $sformatf("Configuration: \n%s", m_cfg.sprint()), UVM_HIGH)
endfunction : print_cfg

`endif // UART_UVC_TX_AGENT_SV
