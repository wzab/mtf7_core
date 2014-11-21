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
module axi_chip2chip_v4_2_tdm
#(
    parameter   SBITS    = 3,
    parameter   CW       = 2,
    parameter   DW       = 49
)
(
  input  wire                    clk,
  input  wire                    reset,
  // static slot table and valid slots
  input  wire [3:0]              slots,
  input  wire [SBITS-1:0]        st0,
  input  wire [SBITS-1:0]        st1,
  input  wire [SBITS-1:0]        st2,
  input  wire [SBITS-1:0]        st3,
  input  wire [SBITS-1:0]        st4,
  input  wire [SBITS-1:0]        st5,
  input  wire [SBITS-1:0]        st6,
  input  wire [SBITS-1:0]        st7,
  input  wire [SBITS-1:0]        st8,
  input  wire [SBITS-1:0]        st9,
  input  wire [SBITS-1:0]        st10,
  input  wire [SBITS-1:0]        st11,
  input  wire [SBITS-1:0]        st12,
  input  wire [SBITS-1:0]        st13,
  input  wire [SBITS-1:0]        st14,
  input  wire [SBITS-1:0]        st15,
  // phy control
  input  wire                    phy_ready,
  // force slot 0 on the bus
  input  wire                    send_ch0,
  input  wire                    send_calib,
  input  wire [CW+DW+2:0]        calib_pattern,
  // control information
  input  wire [CW-1:0]           ctrl_info,
  // channel data and flow control
  input  wire [DW-1:0]           ch0_data,
  input  wire                    ch0_valid,
  output reg                     ch0_ready,
  input  wire                    ch0_fc,
  input  wire [DW-1:0]           ch1_data,
  input  wire                    ch1_valid,
  output reg                     ch1_ready,
  input  wire                    ch1_fc,
  input  wire [DW-1:0]           ch2_data,
  input  wire                    ch2_valid,
  output reg                     ch2_ready,
  input  wire                    ch2_fc,
  input  wire [DW-1:0]           ch3_data,
  input  wire                    ch3_valid,
  output reg                     ch3_ready,
  input  wire                    ch3_fc,
  // output to PHY or ECC - valid - ready interface
  input  wire                    tdm_ready,
  output reg  [CW+DW+2:0]        tdm_data_out,
  output reg                     tdm_data_valid
);

reg  [CW+DW+2:0]        next_tdm_data_out;
reg                     next_tdm_data_valid;

//---------------------------------------------------------
// internal registers
//---------------------------------------------------------
reg                     int_ch0_ready;
reg                     int_ch1_ready;
reg                     int_ch2_ready;
reg                     int_ch3_ready;
reg  [3:0]              slot_select;
reg  [3:0]              next_slot_select;
reg  [3:0]              slot_count;
reg  [3:0]              next_slot_count;
reg                     next_int_ch0_ready;
reg                     next_int_ch1_ready;
reg                     next_int_ch2_ready;
reg                     next_int_ch3_ready;

//---------------------------------------------------------
// intermediate signals
//---------------------------------------------------------
reg                     slot_done;
reg                     ch0_slot_valid;
reg                     ch1_slot_valid;
reg                     ch2_slot_valid;
reg                     ch3_slot_valid;
reg  [CW+DW+2:0]        d0_mask;
reg  [CW+DW+2:0]        d1_mask;
reg  [CW+DW+2:0]        d2_mask;
reg  [CW+DW+2:0]        d3_mask;
reg  [CW+DW+2:0]        d0_masked_data;
reg  [CW+DW+2:0]        d1_masked_data;
reg  [CW+DW+2:0]        d2_masked_data;
reg  [CW+DW+2:0]        d3_masked_data;
reg                     int_ch1_send;
reg                     int_ch2_send;
reg                     int_ch3_send;
reg  [3:0]              one_hot_ss;

//---------------------------------------------------------
// flops - clocked process
//---------------------------------------------------------
always @ ( posedge clk )
begin
   if ( reset )
   begin
      tdm_data_out    <= { CW+DW+3 { 1'b 0 } };
      tdm_data_valid  <= 1'b 0;
      int_ch0_ready   <= 1'b 0;
      int_ch1_ready   <= 1'b 0;
      int_ch2_ready   <= 1'b 0;
      int_ch3_ready   <= 1'b 0;
      slot_select     <= 4'b 0;
      slot_count      <= 4'b 0;
   end
   else
   begin
      tdm_data_out    <= next_tdm_data_out;
      tdm_data_valid  <= next_tdm_data_valid;
      int_ch0_ready   <= next_int_ch0_ready;
      int_ch1_ready   <= next_int_ch1_ready;
      int_ch2_ready   <= next_int_ch2_ready;
      int_ch3_ready   <= next_int_ch3_ready;
      slot_select     <= next_slot_select;
      slot_count      <= next_slot_count;
   end
end

//---------------------------------------------------------
// logic - combo
//---------------------------------------------------------
always @ ( slots           or
           st0             or
           st1             or
           st2             or
           st3             or
           st4             or
           st5             or
           st6             or
           st7             or
           st8             or
           st9             or
           st10            or
           st11            or
           st12            or
           st13            or
           st14            or
           st15            or
           phy_ready       or
           send_ch0        or
           send_calib      or
           calib_pattern   or
           ctrl_info       or
           ch0_data        or
           ch0_valid       or
           ch0_fc          or
           ch1_data        or
           ch1_valid       or
           ch1_fc          or
           ch2_data        or
           ch2_valid       or
           ch2_fc          or
           ch3_data        or
           ch3_valid       or
           ch3_fc          or
           tdm_ready       or
           tdm_data_out    or
           tdm_data_valid  or
           int_ch0_ready   or
           int_ch1_ready   or
           int_ch2_ready   or
           int_ch3_ready   or
           slot_select     or
           slot_count      )
begin
   //------------------------------------------------------
   // ready output (combo) to the fifo interface
   //------------------------------------------------------
   ch0_ready             = int_ch0_ready & tdm_ready;
   ch1_ready             = int_ch1_ready & tdm_ready;
   ch2_ready             = int_ch2_ready & tdm_ready;
   ch3_ready             = int_ch3_ready & tdm_ready;
   //------------------------------------------------------
   // simple slot count logic
   //------------------------------------------------------
   next_tdm_data_valid  = phy_ready;
   slot_done            = ( slot_count[3:0] == slots );
   case ( { phy_ready, tdm_ready, slot_done, send_ch0 } )
      4'b 1100:
      begin
         next_slot_count     = slot_count + 1'b 1;
      end
      4'b 1110, 4'b 1101, 4'b 1111:
      begin
         next_slot_count     = 4'b 0;
      end
      4'b 1000, 4'b 1001, 4'b 1010, 4'b 1011:
      begin
         next_slot_count     = slot_count;
      end
      default: //4'b 0xxx
      begin
         next_slot_count     = slot_count;
      end
   endcase
   //-------------------------------------------------------
   // generate one hot slot select based on count
   //-------------------------------------------------------
   case ( { send_ch0, next_slot_count } )
      { 1'b 0, 4'd 0  } : one_hot_ss = { st0,  1'b 0 };
      { 1'b 0, 4'd 1  } : one_hot_ss = { st1,  1'b 0 };
      { 1'b 0, 4'd 2  } : one_hot_ss = { st2,  1'b 0 };
      { 1'b 0, 4'd 3  } : one_hot_ss = { st3,  1'b 0 };
      { 1'b 0, 4'd 4  } : one_hot_ss = { st4,  1'b 0 };
      { 1'b 0, 4'd 5  } : one_hot_ss = { st5,  1'b 0 };
      { 1'b 0, 4'd 6  } : one_hot_ss = { st6,  1'b 0 };
      { 1'b 0, 4'd 7  } : one_hot_ss = { st7,  1'b 0 };
      { 1'b 0, 4'd 8  } : one_hot_ss = { st8,  1'b 0 };
      { 1'b 0, 4'd 9  } : one_hot_ss = { st9,  1'b 0 };
      { 1'b 0, 4'd 10 } : one_hot_ss = { st10, 1'b 0 };
      { 1'b 0, 4'd 11 } : one_hot_ss = { st11, 1'b 0 };
      { 1'b 0, 4'd 12 } : one_hot_ss = { st12, 1'b 0 };
      { 1'b 0, 4'd 13 } : one_hot_ss = { st13, 1'b 0 };
      { 1'b 0, 4'd 14 } : one_hot_ss = { st14, 1'b 0 };
      { 1'b 0, 4'd 15 } : one_hot_ss = { st15, 1'b 0 };
      default           : one_hot_ss = { 3'b 0, (~send_calib) };
   endcase
   //-------------------------------------------------------
   // use priority logic to fill empty slots
   //-------------------------------------------------------
   int_ch1_send         = ch1_valid & ~ch1_fc & phy_ready;
   int_ch2_send         = ch2_valid & ~ch2_fc & phy_ready;
   int_ch3_send         = ch3_valid & ~ch3_fc & phy_ready;
   next_int_ch0_ready   = one_hot_ss[0];
   next_int_ch1_ready   = int_ch1_send & ( one_hot_ss[1] | ( one_hot_ss[2] & ~int_ch2_send ) | ( one_hot_ss[3] & ~int_ch3_send ) );
   next_int_ch2_ready   = int_ch2_send & ( one_hot_ss[2] | ( one_hot_ss[1] & ~int_ch1_send ) | ( one_hot_ss[3] & ~int_ch3_send & ~int_ch1_send ) );
   next_int_ch3_ready   = int_ch3_send & ( one_hot_ss[3] | ( one_hot_ss[1] & ~int_ch1_send & ~int_ch2_send ) | ( one_hot_ss[2] & ~int_ch2_send & ~int_ch1_send ) );
   //-------------------------------------------------------
   // more optimized - but difficult to read priority encoder
   //-------------------------------------------------------
   //next_int_ch2_ready   = int_ch2_send & ( one_hot_ss[2] | ( ( one_hot_ss[1] | ( one_hot_ss[3] & ~int_ch3_send ) ) & ~int_ch1_send ) );
   //next_int_ch3_ready   = int_ch3_send & ( one_hot_ss[3] | ( ( one_hot_ss[1] | one_hot_ss[2] ) & ~int_ch1_send & ~int_ch2_send  ) );
   //-------------------------------------------------------
   // one more copy of ready, to fix fanout
   //-------------------------------------------------------
   next_slot_select[0]  = one_hot_ss[0];
   next_slot_select[1]  = int_ch1_send & ( one_hot_ss[1] | ( one_hot_ss[2] & ~int_ch2_send ) | ( one_hot_ss[3] & ~int_ch3_send ) );
   next_slot_select[2]  = int_ch2_send & ( one_hot_ss[2] | ( one_hot_ss[1] & ~int_ch1_send ) | ( one_hot_ss[3] & ~int_ch3_send & ~int_ch1_send ) );
   next_slot_select[3]  = int_ch3_send & ( one_hot_ss[3] | ( one_hot_ss[1] & ~int_ch1_send & ~int_ch2_send ) | ( one_hot_ss[2] & ~int_ch2_send & ~int_ch1_send ) );
   //-------------------------------------------------------
   // flow control from far end is used to qualify slot valid
   //-------------------------------------------------------
   ch0_slot_valid       = int_ch0_ready & ch0_valid;
   ch1_slot_valid       = int_ch1_ready & ch1_valid;
   ch2_slot_valid       = int_ch2_ready & ch2_valid;
   ch3_slot_valid       = int_ch3_ready & ch3_valid;
   //-------------------------------------------------------
   // data path mux implemented as AND-OR
   //-------------------------------------------------------
   d0_mask              = { { DW+1 { slot_select[0] } }, { CW { (~send_calib) } }, { 2 { slot_select[0] } } };
   d1_mask              = { { DW+1 { slot_select[1] } }, { CW { (~send_calib) } }, { 2 { slot_select[1] } } };
   d2_mask              = { { DW+1 { slot_select[2] } }, { CW { (~send_calib) } }, { 2 { slot_select[2] } } };
   d3_mask              = { { DW+1 { slot_select[3] } }, { CW { (~send_calib) } }, { 2 { slot_select[3] } } };
   d0_masked_data       = d0_mask & { ch0_data, ch0_slot_valid, ctrl_info, 2'b 00 };
   d1_masked_data       = d1_mask & { ch1_data, ch1_slot_valid, ctrl_info, 2'b 01 };
   d2_masked_data       = d2_mask & { ch2_data, ch2_slot_valid, ctrl_info, 2'b 10 };
   d3_masked_data       = d3_mask & { ch3_data, ch3_slot_valid, ctrl_info, 2'b 11 };

   if ( tdm_ready )
      next_tdm_data_out = d0_masked_data | d1_masked_data | d2_masked_data | d3_masked_data | calib_pattern;
   else
      next_tdm_data_out = tdm_data_out;
end

wire [1:0]    debug_tdm_id   = tdm_data_out[1:0];
wire [CW-1:0] debug_ctrl_out = tdm_data_out[CW+2-1:2];
wire          debug_slot_val = tdm_data_out[CW+2];
wire [DW-1:0] debug_data_out = tdm_data_out[DW+CW+3-1:CW+3];

endmodule
