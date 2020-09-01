//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_tx_seq.sv
// Developer  : Aleksandar Komazec
// Date       : 19.09.2019
// Description: Re-arranged
// Notes      :
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_TX_SEQ_SV
`define UART_UVC_TX_SEQ_SV

class uart_uvc_tx_seq extends uvm_sequence #(uart_uvc_item);

  // sequencer pointer macro
  `uvm_declare_p_sequencer(uart_uvc_sequencer)

  // fields
  rand bit [8:0]      m_data;
  rand parity_valid_e m_parity_valid;

   // registration macro
  `uvm_object_utils(uart_uvc_tx_seq)


  // constraints
  constraint m_data_c{
     m_data < 255 ;
  }

  constraint m_parity_valid_c{
    soft m_parity_valid == GOOD_PARITY_E;
  }

  // constructor
  extern function new(string name = "uart_uvc_tx_seq");
  // body task
  extern virtual task body();

endclass : uart_uvc_tx_seq

// constructor
function uart_uvc_tx_seq::new(string name = "uart_uvc_tx_seq");
  super.new(name);
endfunction : new

// body task
task uart_uvc_tx_seq::body();

  req = uart_uvc_item::type_id::create("req");
  start_item(req);
  if(!req.randomize() with {
    m_data         == local::m_data;
    m_parity_valid == local::m_parity_valid;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end

  finish_item(req);

endtask : body

`endif // UART_UVC_TX_SEQ_SV
