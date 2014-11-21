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
module axi_chip2chip_v4_2_lite_slave
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

  output wire  [ADDR_WIDTH-1:0]           axi_awaddr,
  output wire  [PROT_WIDTH-1:0]           axi_awprot,
  input  wire                             axi_awready,
  output wire                             axi_awvalid,

  output wire  [ADDR_WIDTH-1:0]           axi_araddr,
  output wire  [PROT_WIDTH-1:0]           axi_arprot,
  input  wire                             axi_arready,
  output wire                             axi_arvalid,

  output wire  [DATA_WIDTH-1:0]           axi_wdata,
  output wire  [STB_WIDTH-1:0]            axi_wstb,
  input  wire                             axi_wready,
  output wire                             axi_wvalid,

  input  wire  [DATA_WIDTH-1:0]           axi_rdata,
  input  wire  [RESP_WIDTH-1:0]           axi_rresp,
  output wire                             axi_rready,
  input  wire                             axi_rvalid,

  input  wire  [RESP_WIDTH-1:0]           axi_bresp,
  output wire                             axi_bready,
  input  wire                             axi_bvalid,

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

wire  [INT_DATA_WIDTH:0]       aw_data;
wire  [INT_DATA_WIDTH:0]       ar_data;
wire  [INT_DATA_WIDTH:0]       w_data;
wire  [INT_DATA_WIDTH-1:0]     r_data  = { { RTIE0 { 1'b 0 } }, axi_rresp, axi_rdata };
wire  [INT_DATA_WIDTH-1:0]     b_data  = { { BTIE0 { 1'b 0 } }, axi_bresp };
wire  [PHY_DATA_WIDTH-1:0]     tx_data;
wire                           tx_fifo_full;
wire                           tx_fifo_we;
wire  [PHY_DATA_WIDTH-1:0]     rx_data;
wire                           rx_data_valid;
wire                           rx_fifo_re;
wire                           axi_awvalid_rs;
wire                           axi_awready_rs;
wire                           axi_wvalid_rs;
wire                           axi_wready_rs;
wire                           axi_arvalid_rs;
wire                           axi_arready_rs;
//-----------------------------------------------------------
// output assigns
//-----------------------------------------------------------
axi_chip2chip_v4_2_asitv10_axisc_register_slice #
(
   .C_FAMILY     ( C_FAMILY ),
   .C_DATA_WIDTH ( ADDR_WIDTH+PROT_WIDTH ),
   .C_REG_CONFIG ( 32'h 1 )
) awch_reg_slice_inst
(
 .ACLK           ( axi_aclk ),
 .ARESET         ( axi_reset ),
 .ACLKEN         ( 1'b 1 ),
 .S_PAYLOAD_DATA ( aw_data[ADDR_WIDTH+PROT_WIDTH-1:0] ),
 .S_VALID        ( axi_awvalid_rs ),
 .S_READY        ( axi_awready_rs ),
 .M_PAYLOAD_DATA ( { axi_awprot, axi_awaddr } ),
 .M_VALID        ( axi_awvalid ),
 .M_READY        ( axi_awready )
);
axi_chip2chip_v4_2_asitv10_axisc_register_slice #
(
   .C_FAMILY     ( C_FAMILY ),
   .C_DATA_WIDTH ( ADDR_WIDTH+PROT_WIDTH ),
   .C_REG_CONFIG ( 32'h 1 )
) arch_reg_slice_inst
(
 .ACLK           ( axi_aclk ),
 .ARESET         ( axi_reset ),
 .ACLKEN         ( 1'b 1 ),
 .S_PAYLOAD_DATA ( ar_data[ADDR_WIDTH+PROT_WIDTH-1:0] ),
 .S_VALID        ( axi_arvalid_rs ),
 .S_READY        ( axi_arready_rs ),
 .M_PAYLOAD_DATA ( { axi_arprot, axi_araddr } ),
 .M_VALID        ( axi_arvalid ),
 .M_READY        ( axi_arready )
);
axi_chip2chip_v4_2_asitv10_axisc_register_slice #
(
   .C_FAMILY     ( C_FAMILY ),
   .C_DATA_WIDTH ( DATA_WIDTH+STB_WIDTH ),
   .C_REG_CONFIG ( 32'h 1 )
) wch_reg_slice_inst
(
 .ACLK           ( axi_aclk ),
 .ARESET         ( axi_reset ),
 .ACLKEN         ( 1'b 1 ),
 .S_PAYLOAD_DATA ( w_data[DATA_WIDTH+STB_WIDTH-1:0] ),
 .S_VALID        ( axi_wvalid_rs ),
 .S_READY        ( axi_wready_rs ),
 .M_PAYLOAD_DATA ( { axi_wstb, axi_wdata } ),
 .M_VALID        ( axi_wvalid ),
 .M_READY        ( axi_wready )
);
//-----------------------------------------------------------
// tdm tranmit machine
//-----------------------------------------------------------
axi_chip2chip_v4_2_lite_tdm
#(
     .DIN_WIDTH     ( INT_DATA_WIDTH ),
     .DOUT_WIDTH    ( PHY_DATA_WIDTH ),
     .NO_OF_CHAN    ( 2 )
) axi_chip2chip_lite_tx_tdm_inst
(
     .clk           ( axi_aclk ),
     .reset         ( axi_reset ),
     .use_ch0       ( 1'b 1 ),
     .ch0_data_in   ( r_data[INT_DATA_WIDTH-1:0] ),
     .ch0_valid_in  ( axi_rvalid ),
     .ch0_ready_out ( axi_rready ),
     .use_ch1       ( 1'b 1 ),
     .ch1_data_in   ( b_data[INT_DATA_WIDTH-1:0] ),
     .ch1_valid_in  ( axi_bvalid ),
     .ch1_ready_out ( axi_bready ),
     .use_ch2       ( 1'b 0 ),
     .ch2_data_in   ( { INT_DATA_WIDTH { 1'b 0 } } ),
     .ch2_valid_in  ( 1'b 0 ),
     .ch2_ready_out ( ),
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
     .ch0_data_out  ( aw_data[INT_DATA_WIDTH-1:0] ),
     .ch0_valid_out ( axi_awvalid_rs ),
     .ch0_ready_in  ( axi_awready_rs ),
     .ch1_data_out  ( ar_data[INT_DATA_WIDTH-1:0] ),
     .ch1_valid_out ( axi_arvalid_rs ),
     .ch1_ready_in  ( axi_arready_rs ),
     .ch2_data_out  ( w_data[INT_DATA_WIDTH-1:0]),
     .ch2_valid_out ( axi_wvalid_rs ),
     .ch2_ready_in  ( axi_wready_rs ),
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
) axi_chip2chip_lite_slave_tx_fifo
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
) axi_chip2chip_lite_slave_rx_fifo
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
