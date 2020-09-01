//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_seq_fifo_wr_rd.sv.sv
// Developer  : Aleksandar Komazec
// Date       : 23.09.2019
// Description:
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQ_FIFO_WR_RD_SV
`define WB2UART_VIRTUAL_SEQ_FIFO_WR_RD_SV

class wb2uart_virtual_seq_fifo_wr_rd extends wb2uart_virtual_sequence_base;
  `uvm_object_utils (wb2uart_virtual_seq_fifo_wr_rd)
  `uvm_declare_p_sequencer(wb2uart_virtual_sequencer);

  function new (string name = "wb2uart_virtual_seq_fifo_wr_rd");
    super.new (name);
  endfunction

  // sequences
  wishbone_uvc_seq_master   m_wb_seq;
  uart_uvc_tx_seq           m_uart_seq;
  int value = 16;

  // virtual sequences
  wb2uart_virtual_seq_dut_config m_vseq;

  task body();
    super.body();
    m_vseq = wb2uart_virtual_seq_dut_config::type_id::create( .name("m_vseq"), .contxt( get_full_name()));
    m_vseq.m_number_of_data_bits = p_sequencer.m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_data_bits;
    m_vseq.m_number_of_stop_bits = p_sequencer.m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_number_of_stop_bits;
    m_vseq.m_parity_enable       = p_sequencer.m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_enable;
    m_vseq.m_parity_type         = p_sequencer.m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_parity_type;
    m_vseq.m_baud_rate           = p_sequencer.m_cfg.m_uart_uvc_cfg.m_tx_agent_cfg.m_baud_rate;
    m_vseq.start(p_sequencer);

    //------------------------------------------------------------------------------------------------------------------//
    //------------------------------Write 16 transactions into Transmitter Holding Register-----------------------------//
    //------------------------------------------------------------------------------------------------------------------//
    `uvm_info(get_type_name(), "Write 16 transactions into Transmitter Holding Register", UVM_HIGH)
    m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

    if(!m_wb_seq.randomize() with{
      mode_cycle         == STANDARD_BLOCK_E;
      num_phase_in_block == 16;

      foreach(stb_delay[i]){
        stb_delay[i]     == 0;
      }

      //Write to Transmiter Holding Regster
      foreach(stb_delay[j]){
        sel[j]     == 4'b0001;//0  sel = 1
      }

      foreach(stb_delay[k]){
        addr[k]    == 8'b00000000;
      }


      foreach(cmd[s]){
        cmd[s]          == WRITE_E;
      }

        }) begin
          `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_wb_seq.start (p_sequencer.m_wishbone_seqr);

    #10.071ms;
    //------------------------------------------------------------------------------------------------------------------//
    //------------------------------Write 16 transactions into Receiver Holding Register--------------------------------//
    //------------------------------------------------------------------------------------------------------------------//
    `uvm_info(get_type_name(), "Write 16 transactions into Receiver Holding Register", UVM_HIGH)
    for(int i=0;i<16;i++) begin

      m_uart_seq = uart_uvc_tx_seq::type_id::create ("m_uart_seq");

      if(!m_uart_seq.randomize() with{ m_data == value-i;}) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
      end
      m_uart_seq.start (p_sequencer.m_uart_seqr);
    end


    //-----------------------------------------------------------------------------------------------------------------//
    //------------------------------Read 16 transactions from Receiver Holding Register--------------------------------//
    //-----------------------------------------------------------------------------------------------------------------//

    `uvm_info(get_type_name(), "Read 16 transactions from Receiver Holding Register", UVM_HIGH)

    m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

    if(!m_wb_seq.randomize() with{
      mode_cycle         == STANDARD_BLOCK_E;
      num_phase_in_block == 16;

      foreach(stb_delay[i]){
        stb_delay[i]     == 0;
      }

      //Write to Transmiter Holding Regster
      foreach(stb_delay[j]){
        sel[j]     == 4'b0001;//0  sel = 1
      }

      foreach(stb_delay[k]){
        addr[k]    == 8'b00000000;
      }


      foreach(cmd[s]){
        cmd[s]          == READ_E;
      }

        }) begin
          `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  #10.071ms;
  endtask:body

endclass

`endif // WB2UART_VIRTUAL_SEQ_REGISTER_ACCESS_SV