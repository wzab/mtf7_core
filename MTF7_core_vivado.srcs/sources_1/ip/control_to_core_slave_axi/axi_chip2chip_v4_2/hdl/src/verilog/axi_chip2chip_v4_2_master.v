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
module axi_chip2chip_v4_2_master
#(
    parameter   C_FAMILY              = "kintex7",
    parameter   C_PHY_SELECT          = 0,
    parameter   C_ECC_ENABLE          = 0,
    parameter   AFIFO_WIDTH           = 50,
    parameter   WFIFO_WIDTH           = 42,
    parameter   RFIFO_WIDTH           = 40,
    parameter   BFIFO_WIDTH           = 6,
    parameter   ADDR_MUX_RATIO        = 2,
    parameter   DATA_MUX_RATIO        = 2,
    parameter   PHY_DATA_WIDTH        = 30,
    parameter   PHY_CTRL_WIDTH        = 4,
    parameter   C_COMMON_CLK          = 0,
    parameter   C_INTERRUPT_WIDTH     = 4,
    parameter   C_SYNC_STAGE          = 2,
    parameter   C_INCLUDE_AXILITE     = 0,
    parameter   C_AXILITE_WIDTH       = 20
)
(
  input  wire                             axi_aclk,
  input  wire                             axi_reset_n,
  input  wire  [15:0]                     config_id,

  input  wire  [C_INTERRUPT_WIDTH-1:0]    intr_in,
  output wire  [C_INTERRUPT_WIDTH-1:0]    intr_out,

  input  wire  [AFIFO_WIDTH-1:0]          awfifo_data,
  output wire                             axi_awready,
  input  wire                             axi_awvalid,

  input  wire  [AFIFO_WIDTH-1:0]          arfifo_data,
  output wire                             axi_arready,
  input  wire                             axi_arvalid,

  input  wire  [WFIFO_WIDTH-1:0]          wfifo_data,
  output wire                             axi_wready,
  input  wire                             axi_wvalid,

  output wire  [RFIFO_WIDTH-1:0]          rfifo_data,
  input  wire                             axi_rready,
  output wire                             axi_rvalid,

  output wire  [BFIFO_WIDTH-1:0]          bfifo_data,
  input  wire                             axi_bready,
  output wire                             axi_bvalid,

  input  wire                             tx_user_clk,
  input  wire                             tx_user_reset,
  input  wire                             tx_phy_ready,
  input  wire  [PHY_CTRL_WIDTH-1:0]       tx_phy_ctrl,
  input  wire                             tx_user_data_ready,
  output wire                             tx_user_data_valid,
  output wire  [PHY_DATA_WIDTH-1:0]       tx_user_data,

  input  wire                             rx_user_clk,
  input  wire                             rx_user_reset,
  input  wire                             rx_phy_ready,
  input  wire                             rx_user_data_valid,
  input  wire  [PHY_DATA_WIDTH-1:0]       rx_user_data,

  output wire                             ecc_error,

  input  wire  [C_AXILITE_WIDTH-1:0]      axi_lite_tx_data,
  input  wire                             axi_lite_tx_valid,
  output wire                             axi_lite_tx_ready,
  output wire  [C_AXILITE_WIDTH-1:0]      axi_lite_rx_data,
  output wire                             axi_lite_rx_valid
);


localparam AW_CH_DATA_WIDTH = AFIFO_WIDTH/ADDR_MUX_RATIO;
localparam AW_CH_FIFO_DEPTH = 256;
localparam AW_CH_FC         = 128;
localparam AW_CH_PTR_WIDTH  = 8;

localparam AR_CH_DATA_WIDTH = AFIFO_WIDTH/ADDR_MUX_RATIO;
localparam AR_CH_FIFO_DEPTH = 256;
localparam AR_CH_FC         = 128;
localparam AR_CH_PTR_WIDTH  = 8;

localparam WD_CH_DATA_WIDTH = WFIFO_WIDTH/DATA_MUX_RATIO;
localparam WD_CH_FIFO_DEPTH = 512;
localparam WD_CH_FC         = 384;
localparam WD_CH_PTR_WIDTH  = 9;

localparam RD_CH_DATA_WIDTH = RFIFO_WIDTH/DATA_MUX_RATIO;
localparam RD_CH_FIFO_DEPTH = 512;
localparam RD_CH_FC         = 384;
localparam RD_CH_PTR_WIDTH  = 9;

localparam BR_CH_DATA_WIDTH = BFIFO_WIDTH;
localparam BR_CH_FIFO_DEPTH = 256;
localparam BR_CH_FC         = 128;
localparam BR_CH_PTR_WIDTH  = 8;
//-----------------------------------------------------------
// define the control channel, flow control signaling widths
//-----------------------------------------------------------
localparam AW_FC_BITS        = 2;
localparam BR_FC_BITS        = 3;
localparam TDM_ID_BITS       = 2;
localparam TDM_VAL_BITS      = 1;
localparam AW_TDM_CTRL_WIDTH = AW_FC_BITS + TDM_ID_BITS + TDM_VAL_BITS;
localparam BR_TDM_CTRL_WIDTH = BR_FC_BITS + TDM_ID_BITS + TDM_VAL_BITS;

//-----------------------------------------------------------
// compute TDM module data path and control path width
//-----------------------------------------------------------
localparam AURORA_LANES      = PHY_DATA_WIDTH/64;
localparam AURORA_TDM_WIDTH  = AURORA_LANES*56;
localparam TDM_DATA_WIDTH    = ( C_PHY_SELECT == 0 ) ? PHY_DATA_WIDTH : AURORA_TDM_WIDTH;
localparam AW_TDM_DATA_WIDTH = TDM_DATA_WIDTH - AW_TDM_CTRL_WIDTH;
localparam BR_TDM_DATA_WIDTH = TDM_DATA_WIDTH - BR_TDM_CTRL_WIDTH;

localparam AW_CH_TDM_TIELO = ( AW_TDM_DATA_WIDTH - AW_CH_DATA_WIDTH ) + 1;
localparam AR_CH_TDM_TIELO = ( AW_TDM_DATA_WIDTH - AR_CH_DATA_WIDTH ) + 1;
localparam WD_CH_TDM_TIELO = ( AW_TDM_DATA_WIDTH - WD_CH_DATA_WIDTH ) + 1;
localparam RD_CH_TDM_TIELO = ( BR_TDM_DATA_WIDTH - RD_CH_DATA_WIDTH ) + 1;
localparam BR_CH_TDM_TIELO = ( BR_TDM_DATA_WIDTH - BR_CH_DATA_WIDTH ) + 1;
//-----------------------------------------------------------
// Define TDM slot information for TX TDM
// based on the Interface and Mux ratio
//-----------------------------------------------------------
// 1:1:6 or 2:2:12
//-----------------------------------------------------------
wire  [3:0]  tdm_slots = ( DATA_MUX_RATIO == 4 ) ? 4'h f : 4'h 7;
wire  [2:0]  tdm_slot0 = 3'b 001;
wire  [2:0]  tdm_slot1 = ( DATA_MUX_RATIO == 4 ) ? 3'b 001 : 3'b 010;
wire  [2:0]  tdm_slot2 = ( DATA_MUX_RATIO == 4 ) ? 3'b 010 : 3'b 100;
wire  [2:0]  tdm_slot3 = ( DATA_MUX_RATIO == 4 ) ? 3'b 010 : 3'b 100;
wire  [2:0]  tdm_slot4 = 3'b 100;
wire  [2:0]  tdm_slot5 = 3'b 100;
wire  [2:0]  tdm_slot6 = 3'b 100;
wire  [2:0]  tdm_slot7 = 3'b 100;
wire  [2:0]  tdm_slot8 = 3'b 100;
wire  [2:0]  tdm_slot9 = 3'b 100;
wire  [2:0]  tdm_slota = 3'b 100;
wire  [2:0]  tdm_slotb = 3'b 100;
wire  [2:0]  tdm_slotc = 3'b 100;
wire  [2:0]  tdm_slotd = 3'b 100;
wire  [2:0]  tdm_slote = 3'b 100;
wire  [2:0]  tdm_slotf = 3'b 100;
//-----------------------------------------------------------
// common clocking mode is supported in select IO mode only
// aurora always has seperate PHY clock
//-----------------------------------------------------------
localparam SYNC_MODE = ( C_PHY_SELECT == 0 ) ? C_COMMON_CLK : 0;

//-----------------------------------------------------------
// invert reset and use
//-----------------------------------------------------------
wire                             axi_reset = ~axi_reset_n;
//-----------------------------------------------------------
// internal wires
//-----------------------------------------------------------
wire  [AW_CH_DATA_WIDTH-1:0]     aw_ch_data;
wire                             aw_ch_data_valid;
wire                             aw_ch_data_ready;
wire                             aw_ch_fc;
wire  [AR_CH_DATA_WIDTH-1:0]     ar_ch_data;
wire                             ar_ch_data_valid;
wire                             ar_ch_data_ready;
wire                             ar_ch_fc;
wire  [WD_CH_DATA_WIDTH-1:0]     wd_ch_data;
wire                             wd_ch_data_valid;
wire                             wd_ch_data_ready;
wire                             wd_ch_fc;
wire  [RD_CH_DATA_WIDTH-1:0]     rd_ch_data;
wire                             rd_ch_data_valid;
//wire                             rd_ch_data_ready;
wire                             rd_ch_fc;
wire  [BR_CH_DATA_WIDTH-1:0]     br_ch_data;
wire                             br_ch_data_valid;
//wire                             br_ch_data_ready;
wire                             br_ch_fc;
wire                             tdm_user_data_ready;
wire  [TDM_DATA_WIDTH-1:0]       tdm_user_data;
wire                             tdm_user_data_valid;
wire  [AW_FC_BITS-1:0]           br_flow_control;
wire  [BR_FC_BITS-1:0]           aw_dec_flow_control;
wire  [BR_TDM_DATA_WIDTH-1:0]    rx_dec_data;
wire                             reg_slice_user_data_ready;
wire  [TDM_DATA_WIDTH-1:0]       reg_slice_user_data;
wire                             reg_slice_user_data_valid;

wire  [AW_TDM_DATA_WIDTH:0]      tx_ch0_tdm_data;
wire  [AW_TDM_DATA_WIDTH:0]      aw_ch_tdm_data;
wire  [AW_TDM_DATA_WIDTH:0]      ar_ch_tdm_data;
wire  [AW_TDM_DATA_WIDTH:0]      wd_ch_tdm_data;
//wire  [BR_TDM_DATA_WIDTH:0]      rd_ch_tdm_data;
//wire  [BR_TDM_DATA_WIDTH:0]      br_ch_tdm_data;
wire  [AW_CH_TDM_TIELO-1:0]      aw_ch_tielo = { AW_CH_TDM_TIELO { 1'b 0 } };
wire  [AR_CH_TDM_TIELO-1:0]      ar_ch_tielo = { AR_CH_TDM_TIELO { 1'b 0 } };
wire  [WD_CH_TDM_TIELO-1:0]      wd_ch_tielo = { WD_CH_TDM_TIELO { 1'b 0 } };
wire  [RD_CH_TDM_TIELO-1:0]      rd_ch_tielo = { RD_CH_TDM_TIELO { 1'b 0 } };
wire  [BR_CH_TDM_TIELO-1:0]      br_ch_tielo = { BR_CH_TDM_TIELO { 1'b 0 } };
//-----------------------------------------------------------
// tdm to input and output bus mappings
//-----------------------------------------------------------
assign aw_ch_tdm_data = { aw_ch_tielo, aw_ch_data };
assign ar_ch_tdm_data = { ar_ch_tielo, ar_ch_data };
assign wd_ch_tdm_data = { wd_ch_tielo, wd_ch_data };
assign rd_ch_data     = rx_dec_data[RD_CH_DATA_WIDTH-1:0];
assign br_ch_data     = rx_dec_data[BR_CH_DATA_WIDTH-1:0];
//-----------------------------------------------------------
// channel0 controller - calib/auto neg/interrupts
//-----------------------------------------------------------
wire                           send_ch0;
wire                           send_calib;
wire                           tx_ch0_valid;
wire                           tx_ch0_ready;
wire                           rx_ch0_valid;
wire  [TDM_DATA_WIDTH-1:0]     calib_pattern;
//-----------------------------------------------------------
// follower registers
//-----------------------------------------------------------
reg   [TDM_DATA_WIDTH-1:0]     tdm_user_data_flop;
reg                            tdm_user_data_valid_flop;
reg                            rx_user_data_valid_flop;
reg   [TDM_DATA_WIDTH-1:0]     rx_user_data_flop;
reg                            rx_ecc_dec_error_flop;
//-----------------------------------------------------------
// aurora mode ecc reporting mechanism, only for master
//-----------------------------------------------------------
wire                           master_ecc_error;
wire                           slave_ecc_error;
assign                         ecc_error = master_ecc_error | slave_ecc_error;

axi_chip2chip_v4_2_ch0_ctrl
#(
     .C_SYNC_STAGE     ( C_SYNC_STAGE ),
     .C_MASTER_FPGA     ( 1 ),
     .C_PHY_SELECT      ( C_PHY_SELECT ),
     .PHY_CTRL_WIDTH    ( PHY_CTRL_WIDTH ),
     .C_INTERRUPT_WIDTH ( C_INTERRUPT_WIDTH ),
     .TX_DATA_WIDTH     ( TDM_DATA_WIDTH ),
     .TDM_DATA_WIDTH    ( AW_TDM_DATA_WIDTH ),
     .RXDEC_DATA_WIDTH  ( BR_TDM_DATA_WIDTH ),
     .C_INCLUDE_AXILITE ( C_INCLUDE_AXILITE ),
     .C_AXILITE_WIDTH   ( C_AXILITE_WIDTH )
) axi_chip2chip_ch0_ctrl_inst
(
     .axi_aclk          ( axi_aclk ),
     .axi_reset         ( axi_reset ),
     .intr_in           ( intr_in ),
     .intr_out          ( intr_out ),
     .ecc_dec_error_out ( slave_ecc_error ),

     .tx_user_clk       ( tx_user_clk ),
     .tx_user_reset     ( tx_user_reset ),
     .tx_phy_ctrl       ( tx_phy_ctrl ),
     .config_id         ( config_id ),
     .tdm_ready         ( tdm_user_data_ready ),
     .send_ch0          ( send_ch0 ),
     .send_calib        ( send_calib ),
     .tx_ch0_valid      ( tx_ch0_valid ),
     .tx_ch0_data       ( tx_ch0_tdm_data[AW_TDM_DATA_WIDTH-1:0] ),
     .tx_ch0_ready      ( tx_ch0_ready ),
     .tx_calib_pattern  ( calib_pattern ),

     .rx_user_clk       ( rx_user_clk ),
     .rx_user_reset     ( rx_user_reset ),
     .rx_ch0_valid      ( rx_ch0_valid ),
     .rx_ch0_data       ( rx_dec_data ),
     .ecc_dec_error_in  ( 1'b 0 ),

     .axi_lite_tx_data  ( axi_lite_tx_data ),
     .axi_lite_tx_valid ( axi_lite_tx_valid ),
     .axi_lite_tx_ready ( axi_lite_tx_ready ),
     .axi_lite_rx_data  ( axi_lite_rx_data ),
     .axi_lite_rx_valid ( axi_lite_rx_valid )
);

//-----------------------------------------------------------
// define fifo resets - keep the fifo in reset till
// phy completes control channel transfers
//-----------------------------------------------------------
reg    aw_fifo_reset;
reg    br_fifo_reset;

always @ ( posedge rx_user_clk or posedge axi_reset )
begin
   if ( axi_reset )
   begin
      aw_fifo_reset   <= 1'b 1;
      br_fifo_reset   <= 1'b 1;
   end
   else
   begin
      aw_fifo_reset   <= ~rx_phy_ready;
      br_fifo_reset   <= ~rx_phy_ready;
   end
end
//-----------------------------------------------------------
// input and output fifo
//-----------------------------------------------------------
// AW channel fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_awr_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .PACK_RATIO     ( 1 ),
     .UNPACK_RATIO   ( ADDR_MUX_RATIO ),
     .DIN_WIDTH      ( AFIFO_WIDTH ),
     .DOUT_WIDTH     ( AW_CH_DATA_WIDTH ),
     .FIFO_DEPTH     ( AW_CH_FIFO_DEPTH ),
     .FC_ASSERT      ( AW_CH_FC ),
     .FIFO_PTR_WIDTH ( AW_CH_PTR_WIDTH ),
     .SYNC_FIFO      ( SYNC_MODE ),
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_aw_fifo_inst
(
     .fifo_reset     ( aw_fifo_reset ),

     .wr_clk         ( axi_aclk ),
     .wr_reset       ( axi_reset ),
     .data_in        ( awfifo_data ),
     .data_valid_in  ( axi_awvalid ),
     .data_ready_out ( axi_awready ),
     .flow_control   ( /*NC*/ ),

     .rd_clk         ( tx_user_clk ),
     .rd_reset       ( tx_user_reset ),
     .data_out       ( aw_ch_data ),
     .data_valid_out ( aw_ch_data_valid ),
     .data_ready_in  ( aw_ch_data_ready )
);
//-----------------------------------------------------------
// AR channel fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_awr_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .PACK_RATIO     ( 1 ),
     .UNPACK_RATIO   ( ADDR_MUX_RATIO ),
     .DIN_WIDTH      ( AFIFO_WIDTH ),
     .DOUT_WIDTH     ( AR_CH_DATA_WIDTH ),
     .FIFO_DEPTH     ( AR_CH_FIFO_DEPTH ),
     .FC_ASSERT      ( AR_CH_FC ),
     .FIFO_PTR_WIDTH ( AR_CH_PTR_WIDTH ),
     .SYNC_FIFO      ( SYNC_MODE ),
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_ar_fifo_inst
(
     .fifo_reset     ( aw_fifo_reset ),

     .wr_clk         ( axi_aclk ),
     .wr_reset       ( axi_reset ),
     .data_in        ( arfifo_data ),
     .data_valid_in  ( axi_arvalid ),
     .data_ready_out ( axi_arready ),
     .flow_control   ( /*NC*/ ),

     .rd_clk         ( tx_user_clk ),
     .rd_reset       ( tx_user_reset ),
     .data_out       ( ar_ch_data ),
     .data_valid_out ( ar_ch_data_valid ),
     .data_ready_in  ( ar_ch_data_ready )
);
//-----------------------------------------------------------
// W channel fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_awr_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .PACK_RATIO     ( 1 ),
     .UNPACK_RATIO   ( DATA_MUX_RATIO ),
     .DIN_WIDTH      ( WFIFO_WIDTH ),
     .DOUT_WIDTH     ( WD_CH_DATA_WIDTH ),
     .FIFO_DEPTH     ( WD_CH_FIFO_DEPTH ),
     .FC_ASSERT      ( WD_CH_FC ),
     .FIFO_PTR_WIDTH ( WD_CH_PTR_WIDTH ),
     .SYNC_FIFO      ( SYNC_MODE ),
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_w_fifo_inst
(
     .fifo_reset     ( aw_fifo_reset ),

     .wr_clk         ( axi_aclk ),
     .wr_reset       ( axi_reset ),
     .data_in        ( wfifo_data ),
     .data_valid_in  ( axi_wvalid ),
     .data_ready_out ( axi_wready ),
     .flow_control   ( /*NC*/ ),

     .rd_clk         ( tx_user_clk ),
     .rd_reset       ( tx_user_reset ),
     .data_out       ( wd_ch_data ),
     .data_valid_out ( wd_ch_data_valid ),
     .data_ready_in  ( wd_ch_data_ready )
);
//-----------------------------------------------------------
// R channel fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_awr_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .PACK_RATIO     ( DATA_MUX_RATIO ),
     .UNPACK_RATIO   ( 1 ),
     .DIN_WIDTH      ( RD_CH_DATA_WIDTH ),
     .DOUT_WIDTH     ( RFIFO_WIDTH ),
     .FIFO_DEPTH     ( RD_CH_FIFO_DEPTH ),
     .FC_ASSERT      ( RD_CH_FC ),
     .FIFO_PTR_WIDTH ( RD_CH_PTR_WIDTH ),
     .SYNC_FIFO      ( 0 ), // R FIFO is never sync
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_r_fifo_inst
(
     .fifo_reset     ( br_fifo_reset ),

     .wr_clk         ( rx_user_clk ),
     .wr_reset       ( rx_user_reset ),
     .data_in        ( rd_ch_data ),
     .data_valid_in  ( rd_ch_data_valid ),
     .data_ready_out ( ), //rd_ch_data_ready ),
     .flow_control   ( rd_ch_fc ),

     .rd_clk         ( axi_aclk ),
     .rd_reset       ( axi_reset ),
     .data_out       ( rfifo_data ),
     .data_valid_out ( axi_rvalid ),
     .data_ready_in  ( axi_rready )
);
//-----------------------------------------------------------
// B channel fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_b_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .DATA_WIDTH     ( BFIFO_WIDTH ),
     .FIFO_DEPTH     ( BR_CH_FIFO_DEPTH ),
     .FC_ASSERT      ( BR_CH_FC ),
     .FIFO_PTR_WIDTH ( BR_CH_PTR_WIDTH ),
     .SYNC_FIFO      ( 0 ), // B FIFO is never sync
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_b_fifo_inst
(
     .fifo_reset     ( br_fifo_reset ),

     .wr_clk         ( rx_user_clk ),
     .wr_reset       ( rx_user_reset ),
     .data_in        ( br_ch_data ),
     .data_valid_in  ( br_ch_data_valid ),
     .data_ready_out ( ), //br_ch_data_ready ),
     .flow_control   ( br_ch_fc ),

     .rd_clk         ( axi_aclk ),
     .rd_reset       ( axi_reset ),
     .data_out       ( bfifo_data ),
     .data_valid_out ( axi_bvalid ),
     .data_ready_in  ( axi_bready )
);
//-----------------------------------------------------------
// tdm module
//-----------------------------------------------------------
axi_chip2chip_v4_2_tdm
#(
    .SBITS    ( 3 ),
    .CW       ( AW_FC_BITS ),
    .DW       ( AW_TDM_DATA_WIDTH )
) axi_chip2chip_tdm_inst
(
     .clk            ( tx_user_clk ),
     .reset          ( tx_user_reset ),
     .slots          ( tdm_slots ),
     .st0            ( tdm_slot0 ),
     .st1            ( tdm_slot1 ),
     .st2            ( tdm_slot2 ),
     .st3            ( tdm_slot3 ),
     .st4            ( tdm_slot4 ),
     .st5            ( tdm_slot5 ),
     .st6            ( tdm_slot6 ),
     .st7            ( tdm_slot7 ),
     .st8            ( tdm_slot8 ),
     .st9            ( tdm_slot9 ),
     .st10           ( tdm_slota ),
     .st11           ( tdm_slotb ),
     .st12           ( tdm_slotc ),
     .st13           ( tdm_slotd ),
     .st14           ( tdm_slote ),
     .st15           ( tdm_slotf ),
     .phy_ready      ( tx_phy_ready ),
     .send_ch0       ( send_ch0 ),
     .send_calib     ( send_calib ),
     .calib_pattern  ( calib_pattern ),
     .ctrl_info      ( br_flow_control ),
     .ch0_data       ( tx_ch0_tdm_data[AW_TDM_DATA_WIDTH-1:0] ),
     .ch0_valid      ( tx_ch0_valid ),
     .ch0_ready      ( tx_ch0_ready ),
     .ch0_fc         ( 1'b 0 ),
     .ch1_data       ( aw_ch_tdm_data[AW_TDM_DATA_WIDTH-1:0] ),
     .ch1_valid      ( aw_ch_data_valid ),
     .ch1_ready      ( aw_ch_data_ready ),
     .ch1_fc         ( aw_ch_fc ),
     .ch2_data       ( ar_ch_tdm_data[AW_TDM_DATA_WIDTH-1:0] ),
     .ch2_valid      ( ar_ch_data_valid ),
     .ch2_ready      ( ar_ch_data_ready ),
     .ch2_fc         ( ar_ch_fc ),
     .ch3_data       ( wd_ch_tdm_data[AW_TDM_DATA_WIDTH-1:0] ),
     .ch3_valid      ( wd_ch_data_valid ),
     .ch3_ready      ( wd_ch_data_ready ),
     .ch3_fc         ( wd_ch_fc ),
     .tdm_ready      ( tdm_user_data_ready ),
     .tdm_data_out   ( tdm_user_data ),
     .tdm_data_valid ( tdm_user_data_valid )
);

genvar ecc_count, dec_count;
generate if ( C_PHY_SELECT == 0 )
begin: sio_io_stage
   //----------------------------------------------------------------
   // use a circular buffer to sync RX domain control signals to TX
   // as these clocks are phase async
   //----------------------------------------------------------------
   axi_chip2chip_v4_2_cir_buf
   #(
       .DEPTH       (4),
       .PTR_WIDTH   (2),
       .DWIDTH      (5)
    ) axi_chip2chip_cir_buf_inst
    (
       .reset       ( rx_user_reset ),
       .wr_clk      ( rx_user_clk ),
       .data_in     ( { aw_dec_flow_control, br_ch_fc, rd_ch_fc } ),
       .rd_clk      ( tx_user_clk ),
       .data_out    ( { wd_ch_fc, ar_ch_fc, aw_ch_fc, br_flow_control } )
    );

   //----------------------------------------------------------------
   // no flow control from PHY in SIO mode
   //----------------------------------------------------------------
   assign tdm_user_data_ready = 1'b 1;
   //----------------------------------------------------------------
   // register the output's again - for better timing in SIO mode
   //----------------------------------------------------------------
   always @ ( posedge tx_user_clk )
   begin
      if ( tx_user_reset )
      begin
         tdm_user_data_flop       <= { TDM_DATA_WIDTH { 1'b 0 } };
         tdm_user_data_valid_flop <= 1'b 0;
      end
      else
      begin
         tdm_user_data_flop       <= tdm_user_data;
         tdm_user_data_valid_flop <= tdm_user_data_valid;
      end
   end
   assign tx_user_data_valid = tdm_user_data_valid_flop;
   assign tx_user_data       = tdm_user_data_flop;
   //----------------------------------------------------------------
   // register the inputs - for better timing in SIO mode
   //----------------------------------------------------------------
   always @ ( posedge rx_user_clk )
   begin
      if ( rx_user_reset )
      begin
         rx_user_data_flop       <= { TDM_DATA_WIDTH { 1'b 0 } };
         rx_user_data_valid_flop <= 1'b 0;
         rx_ecc_dec_error_flop   <= 1'b 0;
      end
      else
      begin
         rx_user_data_flop       <= rx_user_data;
         rx_user_data_valid_flop <= rx_user_data_valid;
         rx_ecc_dec_error_flop   <= 1'b 0; // no ecc used
      end
   end
   assign master_ecc_error = 1'b 0;
end
else if ( ( C_PHY_SELECT == 1 ) & ( C_ECC_ENABLE == 1 ) )
begin: aurora_ecc_io_stage
   wire [PHY_DATA_WIDTH-1:0]      ecc_enc_out;
   wire [(PHY_DATA_WIDTH/64)-1:0] rx_ecc_dec_data_valid;
   wire [TDM_DATA_WIDTH-1:0]      rx_ecc_dec_data;
   wire [(PHY_DATA_WIDTH/64)-1:0] rx_ecc_dec_error;
   //----------------------------------------------------------------
   // aurora is syncronous - wire flow control - no x-clocking logic
   //----------------------------------------------------------------
   assign br_flow_control = { br_ch_fc, rd_ch_fc } ;
   assign aw_ch_fc        = aw_dec_flow_control[0];
   assign ar_ch_fc        = aw_dec_flow_control[1];
   assign wd_ch_fc        = aw_dec_flow_control[2];
   //----------------------------------------------------------------
   // register slice stage for tdm data output - to ecc encoder
   //----------------------------------------------------------------
   axi_chip2chip_v4_2_asitv10_axisc_register_slice #
   (
      .C_FAMILY     ( C_FAMILY ),
      .C_DATA_WIDTH ( TDM_DATA_WIDTH ),
      .C_REG_CONFIG ( 32'h 1 )
   ) ecc_in_reg_slice_inst
   (
    // System Signals
    .ACLK           ( tx_user_clk ),
    .ARESET         ( tx_user_reset ),
    .ACLKEN         ( 1'b 1 ),
    .S_PAYLOAD_DATA ( tdm_user_data ),
    .S_VALID        ( tdm_user_data_valid ),
    .S_READY        ( tdm_user_data_ready ),
    .M_PAYLOAD_DATA ( reg_slice_user_data ),
    .M_VALID        ( reg_slice_user_data_valid ),
    .M_READY        ( reg_slice_user_data_ready )
   );
   //----------------------------------------------------------------
   // ecc encoder for tx data - one for every 56 bits of data
   //----------------------------------------------------------------
   for ( ecc_count = 0; ecc_count < TDM_DATA_WIDTH/56; ecc_count = ecc_count + 1 )
   begin: ecc_enc_inst
      axi_chip2chip_v4_2_ecc_enc axi_chip2chip_ecc_enc_inst
      (
        .data_in  ( reg_slice_user_data[((ecc_count+1)*56)-1:(ecc_count*56)] ),
        .data_out ( ecc_enc_out[((ecc_count+1)*64)-1:(ecc_count*64)] )
      );
   end
   //----------------------------------------------------------------
   // register slice stage for tdm data output - to aurora
   //----------------------------------------------------------------
   axi_chip2chip_v4_2_asitv10_axisc_register_slice #
   (
      .C_FAMILY     ( C_FAMILY ),
      .C_DATA_WIDTH ( PHY_DATA_WIDTH ),
      .C_REG_CONFIG ( 32'h 1 )
   ) tdm_out_reg_slice_inst
   (
    // System Signals
    .ACLK           ( tx_user_clk ),
    .ARESET         ( tx_user_reset ),
    .ACLKEN         ( 1'b 1 ),
    .S_PAYLOAD_DATA ( ecc_enc_out ),
    .S_VALID        ( reg_slice_user_data_valid ),
    .S_READY        ( reg_slice_user_data_ready ),
    .M_PAYLOAD_DATA ( tx_user_data ),
    .M_VALID        ( tx_user_data_valid ),
    .M_READY        ( tx_user_data_ready )
   );
   //----------------------------------------------------------------
   // ecc decoder for rx data - one for every 64 bits of data
   //----------------------------------------------------------------
   for ( dec_count = 0; dec_count < PHY_DATA_WIDTH/64; dec_count = dec_count + 1 )
   begin: ecc_dec_inst
      axi_chip2chip_v4_2_ecc_dec axi_chip2chip_ecc_dec_inst
      (
          .clk             ( rx_user_clk ),
          .reset           ( rx_user_reset ),
          .data_in         ( rx_user_data[((dec_count+1)*64)-1:(dec_count*64)] ),
          .data_in_valid   ( rx_user_data_valid ),
          .data_out        ( rx_ecc_dec_data[((dec_count+1)*56)-1:(dec_count*56)] ),
          .data_out_valid  ( rx_ecc_dec_data_valid[dec_count] ),
          .ecc_error       ( rx_ecc_dec_error[dec_count] )
      );
   end

   //----------------------------------------------------------------
   // wire data and valid to decoder
   //----------------------------------------------------------------
   always @ ( rx_ecc_dec_data or rx_ecc_dec_data_valid )
   begin
      rx_user_data_flop       = rx_ecc_dec_data[TDM_DATA_WIDTH-1:0];
      rx_user_data_valid_flop = (|rx_ecc_dec_data_valid);
   end
   //----------------------------------------------------------------
   // register the decoder ecc error bit.
   //----------------------------------------------------------------
   always @ ( posedge rx_user_clk )
   begin
      if ( rx_user_reset )
        rx_ecc_dec_error_flop <= 1'b 0;
      else
        rx_ecc_dec_error_flop <= (|rx_ecc_dec_error);
   end

   axi_chip2chip_v4_2_sync_cell
   #(
       .SYNC_TYPE     ( 0 ),
       .C_SYNC_STAGE  ( C_SYNC_STAGE ),
       .C_DW          ( 1 )
   ) axi_chip2chip_sync_cell_master_ecc_err_inst
   (
     .src_clk   ( rx_user_clk ),
     .src_data  ( rx_ecc_dec_error_flop ),
     .dest_clk  ( axi_aclk ),
     .dest_data ( master_ecc_error )
   );
end
else if  ( C_PHY_SELECT == 1 )
begin: aurora_io_stage
   //----------------------------------------------------------------
   // aurora is syncronous - wire flow control - no x-clocking logic
   //----------------------------------------------------------------
   assign br_flow_control = { br_ch_fc, rd_ch_fc } ;
   assign aw_ch_fc        = aw_dec_flow_control[0];
   assign ar_ch_fc        = aw_dec_flow_control[1];
   assign wd_ch_fc        = aw_dec_flow_control[2];

   //----------------------------------------------------------------
   // register slice stage for tdm data output - to aurora
   //----------------------------------------------------------------
   axi_chip2chip_v4_2_asitv10_axisc_register_slice #
   (
      .C_FAMILY     ( C_FAMILY ),
      .C_DATA_WIDTH ( TDM_DATA_WIDTH ),
      .C_REG_CONFIG ( 32'h 1 )
   ) tdm_out_reg_slice_inst
   (
    // System Signals
    .ACLK           ( tx_user_clk ),
    .ARESET         ( tx_user_reset ),
    .ACLKEN         ( 1'b 1 ),
    .S_PAYLOAD_DATA ( tdm_user_data ),
    .S_VALID        ( tdm_user_data_valid ),
    .S_READY        ( tdm_user_data_ready ),
    .M_PAYLOAD_DATA ( tx_user_data[TDM_DATA_WIDTH-1:0] ),
    .M_VALID        ( tx_user_data_valid ),
    .M_READY        ( tx_user_data_ready )
   );
   assign tx_user_data[PHY_DATA_WIDTH-1:TDM_DATA_WIDTH] = { PHY_DATA_WIDTH-TDM_DATA_WIDTH { 1'b 0 } };
   //----------------------------------------------------------------
   // register the inputs
   //----------------------------------------------------------------
   always @ ( posedge rx_user_clk )
   begin
      if ( rx_user_reset )
      begin
         rx_user_data_flop       <= { TDM_DATA_WIDTH { 1'b 0 } };
         rx_user_data_valid_flop <= 1'b 0;
         rx_ecc_dec_error_flop   <= 1'b 0;
      end
      else
      begin
         rx_user_data_flop       <= rx_user_data[TDM_DATA_WIDTH-1:0];
         rx_user_data_valid_flop <= rx_user_data_valid;
         rx_ecc_dec_error_flop   <= 1'b 0; // no ecc used
      end
   end
   assign master_ecc_error = 1'b 0;
end
endgenerate

//----------------------------------------------------------------
// tdm decoder
//----------------------------------------------------------------
axi_chip2chip_v4_2_decoder
#(
    .CW       ( BR_FC_BITS ),
    .DW       ( BR_TDM_DATA_WIDTH )
) axi_chip2chip_decoder_inst
(
    .clk            ( rx_user_clk ),
    .reset          ( rx_user_reset ),
    .phy_ready      ( rx_phy_ready ),
    .ctrl_info      ( aw_dec_flow_control ),
    .ctrl_valid     ( /* NC */ ),
    .data_out       ( rx_dec_data ),
    .ch0_valid      ( rx_ch0_valid ),
    .ch1_valid      ( rd_ch_data_valid ),
    .ch2_valid      ( br_ch_data_valid ),
    .ch3_valid      ( /* NC */ ),
    .tdm_data_in    ( rx_user_data_flop ),
    .tdm_data_valid ( rx_user_data_valid_flop )
);

endmodule
