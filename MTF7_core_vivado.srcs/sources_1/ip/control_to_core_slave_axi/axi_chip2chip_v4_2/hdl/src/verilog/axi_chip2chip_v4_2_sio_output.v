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
module axi_chip2chip_v4_2_sio_output
#(
    parameter   C_FAMILY       = "kintex7",
    parameter   C_MASTER_PHY   = 1,
    parameter   DDR_MODE       = 0,
    parameter   DATA_WIDTH     = 32, // defines data width
    parameter   OUTPUT_PINS    = 32, // defines number of pins
    parameter   C_USE_DIFF_CLK = 0,  // defines usage of differential IO's for clock output
    parameter   C_USE_DIFF_IO  = 0   // defines usage of differential IO's for data
)
(
  input  wire                     clk_in,
  input  wire                     reset_in,
  input  wire  [DATA_WIDTH-1:0]   data_in,
  output wire                     clk_out,
  output wire  [OUTPUT_PINS-1:0]  data_out,

  output wire                     clk_out_p,
  output wire                     clk_out_n,
  output wire  [OUTPUT_PINS-1:0]  data_out_p,
  output wire  [OUTPUT_PINS-1:0]  data_out_n
);

localparam DW_D2 = DATA_WIDTH/2;
localparam EN_8SER = ( ( C_FAMILY == "kintexu" ) | ( C_FAMILY == "virtexu" ) ) ? 1 : 0;

wire                    clk_out_oddr;
wire                    clk_in_bufr;
wire [DATA_WIDTH-1:0]   data_fdre_oddr;

//----------------------------------------------------------
// Clock forwarding ckt - ODDR & OBUF
//----------------------------------------------------------
generate if(EN_8SER) begin :gen_oddre1
    ODDRE1
      oddr_clk_out_inst (
       .Q   (clk_out_oddr),
       .C   (clk_in),
       .D1  (1'b1),
       .D2  (1'b0),
       .SR  (1'b0));

end else begin:gen_oddr
    ODDR
      #(.DDR_CLK_EDGE   ("SAME_EDGE"),//OPPOSITE_EDGE
        .INIT           (1'b0),
        .SRTYPE         ("ASYNC"))
      oddr_clk_out_inst
       (.D1             (1'b 1),
        .D2             (1'b 0),
        .C              (clk_in),
        .CE             (1'b 1),
        .Q              (clk_out_oddr),
        .R              (1'b 0), // reset for clock pad removed
        .S              (1'b 0));
end
endgenerate

generate if ( C_USE_DIFF_CLK == 1 )
begin : diff_clk_out_gen
   OBUFDS clk_obufds_inst (
       .O  (clk_out_p),
       .OB (clk_out_n),
       .I  (clk_out_oddr));

   assign clk_out  = 1'b 0;
end
else
begin : single_end_clk_out_gen
   OBUF clk_obuf_inst (
       .O (clk_out),
       .I (clk_out_oddr));

   assign clk_out_p = 1'b 0;
   assign clk_out_n = 1'b 0;
end
endgenerate

//----------------------------------------------------------
// data path
//----------------------------------------------------------
genvar pin_count;
genvar out_pin_count;

generate if ( DDR_MODE == 0 )
begin: sdr_output_gen
   //----------------------------------------------------------
   // data output pins - use Flops in the IOB
   //----------------------------------------------------------
   for (pin_count = 0; pin_count < OUTPUT_PINS; pin_count = pin_count + 1)
   begin: output_sdr_pins
       (* IOB = "true" *)
       FDRE fdre_out_inst (
           .D  (data_in[pin_count]),
           .C  (clk_in),
           .CE (1'b 1),
           .R  (reset_in),
           .Q  (data_fdre_oddr[pin_count]));
   end
end
else if ( DDR_MODE == 1 )
begin: ddr_output_gen
   //----------------------------------------------------------
   // data output pins - use ODDR to create DDR output
   //----------------------------------------------------------
   for (pin_count = 0; pin_count < OUTPUT_PINS; pin_count = pin_count + 1)
   begin: output_ddr_pins
       if(EN_8SER) begin :gen_oddre1
           ODDRE1
             oddr_inst (
              .Q   (data_fdre_oddr[pin_count]),
              .C   (clk_in),
              .D1  (data_in[(pin_count*2)]),
              .D2  (data_in[(pin_count*2)+1]),
              .SR  (reset_in));
       
       end else begin:gen_oddr
           ODDR
             #(.DDR_CLK_EDGE   ("SAME_EDGE"),
               .INIT           (1'b0),
               .SRTYPE         ("ASYNC"))
             oddr_inst
              (.D1             (data_in[(pin_count*2)]),
               .D2             (data_in[(pin_count*2)+1]),
               .C              (clk_in),
               .CE             (1'b 1),
               .Q              (data_fdre_oddr[pin_count]),
               .R              (reset_in),
               .S              (1'b0));
       end
   end
end
endgenerate

generate if ( C_USE_DIFF_IO == 1 )
begin : diff_out_gen
   for (out_pin_count = 0; out_pin_count < OUTPUT_PINS; out_pin_count = out_pin_count + 1)
   begin: diff_buf_gen
       OBUFDS obufds_inst (
           .O  (data_out_p[out_pin_count]),
           .OB (data_out_n[out_pin_count]),
           .I  (data_fdre_oddr[out_pin_count]));
   end

   assign data_out = { OUTPUT_PINS { 1'b 0 } };
end
else
begin : single_end_out_gen
   for (out_pin_count = 0; out_pin_count < OUTPUT_PINS; out_pin_count = out_pin_count + 1)
   begin: single_ended_buf_gen
       OBUF obuf_inst (
           .O (data_out[out_pin_count]),
           .I (data_fdre_oddr[out_pin_count]));
   end

   assign data_out_p = { OUTPUT_PINS { 1'b 0 } };
   assign data_out_n = { OUTPUT_PINS { 1'b 0 } };
end
endgenerate

endmodule
