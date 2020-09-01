//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_env_top.sv
// Developer  : Aleksandar Komazec
// Date       : 20.09.2019
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef WB2UART_ENV_TOP_SV
`define WB2UART_ENV_TOP_SV

class wb2uart_env_top extends uvm_env;

  // registration macro
  `uvm_component_utils(wb2uart_env_top)

  // configuration reference
  wb2uart_top_cfg m_cfg;

  // component instance
  uart_uvc_env              m_uart_uvc_env;
  wishbone_uvc_env          m_wishbone_uvc_env;
  wb2uart_scoreboard        m_scoreboard;
  wb2uart_virtual_sequencer m_virt_seqr;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // connect phase
  extern virtual function void connect_phase(uvm_phase phase);

endclass : wb2uart_env_top

// constructor
function wb2uart_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
  `uvm_info(get_type_name(), "m_wb2uart_env_top has been created", UVM_HIGH)
endfunction : new

// build phase
function void wb2uart_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);

   // get configuration
  if(!uvm_config_db #(wb2uart_top_cfg)::get(this, "","m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set uart configuration
  uvm_config_db#(uart_uvc_cfg)::set(this, "m_uart_uvc_env", "m_cfg", m_cfg.m_uart_uvc_cfg);

  // set scoreboard configuration
  uvm_config_db#(uart_uvc_cfg)::set(this, "m_scoreboard", "m_cfg", m_cfg.m_uart_uvc_cfg);

  // set wishbone configuration
  uvm_config_db#(wishbone_uvc_cfg)::set(this, "m_wishbone_uvc_env", "m_cfg", m_cfg.m_wishbone_uvc_cfg);

  // create component
  m_uart_uvc_env     = uart_uvc_env::type_id::create("m_uart_uvc_env", this);
  m_wishbone_uvc_env = wishbone_uvc_env::type_id::create("m_wishbone_uvc_env", this);
  m_virt_seqr        = wb2uart_virtual_sequencer::type_id::create("m_virt_seqr", this);
  m_scoreboard       = wb2uart_scoreboard::type_id::create("m_scoreboard", this);
endfunction : build_phase

// connect phase
function void wb2uart_env_top::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  m_virt_seqr.m_cfg             = m_cfg;
  m_virt_seqr.m_wishbone_seqr   = m_wishbone_uvc_env.m_agent.m_sequencer;
  m_virt_seqr.m_uart_seqr       = m_uart_uvc_env.m_tx_agent.m_sequencer;
  m_wishbone_uvc_env.m_agent.m_aport.connect(m_scoreboard.m_wishbone_aimp);
  m_uart_uvc_env.m_tx_agent.m_aport.connect(m_scoreboard.m_tx_aimp);
  m_uart_uvc_env.m_rx_agent.m_aport.connect(m_scoreboard.m_rx_aimp);

endfunction : connect_phase

`endif // WB2UART_ENV_TOP_SV
