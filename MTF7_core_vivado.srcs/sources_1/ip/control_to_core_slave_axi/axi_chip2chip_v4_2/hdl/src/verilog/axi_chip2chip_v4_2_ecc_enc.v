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
//--------------------------------------------------------------------------
// combo block, takes in 56 bits of data create ecc and appends to the MSB
// input and output needs to be registered for timing
//--------------------------------------------------------------------------
`timescale 1ns/1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module axi_chip2chip_v4_2_ecc_enc
(
input  wire   [55:0]    data_in,
output wire   [63:0]    data_out
);

wire [63:0] din = { 8'b 0, data_in[55:0] };
wire [7:0]  enc_chkbits;

assign data_out = { enc_chkbits, data_in };

assign enc_chkbits[0] = din[00] ^ din[01] ^ din[03] ^ din[04] ^ din[06] ^ din[08] ^ din[10] ^
                        din[11] ^ din[13] ^ din[15] ^ din[17] ^ din[19] ^ din[21] ^ din[23] ^
                        din[25] ^ din[26] ^ din[28] ^ din[30] ^ din[32] ^ din[34] ^ din[36] ^
                        din[38] ^ din[40] ^ din[42] ^ din[44] ^ din[46] ^ din[48] ^ din[50] ^
                        din[52] ^ din[54] ^ din[56] ^ din[57] ^ din[59] ^ din[61] ^ din[63] ;
assign enc_chkbits[1] = din[00] ^ din[02] ^ din[03] ^ din[05] ^ din[06] ^ din[09] ^ din[10] ^
                        din[12] ^ din[13] ^ din[16] ^ din[17] ^ din[20] ^ din[21] ^ din[24] ^
                        din[25] ^ din[27] ^ din[28] ^ din[31] ^ din[32] ^ din[35] ^ din[36] ^
                        din[39] ^ din[40] ^ din[43] ^ din[44] ^ din[47] ^ din[48] ^ din[51] ^
                        din[52] ^ din[55] ^ din[56] ^ din[58] ^ din[59] ^ din[62] ^ din[63] ;
assign enc_chkbits[2] = din[01] ^ din[02] ^ din[03] ^ din[07] ^ din[08] ^ din[09] ^ din[10] ^
                        din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[22] ^ din[23] ^ din[24] ^
                        din[25] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[37] ^ din[38] ^
                        din[39] ^ din[40] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[53] ^
                        din[54] ^ din[55] ^ din[56] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;
assign enc_chkbits[3] = din[04] ^ din[05] ^ din[06] ^ din[07] ^ din[08] ^ din[09] ^ din[10] ^
                        din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^
                        din[25] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^
                        din[39] ^ din[40] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                        din[54] ^ din[55] ^ din[56] ;
assign enc_chkbits[4] = din[11] ^ din[12] ^ din[13] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^
                        din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^
                        din[25] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^
                        din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                        din[54] ^ din[55] ^ din[56] ;
assign enc_chkbits[5] = din[26] ^ din[27] ^ din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^
                        din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^
                        din[40] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^
                        din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                        din[54] ^ din[55] ^ din[56] ;
assign enc_chkbits[6] = din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;
assign enc_chkbits[7] = din[00] ^ din[01] ^ din[02] ^ din[03] ^ din[04] ^ din[05] ^ din[06] ^
                        din[07] ^ din[08] ^ din[09] ^ din[10] ^ din[11] ^ din[12] ^ din[13] ^
                        din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[18] ^ din[19] ^ din[20] ^
                        din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[26] ^ din[27] ^
                        din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[33] ^ din[34] ^
                        din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[41] ^
                        din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^
                        din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^
                        din[56] ^ din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^
                        din[63] ^ enc_chkbits[06] ^ enc_chkbits[05] ^ enc_chkbits[04] ^
                        enc_chkbits[03] ^ enc_chkbits[02] ^ enc_chkbits[01] ^ enc_chkbits[00] ;

endmodule
