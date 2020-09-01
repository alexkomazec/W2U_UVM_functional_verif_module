//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : wb2uart_virtual_seq_dut_config.sv
// Developer  : Aleksandar Komazec
// Date       : 1.10.2019
// Description:
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef WB2UART_VIRTUAL_SEQ_DUT_CONFIG_SV
`define WB2UART_VIRTUAL_SEQ_DUT_CONFIG_SV

class wb2uart_virtual_seq_dut_config extends wb2uart_virtual_sequence_base;
  `uvm_object_utils (wb2uart_virtual_seq_dut_config)

  // config fields
  number_of_bits_e m_number_of_data_bits;
  stop_bits_e      m_number_of_stop_bits;
  parity_e         m_parity_enable;
  type_of_parity_e m_parity_type;
  baud_rate_e      m_baud_rate;
  int              m_baud_rate_int       = 0;
  bit              switch_registers      = 0;

  // sequences
  wishbone_uvc_seq_master   m_wb_seq;

  function new (string name = "wb2uart_virtual_seq_dut_config");
    super.new (name);
  endfunction

  task body();
  bit[7:0] lcr;
  bit[15:0] dl;

  int clk;


  fork
    time_out(3520613); //Excpected time for 24 transactions
  join_none

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Set LCR in order to access Divisor Latches------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  switch_registers = 1;//Enable access to Divisor latches
  lcr[7] = switch_registers;
  lcr[6:0] = 7'b0000000; //dafult value

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_SINGLE_E;
    num_phase_in_block == 1;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Line Control Register in order to enable access to Divisor latches
    foreach(stb_delay[j]){
      sel[j]     == 4'b1000;//3  sel = 8
    }

    //Write to Line Control Register in order to enable access to Divisor latches
    foreach(stb_delay[k]){
      addr[k]    == 8'b00000000;
    }

    //Write to Line Control Register in order to enable access to Divisor latches
    foreach(stb_delay[l]){
      dat[l]          == {lcr,24'h000000} ; //Enable access to divisor latches
    }

    foreach(cmd[s]){
      cmd[s]          == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Calculate Divisor Latche value------------------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//
  case (m_baud_rate)
    BAUD_RATE_1200_E          : clk = 1258000000;// 1258Mhz
    BAUD_RATE_2400_E          : clk = 0; // No information about that
    BAUD_RATE_4800_E          : clk = 0; // No information about that
    BAUD_RATE_9600_E          : clk = 0; // No information about that
    BAUD_RATE_19200_E         : clk = 0; // No information about that
    BAUD_RATE_38400_E         : clk = 0; // No information about that
    BAUD_RATE_57600_E         : clk = 0; // No information about that
    BAUD_RATE_115200_E        : clk = 3686400;// 3.6864Mhz
    default                   : clk = 3686400;// 3.6864Mhz
  endcase

  case (m_baud_rate)
    BAUD_RATE_1200_E          : m_baud_rate_int = 1200;
    BAUD_RATE_2400_E          : m_baud_rate_int = 2400;
    BAUD_RATE_4800_E          : m_baud_rate_int = 4800;
    BAUD_RATE_9600_E          : m_baud_rate_int = 9600;
    BAUD_RATE_19200_E         : m_baud_rate_int = 19200;
    BAUD_RATE_38400_E         : m_baud_rate_int = 38400;
    BAUD_RATE_57600_E         : m_baud_rate_int = 57600;
    BAUD_RATE_115200_E        : m_baud_rate_int = 115200;
    default                   : m_baud_rate_int = 115200;
  endcase

  dl = clk / (16 * m_baud_rate_int);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Write to Divisor latches------------------------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 2;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Divisor Latch Byte 1
    sel[0]          == 4'b0001;//0  sel = 1
    //Write to Divisor Latch Byte 2
    sel[1]          == 4'b0010;//1  sel = 2

    //Write to Divisor Latch Byte 1
    addr[0]          == 8'b00000000;
    //Write to Divisor Latch Byte 2
    addr[1]          == 8'b00000000;

    //Write to Divisor Latch Byte 1
    dat[0]          == {24'h000000,dl[7:0]};
    //Write to Divisor Latch Byte 2
    dat[1]          == {16'h0000,dl[15:8],8'h00};

    foreach(cmd[s]){
      cmd[s]          == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  //------------------------------------------------------------------------------------------------------------------//
  //------------------------------Write to LCR in order to confing DUT------------------------------------------------//
  //------------------------------------------------------------------------------------------------------------------//

  case (m_number_of_data_bits)
    FIVE_E          : lcr[1:0] = 2'b00;
    SIX_E           : lcr[1:0] = 2'b01;
    SEVEN_E         : lcr[1:0] = 2'b10;
    EIGHT_E         : lcr[1:0] = 2'b11;
    default         : lcr[1:0] = 2'b00;
  endcase

  case (m_number_of_stop_bits)
    ONE_E           : lcr[2] = 0;
    ONE_AND_HALF_E  : begin
                          lcr[2] = 1;
                      end
    TWO_E           : lcr[2] = 1;
    default         : lcr[2] = 1;
  endcase

  case (m_parity_enable)
    PARITY_E          : lcr[3] = 1;
    NO_PARITY_E       : lcr[3] = 0;
  endcase

  case (m_parity_type)
    EVEN_E          : lcr[4] = 1;
    ODD_E           : lcr[4] = 0;
  endcase

  lcr[5] = 0; // unimportant for now
  lcr[6] = 0; // unimportant for now

  switch_registers = 0;//Enable access to other registers
  lcr[7] = switch_registers;

  m_wb_seq = wishbone_uvc_seq_master::type_id::create ("m_wb_seq");

  if(!m_wb_seq.randomize() with{
    mode_cycle         == STANDARD_BLOCK_E;
    num_phase_in_block == 1;

    foreach(stb_delay[i]){
      stb_delay[i]     == 0;
    }

    //Write to Line Control Register in order to enable access to other registers
    foreach(stb_delay[j]){
      sel[j]     == 4'b1000;//3  sel = 8
    }

    //Write to Line Control Register in order to enable access to other registers
    foreach(stb_delay[k]){
      addr[k]    == 8'b00000000;
    }

    //Write to Line Control Register in order to enable access to other registers
    foreach(stb_delay[l]){
      dat[l]       == {lcr,24'h000000} ; //Enable access to divisor latches
    }
    foreach(cmd[s]){
      cmd[s]     == WRITE_E;
    }

      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_wb_seq.start (p_sequencer.m_wishbone_seqr);

  endtask
endclass

`endif // WB2UART_VIRTUAL_SEQ_REGISTER_ACCESS_SV