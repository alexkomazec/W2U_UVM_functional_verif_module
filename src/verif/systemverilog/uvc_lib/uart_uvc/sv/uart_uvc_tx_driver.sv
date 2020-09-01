//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_driver.sv
// Developer  : Aleksandar Komazec
// Date       :
// Description:
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TX_DRIVER_SV
`define UART_UVC_TX_DRIVER_SV

class uart_uvc_tx_driver extends uvm_driver #(uart_uvc_item);

  // registration macro
  `uvm_component_utils(uart_uvc_tx_driver)

  // virtual interface reference
  virtual interface uart_uvc_if m_vif;
  // configuration reference
  uart_uvc_agent_cfg m_cfg;

  // handle reset
  extern virtual task handle_reset();

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // process item
  extern virtual task process_item(uart_uvc_item item);

endclass : uart_uvc_tx_driver

// constructor
function uart_uvc_tx_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void uart_uvc_tx_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task uart_uvc_tx_driver::handle_reset();

    wait (m_vif.reset === 1);
    m_vif.txrx  = 1;
  `uvm_info(get_type_name(), "Handle_reset.", UVM_FULL)
endtask : handle_reset

// run phase
task uart_uvc_tx_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.txrx      <= 1;
  forever begin
    wait (m_vif.reset === 0);
    fork : run_phase_fork_block
      begin
        handle_reset();
      end
      begin
        seq_item_port.get_next_item(req);
        process_item(req);
        seq_item_port.item_done();
      end
    join_any 
    disable fork;
  end
endtask : run_phase

// process item
task uart_uvc_tx_driver::process_item(uart_uvc_item item);
  // print item
  `uvm_info(get_type_name(), $sformatf("\n%s", item.sprint()), UVM_HIGH)

   // drive signals
  @(posedge m_vif.clock);
  m_vif.txrx <= 0;
  repeat(2*m_cfg.m_baud_rate) begin
    @(posedge m_vif.clock);
  end

  for(int i = 0; i < m_cfg.m_number_of_data_bits;  i++) begin
    m_vif.txrx <= req.m_data[i];
    repeat(2*m_cfg.m_baud_rate) begin
      @(posedge m_vif.clock);
    end
  end

  if(m_cfg.m_parity_enable == PARITY_E) begin
    req.m_parity  = calc_parity(m_cfg.m_number_of_data_bits,req.m_data,m_cfg.m_parity_type);
  if(req.m_parity_valid == 0) begin
    req.m_parity = ~req.m_parity;
  end
      m_vif.txrx <= req.m_parity;
    repeat(2*m_cfg.m_baud_rate) begin
      @(posedge m_vif.clock);
    end
  end

  case(m_cfg.m_number_of_stop_bits)
    ONE_E:         begin
                    m_vif.txrx  <=  1;
                    repeat(2*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end

    ONE_AND_HALF_E:begin
                    m_vif.txrx  <=  1;
                    repeat(3*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end

    TWO_E:         begin
                    m_vif.txrx  <=  1;
                    repeat(4*m_cfg.m_baud_rate) begin
                      @(posedge m_vif.clock);
                    end
                  end
    default:       `uvm_info(get_type_name(), "WRONG TYPE", UVM_HIGH)
  endcase

endtask : process_item

`endif // UART_UVC_TX_DRIVER_SV
