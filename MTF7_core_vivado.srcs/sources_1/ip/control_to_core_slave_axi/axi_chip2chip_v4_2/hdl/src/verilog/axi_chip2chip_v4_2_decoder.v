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
module axi_chip2chip_v4_2_decoder
#(
    parameter   CW       = 3,
    parameter   DW       = 25
)
(
  input  wire                    clk,
  input  wire                    reset,

  // phy control
  input  wire                    phy_ready,

  // control information
  output reg  [CW-1:0]           ctrl_info,
  output reg                     ctrl_valid,

  // channel data
  output reg  [DW-1:0]           data_out,
  output reg                     ch0_valid,
  output reg                     ch1_valid,
  output reg                     ch2_valid,
  output reg                     ch3_valid,

  // tdm data from PHY
  input  wire [CW+DW+2:0]        tdm_data_in,
  input  wire                    tdm_data_valid
);

always @ ( posedge clk )
begin
   if ( reset )
   begin
      ctrl_info     <= { CW { 1'b 0 } };
      data_out      <= { DW { 1'b 0 } };
      ctrl_valid    <= 1'b 0;
      ch0_valid     <= 1'b 0;
      ch1_valid     <= 1'b 0;
      ch2_valid     <= 1'b 0;
      ch3_valid     <= 1'b 0;
   end
   else
   begin
      ctrl_info     <= tdm_data_in[CW+2-1:2];
      data_out      <= tdm_data_in[DW+CW+2:CW+3];
      ctrl_valid    <= tdm_data_valid & phy_ready;
      ch0_valid     <= tdm_data_valid & phy_ready & ( tdm_data_in[1:0] == 2'b 00 ) & tdm_data_in[CW+2];
      ch1_valid     <= tdm_data_valid & phy_ready & ( tdm_data_in[1:0] == 2'b 01 ) & tdm_data_in[CW+2];
      ch2_valid     <= tdm_data_valid & phy_ready & ( tdm_data_in[1:0] == 2'b 10 ) & tdm_data_in[CW+2];
      ch3_valid     <= tdm_data_valid & phy_ready & ( tdm_data_in[1:0] == 2'b 11 ) & tdm_data_in[CW+2];
   end
end

endmodule
