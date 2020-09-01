//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_monitor.sv
// Developer  : Aleksandar Komazec
// Date       : 10.9.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_MONITOR_SV
`define UART_UVC_MONITOR_SV

class uart_uvc_monitor extends uvm_monitor;
  // fields
  bit m_parity_by_func;
  int k=1;
  // registration macro
  `uvm_component_utils(uart_uvc_monitor)

  // analysis port
  uvm_analysis_port #(uart_uvc_item) m_aport;

  // virtual interface reference
  virtual interface uart_uvc_if m_vif;

  // configuration reference
  uart_uvc_agent_cfg m_cfg;

  // monitor item
  uart_uvc_item m_item;
  uart_uvc_item trans_clone;

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
  extern virtual function void print_item(uart_uvc_item item);

  // coverage groups
   covergroup uart_tr_protocol_cg;
    option.per_instance = 1;

    cp_data_cov : coverpoint m_item.m_data
    {
      bins LOW    =   {[0:85]};
      bins MEDIUM =   {[86:170]};
      bins HIGH   =   {[171:255]};
    }

    cp_parity_valid_cov : coverpoint m_item.m_parity_valid
    {
      bins BAD_PARITY   =   {0};
      bins GOOD_PARITY  =   {1};
    }

    cp_parity_cov : coverpoint m_item.m_parity
    {
      bins LOW  =   {0};
      bins HIGH =   {1};
    }

    cp_number_of_data_bits  : coverpoint m_cfg.m_number_of_data_bits
    {
      bins FIVE  = {5};
      bins SIX   = {6};
      bins SEVEN = {7};
      bins EIGHT = {8};
    }

    cp_number_of_stop_bits  : coverpoint m_cfg.m_number_of_stop_bits
    {
      bins ONE          = {0};
      bins ONE_AND_HALF = {1};
      bins TWO          = {2};
    }

    cp_parity_enable  : coverpoint m_cfg.m_parity_enable
    {
      bins NO_PARITY  = {0};
      bins PARITY     = {1};
    }

    cp_parity_type  : coverpoint m_cfg.m_parity_type
    {
      bins EVEN     = {0};
      bins ODD      = {1};
    }

    cp_baud_rate  : coverpoint m_cfg.m_baud_rate
    {
      bins BAUD_RATE_1200   = {96};
      bins BAUD_RATE_2400   = {49};
      bins BAUD_RATE_4800   = {24};
      bins BAUD_RATE_9600   = {12};
      bins BAUD_RATE_19200  = {6};
      bins BAUD_RATE_38400  = {3};
      bins BAUD_RATE_57600  = {2};
      bins BAUD_RATE_115200 = {1};
    }

  endgroup : uart_tr_protocol_cg

endclass : uart_uvc_monitor

// constructor
function uart_uvc_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  uart_tr_protocol_cg = new();
endfunction : new

// build phase
function void uart_uvc_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create port
  m_aport = new("m_aport", this);

  // create item
  m_item = uart_uvc_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task uart_uvc_monitor::run_phase(uvm_phase phase);
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
task uart_uvc_monitor::handle_reset();
  // wait reset assertion
  @(m_vif.reset iff m_vif.reset == 1);
  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)
endtask : handle_reset

// collect item
task uart_uvc_monitor::collect_item();  
  // wait until reset is de-asserted
  wait (m_vif.reset == 0);

  forever begin
    if (m_vif.txrx !== 0) begin
      @(posedge m_vif.clock iff m_vif.txrx === 0);
    end
      repeat(2*m_cfg.m_baud_rate) begin
        @(posedge m_vif.clock);
      end
    for(int i = 0; i < m_cfg.m_number_of_data_bits;  i++) begin
      m_item.m_data[i] <= m_vif.txrx;
      repeat(2*m_cfg.m_baud_rate) begin
        @(posedge m_vif.clock);
      end
    end
    m_parity_by_func  = calc_parity(m_cfg.m_number_of_data_bits,m_item.m_data,m_cfg.m_parity_type);
    if(m_cfg.m_parity_enable == PARITY_E) begin
      if(m_parity_by_func == m_vif.txrx) begin
        m_item.m_parity_valid = GOOD_PARITY_E;
      end else begin
        m_item.m_parity_valid = BAD_PARITY_E;
      end
      m_item.m_parity <= m_vif.txrx;
      repeat(2*m_cfg.m_baud_rate) begin
        @(posedge m_vif.clock);
      end
    end

  case(m_cfg.m_number_of_stop_bits)
    ONE_E:         begin
                    repeat(2*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end
    ONE_AND_HALF_E:begin
                    repeat(3*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end
    TWO_E:         begin
                    repeat(4*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end
    default:      `uvm_info(get_type_name(), "WRONG TYPE", UVM_HIGH)
  endcase

   //cast trans_clone as m_item
  if(!$cast(trans_clone, m_item.clone())) begin
    `uvm_info(get_type_name(), "cast was failed", UVM_HIGH)
  end

  //print item
  print_item(trans_clone);

  // write analysis port
  m_aport.write(trans_clone);

  //sample coverage 
  uart_tr_protocol_cg.sample();
  end
endtask : collect_item

// print item
function void uart_uvc_monitor::print_item(uart_uvc_item item);
  `uvm_info(get_type_name(), $sformatf("Item collected: \n%s", item.sprint()), UVM_HIGH)
  $display("k is %d",k);
  k++;
endfunction : print_item

`endif // UART_UVC_MONITOR_SV
