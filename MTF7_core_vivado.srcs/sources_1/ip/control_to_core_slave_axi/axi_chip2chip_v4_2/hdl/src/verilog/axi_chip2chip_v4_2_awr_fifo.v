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
module axi_chip2chip_v4_2_awr_fifo
#(
    parameter   C_FAMILY       = "kintex7",
    parameter   PACK_RATIO     = 1,
    parameter   UNPACK_RATIO   = 1,
    parameter   DIN_WIDTH      = 50,
    parameter   DOUT_WIDTH     = 50,
    parameter   FIFO_DEPTH     = 256,
    parameter   FC_ASSERT      = 128,
    parameter   FIFO_PTR_WIDTH = 8,
    parameter   SYNC_FIFO      = 0,
    parameter   C_SYNC_STAGE   = 2
)
(
  input  wire                                  fifo_reset,

  input  wire                                  wr_clk,
  input  wire                                  wr_reset,
  input  wire  [DIN_WIDTH-1:0]                 data_in,
  input  wire                                  data_valid_in,
  output wire                                  data_ready_out,
  output wire                                  flow_control,

  input  wire                                  rd_clk,
  input  wire                                  rd_reset,
  output wire  [DOUT_WIDTH-1:0]                data_out,
  output wire                                  data_valid_out,
  input  wire                                  data_ready_in
);

localparam FIFO_WIDTH        = DIN_WIDTH*PACK_RATIO;
localparam PACK_DIN_WIDTH    = DIN_WIDTH;
localparam PACK_DOUT_WIDTH   = DIN_WIDTH*PACK_RATIO;
localparam UNPACK_DIN_WIDTH  = DOUT_WIDTH*UNPACK_RATIO;
localparam UNPACK_DOUT_WIDTH = DOUT_WIDTH;

wire  [PACK_DOUT_WIDTH-1:0]                pack_data_out;
wire                                       pack_data_we;
wire                                       fifo_full;
wire  [UNPACK_DIN_WIDTH-1:0]               unpack_data_in;
wire                                       unpack_data_re;
wire                                       fifo_empty;

axi_chip2chip_v4_2_packer
#(
    .PACK_RATIO (PACK_RATIO),
    .DIN_WIDTH  (PACK_DIN_WIDTH),
    .DOUT_WIDTH (PACK_DOUT_WIDTH)
) axi_chip2chip_packer_inst
(
    .clk             ( wr_clk ),
    .reset           ( wr_reset ),
    .data_in         ( data_in ),
    .data_valid_in   ( data_valid_in ),
    .data_ready_out  ( data_ready_out ),
    .data_out        ( pack_data_out ),
    .data_write_en   ( pack_data_we ),
    .fifo_full       ( fifo_full )
);


axi_chip2chip_v4_2_unpacker
#(
    .UNPACK_RATIO (UNPACK_RATIO),
    .DIN_WIDTH    (UNPACK_DIN_WIDTH),
    .DOUT_WIDTH   (UNPACK_DOUT_WIDTH)
) axi_chip2chip_unpacker_inst
(
    .clk             ( rd_clk ),
    .reset           ( rd_reset ),
    .data_in         ( unpack_data_in ),
    .fifo_empty      ( fifo_empty ),
    .data_read_en    ( unpack_data_re ),
    .data_out        ( data_out ),
    .data_ready_in   ( data_ready_in ),
    .data_valid_out  ( data_valid_out )
);
//---------------------------------------------------
// for common clock BRAM FIFO:
// C_COMMON_CLOCK = 1
// C_IMPLEMENTATION_TYPE = 0
// C_MEMORY_TYPE = 1
//---------------------------------------------------
// for independent clock BRAM FIFO:
// C_COMMON_CLOCK = 0
// C_IMPLEMENTATION_TYPE = 2
// C_MEMORY_TYPE = 1 
//---------------------------------------------------
localparam COMMON_CLK = ( SYNC_FIFO == 1 ) ? 1 : 0;
localparam IMP_TYPE   = ( SYNC_FIFO == 1 ) ? 0 : 2;
localparam MEM_TYPE   = 1;

wire sync_clk;

generate if ( COMMON_CLK == 1 )
begin
   assign sync_clk = wr_clk;
end
else
begin
   assign sync_clk = 1'b 0;
end
endgenerate

axi_chip2chip_v4_2_async_fifo 
#(
  .C_FAMILY              (C_FAMILY),
  .C_FIFO_DEPTH          (FIFO_DEPTH),
  .C_PROG_FULL_THRESH    (FC_ASSERT),
  .C_DATA_WIDTH          (FIFO_WIDTH),
  .C_PTR_WIDTH           (FIFO_PTR_WIDTH),
  .C_MEMORY_TYPE         (MEM_TYPE),      // BRAM FIFO
  .C_COMMON_CLOCK        (COMMON_CLK),
  .C_IMPLEMENTATION_TYPE (IMP_TYPE),
  .C_SYNCHRONIZER_STAGE  (C_SYNC_STAGE)
) 
axi_chip2chip_async_fifo_inst 
(
  .rst       (fifo_reset),
  .wr_clk    (wr_clk),
  .rd_clk    (rd_clk),
  .sync_clk  (sync_clk),
  .din       (pack_data_out),
  .wr_en     (pack_data_we),
  .rd_en     (unpack_data_re),
  .dout      (unpack_data_in),
  .full      (fifo_full),
  .empty     (fifo_empty),
  .prog_full (flow_control)
);

endmodule
