//------------------------------------------------------------------------------
// Copyright (c) 2019 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : uart_uvc_common.sv
// Developer  : Aleksandar Komazec
// Date       : 9.9.2019
// Description: Enum types are added
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef UART_UVC_COMMON_SV
`define UART_UVC_COMMON_SV

typedef enum {
  NO_PARITY_E = 0,
  PARITY_E    = 1
} parity_e;

typedef enum {
  FIVE_E  = 5,
  SIX_E   = 6,
  SEVEN_E = 7,
  EIGHT_E = 8,
  NINE_E  = 9
} number_of_bits_e;

typedef enum {
  EVEN_E = 0,
  ODD_E  = 1
} type_of_parity_e;

typedef enum {
  ONE_E          = 0,
  ONE_AND_HALF_E = 1,
  TWO_E          = 2
} stop_bits_e;

typedef enum {
  BAUD_RATE_1200_E    =  96,
  BAUD_RATE_2400_E    =  48,
  BAUD_RATE_4800_E    =  24,
  BAUD_RATE_9600_E    =  12,
  BAUD_RATE_19200_E   =  6,
  BAUD_RATE_38400_E   =  3,
  BAUD_RATE_57600_E   =  2,
  BAUD_RATE_115200_E  =  1
} baud_rate_e;

typedef enum {
  BAD_PARITY_E  = 0,
  GOOD_PARITY_E = 1
} parity_valid_e;


function bit calc_parity  (int unsigned num_of_data_bits,bit [8:0] data,type_of_parity_e type_of_parity);
    bit parity;
    if (num_of_data_bits == 5) begin
      parity = ^data[4:0];
    end else if (num_of_data_bits == 6) begin
      parity = ^data[5:0];
    end else if (num_of_data_bits == 7) begin
      parity = ^data[6:0];
    end else if (num_of_data_bits == 8) begin
      parity = ^data[7:0];
    end else begin
      parity = ^data;
    end

    if(type_of_parity == ODD_E) begin
        return ~parity;
    end

    if(type_of_parity == EVEN_E) begin
        return parity;
    end
endfunction:  calc_parity

`endif // UART_UVC_COMMON_SV
