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
module axi_chip2chip_v4_2_lite_aw_seq
(
  input  wire                             clk,
  input  wire                             reset,

  input  wire                             axi_awvalid,
  input  wire                             axi_awready,
  input  wire                             axi_wvalid,
  input  wire                             axi_wready,
  input  wire                             axi_bvalid,
  input  wire                             axi_bready,

  output reg                              use_aw_channel,
  output reg                              use_w_channel
);

reg         next_use_aw_channel;
reg         next_use_w_channel;
reg  [2:0]  state;
reg  [2:0]  next_state;
reg         aw_xfer;
reg         w_xfer;
reg         b_xfer;

localparam ONE_HOT = 3'b 1;
localparam WAIT_AW = ONE_HOT << 0;
localparam WAIT_W  = ONE_HOT << 1;
localparam WAIT_B  = ONE_HOT << 2;

always @ ( posedge clk )
begin
   if ( reset )
   begin
      use_aw_channel <= 1'b 0;
      use_w_channel  <= 1'b 0;
      state          <= WAIT_AW;
   end
   else
   begin
      use_aw_channel <= next_use_aw_channel;
      use_w_channel  <= next_use_w_channel;
      state          <= next_state;
   end
end

always @ ( axi_awvalid    or
           axi_awready    or
           axi_wvalid     or
           axi_wready     or
           axi_bvalid     or
           axi_bready     or
           use_aw_channel or
           use_w_channel  or
           state          )
begin
   next_state          = state;
   next_use_aw_channel = 1'b 0;
   next_use_w_channel  = 1'b 0;
   aw_xfer             = axi_awvalid & axi_awready;
   w_xfer              = axi_wvalid  & axi_wready;
   b_xfer              = axi_bvalid  & axi_bready;

   case ( state )
      WAIT_AW:
      begin
         if ( aw_xfer )
         begin
            next_state          = WAIT_W;
            next_use_aw_channel = 1'b 0;
            next_use_w_channel  = 1'b 1;
         end
         else
         begin
            next_state          = WAIT_AW;
            next_use_aw_channel = 1'b 1;
            next_use_w_channel  = 1'b 0;
         end
      end
      WAIT_W:
      begin
         if ( w_xfer )
         begin
            next_state          = WAIT_B;
            next_use_aw_channel = 1'b 0;
            next_use_w_channel  = 1'b 0;
         end
         else
         begin
            next_state          = WAIT_W;
            next_use_aw_channel = 1'b 0;
            next_use_w_channel  = 1'b 1;
         end
      end
      WAIT_B:
      begin
         if ( b_xfer )
         begin
            next_state          = WAIT_AW;
            next_use_aw_channel = 1'b 1;
            next_use_w_channel  = 1'b 0;
         end
         else
         begin
            next_state          = WAIT_B;
            next_use_aw_channel = 1'b 0;
            next_use_w_channel  = 1'b 0;
         end
      end
   endcase
end
endmodule
