//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : dut_dummy.v
// Developer  : Elsys EE
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TRAINING_UVC_DUT_DUMMY_V
`define TRAINING_UVC_DUT_DUMMY_V

module dut_dummy (
  input wire        PRESETn,
  input wire        PCLK,
  input wire [31:0] PADDR,
  input wire        PWRITE,
  input wire [31:0] PWDATA,
  output reg [31:0] PRDATA,
  output reg        PREADY
  );

  reg [4:0] tmp_cnt;

  always @(PADDR)
  begin
      if (PRESETn && PADDR) begin
      tmp_cnt  = $random();
      repeat(tmp_cnt) @(posedge PCLK);
      if (!PWRITE) PRDATA = $random();
      PREADY = 1'b1;
      @(posedge PCLK);
      if (!PWRITE) PRDATA = 8'h00;
      PREADY = 1'b0;
    end
  end

  initial begin
    PREADY = 1'b0;
    PRDATA = 8'h0;
  end
      
endmodule

`endif // TRAINING_UVC_DUT_DUMMY_V
