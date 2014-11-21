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
module axi_chip2chip_v4_2_ch0_ctrl
#(
    parameter   C_SYNC_STAGE        = 2,
    parameter   C_MASTER_FPGA       = 0,
    parameter   C_PHY_SELECT        = 0,
    parameter   PHY_CTRL_WIDTH      = 3,
    parameter   C_INTERRUPT_WIDTH   = 4,
    parameter   TX_DATA_WIDTH       = 32,
    parameter   TDM_DATA_WIDTH      = 32,
    parameter   RXDEC_DATA_WIDTH    = 32,
    parameter   C_INCLUDE_AXILITE   = 0,
    parameter   C_AXILITE_WIDTH     = 20
)
(
  input  wire                             axi_aclk,
  input  wire                             axi_reset,
  input  wire  [C_INTERRUPT_WIDTH-1:0]    intr_in,
  output reg   [C_INTERRUPT_WIDTH-1:0]    intr_out,
  output wire                             ecc_dec_error_out,

  input  wire                             tx_user_clk,
  input  wire                             tx_user_reset,
  input  wire  [PHY_CTRL_WIDTH-1:0]       tx_phy_ctrl,
  input  wire  [15:0]                     config_id,
  input  wire                             tdm_ready,
  output reg                              send_ch0,
  output reg                              send_calib,
  output reg                              tx_ch0_valid,
  output reg   [TDM_DATA_WIDTH-1:0]       tx_ch0_data,
  input  wire                             tx_ch0_ready,
  output wire  [TX_DATA_WIDTH-1:0]        tx_calib_pattern,

  input  wire                             rx_user_clk,
  input  wire                             rx_user_reset,
  input  wire  [RXDEC_DATA_WIDTH-1:0]     rx_ch0_data,
  input  wire                             rx_ch0_valid,
  input  wire                             ecc_dec_error_in,

  input  wire  [C_AXILITE_WIDTH-1:0]      axi_lite_tx_data,
  input  wire                             axi_lite_tx_valid,
  output reg                              axi_lite_tx_ready,
  output reg   [C_AXILITE_WIDTH-1:0]      axi_lite_rx_data,
  output reg                              axi_lite_rx_valid
);

wire  [RXDEC_DATA_WIDTH+16:0]    rx_ch0_init_pat;
//-----------------------------------------------------------
// extend the lite data path to match TDM slot width
// assumption is the lite data path will always less than tdm data width
//-----------------------------------------------------------
localparam AXI_LITE_EXT_WIDTH = TDM_DATA_WIDTH + C_AXILITE_WIDTH;
wire  [AXI_LITE_EXT_WIDTH-1:0]   axi_lite_tx_data_w = { { TDM_DATA_WIDTH { 1'b 1 } }, axi_lite_tx_data };
wire                             axi_lite_present   = ( C_INCLUDE_AXILITE != 0 );
//-----------------------------------------------------------
// double sync intr_in pins from axi_aclk to tx_user_clk
//-----------------------------------------------------------
wire  [C_INTERRUPT_WIDTH-1:0]    sync_intr_in;
reg   [C_INTERRUPT_WIDTH-1:0]    sync_intr_in_d1;

axi_chip2chip_v4_2_sync_cell
#(
    .SYNC_TYPE     ( 0 ),
    .C_SYNC_STAGE  ( C_SYNC_STAGE ),
    .C_DW          ( C_INTERRUPT_WIDTH )
) axi_chip2chip_sync_cell_intr_in_inst
(
  .src_clk   ( axi_aclk ),
  .src_data  ( intr_in ),
  .dest_clk  ( tx_user_clk ),
  .dest_data ( sync_intr_in )
);

//-----------------------------------------------------------
// 3rd stage is used to detect event on intr_in pin
//-----------------------------------------------------------
always @ ( posedge tx_user_clk )
begin
   sync_intr_in_d1  <= sync_intr_in;
end

//-----------------------------------------------------------
// ecc_error input signal - detect the event 
// this is only for slave fpga in aurora mode
//-----------------------------------------------------------
wire                             ecc_dec_err_event;
reg                              ecc_dec_error_in_dly;

generate if ( ( C_PHY_SELECT == 1 ) && ( C_MASTER_FPGA == 0 ) )
begin
   always @ ( posedge tx_user_clk )
   begin
      ecc_dec_error_in_dly   <=  ecc_dec_error_in;
   end

   assign ecc_dec_err_event = ( ecc_dec_error_in != ecc_dec_error_in_dly );
end
else
begin
   assign ecc_dec_err_event     = 1'b 0;

   always @ ( posedge tx_user_clk )
   begin
      ecc_dec_error_in_dly <= 1'b 0;
   end
end
endgenerate

//-----------------------------------------------------------
// detect edge on intr_in
//-----------------------------------------------------------
wire  intr_event = ( sync_intr_in != sync_intr_in_d1 );
reg   intr_flop;

localparam TX_DATA_WIDTH_D4 = (TX_DATA_WIDTH/4) + 4;
localparam TX_DATA_WIDTH_R4 = TX_DATA_WIDTH_D4*4;


generate if ( C_PHY_SELECT == 0 )
begin : calib_intr_gen
   //-----------------------------------------------------------
   // IO mode has calibration and no auto neg
   //-----------------------------------------------------------
   reg  [3:0]                   cal_nibble;
   wire [TX_DATA_WIDTH_R4-1:0]  cal_pattern;
   reg                          send_intr;

   assign cal_pattern      = { TX_DATA_WIDTH_D4 { cal_nibble } };
   assign tx_calib_pattern = cal_pattern[TX_DATA_WIDTH-1:0];
   assign rx_ch0_init_pat  = { { RXDEC_DATA_WIDTH+17 { 1'b 0 } } };

   always @ ( posedge tx_user_clk )
   begin
      if ( tx_user_reset )
      begin
         tx_ch0_data       <= { TDM_DATA_WIDTH { 1'b 0 } };
         send_ch0          <= 1'b 0;
         send_intr         <= 1'b 0;
         send_calib        <= 1'b 0;
         tx_ch0_valid      <= 1'b 0;
         cal_nibble        <= 4'b 0;
         intr_flop         <= 1'b 0;
         axi_lite_tx_ready <= 1'b 0;
      end
      else if ( |tx_phy_ctrl[2:0] ) // calibration or init
      begin
         send_ch0          <= 1'b 1;
         send_intr         <= 1'b 0;
         send_calib        <= 1'b 1;
         tx_ch0_valid      <= 1'b 0;
         intr_flop         <= 1'b 0;
         axi_lite_tx_ready <= 1'b 0;

         case ( tx_phy_ctrl[2:1] )
            2'b 00: cal_nibble <= 4'b 0000; // initial
            2'b 01: cal_nibble <= 4'b 1111; // calib ack  - all f
            2'b 11: cal_nibble <= 4'b 1100; // calib nack - all c
            default:                        // calib pattern - 5,6,9,7 seq
            begin
               case ( cal_nibble )
                  4'b 0101 : cal_nibble <= 4'b 0110;
                  4'b 0110 : cal_nibble <= 4'b 1001;
                  4'b 1001 : cal_nibble <= 4'b 0111;
                  default  : cal_nibble <= 4'b 0101;
               endcase
            end
         endcase
      end
      else
      begin
         if ( intr_event )
         begin
            intr_flop       <= 1'b 1;
         end
         else if ( send_intr & intr_flop )
         begin
            intr_flop       <= 1'b 0;
         end
         else
         begin
            intr_flop       <= intr_flop;
         end

         cal_nibble        <= 4'b 0;
         send_calib        <= 1'b 0;

         if ( intr_flop & tdm_ready & ~tx_ch0_valid )
         begin
            send_ch0          <= 1'b 1;
            send_intr         <= 1'b1;
            tx_ch0_valid      <= 1'b 1;
            tx_ch0_data       <= { { (TDM_DATA_WIDTH-C_INTERRUPT_WIDTH) { 1'b 1 } }, sync_intr_in_d1 } ;
            axi_lite_tx_ready <= 1'b 0;
         end
         else if ( axi_lite_tx_valid & tdm_ready & ~tx_ch0_valid & axi_lite_present & ~intr_event) // will be trimmed off if no axi_lite
         begin
            send_ch0          <= 1'b 1;
            send_intr         <= 1'b 0;
            tx_ch0_valid      <= 1'b 1;
            tx_ch0_data       <= axi_lite_tx_data_w[TDM_DATA_WIDTH-1:0];
            axi_lite_tx_ready <= 1'b 1;
         end
         else if ( tx_ch0_valid )
         begin
            send_ch0          <= ~tdm_ready & ~tx_ch0_ready;
            send_intr         <= send_intr & (~tdm_ready & ~tx_ch0_ready);
            tx_ch0_valid      <= ~tx_ch0_ready;
            axi_lite_tx_ready <= 1'b 0;
         end
         else
         begin
            send_ch0          <= 1'b 0;
            send_intr         <= 1'b 0;
            tx_ch0_valid      <= 1'b 0;
            axi_lite_tx_ready <= 1'b 0;
         end
      end
   end
end
else
begin : auto_neg_intr_gen
   //-----------------------------------------------------------
   // aurora has auto neg. no calibration
   //-----------------------------------------------------------
   wire  [TDM_DATA_WIDTH+16:0] ch0_control_pat;
   reg                          send_intr;

   assign tx_calib_pattern = { TX_DATA_WIDTH_D4 { 4'b 0 } };
   assign ch0_control_pat  = { { TDM_DATA_WIDTH { 1'b 0 } }, config_id, tx_phy_ctrl[1] };
   assign rx_ch0_init_pat  = { { RXDEC_DATA_WIDTH { 1'b 0 } }, config_id, tx_phy_ctrl[1] };

   always @ ( posedge tx_user_clk )
   begin
      if ( tx_user_reset )
      begin
         tx_ch0_data       <= { TDM_DATA_WIDTH { 1'b 0 } };
         send_ch0          <= 1'b 0;
         send_intr         <= 1'b 0;
         tx_ch0_valid      <= 1'b 0;
         send_calib        <= 1'b 0;
         intr_flop         <= 1'b 0;
         axi_lite_tx_ready <= 1'b 0;
      end
      else if ( tx_phy_ctrl[0] )
      begin
         tx_ch0_data       <= ch0_control_pat[TDM_DATA_WIDTH-1:0];
         send_ch0          <= 1'b 1;
         send_intr         <= 1'b 0;
         tx_ch0_valid      <= 1'b 1;
         send_calib        <= 1'b 0;
         intr_flop         <= 1'b 0;
         axi_lite_tx_ready <= 1'b 0;
      end
      else
      begin
         if ( intr_event | ecc_dec_err_event )
         begin
            intr_flop       <= 1'b 1;
         end
         else if ( send_intr & intr_flop )
         begin
            intr_flop       <= 1'b 0;
         end
         else
         begin
            intr_flop       <= intr_flop;
         end

         send_calib      <= 1'b 0;
         if ( intr_flop & tdm_ready & ~tx_ch0_valid )
         begin
            send_ch0          <= 1'b 1;
            send_intr         <= 1'b1;
            tx_ch0_valid      <= 1'b 1;
            axi_lite_tx_ready <= 1'b 0;
            tx_ch0_data       <= { { TDM_DATA_WIDTH-C_INTERRUPT_WIDTH-3 { 1'b 1 } }, { 3 { ecc_dec_error_in_dly } }, sync_intr_in_d1 } ;
         end
         else if ( axi_lite_tx_valid & tdm_ready & ~tx_ch0_valid & axi_lite_present & ~intr_event) // will be trimmed off if no axi_lite
         begin
            send_ch0          <= 1'b 1;
            send_intr         <= 1'b0;
            tx_ch0_valid      <= 1'b 1;
            tx_ch0_data       <= axi_lite_tx_data_w[TDM_DATA_WIDTH-1:0];
            axi_lite_tx_ready <= 1'b 1;
         end
         else if ( tx_ch0_valid )
         begin
            send_ch0          <= ~tdm_ready & ~tx_ch0_ready;
            send_intr         <= send_intr & (~tdm_ready & ~tx_ch0_ready);
            tx_ch0_valid      <= ~tx_ch0_ready;
            axi_lite_tx_ready <= 1'b 0;
         end
         else
         begin
            send_ch0          <= 1'b 0;
            send_intr         <= 1'b0;
            tx_ch0_valid      <= 1'b 0;
            axi_lite_tx_ready <= 1'b 0;
         end
      end
   end
end
endgenerate

//-----------------------------------------------------------
// decode channel 0, transfers from the far end. latch and hold it
//-----------------------------------------------------------
reg   [C_INTERRUPT_WIDTH-1:0]    intr_data;
wire                             rx_intr_data;

//-----------------------------------------------------------
// interrupt data cannot be same as init/auto neg pattern
// should carry 2'b 11 on the upper bits (int+3 lsb can be anything)
//-----------------------------------------------------------
wire   [RXDEC_DATA_WIDTH-1:0] tie_high = { RXDEC_DATA_WIDTH { 1'b 1 } };
assign rx_intr_data = ( rx_ch0_data[RXDEC_DATA_WIDTH-1:1] != rx_ch0_init_pat[RXDEC_DATA_WIDTH-1:1] ) &
                      ( rx_ch0_data[RXDEC_DATA_WIDTH-1:C_INTERRUPT_WIDTH+3] == tie_high[RXDEC_DATA_WIDTH-1:C_INTERRUPT_WIDTH+3] ) &
                      rx_ch0_valid;

always @ ( posedge rx_user_clk )
begin
   if ( rx_user_reset )
   begin
      intr_data     <= { C_INTERRUPT_WIDTH { 1'b 0 } };
   end
   else if ( rx_intr_data )
   begin
      intr_data     <= rx_ch0_data[C_INTERRUPT_WIDTH-1:0];
   end
   else
   begin
      intr_data     <= intr_data;
   end
end

//-----------------------------------------------------------
// double sync interrupt data from RX channel and send on
// axi_aclk domain
//-----------------------------------------------------------
wire  [C_INTERRUPT_WIDTH-1:0]    sync_intr_out;

axi_chip2chip_v4_2_sync_cell
#(
    .SYNC_TYPE     ( 0 ),
    .C_SYNC_STAGE  ( C_SYNC_STAGE ),
    .C_DW          ( 4 )
) axi_chip2chip_sync_cell_intr_out_inst
(
  .src_clk   ( rx_user_clk ),
  .src_data  ( intr_data ),
  .dest_clk  ( axi_aclk ),
  .dest_data ( sync_intr_out )
);

//-----------------------------------------------------------
// register synced intr_out's - async reset
//-----------------------------------------------------------
always @ ( posedge axi_aclk or posedge axi_reset )
begin
   if ( axi_reset )
      intr_out     <= { C_INTERRUPT_WIDTH { 1'b 0 } };
   else
      intr_out     <= sync_intr_out;
end

//-----------------------------------------------------------
// register and majority vote ecc error interrupt from slave
// this is only for master fpga in aurora mode
//-----------------------------------------------------------
generate if ( ( C_PHY_SELECT == 1 ) && ( C_MASTER_FPGA == 1 ) )
begin: master_ecc_err_intr_gen

   reg  [2:0]  slave_ecc_err;
   reg         slave_ecc_intr;
   wire [1:0]  sum_slave_ecc_err = slave_ecc_err[0] + slave_ecc_err[1] + slave_ecc_err[2];

   always @ ( posedge rx_user_clk )
   begin
      if ( rx_user_reset )
      begin
         slave_ecc_err  <= 3'b 0;
         slave_ecc_intr <= 1'b 0;
      end
      else
      begin
         if ( rx_intr_data )
            slave_ecc_err <= rx_ch0_data[C_INTERRUPT_WIDTH+2:C_INTERRUPT_WIDTH];
         else
            slave_ecc_err <= slave_ecc_err;

         if ( ( slave_ecc_intr == 1'b 1 ) & ( sum_slave_ecc_err[1] == 1'b 0 ) ) // 0 or 1
         begin
            slave_ecc_intr <= 1'b 0;
         end
         else if ( ( slave_ecc_intr == 1'b 0 ) & ( sum_slave_ecc_err[1] == 1'b 1 ) ) // 2 or 3
         begin
            slave_ecc_intr <= 1'b 1;
         end
         else
         begin
            slave_ecc_intr <= slave_ecc_intr;
         end
      end
   end

   axi_chip2chip_v4_2_sync_cell
   #(
       .SYNC_TYPE     ( 0 ),
       .C_SYNC_STAGE  ( C_SYNC_STAGE ),
       .C_DW          ( 1 )
   ) axi_chip2chip_sync_cell_ecc_dec_error_out_inst
   (
     .src_clk   ( rx_user_clk ),
     .src_data  ( slave_ecc_intr ),
     .dest_clk  ( axi_aclk ),
     .dest_data ( ecc_dec_error_out )
   );
end
else
begin
   assign ecc_dec_error_out = 1'b 0;
end
endgenerate

generate if ( C_INCLUDE_AXILITE != 0 )
begin : axi_lite_rx_gen
   wire [RXDEC_DATA_WIDTH+C_AXILITE_WIDTH-1:0] rx_ch0_data_w = { { C_AXILITE_WIDTH { 1'b 0 } }, rx_ch0_data };
   wire axi_lite_rx_data_valid = ( rx_ch0_data[RXDEC_DATA_WIDTH-1:1] != rx_ch0_init_pat[RXDEC_DATA_WIDTH-1:1] ) & 
                                 ( rx_ch0_data_w[C_AXILITE_WIDTH-1:C_AXILITE_WIDTH-2] != 2'b 11 ) & rx_ch0_valid;

   always @ ( posedge rx_user_clk )
   begin
      axi_lite_rx_data <= rx_ch0_data_w[C_AXILITE_WIDTH-1:0];
      if ( rx_user_reset )
      begin
         axi_lite_rx_valid <= 1'b 0;
      end
      else
      begin
         axi_lite_rx_valid <= axi_lite_rx_data_valid;
      end
   end
end
else
begin : no_axi_lite_rx_gen
   always @ ( rx_ch0_valid or rx_ch0_data )
   begin
      axi_lite_rx_data  = { C_AXILITE_WIDTH { 1'b 0 } };
      axi_lite_rx_valid = 1'b 0;
   end
end
endgenerate

endmodule
