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
//-------------------------------------------------------------------------
// 64 bit ecc decoder which - data in msb byte is the parity
// 2 stages of registers for timing.
//-------------------------------------------------------------------------
// ACTION: o: aa120507: if problem seen, then mask stage can be registers
//-------------------------------------------------------------------------
(* DowngradeIPIdentifiedWarnings="yes" *)
module axi_chip2chip_v4_2_ecc_dec
(
  input  wire                    clk,
  input  wire                    reset,

  input  wire  [63:0]            data_in,
  input  wire                    data_in_valid,
  output reg   [55:0]            data_out,
  output reg                     data_out_valid,

  output reg                     ecc_error
);

reg  [63:0]  data_in_flop;
reg          data_in_valid_flop;

wire [63:0]  din;
wire [07:0]  pin;
wire [07:0]  syndrome_chk;
wire [07:0]  syndrome;
reg  [55:0]  mask;
wire [55:0]  dec_data;

always @ ( posedge clk )
begin
   data_in_flop <= data_in;
   data_out     <= dec_data[55:0];
   if ( reset )
   begin
      data_in_valid_flop <= 1'b 0;
      data_out_valid     <= 1'b 0;
   end
   else
   begin
      data_in_valid_flop <= data_in_valid;
      data_out_valid     <= data_in_valid_flop;
   end
end

assign din      = { 8'b 0 , data_in_flop[55:0] };
assign pin      = data_in_flop[63:56];
assign dec_data = mask[55:0] ^ din[55:0];


assign syndrome        = syndrome_chk ^ pin ;
assign syndrome_chk[0] = din[00] ^ din[01] ^ din[03] ^ din[04] ^ din[06] ^ din[08] ^ din[10] ^
                         din[11] ^ din[13] ^ din[15] ^ din[17] ^ din[19] ^ din[21] ^ din[23] ^
                         din[25] ^ din[26] ^ din[28] ^ din[30] ^ din[32] ^ din[34] ^ din[36] ^
                         din[38] ^ din[40] ^ din[42] ^ din[44] ^ din[46] ^ din[48] ^ din[50] ^
                         din[52] ^ din[54] ^ din[56] ^ din[57] ^ din[59] ^ din[61] ^ din[63] ;
assign syndrome_chk[1] = din[00] ^ din[02] ^ din[03] ^ din[05] ^ din[06] ^ din[09] ^ din[10] ^
                         din[12] ^ din[13] ^ din[16] ^ din[17] ^ din[20] ^ din[21] ^ din[24] ^
                         din[25] ^ din[27] ^ din[28] ^ din[31] ^ din[32] ^ din[35] ^ din[36] ^
                         din[39] ^ din[40] ^ din[43] ^ din[44] ^ din[47] ^ din[48] ^ din[51] ^
                         din[52] ^ din[55] ^ din[56] ^ din[58] ^ din[59] ^ din[62] ^ din[63] ;
assign syndrome_chk[2] = din[01] ^ din[02] ^ din[03] ^ din[07] ^ din[08] ^ din[09] ^ din[10] ^
                         din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[22] ^ din[23] ^ din[24] ^
                         din[25] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[37] ^ din[38] ^
                         din[39] ^ din[40] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[53] ^
                         din[54] ^ din[55] ^ din[56] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;
assign syndrome_chk[3] = din[04] ^ din[05] ^ din[06] ^ din[07] ^ din[08] ^ din[09] ^ din[10] ^
                         din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^
                         din[25] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^
                         din[39] ^ din[40] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                         din[54] ^ din[55] ^ din[56] ;
assign syndrome_chk[4] = din[11] ^ din[12] ^ din[13] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^
                         din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^
                         din[25] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^
                         din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                         din[54] ^ din[55] ^ din[56] ;
assign syndrome_chk[5] = din[26] ^ din[27] ^ din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^
                         din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^
                         din[40] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^
                         din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^
                         din[54] ^ din[55] ^ din[56] ;
assign syndrome_chk[6] = din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;
assign syndrome_chk[7] = din[00] ^ din[01] ^ din[02] ^ din[03] ^ din[04] ^ din[05] ^ din[06] ^
                         din[07] ^ din[08] ^ din[09] ^ din[10] ^ din[11] ^ din[12] ^ din[13] ^
                         din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[18] ^ din[19] ^ din[20] ^
                         din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[26] ^ din[27] ^
                         din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[33] ^ din[34] ^
                         din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[41] ^
                         din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^
                         din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^
                         din[56] ^ din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^
                         din[63] ^ pin[06] ^ pin[05] ^ pin[04] ^ pin[03] ^ pin[02] ^ pin[01] ^
                         pin[00] ;


always @ (syndrome)
begin
   case (syndrome)
      8'b10000011 : mask = 56'h 00000000000001 ; // 0
      8'b10000101 : mask = 56'h 00000000000002 ; // 1			
      8'b10000110 : mask = 56'h 00000000000004 ; // 2			
      8'b10000111 : mask = 56'h 00000000000008 ; // 3
      8'b10001001 : mask = 56'h 00000000000010 ; // 4
      8'b10001010 : mask = 56'h 00000000000020 ; // 5
      8'b10001011 : mask = 56'h 00000000000040 ; // 6
      8'b10001100 : mask = 56'h 00000000000080 ; // 7
      8'b10001101 : mask = 56'h 00000000000100 ; // 8
      8'b10001110 : mask = 56'h 00000000000200 ; // 9
      8'b10001111 : mask = 56'h 00000000000400 ; // 10
      8'b10010001 : mask = 56'h 00000000000800 ; // 11
      8'b10010010 : mask = 56'h 00000000001000 ; // 12
      8'b10010011 : mask = 56'h 00000000002000 ; // 13
      8'b10010100 : mask = 56'h 00000000004000 ; // 14
      8'b10010101 : mask = 56'h 00000000008000 ; // 15
      8'b10010110 : mask = 56'h 00000000010000 ; // 16
      8'b10010111 : mask = 56'h 00000000020000 ; // 17
      8'b10011000 : mask = 56'h 00000000040000 ; // 18
      8'b10011001 : mask = 56'h 00000000080000 ; // 19
      8'b10011010 : mask = 56'h 00000000100000 ; // 20
      8'b10011011 : mask = 56'h 00000000200000 ; // 21
      8'b10011100 : mask = 56'h 00000000400000 ; // 22
      8'b10011101 : mask = 56'h 00000000800000 ; // 23
      8'b10011110 : mask = 56'h 00000001000000 ; // 24
      8'b10011111 : mask = 56'h 00000002000000 ; // 25
      8'b10100001 : mask = 56'h 00000004000000 ; // 26
      8'b10100010 : mask = 56'h 00000008000000 ; // 27
      8'b10100011 : mask = 56'h 00000010000000 ; // 28
      8'b10100100 : mask = 56'h 00000020000000 ; // 29
      8'b10100101 : mask = 56'h 00000040000000 ; // 30
      8'b10100110 : mask = 56'h 00000080000000 ; // 31
      8'b10100111 : mask = 56'h 00000100000000 ; // 32
      8'b10101000 : mask = 56'h 00000200000000 ; // 33
      8'b10101001 : mask = 56'h 00000400000000 ; // 34
      8'b10101010 : mask = 56'h 00000800000000 ; // 35
      8'b10101011 : mask = 56'h 00001000000000 ; // 36
      8'b10101100 : mask = 56'h 00002000000000 ; // 37
      8'b10101101 : mask = 56'h 00004000000000 ; // 38
      8'b10101110 : mask = 56'h 00008000000000 ; // 39
      8'b10101111 : mask = 56'h 00010000000000 ; // 40
      8'b10110000 : mask = 56'h 00020000000000 ; // 41
      8'b10110001 : mask = 56'h 00040000000000 ; // 42
      8'b10110010 : mask = 56'h 00080000000000 ; // 43
      8'b10110011 : mask = 56'h 00100000000000 ; // 44
      8'b10110100 : mask = 56'h 00200000000000 ; // 45
      8'b10110101 : mask = 56'h 00400000000000 ; // 46
      8'b10110110 : mask = 56'h 00800000000000 ; // 47
      8'b10110111 : mask = 56'h 01000000000000 ; // 48
      8'b10111000 : mask = 56'h 02000000000000 ; // 49
      8'b10111001 : mask = 56'h 04000000000000 ; // 50
      8'b10111010 : mask = 56'h 08000000000000 ; // 51
      8'b10111011 : mask = 56'h 10000000000000 ; // 52
      8'b10111100 : mask = 56'h 20000000000000 ; // 53
      8'b10111101 : mask = 56'h 40000000000000 ; // 54
      8'b10111110 : mask = 56'h 80000000000000 ; // 55
      default     : mask = 56'h 00000000000000 ;
/* mask bits 56 - to - 63 will not be used as the data is only 56 bit wide */
   endcase
end


reg [1:0] error;
//-----------------------------------
// syndrome error code
// 00 = no error/data corrected
// 01 = single bit error
// 10 = double bit error
// 11 = single check-bit error
//-----------------------------------
always @(posedge clk)
begin
   if (reset)
   begin
      error <= {2{1'b0}} ;
      ecc_error <= 1'b 0;
   end
   else
   begin
      ecc_error <= ( ecc_error | error[1] ); // sticky bit cleared only on reset

      case ({ data_in_valid_flop, syndrome[7] })
         2'b10 :
         begin
            case (syndrome[6:0])
               7'b0000000 : error <= 2'b00 ; // no error 
               default :    error <= 2'b10 ; // double error
            endcase 
         end
         2'b11 :
         begin
            case (syndrome[6:3])
               4'b1001 :    error <= 2'b11 ; // detect multiple errors
               4'b1010 :    error <= 2'b11 ; 
               4'b1011 :    error <= 2'b11 ; 
               4'b1100 :    error <= 2'b11 ; 
               4'b1101 :    error <= 2'b11 ; 
               4'b1110 :    error <= 2'b11 ; 
               4'b1111 :    error <= 2'b11 ; 
               default :    error <= 2'b01 ; // single error
            endcase 
         end
         default :          error <= 2'b00 ; 
      endcase 
   end
end

endmodule
