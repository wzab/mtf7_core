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
module axi_chip2chip_v4_2_phy_if
#(
    parameter   C_FAMILY              = "kintex7",
    parameter   C_SIMULATION          = 0,
    parameter   C_SYNC_STAGE          = 2,
    parameter   C_AXI_MASTER_PHY      = 1,  // 0 -> slave fpga PHY, 1 -> master fpga PHY
    parameter   C_PHY_SELECT          = 0,  // 0 -> select IO, 1 -> Aurora 64/66
    parameter   C_SELECTIO_DDR        = 0,  // 0 -> select IO SDR, 1-> select IO DDR mode
    parameter   C_AXI_PHY_DATA_WIDTH  = 32,
    parameter   C_AXI_SIO_IN_WIDTH    = 32,
    parameter   C_AXI_SIO_OUT_WIDTH   = 32,
    parameter   C_AURORA_WIDTH        = 64,
    parameter   C_AXI_PHY_CTRL_WIDTH  = 3,
    parameter   C_AXI_TDM_CTRL_WIDTH  = 3,
    parameter   C_AXI_TDM_DATA_WIDTH  = 25,
    parameter   C_SELECTIO_PHY_CLK    = 100,
    parameter   C_COMMON_CLK          = 0,
    parameter   C_DISABLE_DESKEW      = 0,
    parameter   C_DISABLE_CLK_SHIFT   = 0,
    parameter   C_USE_DIFF_CLK        = 0,
    parameter   C_USE_DIFF_IO         = 0
)
(
  input  wire                             axi_aclk,
  input  wire                             axi_reset_n,
  input  wire [15:0]                      config_id,

  input  wire                             idelay_ref_clk,
  input  wire                             axi_c2c_phy_clk,
  output wire                             do_cc,
  input  wire                             pma_init_in,
  input  wire                             INIT_clk_i,
  output wire                             pma_init_out,
  input  wire                             aurora_rst_in,
  output wire                             aurora_rst_out,

  output wire                             axi_c2c_sio_tx_clk_out,
  output wire [C_AXI_SIO_OUT_WIDTH-1:0]   axi_c2c_sio_tx_data_out,

  input  wire                             axi_c2c_sio_rx_clk_in,
  input  wire [C_AXI_SIO_IN_WIDTH-1:0]    axi_c2c_sio_rx_data_in,

  output wire                             axi_c2c_sio_tx_diff_clk_out_p,
  output wire                             axi_c2c_sio_tx_diff_clk_out_n,
  output wire [C_AXI_SIO_OUT_WIDTH-1:0]   axi_c2c_sio_tx_diff_data_out_p,
  output wire [C_AXI_SIO_OUT_WIDTH-1:0]   axi_c2c_sio_tx_diff_data_out_n,

  input  wire                             axi_c2c_sio_rx_diff_clk_in_p,
  input  wire                             axi_c2c_sio_rx_diff_clk_in_n,
  input  wire [C_AXI_SIO_IN_WIDTH-1:0]    axi_c2c_sio_rx_diff_data_in_p,
  input  wire [C_AXI_SIO_IN_WIDTH-1:0]    axi_c2c_sio_rx_diff_data_in_n,

  input  wire                             axi_c2c_auro_channel_up,
  input  wire                             axi_c2c_auro_tx_tready,
  output wire [C_AURORA_WIDTH-1:0]        axi_c2c_auro_tx_tdata,
  output wire                             axi_c2c_auro_tx_tvalid,
  input  wire [C_AURORA_WIDTH-1:0]        axi_c2c_auro_rx_tdata,
  input  wire                             axi_c2c_auro_rx_tvalid,

  output wire                             tx_user_clk,
  output wire                             tx_user_reset,
  output wire                             tx_phy_ready,
  output wire [C_AXI_PHY_CTRL_WIDTH-1:0]  tx_phy_ctrl,

  input  wire                             tx_user_data_valid,
  input  wire [C_AXI_PHY_DATA_WIDTH-1:0]  tx_user_data,
  output wire                             tx_user_ready,

  output wire                             rx_user_clk,
  output wire                             rx_user_reset,
  output wire                             rx_phy_ready,
  output wire                             rx_user_data_valid,
  output wire [C_AXI_PHY_DATA_WIDTH-1:0]  rx_user_data,

  output wire                             calib_done_out,
  output wire                             calib_error_out,
  output wire                             phy_error_out,
  output wire                             link_error_out
);

wire                            channel_up;
wire [C_AXI_PHY_CTRL_WIDTH-1:0] phy_init_phy_ctrl;
wire                            tx_phy_ready_init;
wire                            clk_locked;
wire                            idelay_ready;
wire                            calib_start;
wire                            calib_done;
wire                            calib_error;
wire [C_AXI_PHY_DATA_WIDTH-1:0] delay_load;
wire [4:0]                      delay_tap;
wire [C_AXI_PHY_DATA_WIDTH-1:0] calib_data;
wire [C_AXI_PHY_DATA_WIDTH-1:0] calib_neg_data;

//--------------------------------------------------------------------
// define data groups for input calibration
// default setup is nibble wise groups. last group may be 4 to 7 bits
//--------------------------------------------------------------------
localparam   GRP_SIZE        = 4; //C_AXI_PHY_DATA_WIDTH; //8;
localparam   LOG_GRP_SIZE    = 2;
localparam   GRPS            = (C_AXI_PHY_DATA_WIDTH/GRP_SIZE);
localparam   DW_MOD_GRP_SIZE = C_AXI_PHY_DATA_WIDTH%GRP_SIZE;
localparam   LAST_GRP_SIZE   = GRP_SIZE + DW_MOD_GRP_SIZE;

wire  master_phy_clk;
generate if ( ( C_AXI_MASTER_PHY ==1 ) & ( C_COMMON_CLK == 1 ) )
begin
   assign master_phy_clk = axi_aclk;
end
else
begin
   assign master_phy_clk = axi_c2c_phy_clk;
end
endgenerate
//--------------------------------------------------------------------
// data ouptuts
//--------------------------------------------------------------------
generate if ( ( C_PHY_SELECT == 0 )  & ( C_AXI_MASTER_PHY == 1 ) )
begin : master_sio_phy

   assign tx_user_clk             = master_phy_clk;
   assign channel_up              = idelay_ready;
   assign rx_user_data_valid      = 1'b 1;
   assign tx_user_ready           = 1'b 1;
   assign axi_c2c_auro_tx_tvalid  = 1'b 0;
   assign do_cc                   = 1'b 0;
   assign pma_init_out            = 1'b 0;
   assign axi_c2c_auro_tx_tdata   = { C_AURORA_WIDTH { 1'b 0 } };
   wire   rx_user_reset_int_n     = ( ( axi_reset_n == 1'b 1 ) & ( clk_locked == 1'b 1 ) );


   axi_chip2chip_v4_2_reset_sync tx_reset_sync_inst (
       .clk                   ( tx_user_clk ),
       .reset_n               ( axi_reset_n ),
       .sync_reset_out        ( tx_user_reset )
   );

   axi_chip2chip_v4_2_reset_sync rx_reset_sync_inst (
       .clk                   ( rx_user_clk ),
       .reset_n               ( rx_user_reset_int_n ),
       .sync_reset_out        ( rx_user_reset )
   );

   axi_chip2chip_v4_2_sio_output
   #(
       .C_FAMILY       ( C_FAMILY ),
       .C_MASTER_PHY   ( 1 ),
       .DDR_MODE       ( C_SELECTIO_DDR ),
       .DATA_WIDTH     ( C_AXI_PHY_DATA_WIDTH ),
       .OUTPUT_PINS    ( C_AXI_SIO_OUT_WIDTH ),
       .C_USE_DIFF_CLK ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO  ( C_USE_DIFF_IO )

   ) axi_chip2chip_sio_output_inst
   (
       .clk_in      ( tx_user_clk ),
       .reset_in    ( tx_user_reset ),
       .data_in     ( tx_user_data ),
       .clk_out     ( axi_c2c_sio_tx_clk_out ),
       .data_out    ( axi_c2c_sio_tx_data_out ),

       .clk_out_p   ( axi_c2c_sio_tx_diff_clk_out_p ),
       .clk_out_n   ( axi_c2c_sio_tx_diff_clk_out_n ),
       .data_out_p  ( axi_c2c_sio_tx_diff_data_out_p ),
       .data_out_n  ( axi_c2c_sio_tx_diff_data_out_n )
   );

   axi_chip2chip_v4_2_sio_input
   #(
       .C_FAMILY       ( C_FAMILY ),
       .C_MASTER_PHY   ( 1 ),
       .CLK_IN_FREQ    ( C_SELECTIO_PHY_CLK ),
       .DDR_MODE       ( C_SELECTIO_DDR ),
       .DATA_WIDTH     ( C_AXI_PHY_DATA_WIDTH ),
       .INPUT_PINS     ( C_AXI_SIO_IN_WIDTH ),
       .DIS_DESKEW     ( C_DISABLE_DESKEW ),
       .DIS_CLK_SHIFT  ( C_DISABLE_CLK_SHIFT ),
       .C_USE_DIFF_CLK ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO  ( C_USE_DIFF_IO )
   ) axi_chip2chip_sio_input_inst
   (
       .idelay_ref_clk ( idelay_ref_clk ),
       .idelay_ready   ( idelay_ready ),

       .clk_in         ( axi_c2c_sio_rx_clk_in ),
       .reset_in       ( tx_user_reset ), // used for MMCM and IDELAY olny
       .clk_locked     ( clk_locked ),

       .data_in        ( axi_c2c_sio_rx_data_in ),
       .clk_out        ( rx_user_clk ),
       .data_out       ( calib_data ),
       .data_neg_out   ( calib_neg_data ),
       .delay_tap      ( delay_tap ),
       .delay_load     ( delay_load ),

       .clk_in_p       ( axi_c2c_sio_rx_diff_clk_in_p ),
       .clk_in_n       ( axi_c2c_sio_rx_diff_clk_in_n ),
       .data_in_p      ( axi_c2c_sio_rx_diff_data_in_p ),
       .data_in_n      ( axi_c2c_sio_rx_diff_data_in_n )
   );

   axi_chip2chip_v4_2_cir_buf
   #(
       .DEPTH       (4),
       .PTR_WIDTH   (2),
       .DWIDTH      (C_AXI_PHY_CTRL_WIDTH+1)
    ) axi_chip2chip_cir_buf_inst
    (
       .reset       ( rx_user_reset ),
       .wr_clk      ( rx_user_clk ),
       .data_in     ( { tx_phy_ready_init, phy_init_phy_ctrl } ),
       .rd_clk      ( tx_user_clk ),
       .data_out    ( { tx_phy_ready, tx_phy_ctrl } )
    );

   axi_chip2chip_v4_2_phy_calib
   #( .DDR_MODE   ( C_SELECTIO_DDR ),
      .DW         ( C_AXI_PHY_DATA_WIDTH ),
      .GRPS       ( GRPS ),
      .GRPW       ( GRP_SIZE ),
      .LOGGRPW    ( LOG_GRP_SIZE ),
      .LASTGRPW   ( LAST_GRP_SIZE ),
      .DIS_DESKEW ( C_DISABLE_DESKEW )
   ) axi_chip2chip_phy_calib_inst
   (
       .clk            ( rx_user_clk ),
       .reset          ( rx_user_reset ),
       .data_in        ( calib_data ),
       .data_neg_in    ( calib_neg_data ),
       .data_out       ( rx_user_data ),
       .calib_start    ( calib_start ),
       .calib_done     ( calib_done ),
       .calib_error    ( calib_error ),
       .delay_tap      ( delay_tap ),
       .delay_load     ( delay_load )
   );
end
else if ( ( C_PHY_SELECT == 0 )  & ( C_AXI_MASTER_PHY == 0 ) )
begin: slave_sio_phy

   assign tx_user_clk              = rx_user_clk;
   assign tx_user_reset            = rx_user_reset;

   assign tx_phy_ctrl              = phy_init_phy_ctrl;
   assign tx_phy_ready             = tx_phy_ready_init;
   assign channel_up               = idelay_ready;
   assign rx_user_data_valid       = 1'b 1;
   assign tx_user_ready            = 1'b 1;
   assign axi_c2c_auro_tx_tvalid   = 1'b 0;
   assign do_cc                    = 1'b 0;
   assign pma_init_out             = 1'b 0;
   assign axi_c2c_auro_tx_tdata    = { C_AURORA_WIDTH { 1'b 0 } };

   wire   mmcm_idelay_reset        = ~axi_reset_n;
   wire   rx_user_reset_int_n      = ( ( axi_reset_n == 1'b 1 ) & ( clk_locked == 1'b 1 ) );

   axi_chip2chip_v4_2_reset_sync rx_reset_sync_inst (
       .clk                   ( rx_user_clk ),
       .reset_n               ( rx_user_reset_int_n ),
       .sync_reset_out        ( rx_user_reset )
   );

   axi_chip2chip_v4_2_sio_output
   #(
       .C_FAMILY       ( C_FAMILY ),
       .C_MASTER_PHY   ( 0 ),
       .DDR_MODE       ( C_SELECTIO_DDR ),
       .DATA_WIDTH     ( C_AXI_PHY_DATA_WIDTH ),
       .OUTPUT_PINS    ( C_AXI_SIO_OUT_WIDTH ),
       .C_USE_DIFF_CLK ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO  ( C_USE_DIFF_IO )
   ) axi_chip2chip_sio_output_inst
   (
       .clk_in      ( tx_user_clk ),
       .reset_in    ( tx_user_reset ),
       .data_in     ( tx_user_data ),
       .clk_out     ( axi_c2c_sio_tx_clk_out ),
       .data_out    ( axi_c2c_sio_tx_data_out ),

       .clk_out_p   ( axi_c2c_sio_tx_diff_clk_out_p ),
       .clk_out_n   ( axi_c2c_sio_tx_diff_clk_out_n ),
       .data_out_p  ( axi_c2c_sio_tx_diff_data_out_p ),
       .data_out_n  ( axi_c2c_sio_tx_diff_data_out_n )
   );

   axi_chip2chip_v4_2_sio_input
   #(
       .C_FAMILY       ( C_FAMILY ),
       .C_MASTER_PHY   ( 0 ),
       .CLK_IN_FREQ    ( C_SELECTIO_PHY_CLK ),
       .DDR_MODE       ( C_SELECTIO_DDR ),
       .DATA_WIDTH     ( C_AXI_PHY_DATA_WIDTH ),
       .INPUT_PINS     ( C_AXI_SIO_IN_WIDTH ),
       .DIS_DESKEW     ( C_DISABLE_DESKEW ),
       .DIS_CLK_SHIFT  ( C_DISABLE_CLK_SHIFT ),
       .C_USE_DIFF_CLK ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO  ( C_USE_DIFF_IO )
   ) axi_chip2chip_sio_input_inst
   (
       .idelay_ref_clk ( idelay_ref_clk ),
       .idelay_ready   ( idelay_ready ),

       .clk_in         ( axi_c2c_sio_rx_clk_in ),
       .reset_in       ( mmcm_idelay_reset ),
       .clk_locked     ( clk_locked ),

       .data_in        ( axi_c2c_sio_rx_data_in ),
       .clk_out        ( rx_user_clk ),
       .data_out       ( calib_data ),
       .data_neg_out   ( calib_neg_data ),
       .delay_tap      ( delay_tap ),
       .delay_load     ( delay_load ),

       .clk_in_p       ( axi_c2c_sio_rx_diff_clk_in_p ),
       .clk_in_n       ( axi_c2c_sio_rx_diff_clk_in_n ),
       .data_in_p      ( axi_c2c_sio_rx_diff_data_in_p ),
       .data_in_n      ( axi_c2c_sio_rx_diff_data_in_n )
   );

   axi_chip2chip_v4_2_phy_calib
   #( .DDR_MODE   ( C_SELECTIO_DDR ),
      .DW         ( C_AXI_PHY_DATA_WIDTH ),
      .GRPS       ( GRPS ),
      .GRPW       ( GRP_SIZE ),
      .LOGGRPW    ( LOG_GRP_SIZE ),
      .LASTGRPW   ( LAST_GRP_SIZE ),
      .DIS_DESKEW ( C_DISABLE_DESKEW )
   ) axi_chip2chip_phy_calib_inst
   (
       .clk            ( rx_user_clk ),
       .reset          ( rx_user_reset ),
       .data_in        ( calib_data ),
       .data_neg_in    ( calib_neg_data ),
       .data_out       ( rx_user_data ),
       .calib_start    ( calib_start ),
       .calib_done     ( calib_done ),
       .calib_error    ( calib_error ),
       .delay_tap      ( delay_tap ),
       .delay_load     ( delay_load )
   );

end
else if ( C_PHY_SELECT == 1 )
begin: aurora_phy

   assign tx_user_clk              = axi_c2c_phy_clk;
   assign rx_user_clk              = axi_c2c_phy_clk;
   assign rx_user_reset            = tx_user_reset;

   assign axi_c2c_auro_tx_tvalid   = tx_user_data_valid;
   assign axi_c2c_auro_tx_tdata    = tx_user_data;
   assign tx_user_ready            = axi_c2c_auro_tx_tready;
   assign rx_user_data_valid       = axi_c2c_auro_rx_tvalid;
   assign rx_user_data             = axi_c2c_auro_rx_tdata;
   assign channel_up               = axi_c2c_auro_channel_up;
   assign tx_phy_ctrl              = phy_init_phy_ctrl;
   assign tx_phy_ready             = tx_phy_ready_init;
   assign calib_done               = 1'b 1;
   assign calib_error              = 1'b 0;

   // Standard CC Module
   axi_chip2chip_v4_2_aurora_standard_cc_module
   #(.C_SIMULATION (C_SIMULATION))
   standard_cc_module_inst
   (
       .DO_CC(do_cc),
       .USER_CLK(axi_c2c_phy_clk),
       .CHANNEL_UP(channel_up),
       .pma_init_in (pma_init_in),
       .INIT_clk_i (INIT_clk_i),
       .pma_init_out (pma_init_out) 
   );

   axi_chip2chip_v4_2_reset_sync user_reset_sync_inst (
       .clk                   ( axi_c2c_phy_clk ),
       .reset_n               ( axi_reset_n ),
       .sync_reset_out        ( tx_user_reset )
   );

   // tie off sio outputs
   assign axi_c2c_sio_tx_clk_out          = 1'b 0;
   assign axi_c2c_sio_tx_data_out         = { C_AXI_SIO_OUT_WIDTH { 1'b 0 } };
   assign axi_c2c_sio_tx_diff_clk_out_p   = 1'b 0;
   assign axi_c2c_sio_tx_diff_clk_out_n   = 1'b 0;
   assign axi_c2c_sio_tx_diff_data_out_p  = { C_AXI_SIO_OUT_WIDTH { 1'b 0 } };
   assign axi_c2c_sio_tx_diff_data_out_n  = { C_AXI_SIO_OUT_WIDTH { 1'b 0 } };
end
endgenerate

//----------------------------------------------------------
// phy init FSM - controls
//----------------------------------------------------------
axi_chip2chip_v4_2_phy_init
#(
    .C_AXI_MASTER_PHY     (C_AXI_MASTER_PHY),
    .C_SYNC_STAGE         (C_SYNC_STAGE),
    .C_PHY_SELECT         (C_PHY_SELECT),
    .C_AXI_PHY_CTRL_WIDTH (C_AXI_PHY_CTRL_WIDTH),
    .C_AXI_PHY_DATA_WIDTH (C_AXI_PHY_DATA_WIDTH),
    .C_AXI_TDM_CTRL_WIDTH (C_AXI_TDM_CTRL_WIDTH),
    .C_AXI_TDM_DATA_WIDTH (C_AXI_TDM_DATA_WIDTH),
    .C_COMMON_CLK         (C_COMMON_CLK)
) axi_chip2chip_phy_init_inst
(
    .axi_aclk           ( axi_aclk ),
    .axi_reset_n        ( axi_reset_n ),
    .aurora_rst_in      ( aurora_rst_in),
    .aurora_rst_out     ( aurora_rst_out),
    .phy_clk            ( rx_user_clk ),
    .phy_reset          ( rx_user_reset ),
    .config_id          ( config_id ),
    .channel_up         ( channel_up ),
    .rx_user_data_valid ( rx_user_data_valid ),
    .rx_user_data       ( rx_user_data ),
    .tx_phy_ctrl        ( phy_init_phy_ctrl ),
    .tx_phy_ready       ( tx_phy_ready_init ),
    .rx_phy_ready       ( rx_phy_ready ),
    .calib_start        ( calib_start ),
    .calib_done         ( calib_done ),
    .calib_error        ( calib_error ),
    .calib_done_out     ( calib_done_out ),
    .calib_error_out    ( calib_error_out ),
    .phy_error_out      ( phy_error_out ),
    .link_error_out     ( link_error_out )
);


// synthesis translate_off
wire [C_AXI_TDM_CTRL_WIDTH-1:0]   debug_ctrl_out = rx_user_data[C_AXI_TDM_CTRL_WIDTH-1:0];
wire [C_AXI_TDM_DATA_WIDTH-1:0]   debug_data_out = rx_user_data[C_AXI_TDM_DATA_WIDTH-1:C_AXI_TDM_CTRL_WIDTH];
wire [1:0]                        debug_slot_id  = debug_ctrl_out[1:0];
wire [C_AXI_TDM_CTRL_WIDTH-3-1:0] debug_fc       = debug_ctrl_out[C_AXI_TDM_CTRL_WIDTH-2:2];
wire                              debug_svalid   = debug_ctrl_out[C_AXI_TDM_CTRL_WIDTH-1];

initial
begin
   $display (" %m GRP_SIZE        = %d", GRP_SIZE        );
   $display (" %m LOG_GRP_SIZE    = %d", LOG_GRP_SIZE    );
   $display (" %m GRPS            = %d", GRPS            );
   $display (" %m DW_MOD_GRP_SIZE = %d", DW_MOD_GRP_SIZE );
   $display (" %m LAST_GRP_SIZE   = %d", LAST_GRP_SIZE   );
end
// synthesis translate_on

endmodule
