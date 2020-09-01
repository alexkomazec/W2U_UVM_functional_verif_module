//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_scoreboard.sv
// Developer  : Elsys EE
// Date       : 23.09.2019
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_SCOREBOARD_SV
`define WB2UART_SCOREBOARD_SV

`uvm_analysis_imp_decl(_wishbone)
`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_rx)

class wb2uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(wb2uart_scoreboard)
  //Queues
  bit [7 : 0] m_wb_que[$];
  bit [7 : 0] m_uart_que[$];
  bit [7 : 0] buffer;

  //iterators
  int i;
  int is_data_ready = 0;
  // m_wb_que will be filled when is_data_ready is 1 or higher.
  // Before that wishbone transactions are related to configuring DUT

  //Items
  wishbone_uvc_item m_wishbone_item;
  wishbone_uvc_item m_trans_cloned;
  uart_uvc_item     m_uart_item;

  //Configuration
  uart_uvc_cfg m_cfg;

  //Events
  event m_get_uart_item_event;

  // This TLM port is used to connect the scoreboard to the monitor
  uvm_analysis_imp_wishbone#(wishbone_uvc_item, wb2uart_scoreboard) m_wishbone_aimp;
  uvm_analysis_imp_tx#(uart_uvc_item, wb2uart_scoreboard) m_tx_aimp;
  uvm_analysis_imp_rx#(uart_uvc_item, wb2uart_scoreboard) m_rx_aimp;

  function new(string name = "wb2uart_scoreboard", uvm_component parent = null);
    super.new(name,parent);
    `uvm_info(get_type_name(), "m_wb2uart_scoreboard has been created", UVM_HIGH)
    m_wishbone_aimp = new("m_wishbone_aimp", this);
    m_tx_aimp  = new("m_tx_aimp", this);
    m_rx_aimp  = new("m_rx_aimp", this);
  endfunction : new

  task run_phase(uvm_phase phase);
    begin
      forever begin
        @(m_get_uart_item_event);
        asrt_m_wb_que_not_empty : assert (m_wb_que.size())
        else `uvm_fatal(get_type_name(), "No more data in the queue to compare");
              buffer = m_wb_que.pop_front();
              if(buffer == m_uart_item.m_data) begin
                `uvm_info(get_type_name(), "Bits are the same", UVM_HIGH)
              end else begin
                  $display("wishbone data is %d\n uart data is %d\n",buffer,m_uart_item.m_data);
                  `uvm_fatal(get_type_name(), "Wishbone data from queue is not the same as uart data");
                end
              end
      end
  endtask

  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  // get configuration
  if(!uvm_config_db #(uart_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  endfunction : build_phase

  function write_wishbone (wishbone_uvc_item tr);
//     $cast(m_trans_cloned, tr.clone());
//       foreach(m_trans_cloned.dat[i]) begin
//         if(m_trans_cloned.cmd[i] == WRITE_E) begin
//           if(m_trans_cloned.sel[i] == 1 && m_trans_cloned.addr[i] == 0) begin //Trans or rec register
//             if(1<=is_data_ready) begin
//               m_wb_que.push_back(m_trans_cloned.dat[i]);
//             end
//               is_data_ready++;
//           end
//         end
// 
//         if(m_trans_cloned.cmd[i] == READ_E) begin
//           buffer = m_uart_que.pop_front();
//           if(buffer == m_trans_cloned.dat[i]) begin
//             `uvm_info(get_type_name(), "Bits are the same", UVM_HIGH)
//           end else begin
//             $display("uart data is %d\n wishbone data is %d\n",buffer,m_trans_cloned.dat[i]);
//             `uvm_fatal(get_type_name(), "Wishbone data from queue is not the same as uart data");
//           end
//         end
//       end
  endfunction : write_wishbone

  function write_tx (uart_uvc_item tr);
//     $cast(m_uart_item, tr.clone());
//     `uvm_info(get_type_name(), $sformatf("Tx monitor data has been collected",), UVM_HIGH);
//     m_uart_que.push_back(m_uart_item.m_data);
//     $display("m_uart_item is %d",m_uart_item.m_data);
  endfunction : write_tx

  function write_rx (uart_uvc_item tr);
//     $cast(m_uart_item, tr.clone());
//     `uvm_info(get_type_name(), $sformatf("Item Received: \n%s", tr.sprint()), UVM_HIGH)
//     ->m_get_uart_item_event;
  endfunction : write_rx

  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("scoreboard examined: transactions",), UVM_LOW);
  endfunction : report_phase

endclass : wb2uart_scoreboard



`endif // WB2UART_SCOREBOARD_SV