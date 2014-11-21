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
module axi_chip2chip_v4_2
#(

    parameter   C_FAMILY            = "kintex7",
    parameter   C_INSTANCE          = "axi_c2c",
    parameter   C_SIMULATION        = 0,

    // global cfg
    parameter   C_MASTER_FPGA       = 0,  // 0 -> slave fpga, 1 -> master fpga
    parameter   C_AXI_BUS_TYPE      = 0,  // 0 -> AXI MM, 1 -> AXI Lite, 2 -> AXI Stream

    // clocking mode selection
    parameter   C_COMMON_CLK        = 0,  // 0 -> use phy clock and async fifo. 1 -> use axi clock on phy also

    // PHY Config
    parameter   C_INTERFACE_TYPE    = 1,  // 0 -> sdr, 1 -> ddr, 2 -> aurora
    parameter   C_INTERFACE_MODE    = 2,  // 0 -> 1:1, 1 -> 2:1, 2 -> 4:1
    parameter   C_NUM_OF_IO         = 20, // total pins (input + output + 2 clock pins)
    parameter   C_SELECTIO_PHY_CLK  = 100,// Freq in Mhz for use in DDR mode
    parameter   C_INCLUDE_AXILITE   = 0,  // 0 -> not included, 1 -> AXI Lite Slave, 2 -> AXI Lite Master

    // PHY Config
    parameter   C_AXI_DATA_WIDTH    = 32, // 32 or 64 supported
    parameter   C_AXI_ID_WIDTH      = 6,  // fixed
    parameter   C_AXI_WUSER_WIDTH   = 4,  // fixed

    // optional configuration
    parameter   C_DISABLE_DESKEW    = 0,  // disable calibration deskew in select IO mode if set to 1
    parameter   C_DISABLE_CLK_SHIFT = 0,  // disable clock shift of 90 or 180 deg
    parameter   C_USE_DIFF_CLK      = 0,  // enable usage of differential clock
    parameter   C_USE_DIFF_IO       = 0,  // enable usage of differential IO data

    // Aurora and Ecc config
    parameter   C_AURORA_WIDTH      = 64, // axi data * 2
    parameter   C_ECC_ENABLE        = 1,  // enable ECC insertion valid in Aurora only
    // AXI Bus config
    parameter   C_AXI_STB_WIDTH     = 4,  // 4 or 8 supported

    // Fixed AXI
    parameter   C_AXI_ADDR_WIDTH    = 32, // fixed
    parameter   C_AXI_LEN_WIDTH     = 8,  // fixed
    parameter   C_AXI_SIZE_WIDTH    = 2,  // fixed
    parameter   C_AXI_BRST_WIDTH    = 2,  // fixed
    parameter   C_AXI_RESP_WIDTH    = 2,  // fixed
    parameter   C_INTERRUPT_WIDTH   = 4,

    // AXI Lite interface
    parameter   C_AXI_LITE_ADDR_WIDTH = 32, // fixed
    parameter   C_AXI_LITE_PROT_WIDTH = 2,  // fixed
    parameter   C_AXI_LITE_DATA_WIDTH = 32, // fixed
    parameter   C_AXI_LITE_STB_WIDTH  = 4,  // fixed
    parameter   C_AXI_LITE_RESP_WIDTH = 2   // fixed
)
(

  // C_AXI Master FPGA interface
  input  wire                             s_aclk,
  input  wire                             s_aresetn,

  input  wire [C_AXI_ID_WIDTH-1:0]        s_axi_awid,
  input  wire [C_AXI_ADDR_WIDTH-1:0]      s_axi_awaddr,
  input  wire [C_AXI_LEN_WIDTH-1:0]       s_axi_awlen,
  input  wire [C_AXI_SIZE_WIDTH-1:0]      s_axi_awsize,
  input  wire [C_AXI_BRST_WIDTH-1:0]      s_axi_awburst,
  input  wire                             s_axi_awvalid,
  output wire                             s_axi_awready,
  input  wire [C_AXI_WUSER_WIDTH-1:0]     s_axi_wuser,
  input  wire [C_AXI_DATA_WIDTH-1:0]      s_axi_wdata,
  input  wire [C_AXI_STB_WIDTH-1:0]       s_axi_wstrb,
  input  wire                             s_axi_wlast,
  input  wire                             s_axi_wvalid,
  output wire                             s_axi_wready,
  output wire [C_AXI_ID_WIDTH-1:0]        s_axi_bid,
  output wire [C_AXI_RESP_WIDTH-1:0]      s_axi_bresp,
  output wire                             s_axi_bvalid,
  input  wire                             s_axi_bready,

  input  wire [C_AXI_ID_WIDTH-1:0]        s_axi_arid,
  input  wire [C_AXI_ADDR_WIDTH-1:0]      s_axi_araddr,
  input  wire [C_AXI_LEN_WIDTH-1:0]       s_axi_arlen,
  input  wire [C_AXI_SIZE_WIDTH-1:0]      s_axi_arsize,
  input  wire [C_AXI_BRST_WIDTH-1:0]      s_axi_arburst,
  input  wire                             s_axi_arvalid,
  output wire                             s_axi_arready,
  output wire [C_AXI_ID_WIDTH-1:0]        s_axi_rid,
  output wire [C_AXI_DATA_WIDTH-1:0]      s_axi_rdata,
  output wire [C_AXI_RESP_WIDTH-1:0]      s_axi_rresp,
  output wire                             s_axi_rlast,
  output wire                             s_axi_rvalid,
  input  wire                             s_axi_rready,

  input  wire [C_INTERRUPT_WIDTH-1:0]     axi_c2c_m2s_intr_in,
  output wire [C_INTERRUPT_WIDTH-1:0]     axi_c2c_s2m_intr_out,


  // C_AXI slave FPGA interface
  input  wire                             m_aclk,
  input  wire                             m_aresetn,

  output wire [C_AXI_ID_WIDTH-1:0]        m_axi_awid,
  output wire [C_AXI_ADDR_WIDTH-1:0]      m_axi_awaddr,
  output wire [C_AXI_LEN_WIDTH-1:0]       m_axi_awlen,
  output wire [C_AXI_SIZE_WIDTH-1:0]      m_axi_awsize,
  output wire [C_AXI_BRST_WIDTH-1:0]      m_axi_awburst,
  output wire                             m_axi_awvalid,
  input  wire                             m_axi_awready,
  output wire [C_AXI_WUSER_WIDTH-1:0]     m_axi_wuser,
  output wire [C_AXI_DATA_WIDTH-1:0]      m_axi_wdata,
  output wire [C_AXI_STB_WIDTH-1:0]       m_axi_wstrb,
  output wire                             m_axi_wlast,
  output wire                             m_axi_wvalid,
  input  wire                             m_axi_wready,
  input  wire [C_AXI_ID_WIDTH-1:0]        m_axi_bid,
  input  wire [C_AXI_RESP_WIDTH-1:0]      m_axi_bresp,
  input  wire                             m_axi_bvalid,
  output wire                             m_axi_bready,

  output wire [C_AXI_ID_WIDTH-1:0]        m_axi_arid,
  output wire [C_AXI_ADDR_WIDTH-1:0]      m_axi_araddr,
  output wire [C_AXI_LEN_WIDTH-1:0]       m_axi_arlen,
  output wire [C_AXI_SIZE_WIDTH-1:0]      m_axi_arsize,
  output wire [C_AXI_BRST_WIDTH-1:0]      m_axi_arburst,
  output wire                             m_axi_arvalid,
  input  wire                             m_axi_arready,
  input  wire [C_AXI_ID_WIDTH-1:0]        m_axi_rid,
  input  wire [C_AXI_DATA_WIDTH-1:0]      m_axi_rdata,
  input  wire [C_AXI_RESP_WIDTH-1:0]      m_axi_rresp,
  input  wire                             m_axi_rlast,
  input  wire                             m_axi_rvalid,
  output wire                             m_axi_rready,

  input  wire [C_INTERRUPT_WIDTH-1:0]     axi_c2c_s2m_intr_in,
  output wire [C_INTERRUPT_WIDTH-1:0]     axi_c2c_m2s_intr_out,

  // delay controller reference clock
  input  wire                             idelay_ref_clk,
  input  wire                             axi_c2c_phy_clk,

  // Select IO phy interface
  output wire                             axi_c2c_selio_tx_clk_out,
  output wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_tx_data_out,
  input  wire                             axi_c2c_selio_rx_clk_in,
  input  wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_rx_data_in,

  // Select IO Differential PHY interface
  output wire                             axi_c2c_selio_tx_diff_clk_out_p,
  output wire                             axi_c2c_selio_tx_diff_clk_out_n,
  output wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_tx_diff_data_out_p,
  output wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_tx_diff_data_out_n,
  input  wire                             axi_c2c_selio_rx_diff_clk_in_p,
  input  wire                             axi_c2c_selio_rx_diff_clk_in_n,
  input  wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_rx_diff_data_in_p,
  input  wire [((C_NUM_OF_IO/2)-1)-1:0]   axi_c2c_selio_rx_diff_data_in_n,

  // FPGA aurora interface
  input  wire                             axi_c2c_aurora_channel_up,
  input  wire                             axi_c2c_aurora_tx_tready,
  output wire [C_AURORA_WIDTH-1:0]        axi_c2c_aurora_tx_tdata,
  output wire                             axi_c2c_aurora_tx_tvalid,
  input  wire [C_AURORA_WIDTH-1:0]        axi_c2c_aurora_rx_tdata,
  input  wire                             axi_c2c_aurora_rx_tvalid,

  output wire                             aurora_do_cc,
  input  wire                             aurora_pma_init_in,
  input  wire                             aurora_init_clk,
  output wire                             aurora_pma_init_out,
  input  wire                             aurora_mmcm_not_locked,
  output wire                             aurora_reset_pb,

  output wire                             axi_c2c_config_error_out,
  output wire                             axi_c2c_link_status_out,
  output wire                             axi_c2c_multi_bit_error_out,
  output wire                             axi_c2c_link_error_out,

  output wire                             m_aclk_out,// common clocking output

  // AXI LITE Slave interface - for master AXI Lite interface
  input  wire                             s_axi_lite_aclk,
  // input  wire                             s_axi_lite_aresetn,

  input  wire [C_AXI_LITE_ADDR_WIDTH-1:0] s_axi_lite_awaddr,
  input  wire [C_AXI_LITE_PROT_WIDTH-1:0] s_axi_lite_awprot,
  input  wire                             s_axi_lite_awvalid,
  output wire                             s_axi_lite_awready,
  input  wire [C_AXI_LITE_DATA_WIDTH-1:0] s_axi_lite_wdata,
  input  wire [C_AXI_LITE_STB_WIDTH-1:0]  s_axi_lite_wstrb,
  input  wire                             s_axi_lite_wvalid,
  output wire                             s_axi_lite_wready,
  output wire [C_AXI_LITE_RESP_WIDTH-1:0] s_axi_lite_bresp,
  output wire                             s_axi_lite_bvalid,
  input  wire                             s_axi_lite_bready,

  input  wire [C_AXI_LITE_ADDR_WIDTH-1:0] s_axi_lite_araddr,
  input  wire [C_AXI_LITE_PROT_WIDTH-1:0] s_axi_lite_arprot,
  input  wire                             s_axi_lite_arvalid,
  output wire                             s_axi_lite_arready,
  output wire [C_AXI_LITE_DATA_WIDTH-1:0] s_axi_lite_rdata,
  output wire [C_AXI_LITE_RESP_WIDTH-1:0] s_axi_lite_rresp,
  output wire                             s_axi_lite_rvalid,
  input  wire                             s_axi_lite_rready,

  // AXI LITE Master interface - for slave AXI Lite interface
  input  wire                             m_axi_lite_aclk,
  // input  wire                             m_axi_lite_aresetn,

  output wire [C_AXI_LITE_ADDR_WIDTH-1:0] m_axi_lite_awaddr,
  output wire [C_AXI_LITE_PROT_WIDTH-1:0] m_axi_lite_awprot,
  output wire                             m_axi_lite_awvalid,
  input  wire                             m_axi_lite_awready,
  output wire [C_AXI_LITE_DATA_WIDTH-1:0] m_axi_lite_wdata,
  output wire [C_AXI_LITE_STB_WIDTH-1:0]  m_axi_lite_wstrb,
  output wire                             m_axi_lite_wvalid,
  input  wire                             m_axi_lite_wready,
  input  wire [C_AXI_LITE_RESP_WIDTH-1:0] m_axi_lite_bresp,
  input  wire                             m_axi_lite_bvalid,
  output wire                             m_axi_lite_bready,

  output wire [C_AXI_LITE_ADDR_WIDTH-1:0] m_axi_lite_araddr,
  output wire [C_AXI_LITE_PROT_WIDTH-1:0] m_axi_lite_arprot,
  output wire                             m_axi_lite_arvalid,
  input  wire                             m_axi_lite_arready,
  input  wire [C_AXI_LITE_DATA_WIDTH-1:0] m_axi_lite_rdata,
  input  wire [C_AXI_LITE_RESP_WIDTH-1:0] m_axi_lite_rresp,
  input  wire                             m_axi_lite_rvalid,
  output wire                             m_axi_lite_rready
);

//----------------------------------------------------------------------
// C_AXI_SIZE_WIDTH modification for axi interconnect constant parameter of 3
//----------------------------------------------------------------------
localparam C_AXI_SIZE_WIDTH_INTERNAL = ( C_AXI_DATA_WIDTH == 32 ) ? 2 :
                                       ( C_AXI_DATA_WIDTH == 64 ) ? 2 : 3;

//----------------------------------------------------------------------
// C_SYNC_STAGE localparam defines the number of sync flops
// to be used in x-clock fifo. set to 2 by default. change to 3 on need.
//----------------------------------------------------------------------
//localparam C_SYNC_STAGE = 6;
localparam C_SYNC_STAGE = ( C_INTERFACE_TYPE    >= 2 ) ? 3 :  //Aurora - fix to 3 stages
                          ( C_SELECTIO_PHY_CLK < 100 ) ? 2 :  //SelectIO - vary MTBF stages according to the input frequency
                          ( C_SELECTIO_PHY_CLK < 150 ) ? 3 :
                          ( C_SELECTIO_PHY_CLK < 200 ) ? 4 :
                          ( C_SELECTIO_PHY_CLK < 350 ) ? 5 : 6; //Stages=6 when PHY frequency = 400 MHz

//----------------------------------------------------------------------
// internally computed
//----------------------------------------------------------------------
localparam   C_PHY_SELECT        = ( C_INTERFACE_TYPE  >= 2 ) ? 1 : 0;  // 0 -> select IO, 1 -> Aurora 64/66
localparam   C_SELECTIO_DDR      = ( C_INTERFACE_TYPE  == 1 ) ? 1 : 0;  // 0 -> select IO SDR, 1-> select IO DDR mode
localparam   C_WIDTH_CONVERSION  = ( C_INTERFACE_MODE  == 0 ) ? 1 :     // 1 No mux; 2 2:1 mux; 3 3:1 mux; 4 4:1 mux
                                   ( C_INTERFACE_MODE  == 1 ) ? 2 : 
                                   ( C_INTERFACE_MODE  == 2 ) ? 4 :
                                   ( C_INTERFACE_MODE  == 3 ) ? 3 : 1;
localparam   C_SELECTIO_WIDTH    = ( ( C_NUM_OF_IO / 2 ) - 1);

//----------------------------------------------------------------------
// local parameter computations
//----------------------------------------------------------------------
localparam PHY_DATA_WIDTH    = ( C_PHY_SELECT == 0 ) ? ( ( C_SELECTIO_DDR == 0 ) ? C_SELECTIO_WIDTH : C_SELECTIO_WIDTH*2 ) : C_AURORA_WIDTH;
// no packing / unpacking for addresses in Aurora mode
//12May2014 Enabled packing for >6bit id width support for addresses when aurora_width is 64
//localparam ADDR_MUX_RATIO    = ( C_PHY_SELECT == 0 ) ? C_WIDTH_CONVERSION : 1;
localparam ADDR_MUX_RATIO    = ( C_PHY_SELECT == 0 ) ? C_WIDTH_CONVERSION :
			       ( C_PHY_SELECT == 1 && C_AXI_ID_WIDTH > 6 && C_AXI_ID_WIDTH <= 12 && C_AURORA_WIDTH ==64) ? C_WIDTH_CONVERSION : 1;
//12May2014 Disabled packing for data channel if 32bit AXI && >6bit id width support for aurora
//localparam DATA_MUX_RATIO    = C_WIDTH_CONVERSION;
localparam DATA_MUX_RATIO    = ( C_PHY_SELECT == 1 && C_AXI_ID_WIDTH > 6 && C_AXI_ID_WIDTH <= 12 && C_AXI_DATA_WIDTH == 32 && C_AURORA_WIDTH ==64) ? 1 :C_WIDTH_CONVERSION;


//----------------------------------------------------------------------
// address fifo size computation - rounded up to match packing ratio
//----------------------------------------------------------------------
localparam AFIFO_DATA_SIZE    = C_AXI_ID_WIDTH + C_AXI_ADDR_WIDTH  + C_AXI_LEN_WIDTH  + C_AXI_SIZE_WIDTH_INTERNAL + C_AXI_BRST_WIDTH;
localparam AFIFO_DATA_SIZE_M2 = ( AFIFO_DATA_SIZE % 2);
localparam AFIFO_DATA_SIZE_M3 = ( AFIFO_DATA_SIZE % 3);
localparam AFIFO_DATA_SIZE_M4 = ( AFIFO_DATA_SIZE % 4);
localparam AFIFO_WIDTH        = ( ADDR_MUX_RATIO == 1 ) ? AFIFO_DATA_SIZE :
                                  ( ( ADDR_MUX_RATIO  == 2 ) ?  ( AFIFO_DATA_SIZE + AFIFO_DATA_SIZE_M2 ) :
                                    ( ( ADDR_MUX_RATIO  == 3 ) ?  ( ( AFIFO_DATA_SIZE_M3 == 0 ) ?  AFIFO_DATA_SIZE : 
                                                                                                 ( AFIFO_DATA_SIZE + (3-AFIFO_DATA_SIZE_M3) ) ) :
                                      ( ( AFIFO_DATA_SIZE_M4 == 0 ) ?  AFIFO_DATA_SIZE : 
                                                                     ( AFIFO_DATA_SIZE+(4-AFIFO_DATA_SIZE_M4) ) ) ) );
localparam AFIFO_TIE_WIDTH    = ( AFIFO_WIDTH - AFIFO_DATA_SIZE ) + 1;
//----------------------------------------------------------------------
// wdata fifo size computation - rounded up to match packing ratio (added 1 for wlast)
//----------------------------------------------------------------------
localparam WFIFO_DATA_SIZE    = C_AXI_WUSER_WIDTH + C_AXI_STB_WIDTH  + C_AXI_DATA_WIDTH + 1;
localparam WFIFO_DATA_SIZE_M2 = ( WFIFO_DATA_SIZE % 2);
localparam WFIFO_DATA_SIZE_M3 = ( WFIFO_DATA_SIZE % 3);
localparam WFIFO_DATA_SIZE_M4 = ( WFIFO_DATA_SIZE % 4);
localparam WFIFO_WIDTH        = ( DATA_MUX_RATIO == 1 ) ? WFIFO_DATA_SIZE :
                                  ( ( DATA_MUX_RATIO  == 2 ) ?  ( WFIFO_DATA_SIZE + WFIFO_DATA_SIZE_M2 ) :
                                    ( ( DATA_MUX_RATIO  == 3 ) ?  ( ( WFIFO_DATA_SIZE_M3 == 0 ) ?  WFIFO_DATA_SIZE : 
                                                                                                 ( WFIFO_DATA_SIZE + (3-WFIFO_DATA_SIZE_M3) ) ) :
                                      ( ( WFIFO_DATA_SIZE_M4 == 0 ) ?  WFIFO_DATA_SIZE : 
                                                                     ( WFIFO_DATA_SIZE+(4-WFIFO_DATA_SIZE_M4) ) ) ) );
localparam WFIFO_TIE_WIDTH    = ( WFIFO_WIDTH - WFIFO_DATA_SIZE ) + 1;
//----------------------------------------------------------------------
// rdata fifo size computation - rounded up to match packing ratio (added 1 for wlast)
//----------------------------------------------------------------------
localparam RFIFO_DATA_SIZE    = C_AXI_ID_WIDTH + C_AXI_RESP_WIDTH + C_AXI_DATA_WIDTH + 1;
localparam RFIFO_DATA_SIZE_M2 = ( RFIFO_DATA_SIZE % 2);
localparam RFIFO_DATA_SIZE_M3 = ( RFIFO_DATA_SIZE % 3);
localparam RFIFO_DATA_SIZE_M4 = ( RFIFO_DATA_SIZE % 4);
localparam RFIFO_WIDTH        = ( DATA_MUX_RATIO == 1 ) ? RFIFO_DATA_SIZE :
                                  ( ( DATA_MUX_RATIO  == 2 ) ?  ( RFIFO_DATA_SIZE + RFIFO_DATA_SIZE_M2 ) :
                                    ( ( DATA_MUX_RATIO  == 3 ) ?  ( ( RFIFO_DATA_SIZE_M3 == 0 ) ?  RFIFO_DATA_SIZE : 
                                                                                                 ( RFIFO_DATA_SIZE + (3-RFIFO_DATA_SIZE_M3) ) ) :
                                      ( ( RFIFO_DATA_SIZE_M4 == 0 ) ?  RFIFO_DATA_SIZE : 
                                                                     ( RFIFO_DATA_SIZE+(4-RFIFO_DATA_SIZE_M4) ) ) ) );
localparam RFIFO_TIE_WIDTH    = ( RFIFO_WIDTH - RFIFO_DATA_SIZE ) + 1;
//----------------------------------------------------------------------
// resp fifo size computation - rounded up to match packing ratio
//----------------------------------------------------------------------
localparam BFIFO_DATA_SIZE   = C_AXI_ID_WIDTH + C_AXI_RESP_WIDTH;
localparam BFIFO_WIDTH       = BFIFO_DATA_SIZE;
//----------------------------------------------------------------------
// Define the flow control channel widths
//----------------------------------------------------------------------
localparam AWB_FC_WIDTH      = 2;
localparam RB_FC_WIDTH       = 3;
localparam TDM_ID_WIDTH      = 2;
localparam TDM_VAL_BITS      = 1;
localparam PHY_CTRL_WIDTH    = 3;

//----------------------------------------------------------------------
// define internal signals for splitting the awsize and arsize bus for 32, 64 bit cases
//----------------------------------------------------------------------
wire [C_AXI_SIZE_WIDTH_INTERNAL-1:0]      m_axi_awsize_internal;
wire [C_AXI_SIZE_WIDTH_INTERNAL-1:0]      m_axi_arsize_internal;
wire [C_AXI_SIZE_WIDTH_INTERNAL-1:0]      s_axi_awsize_internal;
wire [C_AXI_SIZE_WIDTH_INTERNAL-1:0]      s_axi_arsize_internal;

assign m_axi_awsize          =  ( C_AXI_DATA_WIDTH == 32 ) ? { 1'b0, m_axi_awsize_internal } :
                                ( C_AXI_DATA_WIDTH == 64 ) ? { 1'b0, m_axi_awsize_internal } : m_axi_awsize_internal;
assign m_axi_arsize          =  ( C_AXI_DATA_WIDTH == 32 ) ? { 1'b0, m_axi_arsize_internal } :
                                ( C_AXI_DATA_WIDTH == 64 ) ? { 1'b0, m_axi_arsize_internal } : m_axi_arsize_internal;

assign s_axi_awsize_internal =  ( C_AXI_DATA_WIDTH == 32 ) ? s_axi_awsize[1:0]:
                                ( C_AXI_DATA_WIDTH == 64 ) ? s_axi_awsize[1:0]: s_axi_awsize;
assign s_axi_arsize_internal =  ( C_AXI_DATA_WIDTH == 32 ) ? s_axi_arsize[1:0]:
                                ( C_AXI_DATA_WIDTH == 64 ) ? s_axi_arsize[1:0]: s_axi_arsize;
//----------------------------------------------------------------------
// define one bit extra wires for concat - avoid 0 concat problems
// response has no muxing
//----------------------------------------------------------------------
wire [AFIFO_WIDTH:0]             awfifo_data;
wire [AFIFO_WIDTH:0]             arfifo_data;
wire [WFIFO_WIDTH:0]             wfifo_data;
wire [RFIFO_WIDTH:0]             rfifo_data;
wire [BFIFO_WIDTH-1:0]           bfifo_data;
//----------------------------------------------------------------------
// tie off wires for concat
//----------------------------------------------------------------------
wire [AFIFO_TIE_WIDTH-1:0]       awfifo_tie = { AFIFO_TIE_WIDTH { 1'b 0 } };
wire [AFIFO_TIE_WIDTH-1:0]       arfifo_tie = { AFIFO_TIE_WIDTH { 1'b 0 } };
wire [WFIFO_TIE_WIDTH-1:0]       wfifo_tie  = { WFIFO_TIE_WIDTH { 1'b 0 } };
wire [RFIFO_TIE_WIDTH-1:0]       rfifo_tie  = { RFIFO_TIE_WIDTH { 1'b 0 } };
//------------------------------------------------------------
// phy interface wires
//------------------------------------------------------------
wire                             tx_user_clk;
wire                             tx_user_reset;
wire                             tx_phy_ready;
wire  [PHY_CTRL_WIDTH-1:0]       tx_phy_ctrl;
wire                             tx_user_data_valid;
wire  [PHY_DATA_WIDTH-1:0]       tx_user_data;
wire                             tx_user_data_ready;
wire                             rx_user_clk;
wire                             rx_user_reset;
wire                             rx_phy_ready;
wire                             rx_user_data_valid;
wire  [PHY_DATA_WIDTH-1:0]       rx_user_data;

wire                             slave_fpga_axi_clk;
wire                             slave_fpga_axi_reset_n;
wire                             master_ecc_error;
wire                             calib_error_out;
//------------------------------------------------------------
// derive unique ID based on config for PHY HS
//------------------------------------------------------------
wire         axi_phy_code    = ( C_PHY_SELECT == 0 ) ? 1'b 0 : 1'b 1;

wire  [2:0]  axi_dwidth_code = ( C_AXI_DATA_WIDTH == 32  ) ? 3'h 1 :
                               ( ( C_AXI_DATA_WIDTH == 64  ) ? 3'h 2 :
                                 ( ( C_AXI_DATA_WIDTH == 128 ) ? 3'h 3 :
                                   ( ( C_AXI_DATA_WIDTH == 256 ) ? 3'h 4 :
                                     ( ( C_AXI_DATA_WIDTH == 512 ) ? 3'h 5 : 3'h 6 ) ) ) );
wire  [2:0]  axi_conv_code   = ( C_WIDTH_CONVERSION == 1 ) ? 3'h 1 :
                               ( ( C_WIDTH_CONVERSION == 2 ) ? 3'h 2 : 3'h 4 );

wire         axi_ddr_phy     = ( ( C_PHY_SELECT == 0 ) & ( C_SELECTIO_DDR == 1 ) ) ? 1'b 1 : 1'b 0;

wire  [7:0]  axi_phy_width   = ( C_PHY_SELECT == 0 ) ? C_SELECTIO_WIDTH : C_AURORA_WIDTH;

wire  [15:0] config_id       = { axi_phy_width, axi_ddr_phy, axi_conv_code, axi_dwidth_code, axi_phy_code };
//------------------------------------------------------------
// axi_lite interface wires
//------------------------------------------------------------
localparam AXILITE_WIDTH = 20; // fixed to 20 always //
wire  [AXILITE_WIDTH-1:0]        axi_lite_tx_data;
wire                             axi_lite_tx_valid;
wire                             axi_lite_tx_ready;
wire  [AXILITE_WIDTH-1:0]        axi_lite_rx_data;
wire                             axi_lite_rx_valid;
wire                             lite_aresetn = axi_c2c_link_status_out;
wire                             lite_sync_reset;
//------------------------------------------------------------
// thin axi master fpga instantiation
//------------------------------------------------------------
generate if ( C_MASTER_FPGA == 1 )
begin: master_fpga_gen
   assign awfifo_data = { awfifo_tie, s_axi_awaddr, s_axi_awburst, s_axi_awsize_internal, s_axi_awlen, s_axi_awid };
   assign arfifo_data = { arfifo_tie, s_axi_araddr, s_axi_arburst, s_axi_arsize_internal, s_axi_arlen, s_axi_arid };
   assign wfifo_data  = { wfifo_tie, s_axi_wdata , s_axi_wstrb, s_axi_wlast, s_axi_wuser };
   assign { s_axi_rdata , s_axi_rresp, s_axi_rlast, s_axi_rid } = rfifo_data[RFIFO_DATA_SIZE-1:0];
   assign { s_axi_bresp , s_axi_bid } = bfifo_data;

   assign axi_c2c_multi_bit_error_out = ( C_PHY_SELECT == 1 ) ? master_ecc_error : calib_error_out;
   //------------------------------------------------------------
   // thin axi master logic
   //------------------------------------------------------------
   axi_chip2chip_v4_2_master
   #(
      .C_FAMILY                ( C_FAMILY ),
      .C_PHY_SELECT            ( C_PHY_SELECT ),
      .C_ECC_ENABLE            ( C_ECC_ENABLE ),
      .C_COMMON_CLK            ( C_COMMON_CLK ),
      .AFIFO_WIDTH             ( AFIFO_WIDTH ),
      .WFIFO_WIDTH             ( WFIFO_WIDTH ),
      .RFIFO_WIDTH             ( RFIFO_WIDTH ),
      .BFIFO_WIDTH             ( BFIFO_WIDTH ),
      .ADDR_MUX_RATIO          ( ADDR_MUX_RATIO ),
      .DATA_MUX_RATIO          ( DATA_MUX_RATIO ),
      .PHY_DATA_WIDTH          ( PHY_DATA_WIDTH ),
      .PHY_CTRL_WIDTH          ( PHY_CTRL_WIDTH ),
      .C_INTERRUPT_WIDTH       ( C_INTERRUPT_WIDTH ),
      .C_SYNC_STAGE            ( C_SYNC_STAGE ),
      .C_INCLUDE_AXILITE       ( C_INCLUDE_AXILITE ),
      .C_AXILITE_WIDTH         ( AXILITE_WIDTH )

   )
   axi_chip2chip_master_inst
   (
      .axi_aclk                ( s_aclk ),
      .axi_reset_n             ( s_aresetn ),

      .config_id               ( config_id ),

      .intr_in                 ( axi_c2c_m2s_intr_in ),
      .intr_out                ( axi_c2c_s2m_intr_out ),

      .awfifo_data             ( awfifo_data[AFIFO_WIDTH-1:0] ),
      .axi_awvalid             ( s_axi_awvalid ),
      .axi_awready             ( s_axi_awready ),

      .arfifo_data             ( arfifo_data[AFIFO_WIDTH-1:0] ),
      .axi_arvalid             ( s_axi_arvalid ),
      .axi_arready             ( s_axi_arready ),

      .wfifo_data              ( wfifo_data[WFIFO_WIDTH-1:0] ),
      .axi_wvalid              ( s_axi_wvalid ),
      .axi_wready              ( s_axi_wready ),

      .rfifo_data              ( rfifo_data[RFIFO_WIDTH-1:0] ),
      .axi_rvalid              ( s_axi_rvalid ),
      .axi_rready              ( s_axi_rready ),

      .bfifo_data              ( bfifo_data[BFIFO_WIDTH-1:0] ),
      .axi_bvalid              ( s_axi_bvalid ),
      .axi_bready              ( s_axi_bready ),

      .tx_user_clk             ( tx_user_clk ),
      .tx_user_reset           ( tx_user_reset ),
      .tx_phy_ready            ( tx_phy_ready ),
      .tx_phy_ctrl             ( tx_phy_ctrl ),
      .tx_user_data_valid      ( tx_user_data_valid ),
      .tx_user_data            ( tx_user_data ),
      .tx_user_data_ready      ( tx_user_data_ready ),

      .rx_user_clk             ( rx_user_clk ),
      .rx_user_reset           ( rx_user_reset ),
      .rx_phy_ready            ( rx_phy_ready ),
      .rx_user_data_valid      ( rx_user_data_valid ),
      .rx_user_data            ( rx_user_data ),

      .ecc_error               ( master_ecc_error ),

      .axi_lite_tx_data        ( axi_lite_tx_data ),
      .axi_lite_tx_valid       ( axi_lite_tx_valid ),
      .axi_lite_tx_ready       ( axi_lite_tx_ready ),
      .axi_lite_rx_data        ( axi_lite_rx_data ),
      .axi_lite_rx_valid       ( axi_lite_rx_valid )
   );

   axi_chip2chip_v4_2_phy_if
   #(
       .C_FAMILY               ( C_FAMILY ),
       .C_SIMULATION           ( C_SIMULATION),
       .C_SYNC_STAGE           ( C_SYNC_STAGE ),
       .C_AXI_MASTER_PHY       ( 1 ),
       .C_PHY_SELECT           ( C_PHY_SELECT ),
       .C_SELECTIO_DDR         ( C_SELECTIO_DDR ),
       .C_AXI_PHY_DATA_WIDTH   ( PHY_DATA_WIDTH ),
       .C_AXI_SIO_IN_WIDTH     ( C_SELECTIO_WIDTH ),
       .C_AXI_SIO_OUT_WIDTH    ( C_SELECTIO_WIDTH ),
       .C_AURORA_WIDTH         ( C_AURORA_WIDTH ),
       .C_AXI_PHY_CTRL_WIDTH   ( PHY_CTRL_WIDTH ),
       .C_AXI_TDM_CTRL_WIDTH   ( RB_FC_WIDTH+2+1 ),
       .C_AXI_TDM_DATA_WIDTH   ( PHY_DATA_WIDTH-RB_FC_WIDTH-2-1 ),
       .C_SELECTIO_PHY_CLK     ( C_SELECTIO_PHY_CLK ),
       .C_COMMON_CLK           ( C_COMMON_CLK ),
       .C_DISABLE_DESKEW       ( C_DISABLE_DESKEW ),
       .C_DISABLE_CLK_SHIFT    ( C_DISABLE_CLK_SHIFT ),
       .C_USE_DIFF_CLK         ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO          ( C_USE_DIFF_IO )
   )
   axi_chip2chip_master_phy_inst
   (
       .axi_aclk                       ( s_aclk ),
       .axi_reset_n                    ( s_aresetn ),
       .config_id                      ( config_id ),

       .idelay_ref_clk                 ( idelay_ref_clk ),
       .axi_c2c_phy_clk                ( axi_c2c_phy_clk ),
       .INIT_clk_i                     ( aurora_init_clk ),
       .pma_init_in                    ( aurora_pma_init_in ),
       .pma_init_out                   ( aurora_pma_init_out),
       .do_cc                          ( aurora_do_cc ),
       .aurora_rst_in                  ( aurora_mmcm_not_locked),
       .aurora_rst_out                 ( aurora_reset_pb),

       .axi_c2c_sio_tx_clk_out         ( axi_c2c_selio_tx_clk_out ),
       .axi_c2c_sio_tx_data_out        ( axi_c2c_selio_tx_data_out ),
       .axi_c2c_sio_tx_diff_clk_out_p  ( axi_c2c_selio_tx_diff_clk_out_p ),
       .axi_c2c_sio_tx_diff_clk_out_n  ( axi_c2c_selio_tx_diff_clk_out_n ),
       .axi_c2c_sio_tx_diff_data_out_p ( axi_c2c_selio_tx_diff_data_out_p ),
       .axi_c2c_sio_tx_diff_data_out_n ( axi_c2c_selio_tx_diff_data_out_n ),

       .axi_c2c_sio_rx_clk_in          ( axi_c2c_selio_rx_clk_in ),
       .axi_c2c_sio_rx_data_in         ( axi_c2c_selio_rx_data_in ),
       .axi_c2c_sio_rx_diff_clk_in_p   ( axi_c2c_selio_rx_diff_clk_in_p ),
       .axi_c2c_sio_rx_diff_clk_in_n   ( axi_c2c_selio_rx_diff_clk_in_n ),
       .axi_c2c_sio_rx_diff_data_in_p  ( axi_c2c_selio_rx_diff_data_in_p ),
       .axi_c2c_sio_rx_diff_data_in_n  ( axi_c2c_selio_rx_diff_data_in_n ),

       .axi_c2c_auro_channel_up        ( axi_c2c_aurora_channel_up ),
       .axi_c2c_auro_tx_tready         ( axi_c2c_aurora_tx_tready ),
       .axi_c2c_auro_tx_tdata          ( axi_c2c_aurora_tx_tdata ),
       .axi_c2c_auro_tx_tvalid         ( axi_c2c_aurora_tx_tvalid ),
       .axi_c2c_auro_rx_tdata          ( axi_c2c_aurora_rx_tdata ),
       .axi_c2c_auro_rx_tvalid         ( axi_c2c_aurora_rx_tvalid ),

       .tx_user_clk                    ( tx_user_clk ),
       .tx_user_reset                  ( tx_user_reset ),
       .tx_phy_ready                   ( tx_phy_ready ),
       .tx_phy_ctrl                    ( tx_phy_ctrl ),

       .tx_user_data_valid             ( tx_user_data_valid ),
       .tx_user_data                   ( tx_user_data ),
       .tx_user_ready                  ( tx_user_data_ready ),

       .rx_user_clk                    ( rx_user_clk ),
       .rx_user_reset                  ( rx_user_reset ),
       .rx_phy_ready                   ( rx_phy_ready ),
       .rx_user_data_valid             ( rx_user_data_valid ),
       .rx_user_data                   ( rx_user_data ),

       .calib_done_out                 ( axi_c2c_link_status_out ),
       .calib_error_out                ( calib_error_out ),
       .phy_error_out                  ( axi_c2c_config_error_out ),
       .link_error_out                 ( axi_c2c_link_error_out )
   );

   //------------------------------------------------------------
   // tie off unused output ports
   //------------------------------------------------------------
   assign m_axi_awid      = { C_AXI_ID_WIDTH   { 1'b 0 } };
   assign m_axi_awaddr    = { C_AXI_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_awlen     = { C_AXI_LEN_WIDTH  { 1'b 0 } };
   assign m_axi_awsize_internal    = { C_AXI_SIZE_WIDTH_INTERNAL { 1'b 0 } };
   assign m_axi_awburst   = { C_AXI_BRST_WIDTH { 1'b 0 } };
   assign m_axi_wuser     = { C_AXI_WUSER_WIDTH { 1'b 0 } };
   assign m_axi_wdata     = { C_AXI_DATA_WIDTH { 1'b 0 } };
   assign m_axi_wstrb     = { C_AXI_STB_WIDTH  { 1'b 0 } };
   assign m_axi_arid      = { C_AXI_ID_WIDTH   { 1'b 0 } };
   assign m_axi_araddr    = { C_AXI_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_arlen     = { C_AXI_LEN_WIDTH  { 1'b 0 } };
   assign m_axi_arsize_internal    = { C_AXI_SIZE_WIDTH_INTERNAL { 1'b 0 } };
   assign m_axi_arburst   = { C_AXI_BRST_WIDTH { 1'b 0 } };
   assign m_axi_awvalid   = 1'b 0;
   assign m_axi_wlast     = 1'b 0;
   assign m_axi_wvalid    = 1'b 0;
   assign m_axi_bready    = 1'b 0;
   assign m_axi_arvalid   = 1'b 0;
   assign m_axi_rready    = 1'b 0;
   assign axi_c2c_m2s_intr_out = { C_INTERRUPT_WIDTH { 1'b 0 } };
end
else if ( C_MASTER_FPGA == 0 )
begin: slave_fpga_gen

   assign { m_axi_awaddr, m_axi_awburst, m_axi_awsize_internal, m_axi_awlen, m_axi_awid } = awfifo_data[AFIFO_DATA_SIZE-1:0];
   assign { m_axi_araddr, m_axi_arburst, m_axi_arsize_internal, m_axi_arlen, m_axi_arid } = arfifo_data[AFIFO_DATA_SIZE-1:0];
   assign { m_axi_wdata , m_axi_wstrb, m_axi_wlast, m_axi_wuser } = wfifo_data[WFIFO_DATA_SIZE-1:0];
   assign rfifo_data  = { rfifo_tie, m_axi_rdata , m_axi_rresp, m_axi_rlast, m_axi_rid };
   assign bfifo_data  = { m_axi_bresp , m_axi_bid };

   //------------------------------------------------------------
   // thin axi slave logic
   //------------------------------------------------------------
   axi_chip2chip_v4_2_slave
   #(
      .C_FAMILY                ( C_FAMILY ),
      .C_PHY_SELECT            ( C_PHY_SELECT ),
      .C_ECC_ENABLE            ( C_ECC_ENABLE ),
      .C_COMMON_CLK            ( C_COMMON_CLK ),
      .AFIFO_WIDTH             ( AFIFO_WIDTH ),
      .WFIFO_WIDTH             ( WFIFO_WIDTH ),
      .RFIFO_WIDTH             ( RFIFO_WIDTH ),
      .BFIFO_WIDTH             ( BFIFO_WIDTH ),
      .ADDR_MUX_RATIO          ( ADDR_MUX_RATIO ),
      .DATA_MUX_RATIO          ( DATA_MUX_RATIO ),
      .PHY_DATA_WIDTH          ( PHY_DATA_WIDTH ),
      .PHY_CTRL_WIDTH          ( PHY_CTRL_WIDTH ),
      .C_INTERRUPT_WIDTH       ( C_INTERRUPT_WIDTH ),
      .C_SYNC_STAGE            ( C_SYNC_STAGE ),
      .C_INCLUDE_AXILITE       ( C_INCLUDE_AXILITE ),
      .C_AXILITE_WIDTH         ( AXILITE_WIDTH )
   )
   axi_chip2chip_slave_inst
   (
      .axi_aclk                ( slave_fpga_axi_clk ),
      .axi_reset_n             ( slave_fpga_axi_reset_n ),
      .config_id               ( config_id ),

      .intr_in                 ( axi_c2c_s2m_intr_in ),
      .intr_out                ( axi_c2c_m2s_intr_out ),

      .awfifo_data             ( awfifo_data[AFIFO_WIDTH-1:0] ),
      .axi_awvalid             ( m_axi_awvalid ),
      .axi_awready             ( m_axi_awready ),

      .arfifo_data             ( arfifo_data[AFIFO_WIDTH-1:0] ),
      .axi_arvalid             ( m_axi_arvalid ),
      .axi_arready             ( m_axi_arready ),

      .wfifo_data              ( wfifo_data[WFIFO_WIDTH-1:0] ),
      .axi_wvalid              ( m_axi_wvalid ),
      .axi_wready              ( m_axi_wready ),

      .rfifo_data              ( rfifo_data[RFIFO_WIDTH-1:0] ),
      .axi_rvalid              ( m_axi_rvalid ),
      .axi_rready              ( m_axi_rready ),

      .bfifo_data              ( bfifo_data[BFIFO_WIDTH-1:0] ),
      .axi_bvalid              ( m_axi_bvalid ),
      .axi_bready              ( m_axi_bready ),

      .tx_user_clk             ( tx_user_clk ),
      .tx_user_reset           ( tx_user_reset ),
      .tx_phy_ready            ( tx_phy_ready ),
      .tx_phy_ctrl             ( tx_phy_ctrl ),
      .tx_user_data_valid      ( tx_user_data_valid ),
      .tx_user_data            ( tx_user_data ),
      .tx_user_data_ready      ( tx_user_data_ready ),

      .rx_user_clk             ( rx_user_clk ),
      .rx_user_reset           ( rx_user_reset ),
      .rx_phy_ready            ( rx_phy_ready ),
      .rx_user_data_valid      ( rx_user_data_valid ),
      .rx_user_data            ( rx_user_data ),

      .axi_lite_tx_data        ( axi_lite_tx_data ),
      .axi_lite_tx_valid       ( axi_lite_tx_valid ),
      .axi_lite_tx_ready       ( axi_lite_tx_ready ),
      .axi_lite_rx_data        ( axi_lite_rx_data ),
      .axi_lite_rx_valid       ( axi_lite_rx_valid )
   );

   axi_chip2chip_v4_2_phy_if
   #(
       .C_FAMILY               ( C_FAMILY ),
       .C_SIMULATION           ( C_SIMULATION),
       .C_SYNC_STAGE           ( C_SYNC_STAGE ),
       .C_AXI_MASTER_PHY       ( 0 ),
       .C_PHY_SELECT           ( C_PHY_SELECT ),
       .C_SELECTIO_DDR         ( C_SELECTIO_DDR ),
       .C_AXI_PHY_DATA_WIDTH   ( PHY_DATA_WIDTH ),
       .C_AXI_SIO_IN_WIDTH     ( C_SELECTIO_WIDTH ),
       .C_AXI_SIO_OUT_WIDTH    ( C_SELECTIO_WIDTH ),
       .C_AURORA_WIDTH         ( C_AURORA_WIDTH ),
       .C_AXI_PHY_CTRL_WIDTH   ( PHY_CTRL_WIDTH ),
       .C_AXI_TDM_CTRL_WIDTH   ( AWB_FC_WIDTH+2+1 ),
       .C_AXI_TDM_DATA_WIDTH   ( PHY_DATA_WIDTH-AWB_FC_WIDTH-2-1 ),
       .C_SELECTIO_PHY_CLK     ( C_SELECTIO_PHY_CLK ),
       .C_COMMON_CLK           ( C_COMMON_CLK ),
       .C_DISABLE_DESKEW       ( C_DISABLE_DESKEW ),
       .C_DISABLE_CLK_SHIFT    ( C_DISABLE_CLK_SHIFT ),
       .C_USE_DIFF_CLK         ( C_USE_DIFF_CLK ),
       .C_USE_DIFF_IO          ( C_USE_DIFF_IO )
   )
   axi_chip2chip_slave_phy_inst
   (
       .axi_aclk                       ( m_aclk ),
       .axi_reset_n                    ( m_aresetn ),
       .config_id                      ( config_id ),

       .idelay_ref_clk                 ( idelay_ref_clk ),
       .axi_c2c_phy_clk                ( axi_c2c_phy_clk ),
       .INIT_clk_i                     ( aurora_init_clk ),
       .pma_init_in                    ( aurora_pma_init_in ),
       .pma_init_out                   ( aurora_pma_init_out),
       .do_cc                          ( aurora_do_cc ),
       .aurora_rst_in                  ( aurora_mmcm_not_locked),
       .aurora_rst_out                 ( aurora_reset_pb),

       .axi_c2c_sio_tx_clk_out         ( axi_c2c_selio_tx_clk_out ),
       .axi_c2c_sio_tx_data_out        ( axi_c2c_selio_tx_data_out ),
       .axi_c2c_sio_tx_diff_clk_out_p  ( axi_c2c_selio_tx_diff_clk_out_p ),
       .axi_c2c_sio_tx_diff_clk_out_n  ( axi_c2c_selio_tx_diff_clk_out_n ),
       .axi_c2c_sio_tx_diff_data_out_p ( axi_c2c_selio_tx_diff_data_out_p ),
       .axi_c2c_sio_tx_diff_data_out_n ( axi_c2c_selio_tx_diff_data_out_n ),

       .axi_c2c_sio_rx_clk_in          ( axi_c2c_selio_rx_clk_in ),
       .axi_c2c_sio_rx_data_in         ( axi_c2c_selio_rx_data_in ),
       .axi_c2c_sio_rx_diff_clk_in_p   ( axi_c2c_selio_rx_diff_clk_in_p ),
       .axi_c2c_sio_rx_diff_clk_in_n   ( axi_c2c_selio_rx_diff_clk_in_n ),
       .axi_c2c_sio_rx_diff_data_in_p  ( axi_c2c_selio_rx_diff_data_in_p ),
       .axi_c2c_sio_rx_diff_data_in_n  ( axi_c2c_selio_rx_diff_data_in_n ),

       .axi_c2c_auro_channel_up        ( axi_c2c_aurora_channel_up ),
       .axi_c2c_auro_tx_tready         ( axi_c2c_aurora_tx_tready ),
       .axi_c2c_auro_tx_tdata          ( axi_c2c_aurora_tx_tdata ),
       .axi_c2c_auro_tx_tvalid         ( axi_c2c_aurora_tx_tvalid ),
       .axi_c2c_auro_rx_tdata          ( axi_c2c_aurora_rx_tdata ),
       .axi_c2c_auro_rx_tvalid         ( axi_c2c_aurora_rx_tvalid ),

       .tx_user_clk                    ( tx_user_clk ),
       .tx_user_reset                  ( tx_user_reset ),
       .tx_phy_ready                   ( tx_phy_ready ),
       .tx_phy_ctrl                    ( tx_phy_ctrl ),

       .tx_user_data_valid             ( tx_user_data_valid ),
       .tx_user_data                   ( tx_user_data ),
       .tx_user_ready                  ( tx_user_data_ready ),

       .rx_user_clk                    ( rx_user_clk ),
       .rx_user_reset                  ( rx_user_reset ),
       .rx_phy_ready                   ( rx_phy_ready ),
       .rx_user_data_valid             ( rx_user_data_valid ),
       .rx_user_data                   ( rx_user_data ),

       .calib_done_out                 ( axi_c2c_link_status_out ),
       .calib_error_out                ( axi_c2c_multi_bit_error_out ),
       .phy_error_out                  ( axi_c2c_config_error_out ),
       .link_error_out                 ( axi_c2c_link_error_out )
   );

   //------------------------------------------------------------
   // tie off unused output ports
   //------------------------------------------------------------
   assign  s_axi_bid     = { C_AXI_ID_WIDTH   { 1'b 0 } };
   assign  s_axi_bresp   = { C_AXI_RESP_WIDTH { 1'b 0 } };
   assign  s_axi_rid     = { C_AXI_ID_WIDTH   { 1'b 0 } };
   assign  s_axi_rdata   = { C_AXI_DATA_WIDTH { 1'b 0 } };
   assign  s_axi_rresp   = { C_AXI_RESP_WIDTH { 1'b 0 } };
   assign  s_axi_awready = 1'b 0;
   assign  s_axi_wready  = 1'b 0;
   assign  s_axi_bvalid  = 1'b 0;
   assign  s_axi_arready = 1'b 0;
   assign  s_axi_rlast   = 1'b 0;
   assign  s_axi_rvalid  = 1'b 0;
   assign  axi_c2c_s2m_intr_out = { C_INTERRUPT_WIDTH { 1'b 0 } };
end
endgenerate

//------------------------------------------------------------
// choose the clocks to be used based on clocking mode selected
//------------------------------------------------------------
generate if ( ( C_MASTER_FPGA == 0 ) & ( C_COMMON_CLK == 0 ) )
begin
   assign slave_fpga_axi_clk     = m_aclk;
   assign slave_fpga_axi_reset_n = m_aresetn;
   assign m_aclk_out             = 1'b 0;
end
else if ( ( C_MASTER_FPGA == 0 ) & ( C_COMMON_CLK == 1 ) )
begin
   assign slave_fpga_axi_clk     = rx_user_clk;
   assign slave_fpga_axi_reset_n = ~rx_user_reset;
   assign m_aclk_out             = rx_user_clk;
end
else
begin
   assign slave_fpga_axi_clk     = 1'b 0;
   assign slave_fpga_axi_reset_n = 1'b 1;
   assign m_aclk_out             = 1'b 0;
end
endgenerate

//------------------------------------------------------------
// axi_lite interface generates
//------------------------------------------------------------
generate if ( C_INCLUDE_AXILITE == 1 ) // axi lite master - slave on the axi lite bus
begin : axi_lite_master_gen


   axi_chip2chip_v4_2_reset_sync reset_sync_lite_mst
   (
           .clk                ( s_axi_lite_aclk ),
           .reset_n            ( lite_aresetn ),
           .sync_reset_out     ( lite_sync_reset )
   );

   axi_chip2chip_v4_2_lite_master
   #(
          .C_FAMILY            ( C_FAMILY ),
          .ADDR_WIDTH          ( C_AXI_LITE_ADDR_WIDTH ),
          .PROT_WIDTH          ( C_AXI_LITE_PROT_WIDTH ),
          .DATA_WIDTH          ( C_AXI_LITE_DATA_WIDTH ),
          .STB_WIDTH           ( C_AXI_LITE_STB_WIDTH  ),
          .RESP_WIDTH          ( C_AXI_LITE_RESP_WIDTH ),
          .PHY_DATA_WIDTH      ( AXILITE_WIDTH ),
          .C_SYNC_STAGE        ( C_SYNC_STAGE )
   ) axi_chip2chip_lite_master_inst
   (
           .axi_aclk           ( s_axi_lite_aclk ),
           .axi_reset          ( lite_sync_reset ),
   
           .axi_awaddr         ( s_axi_lite_awaddr ),
           .axi_awprot         ( s_axi_lite_awprot ),
           .axi_awready        ( s_axi_lite_awready ),
           .axi_awvalid        ( s_axi_lite_awvalid ),
           .axi_wdata          ( s_axi_lite_wdata ),
           .axi_wstb           ( s_axi_lite_wstrb ),
           .axi_wready         ( s_axi_lite_wready ),
           .axi_wvalid         ( s_axi_lite_wvalid ),
           .axi_bresp          ( s_axi_lite_bresp ),
           .axi_bready         ( s_axi_lite_bready ),
           .axi_bvalid         ( s_axi_lite_bvalid ),
   
           .axi_araddr         ( s_axi_lite_araddr ),
           .axi_arprot         ( s_axi_lite_arprot ),
           .axi_arready        ( s_axi_lite_arready ),
           .axi_arvalid        ( s_axi_lite_arvalid ),
           .axi_rdata          ( s_axi_lite_rdata ),
           .axi_rresp          ( s_axi_lite_rresp ),
           .axi_rready         ( s_axi_lite_rready ),
           .axi_rvalid         ( s_axi_lite_rvalid ),
   
           .tx_user_clk        ( tx_user_clk ),
           .tx_user_reset      ( tx_user_reset ),
           .tx_phy_ready       ( tx_phy_ready ),
           .tx_user_data       ( axi_lite_tx_data ),
           .tx_user_data_valid ( axi_lite_tx_valid ),
           .tx_user_data_ready ( axi_lite_tx_ready ),
   
           .rx_user_clk        ( rx_user_clk ),
           .rx_user_reset      ( rx_user_reset ),
           .rx_phy_ready       ( rx_phy_ready ),
           .rx_user_data_valid ( axi_lite_rx_valid ),
           .rx_user_data       ( axi_lite_rx_data )
   );
   //------------------------------------------------------------
   // tie off unused output ports
   //------------------------------------------------------------
   assign m_axi_lite_awaddr    = { C_AXI_LITE_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_lite_awprot    = { C_AXI_LITE_PROT_WIDTH  { 1'b 0 } };
   assign m_axi_lite_wdata     = { C_AXI_LITE_DATA_WIDTH { 1'b 0 } };
   assign m_axi_lite_wstrb     = { C_AXI_LITE_STB_WIDTH  { 1'b 0 } };
   assign m_axi_lite_araddr    = { C_AXI_LITE_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_lite_arprot    = { C_AXI_LITE_PROT_WIDTH  { 1'b 0 } };
   assign m_axi_lite_awvalid   = 1'b 0;
   assign m_axi_lite_wvalid    = 1'b 0;
   assign m_axi_lite_bready    = 1'b 0;
   assign m_axi_lite_arvalid   = 1'b 0;
   assign m_axi_lite_rready    = 1'b 0;
end
else if ( C_INCLUDE_AXILITE == 2 ) // axi lite slave - master on the axi lite bus
begin : axi_lite_slave_gen


   axi_chip2chip_v4_2_reset_sync reset_sync_lite_slv (
           .clk                ( m_axi_lite_aclk ),
           .reset_n            ( lite_aresetn ),
           .sync_reset_out     ( lite_sync_reset )
   );

   axi_chip2chip_v4_2_lite_slave
   #(
          .C_FAMILY            ( C_FAMILY ),
          .ADDR_WIDTH          ( C_AXI_LITE_ADDR_WIDTH ),
          .PROT_WIDTH          ( C_AXI_LITE_PROT_WIDTH ),
          .DATA_WIDTH          ( C_AXI_LITE_DATA_WIDTH ),
          .STB_WIDTH           ( C_AXI_LITE_STB_WIDTH  ),
          .RESP_WIDTH          ( C_AXI_LITE_RESP_WIDTH ),
          .PHY_DATA_WIDTH      ( AXILITE_WIDTH ),
          .C_SYNC_STAGE        ( C_SYNC_STAGE )
   ) axi_chip2chip_lite_slave_inst
   (
           .axi_aclk           ( m_axi_lite_aclk ),
           .axi_reset          ( lite_sync_reset ),
   
           .axi_awaddr         ( m_axi_lite_awaddr ),
           .axi_awprot         ( m_axi_lite_awprot ),
           .axi_awready        ( m_axi_lite_awready ),
           .axi_awvalid        ( m_axi_lite_awvalid ),
           .axi_wdata          ( m_axi_lite_wdata ),
           .axi_wstb           ( m_axi_lite_wstrb ),
           .axi_wready         ( m_axi_lite_wready ),
           .axi_wvalid         ( m_axi_lite_wvalid ),
           .axi_bresp          ( m_axi_lite_bresp ),
           .axi_bready         ( m_axi_lite_bready ),
           .axi_bvalid         ( m_axi_lite_bvalid ),
   
           .axi_araddr         ( m_axi_lite_araddr ),
           .axi_arprot         ( m_axi_lite_arprot ),
           .axi_arready        ( m_axi_lite_arready ),
           .axi_arvalid        ( m_axi_lite_arvalid ),
           .axi_rdata          ( m_axi_lite_rdata ),
           .axi_rresp          ( m_axi_lite_rresp ),
           .axi_rready         ( m_axi_lite_rready ),
           .axi_rvalid         ( m_axi_lite_rvalid ),
   
           .tx_user_clk        ( tx_user_clk ),
           .tx_user_reset      ( tx_user_reset ),
           .tx_phy_ready       ( tx_phy_ready ),
           .tx_user_data       ( axi_lite_tx_data ),
           .tx_user_data_valid ( axi_lite_tx_valid ),
           .tx_user_data_ready ( axi_lite_tx_ready ),
   
           .rx_user_clk        ( rx_user_clk ),
           .rx_user_reset      ( rx_user_reset ),
           .rx_phy_ready       ( rx_phy_ready ),
           .rx_user_data_valid ( axi_lite_rx_valid ),
           .rx_user_data       ( axi_lite_rx_data )
   );

   //------------------------------------------------------------
   // tie off unused output ports
   //------------------------------------------------------------
   assign s_axi_lite_bresp     = { C_AXI_LITE_RESP_WIDTH { 1'b 0 } };
   assign s_axi_lite_rdata     = { C_AXI_LITE_DATA_WIDTH { 1'b 0 } };
   assign s_axi_lite_rresp     = { C_AXI_LITE_RESP_WIDTH { 1'b 0 } };
   assign s_axi_lite_awready   = 1'b 0;
   assign s_axi_lite_wready    = 1'b 0;
   assign s_axi_lite_bvalid    = 1'b 0;
   assign s_axi_lite_arready   = 1'b 0;
   assign s_axi_lite_rvalid    = 1'b 0;
end
else
begin : no_axi_lite_gen
   //------------------------------------------------------------
   // tie off unused output ports
   //------------------------------------------------------------
   assign s_axi_lite_bresp     = { C_AXI_LITE_RESP_WIDTH { 1'b 0 } };
   assign s_axi_lite_rdata     = { C_AXI_LITE_DATA_WIDTH { 1'b 0 } };
   assign s_axi_lite_rresp     = { C_AXI_LITE_RESP_WIDTH { 1'b 0 } };
   assign s_axi_lite_awready   = 1'b 0;
   assign s_axi_lite_wready    = 1'b 0;
   assign s_axi_lite_bvalid    = 1'b 0;
   assign s_axi_lite_arready   = 1'b 0;
   assign s_axi_lite_rvalid    = 1'b 0;
   assign m_axi_lite_awaddr    = { C_AXI_LITE_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_lite_awprot    = { C_AXI_LITE_PROT_WIDTH  { 1'b 0 } };
   assign m_axi_lite_wdata     = { C_AXI_LITE_DATA_WIDTH { 1'b 0 } };
   assign m_axi_lite_wstrb     = { C_AXI_LITE_STB_WIDTH  { 1'b 0 } };
   assign m_axi_lite_araddr    = { C_AXI_LITE_ADDR_WIDTH  { 1'b 0 } };
   assign m_axi_lite_arprot    = { C_AXI_LITE_PROT_WIDTH  { 1'b 0 } };
   assign m_axi_lite_awvalid   = 1'b 0;
   assign m_axi_lite_wvalid    = 1'b 0;
   assign m_axi_lite_bready    = 1'b 0;
   assign m_axi_lite_arvalid   = 1'b 0;
   assign m_axi_lite_rready    = 1'b 0;
   assign axi_lite_tx_data     = { AXILITE_WIDTH { 1'b 0 } };
   assign axi_lite_tx_valid    = 1'b 0;
end
endgenerate

// synthesis translate_off
initial
begin
   if ( ( C_WIDTH_CONVERSION != 1 ) & ( C_WIDTH_CONVERSION != 2 ) & ( C_WIDTH_CONVERSION != 4 ) & ( C_WIDTH_CONVERSION != 3 ))
   begin
      $display ("Config C_WIDTH_CONVERSION %d is not supported", C_WIDTH_CONVERSION);
//      $stop;
   end
   if ( C_PHY_SELECT > 1 )
   begin
      $display ("Config C_PHY_SELECT %d is not supported", C_PHY_SELECT);
//      $stop;
   end
   if ( ( C_ECC_ENABLE == 1 ) & ( C_PHY_SELECT == 0 ) )
   begin
      $display ("Config C_ECC_ENABLE %d is not supported with SIO %d", C_ECC_ENABLE, C_PHY_SELECT);
//      $stop;
   end

   if ( C_PHY_SELECT == 0 )
   begin
      if ( ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 55 ) | ( C_SELECTIO_WIDTH == 61 )) & ( C_SELECTIO_DDR == 0 ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 30 ) | ( C_SELECTIO_WIDTH == 33 )) & ( C_SELECTIO_DDR == 0 ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 18 ) | ( C_SELECTIO_WIDTH == 20 )) & ( C_SELECTIO_DDR == 0 ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 64 ) & (( C_SELECTIO_WIDTH == 44 ) | ( C_SELECTIO_WIDTH == 46 )) & ( C_SELECTIO_DDR == 0 ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 64 ) & (( C_SELECTIO_WIDTH == 25 ) | ( C_SELECTIO_WIDTH == 26 )) & ( C_SELECTIO_DDR == 0 ) ) )
      begin
         $display ("%m Valid Config: SDR : SIO C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_SELECTIO_WIDTH = %d",
                                               C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_SELECTIO_WIDTH);
      end
      else if ( ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 28 ) | ( C_SELECTIO_WIDTH == 31 )) & ( C_SELECTIO_DDR == 1 ) ) |
                ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 15 ) | ( C_SELECTIO_WIDTH == 17 )) & ( C_SELECTIO_DDR == 1 ) ) |
                ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 32 ) & (( C_SELECTIO_WIDTH == 09 ) | ( C_SELECTIO_WIDTH == 10 )) & ( C_SELECTIO_DDR == 1 ) ) |
                ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 64 ) & (( C_SELECTIO_WIDTH == 41 ) | ( C_SELECTIO_WIDTH == 43 )) & ( C_SELECTIO_DDR == 1 ) ) |
                ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 64 ) & (( C_SELECTIO_WIDTH == 22 ) | ( C_SELECTIO_WIDTH == 23 )) & ( C_SELECTIO_DDR == 1 ) ) |
                ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 64 ) & ( C_SELECTIO_WIDTH == 13 )  & ( C_SELECTIO_DDR == 1 ) ) )
      begin
         $display ("%m Valid Config: DDR : SIO C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_SELECTIO_WIDTH = %d",
                                               C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_SELECTIO_WIDTH);
      end
      else if ( C_SELECTIO_DDR == 0 )
      begin
         $display ("%m ERROR Config: SDR : SIO C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_SELECTIO_WIDTH = %d",
                                               C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_SELECTIO_WIDTH);
      end
      else
      begin
         $display ("%m ERROR Config: DDR : SIO C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_SELECTIO_WIDTH = %d",
                                               C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_SELECTIO_WIDTH);
      end
   end
   else //if ( C_ECC_ENABLE == 1 )
   begin
      if ( ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 32  ) & ( C_AURORA_WIDTH == 64  ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 32  ) & ( C_AURORA_WIDTH == 64  ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 64  ) & ( C_AURORA_WIDTH == 64  ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 128 ) & ( C_AURORA_WIDTH == 64  ) ) |

           ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 64  ) & ( C_AURORA_WIDTH == 128 ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 128 ) & ( C_AURORA_WIDTH == 128 ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 256 ) & ( C_AURORA_WIDTH == 128 ) ) |

           ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 128 ) & ( C_AURORA_WIDTH == 192 ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 256 ) & ( C_AURORA_WIDTH == 192 ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 512 ) & ( C_AURORA_WIDTH == 192 ) ) |

           ( ( C_WIDTH_CONVERSION == 3 ) & ( C_AXI_DATA_WIDTH == 512 ) & ( C_AURORA_WIDTH == 256 ) ) |

           ( ( C_WIDTH_CONVERSION == 1 ) & ( C_AXI_DATA_WIDTH == 256 ) & ( C_AURORA_WIDTH == 384 ) ) |
           ( ( C_WIDTH_CONVERSION == 2 ) & ( C_AXI_DATA_WIDTH == 512 ) & ( C_AURORA_WIDTH == 384 ) ) |
           ( ( C_WIDTH_CONVERSION == 4 ) & ( C_AXI_DATA_WIDTH == 1024) & ( C_AURORA_WIDTH == 384 ) ) )

      begin
         $display ("%m Valid Config: Aurora: C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_AURORA_WIDTH = %d",
                                             C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_AURORA_WIDTH);
      end
      else
      begin
         $display ("%m Config: Aurora: C_AXI_DATA_WIDTH = %d, C_WIDTH_CONVERSION = %d, C_AURORA_WIDTH = %d",
                                             C_AXI_DATA_WIDTH,      C_WIDTH_CONVERSION,      C_AURORA_WIDTH);
      end
   end
end
// synthesis translate_on

endmodule
