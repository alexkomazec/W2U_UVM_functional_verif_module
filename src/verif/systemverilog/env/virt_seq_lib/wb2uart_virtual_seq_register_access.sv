//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_seq_register_access.sv
// Developer  : Aleksandar Komazec
// Date       : 23.09.2019
// Description:
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQ_REGISTER_ACCESS_SV
`define WB2UART_VIRTUAL_SEQ_REGISTER_ACCESS_SV

class wb2uart_virtual_seq_register_access extends wb2uart_virtual_sequence_base;
  `uvm_object_utils (wb2uart_virtual_seq_register_access)

  function new (string name = "wb2uart_virtual_seq_register_access");
    super.new (name);
  endfunction

  wishbone_uvc_seq_master   m_wb_seq;
  int j;

  task body();

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Receiver FIFO, Interrupt Enable Register-------------------------------//
  //------------------------------Interrupt Identification Register, Line Control Register ---------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 4;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Read from Receiver fifo
    sel[0]          == 4'b0001;//0  sel = 1
    //Read from Interrupt Enable Register
    sel[1]          == 4'b0010;//1  sel = 2
    //Read from Interrupt Identification Register
    sel[2]          == 4'b0100;//2  sel = 4
    //Read from Line Control Register
    sel[3]          == 4'b1000;//3  sel = 8

    //Read from Receiver fifo
    addr[0]          == 8'b00000000;
    //Read from Interrupt Enable Register
    addr[1]          == 8'b00000000;
    //Read from Interrupt Identification Register
    addr[2]          == 8'b00000000;
    //Read from Line Control Register
    addr[3]          == 8'b00000000;

    foreach(cmd[s]){
      cmd[s]          == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Receiver Line Status Register------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_SINGLE_E;
    num_phase_in_block == 1;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Read from Line Status Register
    foreach(sel[j]){
      sel[j]           == 4'b0010; //1 sel = 2
    }

    //Read from Line Status Register
    foreach(addr[k]){
      addr[k]          == 4;
    }

    foreach(cmd[s]){
      cmd[s ]          == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Writing to Transmitter FIFO, Interrupt Enable Register------------------------------//
  //------------------------------Fifo Control Register, Line Control Register ---------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 5;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Transmitter Fifo
    sel[0]          == 4'b0001;//0  sel = 1
    //Write to Interrupt Enable Register
    sel[1]          == 4'b0010;//1  sel = 2
    //Write to Fifo Control Register
    sel[2]          == 4'b0100;//2  sel = 4
    //Write to Line Control Register
    sel[3]          == 4'b1000;//3  sel = 8
    //Write to Line Status Register
    sel[4]          == 4'b0010; //1 sel = 2

    //Write to Transmitter Fifo
    addr[0]          == 8'b00000000;
    //Write to Interrupt Enable Register
    addr[1]          == 8'b00000000;
    //Write to Fifo Control Register
    addr[2]          == 8'b00000000;
    //Write to Line Control Register
    addr[3]          == 8'b00000000;
    //Write to Line Status Register
    addr[4]          == 8'b00000100;

    //Write to Transmitter Fifo
    dat[0]          == 32'h00000001;
    //Write to Interrupt Enable Register
    dat[1]          == 32'h00000100;
    //Write to Fifo Control Register
    dat[2]          == 32'h00C100000; //h C1
    //Write to Line Control Register
    dat[3]          == 32'h83000000; //h 83 Enable access to Divisor latches
    //Write to Line Status Register
    dat[4]          == 32'h00006100; 

    foreach(cmd[s]){
      cmd[s]          == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //-------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Divisor Latch Byte 1, Divisor Latch Byte 2------------------------------//
  //------------------------------Line Control Register----------------------------------------------------------------//
  //-------------------------------------------------------------------------------------------------------------------//

    m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 3;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

      //Read from Divisor Latch Byte 1
      sel[0]          == 4'b0001;//0  sel = 1
      //Read from Divisor Latch Byte 2
      sel[1]          == 4'b0010;//1  sel = 2
      //Read from Line Control Register
      sel[2]          == 4'b1000;//3  sel = 8

      //Read from Divisor Latch Byte 1
      addr[0]          == 8'b00000000;
      //Read from Divisor Latch Byte 2
      addr[1]          == 8'b00000000;
      //Read from Line Control Register
      addr[2]          == 8'b00000000;

    foreach(cmd[s]){
      cmd[s ]          == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Writing to Line Control Register----------------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_SINGLE_E;
    num_phase_in_block == 1;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Line Control Register
    foreach(sel[j]){
      sel[j]           == 4'b1000; //3  sel = 8
    }

    //Write to Line Control Register
    foreach(addr[k]){
      addr[k]          == 0;
    }

    //Write to Line Control Register
    foreach(dat[j]){
      dat[j]          == 32'h11000000; //Enable access to other registers (not divisor latches)
    }

    foreach(cmd[s]){
      cmd[s ]          == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Receiver FIFO, Interrupt Enable Register-------------------------------//
  //------------------------------Interrupt Identification Register, Line Control Register ---------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 4;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Read from Receiver fifo
    sel[0]          == 4'b0001;//0  sel = 1
    //Read from Interrupt Enable Register
    sel[1]          == 4'b0010;//1  sel = 2
    //Read from Interrupt Identification Register
    sel[2]          == 4'b0100;//2  sel = 4
    //Read from Line Control Register
    sel[3]          == 4'b1000;//3  sel = 8

    //Read from Receiver fifo
    addr[0]          == 8'b00000000;
    //Read from Interrupt Enable Register
    addr[1]          == 8'b00000000;
    //Read from Interrupt Identification Register
    addr[2]          == 8'b00000000;
    //Read from Line Control Register
    addr[3]          == 8'b00000000;

    foreach(cmd[s]){
      cmd[s]          == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //--------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Line Status Register----------------------------------------------------//
  //--------------------------------------------------------------------------------------------------------------------//
  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_SINGLE_E;
    num_phase_in_block == 1;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Read from Line Status Register
    foreach(sel[j]){
      sel[j]           == 4'b0010; //1 sel = 2
    }

    //Read from Line Status Register
    foreach(addr[k]){
      addr[k]          == 4;
    }

    foreach(cmd[s]){
      cmd[s ]          == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  `uvm_info(get_type_name(),"Reading from LSR", UVM_HIGH)
  //-------------------------------------------------------------------------------------------------------------------//
  //------------------------------Writing to Divisor Latch Byte 1, Divisor Latch Byte 2--------------------------------//
  //------------------------------Line Control Register----------------------------------------------------------------//
  //-------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 3;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Line Control Register
    sel[0]          == 4'b1000;//3  sel = 8
    //Write to Divisor Latch Byte 1
    sel[1]          == 4'b0001;//0  sel = 1
    //Write to Divisor Latch Byte 2
    sel[2]          == 4'b0010;//1  sel = 2

    //Write to Line Control Register
    addr[0]          == 8'b00000000;
    //Write to Divisor Latch Byte 1
    addr[1]          == 8'b00000000;
    //Write to Divisor Latch Byte 2
    addr[2]          == 8'b00000000;

    //Write to Line Control Register
    dat[0]          == 32'h83000000;
    //Write to Divisor Latch Byte 1
    dat[1]          == 32'h00000001;
    //Write to Divisor Latch Byte 2
    dat[2]          == 32'h00000100;

    foreach(cmd[s]){
      cmd[s]          == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //-------------------------------------------------------------------------------------------------------------------//
  //------------------------------Reading from Divisor Latch Byte 1, Divisor Latch Byte 2------------------------------//
  //-------------------------------------------------------------------------------------------------------------------//
  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 2;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Read from Divisor Latch Byte 1
    sel[0]           == 4'b0001;//0  sel = 1
    //Read from Divisor Latch Byte 2
    sel[1]           == 4'b0010;//1  sel = 2

    //Read from Divisor Latch Byte 1
    addr[0]          == 8'b00000000;
    //Read from Divisor Latch Byte 2
    addr[1]          == 8'b00000000;

    foreach(cmd[s]){
      cmd[s]         == READ_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  endtask
endclass

`endif // WB2UART_VIRTUAL_SEQ_REGISTER_ACCESS_SV