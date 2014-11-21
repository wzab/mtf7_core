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
module axi_chip2chip_v4_2_lite_decoder
#(
    parameter   DIN_WIDTH             = 20,
    parameter   DOUT_WIDTH            = 36
)
(
  input  wire                             clk,
  input  wire                             reset,

  output reg   [DOUT_WIDTH-1:0]           ch0_data_out,
  output reg                              ch0_valid_out,
  input  wire                             ch0_ready_in,

  output reg   [DOUT_WIDTH-1:0]           ch1_data_out,
  output reg                              ch1_valid_out,
  input  wire                             ch1_ready_in,

  output reg   [DOUT_WIDTH-1:0]           ch2_data_out,
  output reg                              ch2_valid_out,
  input  wire                             ch2_ready_in,

  input  wire                             rx_data_valid,
  input  wire  [DIN_WIDTH-1:0]            rx_data,
  output reg                              rx_fifo_re
);

reg   [DOUT_WIDTH-1:0]          next_ch0_data_out;
reg                             next_ch0_valid_out;
reg   [DOUT_WIDTH-1:0]          next_ch1_data_out;
reg                             next_ch1_valid_out;
reg   [DOUT_WIDTH-1:0]          next_ch2_data_out;
reg                             next_ch2_valid_out;
reg                             next_rx_fifo_re;
reg   [5:0]                     next_state;
reg   [5:0]                     state;

localparam ONE_HOT         = 6'b 1;
localparam IDLE            = ONE_HOT << 0;
localparam WAIT            = ONE_HOT << 1;
localparam DATA_MSB        = ONE_HOT << 2;
localparam READY_CH0       = ONE_HOT << 3;
localparam READY_CH1       = ONE_HOT << 4;
localparam READY_CH2       = ONE_HOT << 5;

localparam DOUT_D2         = DOUT_WIDTH/2;

always @ ( posedge clk )
begin
   if ( reset )
   begin
      ch0_data_out   <= { DOUT_WIDTH { 1'b 0 } };
      ch0_valid_out  <= 1'b 0;
      ch1_data_out   <= { DOUT_WIDTH { 1'b 0 } };
      ch1_valid_out  <= 1'b 0;
      ch2_data_out   <= { DOUT_WIDTH { 1'b 0 } };
      ch2_valid_out  <= 1'b 0;
      rx_fifo_re     <= 1'b 0;
      state          <= IDLE;
   end
   else
   begin
      ch0_data_out   <= next_ch0_data_out;
      ch0_valid_out  <= next_ch0_valid_out;
      ch1_data_out   <= next_ch1_data_out;
      ch1_valid_out  <= next_ch1_valid_out;
      ch2_data_out   <= next_ch2_data_out;
      ch2_valid_out  <= next_ch2_valid_out;
      rx_fifo_re     <= next_rx_fifo_re;
      state          <= next_state;
   end
end

always @ ( ch0_data_out   or
           ch0_valid_out  or
           ch0_ready_in   or
           ch1_data_out   or
           ch1_valid_out  or
           ch1_ready_in   or
           ch2_data_out   or
           ch2_valid_out  or
           ch2_ready_in   or
           rx_data_valid  or
           rx_data        or
           rx_fifo_re     or
           state          )
begin
   next_ch0_data_out   = ch0_data_out;
   next_ch0_valid_out  = 1'b 0;
   next_ch1_data_out   = ch1_data_out;
   next_ch1_valid_out  = 1'b 0;
   next_ch2_data_out   = ch2_data_out;
   next_ch2_valid_out  = 1'b 0;
   next_rx_fifo_re     = 1'b 0;
   next_state          = state;

   case ( state )
      IDLE:
      begin
         next_rx_fifo_re                = rx_data_valid;
         next_ch0_data_out[DOUT_D2-1:0] = rx_data[DOUT_D2-1:0];
         next_ch1_data_out[DOUT_D2-1:0] = rx_data[DOUT_D2-1:0];
         next_ch2_data_out[DOUT_D2-1:0] = rx_data[DOUT_D2-1:0];
         if ( rx_data_valid )
         begin
            next_state            = WAIT;
         end
         else
         begin
            next_state            = IDLE;
         end
      end
      WAIT:
      begin
         next_state               = DATA_MSB;
      end
      DATA_MSB:
      begin
         next_rx_fifo_re                         = rx_data_valid;
         next_ch0_data_out[DOUT_WIDTH-1:DOUT_D2] = rx_data[DOUT_D2-1:0];
         next_ch1_data_out[DOUT_WIDTH-1:DOUT_D2] = rx_data[DOUT_D2-1:0];
         next_ch2_data_out[DOUT_WIDTH-1:DOUT_D2] = rx_data[DOUT_D2-1:0];

         case ( { rx_data_valid, rx_data[DIN_WIDTH-1:DIN_WIDTH-2] } )
            3'b 100:
            begin
               next_ch0_valid_out = 1'b 1;
               next_state         = READY_CH0;
            end
            3'b 101:
            begin
               next_ch1_valid_out = 1'b 1;
               next_state         = READY_CH1;
            end
            3'b 110:
            begin
               next_ch2_valid_out = 1'b 1;
               next_state         = READY_CH2;
            end
            3'b 111:
            begin
               next_state         = IDLE;
            end
            default:
            begin
               next_state         = DATA_MSB;
            end
         endcase
      end
      READY_CH0:
      begin
         if ( ch0_ready_in )
         begin
            next_ch0_valid_out    = 1'b 0;
            next_state            = IDLE;
         end
         else
         begin
            next_ch0_valid_out    = 1'b 1;
            next_state            = READY_CH0;
         end
      end
      READY_CH1:
      begin
         if ( ch1_ready_in )
         begin
            next_ch1_valid_out    = 1'b 0;
            next_state            = IDLE;
         end
         else
         begin
            next_ch1_valid_out    = 1'b 1;
            next_state            = READY_CH1;
         end
      end
      READY_CH2:
      begin
         if ( ch2_ready_in )
         begin
            next_ch2_valid_out    = 1'b 0;
            next_state            = IDLE;
         end
         else
         begin
            next_ch2_valid_out    = 1'b 1;
            next_state            = READY_CH2;
         end
      end
   endcase
end

// synthesis translate_off
initial
begin
   if ( ( DIN_WIDTH != 20 ) | ( DOUT_WIDTH != 36 ) )
   begin
      $display ("ERROR:: Invalid config DIN_WIDTH %d, DOUT_WIDTH %d",DIN_WIDTH, DOUT_WIDTH);
      $stop;
   end
end
// synthesis translate_on

endmodule
