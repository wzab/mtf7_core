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
module axi_chip2chip_v4_2_lite_ar_seq
(
  input  wire                             clk,
  input  wire                             reset,

  input  wire                             axi_arvalid,
  input  wire                             axi_arready,
  input  wire                             axi_rvalid,
  input  wire                             axi_rready,

  output reg                              use_ar_channel
);

reg         next_use_ar_channel;
reg  [1:0]  state;
reg  [1:0]  next_state;
reg         ar_xfer;
reg         r_xfer;

localparam ONE_HOT = 2'b 1;
localparam WAIT_AR = ONE_HOT << 0;
localparam WAIT_R  = ONE_HOT << 1;

always @ ( posedge clk )
begin
   if ( reset )
   begin
      use_ar_channel <= 1'b 0;
      state          <= WAIT_AR;
   end
   else
   begin
      use_ar_channel <= next_use_ar_channel;
      state          <= next_state;
   end
end

always @ ( axi_arvalid    or
           axi_arready    or
           axi_rvalid     or
           axi_rready     or
           use_ar_channel or
           state          )
begin
   next_state          = state;
   next_use_ar_channel = 1'b 0;
   ar_xfer             = axi_arvalid & axi_arready;
   r_xfer              = axi_rvalid  & axi_rready;

   case ( state )
      WAIT_AR:
      begin
         if ( ar_xfer )
         begin
            next_state          = WAIT_R;
            next_use_ar_channel = 1'b 0;
         end
         else
         begin
            next_state          = WAIT_AR;
            next_use_ar_channel = 1'b 1;
         end
      end
      WAIT_R:
      begin
         if ( r_xfer )
         begin
            next_state          = WAIT_AR;
            next_use_ar_channel = 1'b 1;
         end
         else
         begin
            next_state          = WAIT_R;
            next_use_ar_channel = 1'b 0;
         end
      end
   endcase
end

endmodule
