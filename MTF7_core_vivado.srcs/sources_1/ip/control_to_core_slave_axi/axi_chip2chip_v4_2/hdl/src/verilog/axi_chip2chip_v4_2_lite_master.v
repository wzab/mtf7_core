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
module axi_chip2chip_v4_2_lite_master
#(
    parameter   C_FAMILY              = "kintex7",
    parameter   ADDR_WIDTH            = 32,
    parameter   PROT_WIDTH            = 2,
    parameter   DATA_WIDTH            = 32,
    parameter   STB_WIDTH             = 4,
    parameter   RESP_WIDTH            = 2,
    parameter   PHY_DATA_WIDTH        = 20,
    parameter   C_SYNC_STAGE          = 2
)
(
  input  wire                             axi_aclk,
  input  wire                             axi_reset,

  input  wire  [ADDR_WIDTH-1:0]           axi_awaddr,
  input  wire  [PROT_WIDTH-1:0]           axi_awprot,
  output wire                             axi_awready,
  input  wire                             axi_awvalid,

  input  wire  [ADDR_WIDTH-1:0]           axi_araddr,
  input  wire  [PROT_WIDTH-1:0]           axi_arprot,
  output wire                             axi_arready,
  input  wire                             axi_arvalid,

  input  wire  [DATA_WIDTH-1:0]           axi_wdata,
  input  wire  [STB_WIDTH-1:0]            axi_wstb,
  output wire                             axi_wready,
  input  wire                             axi_wvalid,

  output wire  [DATA_WIDTH-1:0]           axi_rdata,
  output wire  [RESP_WIDTH-1:0]           axi_rresp,
  input  wire                             axi_rready,
  output wire                             axi_rvalid,

  output wire  [RESP_WIDTH-1:0]           axi_bresp,
  input  wire                             axi_bready,
  output wire                             axi_bvalid,

  input  wire                             tx_user_clk,
  input  wire                             tx_user_reset,
  input  wire                             tx_phy_ready,
  output wire  [PHY_DATA_WIDTH-1:0]       tx_user_data,
  output wire                             tx_user_data_valid,
  input  wire                             tx_user_data_ready,

  input  wire                             rx_user_clk,
  input  wire                             rx_user_reset,
  input  wire                             rx_phy_ready,
  input  wire                             rx_user_data_valid,
  input  wire  [PHY_DATA_WIDTH-1:0]       rx_user_data
  );

//-----------------------------------------------------------
// invert reset and use
//-----------------------------------------------------------
//wire                             axi_reset = ~axi_reset_n;
//-----------------------------------------------------------
// define fifo resets - keep the fifo in reset till
// phy completes control channel transfers
//-----------------------------------------------------------
reg    fifo_reset;

always @ ( posedge rx_user_clk or posedge axi_reset )
begin
   if ( axi_reset )
   begin
      fifo_reset   <= 1'b 1;
   end
   else
   begin
      fifo_reset   <= ~rx_phy_ready;
   end
end

localparam INT_DATA_WIDTH = (PHY_DATA_WIDTH-2)*2;
localparam ATIE0          = INT_DATA_WIDTH - ADDR_WIDTH - PROT_WIDTH + 1;
localparam WTIE0          = INT_DATA_WIDTH - DATA_WIDTH - STB_WIDTH + 1;
localparam RTIE0          = INT_DATA_WIDTH - DATA_WIDTH - RESP_WIDTH + 1;
localparam BTIE0          = INT_DATA_WIDTH - RESP_WIDTH + 1;

wire  [INT_DATA_WIDTH:0]       aw_data = { { ATIE0 { 1'b 0 } }, axi_awprot, axi_awaddr };
wire  [INT_DATA_WIDTH:0]       ar_data = { { ATIE0 { 1'b 0 } }, axi_arprot, axi_araddr };
wire  [INT_DATA_WIDTH:0]       w_data  = { { WTIE0 { 1'b 0 } }, axi_wstb, axi_wdata };
wire  [INT_DATA_WIDTH-1:0]     r_data;
wire  [INT_DATA_WIDTH-1:0]     b_data;
wire  [PHY_DATA_WIDTH-1:0]     tx_data;
wire                           tx_fifo_full;
wire                           tx_fifo_we;
wire  [PHY_DATA_WIDTH-1:0]     rx_data;
wire                           rx_data_valid;
wire                           rx_fifo_re;
wire                           use_aw_channel;
wire                           use_w_channel;
wire                           use_ar_channel;
wire                           axi_rvalid_rs;
wire                           axi_rready_rs;
wire                           axi_bvalid_rs;
wire                           axi_bready_rs;
//-----------------------------------------------------------
// output register slices
//-----------------------------------------------------------
axi_chip2chip_v4_2_asitv10_axisc_register_slice #
(
   .C_FAMILY     ( C_FAMILY ),
   .C_DATA_WIDTH ( DATA_WIDTH+RESP_WIDTH ),
   .C_REG_CONFIG ( 32'h 1 )
) rch_reg_slice_inst
(
 // System Signals
 .ACLK           ( axi_aclk ),
 .ARESET         ( axi_reset ),
 .ACLKEN         ( 1'b 1 ),
 .S_PAYLOAD_DATA ( r_data[DATA_WIDTH+RESP_WIDTH-1:0] ),
 .S_VALID        ( axi_rvalid_rs ),
 .S_READY        ( axi_rready_rs ),
 .M_PAYLOAD_DATA ( { axi_rresp, axi_rdata } ),
 .M_VALID        ( axi_rvalid ),
 .M_READY        ( axi_rready )
);
axi_chip2chip_v4_2_asitv10_axisc_register_slice #
(
   .C_FAMILY     ( C_FAMILY ),
   .C_DATA_WIDTH ( RESP_WIDTH ),
   .C_REG_CONFIG ( 32'h 1 )
) bch_reg_slice_inst
(
 // System Signals
 .ACLK           ( axi_aclk ),
 .ARESET         ( axi_reset ),
 .ACLKEN         ( 1'b 1 ),
 .S_PAYLOAD_DATA ( b_data[RESP_WIDTH-1:0] ),
 .S_VALID        ( axi_bvalid_rs ),
 .S_READY        ( axi_bready_rs ),
 .M_PAYLOAD_DATA ( axi_bresp ),
 .M_VALID        ( axi_bvalid ),
 .M_READY        ( axi_bready )
);
//-----------------------------------------------------------
// AW sequencer - AW, W -- completes with B from far end
//-----------------------------------------------------------
axi_chip2chip_v4_2_lite_aw_seq axi_chip2chip_lite_aw_seq_inst
(
     .clk            ( axi_aclk ),
     .reset          ( axi_reset ),
     .axi_awvalid    ( axi_awvalid ),
     .axi_awready    ( axi_awready ),
     .axi_wvalid     ( axi_wvalid ),
     .axi_wready     ( axi_wready ),
     .axi_bvalid     ( axi_bvalid ),
     .axi_bready     ( axi_bready ),
     .use_aw_channel ( use_aw_channel ),
     .use_w_channel  ( use_w_channel )
);
//-----------------------------------------------------------
// AR sequencer - AR -- completes with R from far end
//-----------------------------------------------------------
axi_chip2chip_v4_2_lite_ar_seq axi_chip2chip_lite_ar_seq_inst
(
     .clk            ( axi_aclk ),
     .reset          ( axi_reset ),
     .axi_arvalid    ( axi_arvalid ),
     .axi_arready    ( axi_arready ),
     .axi_rvalid     ( axi_rvalid ),
     .axi_rready     ( axi_rready ),
     .use_ar_channel ( use_ar_channel )
);
//-----------------------------------------------------------
// tdm tranmit machine
//-----------------------------------------------------------
axi_chip2chip_v4_2_lite_tdm
#(
     .DIN_WIDTH     ( INT_DATA_WIDTH ),
     .DOUT_WIDTH    ( PHY_DATA_WIDTH ),
     .NO_OF_CHAN    ( 3 )
) axi_chip2chip_lite_tx_tdm_inst
(
     .clk           ( axi_aclk ),
     .reset         ( axi_reset ),
     .use_ch0       ( use_aw_channel ),
     .ch0_data_in   ( aw_data[INT_DATA_WIDTH-1:0] ),
     .ch0_valid_in  ( axi_awvalid ),
     .ch0_ready_out ( axi_awready ),
     .use_ch1       ( use_ar_channel ),
     .ch1_data_in   ( ar_data[INT_DATA_WIDTH-1:0] ),
     .ch1_valid_in  ( axi_arvalid ),
     .ch1_ready_out ( axi_arready ),
     .use_ch2       ( use_w_channel ),
     .ch2_data_in   ( w_data[INT_DATA_WIDTH-1:0] ),
     .ch2_valid_in  ( axi_wvalid ),
     .ch2_ready_out ( axi_wready ),
     .tx_fifo_full  ( tx_fifo_full ),
     .tx_data       ( tx_data ),
     .tx_fifo_we    ( tx_fifo_we )
);
//-----------------------------------------------------------
// decoder on rx data path
//-----------------------------------------------------------
axi_chip2chip_v4_2_lite_decoder
#(
     .DIN_WIDTH     ( PHY_DATA_WIDTH ),
     .DOUT_WIDTH    ( INT_DATA_WIDTH )
) axi_chip2chip_lite_decoder_inst
(
     .clk           ( axi_aclk ),
     .reset         ( axi_reset ),
     .ch0_data_out  ( r_data ),
     .ch0_valid_out ( axi_rvalid_rs ),
     .ch0_ready_in  ( axi_rready_rs ),
     .ch1_data_out  ( b_data ),
     .ch1_valid_out ( axi_bvalid_rs ),
     .ch1_ready_in  ( axi_bready_rs ),
     .ch2_data_out  ( ),
     .ch2_valid_out ( ),
     .ch2_ready_in  ( 1'b 0 ),
     .rx_data_valid ( rx_data_valid ),
     .rx_data       ( rx_data ),
     .rx_fifo_re    ( rx_fifo_re )
);
localparam TX_FIFO_DEPTH     = 16;
localparam TX_FIFO_PTR_WIDTH = 4;
localparam TX_FIFO_FC_ASSERT = 14;
//-----------------------------------------------------------
// Lite transmit fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_b_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .DATA_WIDTH     ( PHY_DATA_WIDTH ),
     .FIFO_DEPTH     ( TX_FIFO_DEPTH ),
     .FC_ASSERT      ( TX_FIFO_FC_ASSERT ),
     .FIFO_PTR_WIDTH ( TX_FIFO_PTR_WIDTH ),
     .SYNC_FIFO      ( 0 ),
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_lite_master_tx_fifo
(
     .fifo_reset     ( fifo_reset ),
     .wr_clk         ( axi_aclk ),
     .wr_reset       ( axi_reset ),
     .data_in        ( tx_data ),
     .data_valid_in  ( tx_fifo_we ),
     .data_ready_out (  ), //br_ch_data_ready ),
     .flow_control   ( tx_fifo_full ),

     .rd_clk         ( tx_user_clk ),
     .rd_reset       ( tx_user_reset ),
     .data_out       ( tx_user_data ),
     .data_valid_out ( tx_user_data_valid ),
     .data_ready_in  ( tx_user_data_ready )
);

localparam RX_FIFO_DEPTH     = 16;
localparam RX_FIFO_PTR_WIDTH = 4;
localparam RX_FIFO_FC_ASSERT = 14;
//-----------------------------------------------------------
// Lite Receive fifo
//-----------------------------------------------------------
axi_chip2chip_v4_2_b_fifo
#(
     .C_FAMILY       ( C_FAMILY ),
     .DATA_WIDTH     ( PHY_DATA_WIDTH ),
     .FIFO_DEPTH     ( RX_FIFO_DEPTH ),
     .FC_ASSERT      ( RX_FIFO_FC_ASSERT ),
     .FIFO_PTR_WIDTH ( RX_FIFO_PTR_WIDTH ),
     .SYNC_FIFO      ( 0 ),
     .C_SYNC_STAGE   ( C_SYNC_STAGE )
) axi_chip2chip_lite_master_rx_fifo
(
     .fifo_reset     ( fifo_reset ),

     .wr_clk         ( rx_user_clk ),
     .wr_reset       ( rx_user_reset ),
     .data_in        ( rx_user_data ),
     .data_valid_in  ( rx_user_data_valid ),
     .data_ready_out (  ),
     .flow_control   (  ),

     .rd_clk         ( axi_aclk ),
     .rd_reset       ( axi_reset ),
     .data_out       ( rx_data ),
     .data_valid_out ( rx_data_valid ),
     .data_ready_in  ( rx_fifo_re )
);
endmodule
