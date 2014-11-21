/******************************************************************************

File name:
Rev:
Description:

-- (c) Copyright 1995 - 2010 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
*******************************************************************************/
`timescale 1ns/1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module axi_chip2chip_v4_2_packer
#(
    parameter   PACK_RATIO            = 1, // 1, 2, 3, 4
    parameter   DIN_WIDTH             = 32,
    parameter   DOUT_WIDTH            = 32
)
(
  input  wire                             clk,
  input  wire                             reset,

  input  wire  [DIN_WIDTH-1:0]            data_in,
  input  wire                             data_valid_in,
  output wire                             data_ready_out,

  output reg   [DOUT_WIDTH-1:0]           data_out,
  output reg                              data_write_en,
  input  wire                             fifo_full
);

wire                             fifo_not_full;
wire                             data_write;

assign fifo_not_full  = ~fifo_full;
assign data_write     = data_valid_in & fifo_not_full;
assign data_ready_out = fifo_not_full;

generate if ( PACK_RATIO == 1 )
begin:bypass
   always @ ( data_in or data_valid_in or data_write )
   begin
      data_out       = data_in;
      data_write_en  = data_write;
   end
end
else if ( PACK_RATIO == 2 )
begin:mux_by_2
   reg [DIN_WIDTH-1:0] pack_reg0;
   reg [1:0]           data_count;

   always @ ( posedge clk )
   begin
      if ( data_write )
      begin
         pack_reg0  <= data_in;
      end
      else
      begin
         pack_reg0  <= pack_reg0;
      end
   end
   always @ ( posedge clk )
   begin
      if ( reset )
      begin
         data_count  <= 2'b 01;
      end
      else
      begin
         if ( data_write )
            data_count <= { data_count[0], data_count[1] };
         else
            data_count <= data_count;
      end
   end

   always @ ( data_in or data_valid_in or pack_reg0 or data_count  or data_write )
   begin
      data_out       = { data_in, pack_reg0 };
      data_write_en  = data_write & data_count[1];
   end
end
else if ( PACK_RATIO == 3 )
begin:mux_by_3
   reg [DIN_WIDTH-1:0] pack_reg0;
   reg [DIN_WIDTH-1:0] pack_reg1;
   reg [2:0]           data_count;

   always @ ( posedge clk )
   begin
      if ( data_write )
      begin
         pack_reg0  <= data_in;
         pack_reg1  <= pack_reg0;
      end
      else
      begin
         pack_reg0  <= pack_reg0;
         pack_reg1  <= pack_reg1;
      end
   end

   always @ ( posedge clk )
   begin
      if ( reset )
      begin
         data_count    <= 3'b 001;
      end
      else
      begin
         if ( data_write )
            data_count <= { data_count[1:0], data_count[2] };
         else
            data_count <= data_count;
      end
   end

   always @ ( data_in   or data_valid_in or data_write or
              pack_reg0 or pack_reg1     or data_count  )
   begin
      data_out      =  { data_in, pack_reg0, pack_reg1 };
      data_write_en =  data_write & data_count[2];
   end
end
else if ( PACK_RATIO == 4 )
begin:mux_by_4
   reg [DIN_WIDTH-1:0] pack_reg0;
   reg [DIN_WIDTH-1:0] pack_reg1;
   reg [DIN_WIDTH-1:0] pack_reg2;
   reg [3:0]           data_count;

   always @ ( posedge clk )
   begin
      if ( data_write )
      begin
         pack_reg0  <= data_in;
         pack_reg1  <= pack_reg0;
         pack_reg2  <= pack_reg1;
      end
      else
      begin
         pack_reg0  <= pack_reg0;
         pack_reg1  <= pack_reg1;
         pack_reg2  <= pack_reg2;
      end
   end

   always @ ( posedge clk )
   begin
      if ( reset )
      begin
         data_count   <= 4'b 0001;
      end
      else
      begin
         if ( data_write )
            data_count <= { data_count[2:0], data_count[3] };
         else
            data_count  <=  data_count;
      end
   end

   always @ ( data_in   or data_valid_in or data_write or
              pack_reg0 or pack_reg1     or pack_reg2  or data_count )
   begin
      data_out       = { data_in, pack_reg0, pack_reg1, pack_reg2 };
      data_write_en  = data_write & data_count[3];
   end
end
endgenerate

endmodule


