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
module axi_chip2chip_v4_2_lite_tdm
#(
    parameter   DIN_WIDTH             = 36,
    parameter   DOUT_WIDTH            = 20,
    parameter   NO_OF_CHAN            = 3
)
(
  input  wire                             clk,
  input  wire                             reset,

  input  wire                             use_ch0,
  input  wire  [DIN_WIDTH-1:0]            ch0_data_in,
  input  wire                             ch0_valid_in,
  output reg                              ch0_ready_out,

  input  wire                             use_ch1,
  input  wire  [DIN_WIDTH-1:0]            ch1_data_in,
  input  wire                             ch1_valid_in,
  output reg                              ch1_ready_out,

  input  wire                             use_ch2,
  input  wire  [DIN_WIDTH-1:0]            ch2_data_in,
  input  wire                             ch2_valid_in,
  output reg                              ch2_ready_out,

  input  wire                             tx_fifo_full,
  output reg   [DOUT_WIDTH-1:0]           tx_data,
  output reg                              tx_fifo_we
);

reg                  next_ch0_ready_out;
reg                  next_ch1_ready_out;
reg                  next_ch2_ready_out;
reg                  next_tx_fifo_we;
reg [DOUT_WIDTH-1:0] next_tx_data;
reg [5:0]            state;
reg [5:0]            next_state;
reg                  send_ready;
reg                  next_send_ready;

//----------------------------------------------------------
//initial wait cycles added to let the lite-master wait 
//until the slow lite-slave has come out of reset
//----------------------------------------------------------

reg [8:0]            wait_count;
reg [8:0]            next_wait_count;
wire                 wait_done;

//----------------------------------------------------------
//wait only at the master-lite side 
//----------------------------------------------------------
assign wait_done         = ( NO_OF_CHAN == 3 ) ? ( wait_count[8] == 1'b 1 ) : 1;

localparam ONE_HOT = 6'b 1;
localparam S0      = ONE_HOT << 0;
localparam S1      = ONE_HOT << 1;
localparam S2      = ONE_HOT << 2;
localparam S3      = ONE_HOT << 3;
localparam S4      = ONE_HOT << 4;
localparam S5      = ONE_HOT << 5;

always @ ( posedge clk )
begin
   if ( reset )
   begin
      ch0_ready_out   <= 1'b 0;
      ch1_ready_out   <= 1'b 0;
      ch2_ready_out   <= 1'b 0;
      tx_fifo_we      <= 1'b 0;
      tx_data         <= { DOUT_WIDTH { 1'b 0 } };
      send_ready      <= 1'b 0;
      state           <= S0;
      wait_count      <= 9'b 0;
   end
   else
   begin
      ch0_ready_out   <= next_ch0_ready_out;
      ch1_ready_out   <= next_ch1_ready_out;
      ch2_ready_out   <= next_ch2_ready_out;
      tx_fifo_we      <= next_tx_fifo_we;
      tx_data         <= next_tx_data;
      send_ready      <= next_send_ready;
      state           <= next_state;
      wait_count      <= next_wait_count;
   end
end

always @ ( use_ch0          or
           ch0_data_in      or
           ch0_valid_in     or
           ch0_ready_out    or
           use_ch1          or
           ch1_data_in      or
           ch1_valid_in     or
           ch1_ready_out    or
           use_ch2          or
           ch2_data_in      or
           ch2_valid_in     or
           ch2_ready_out    or
           tx_fifo_full     or
           tx_data          or
           tx_fifo_we       or
           send_ready       or
           wait_done        or
           wait_count       or
           state            )
begin
   next_ch0_ready_out       = 1'b 0;
   next_ch1_ready_out       = 1'b 0;
   next_ch2_ready_out       = 1'b 0;
   next_tx_fifo_we          = 1'b 0;
   next_state               = state;
   next_tx_data             = tx_data;
   next_send_ready          = 1'b 0;
   next_wait_count          = wait_count;

   case ( state )
      S0:
      begin
         if ( wait_done )
         begin
            next_state         = S1;
            next_send_ready    = ( ch0_valid_in & use_ch0 & ~tx_fifo_full );
            next_tx_fifo_we    = ( ch0_valid_in & use_ch0 & ~tx_fifo_full );
            next_tx_data       = { 2'b 00, ch0_data_in[(DIN_WIDTH/2)-1:0] };
         end
         else
         begin
            next_state         = S0;
            next_wait_count    = wait_count + 1'b 1;
         end
      end
      S1:
      begin
         next_state         = S2;
         next_send_ready    = 1'b 0;
         next_tx_fifo_we    = send_ready;
         next_ch0_ready_out = send_ready;
         next_tx_data       = { 2'b 00, ch0_data_in[DIN_WIDTH-1:(DIN_WIDTH/2)] };
      end
      S2:
      begin
         next_state         = S3;
         next_send_ready    = ( ch1_valid_in & use_ch1 & ~tx_fifo_full );
         next_tx_fifo_we    = ( ch1_valid_in & use_ch1 & ~tx_fifo_full );
         next_tx_data       = { 2'b 01, ch1_data_in[(DIN_WIDTH/2)-1:0] };
      end
      S3:
      begin
         next_state         = ( NO_OF_CHAN == 3 ) ? S4 : S0;
         next_send_ready    = 1'b 0;
         next_tx_fifo_we    = send_ready;
         next_ch1_ready_out = send_ready;
         next_tx_data       = { 2'b 01, ch1_data_in[DIN_WIDTH-1:(DIN_WIDTH/2)] };
      end
      S4:
      begin
         next_state         = S5;
         next_send_ready    = ( ch2_valid_in & use_ch2 & ~tx_fifo_full );
         next_tx_fifo_we    = ( ch2_valid_in & use_ch2 & ~tx_fifo_full );
         next_tx_data       = { 2'b 10, ch2_data_in[(DIN_WIDTH/2)-1:0] };
      end
      S5:
      begin
         next_state         = S0;
         next_send_ready    = 1'b 0;
         next_tx_fifo_we    = send_ready;
         next_ch2_ready_out = send_ready;
         next_tx_data       = { 2'b 10, ch2_data_in[DIN_WIDTH-1:(DIN_WIDTH/2)] };
      end
   endcase
end

endmodule
