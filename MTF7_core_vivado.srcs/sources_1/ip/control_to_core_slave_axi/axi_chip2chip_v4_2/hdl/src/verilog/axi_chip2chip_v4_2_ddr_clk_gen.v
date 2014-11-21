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
module axi_chip2chip_v4_2_clk_gen
#(
    parameter   C_FAMILY          = "kintex7",
    parameter   CLK_IN_FREQ       = 100,        // in MHz
    parameter   CLK_PHASE         = 90,
    parameter   C_USE_DIFF_CLK    = 0
)
(
  input  wire                             clk_in,
  input  wire                             clk_in_p,
  input  wire                             clk_in_n,
  input  wire                             reset,
  output wire                             clk_ph_out,
  output wire                             clk_locked
);

localparam integer MAX_VCO        = 1000;
localparam integer MIN_VCO        = 700;
localparam integer MMIN           = 4;
localparam integer MMAX           = 16;
localparam integer MAX_DIV        = MAX_VCO/CLK_IN_FREQ;
localparam integer MIN_DIV        = MIN_VCO/CLK_IN_FREQ;
localparam real    M_VALUE        = ( MAX_DIV <= MMAX ) ? (1.0*MAX_DIV) : (1.0*MMAX);

localparam real    FREQ           = 1.0*CLK_IN_FREQ;
localparam real    CLK_IN_PERIOD  = (1000.000/FREQ);

wire clk_in_ibufg;
wire clk_out;
wire clkfbout;
wire clkfbout_bufg;

generate if ( C_USE_DIFF_CLK == 1 )
begin : diff_clk_input_gen

  IBUFGDS ibufgds_clk_inst (.O(clk_in_ibufg), .I(clk_in_p), .IB(clk_in_n));
end
else
begin : single_end_clk_gen

  IBUFG  ibufg_clk_inst (.O(clk_in_ibufg), .I(clk_in));
end
endgenerate


  BUFG   bufg_inst      (.O(clk_ph_out),   .I(clk_out));
  BUFG   fb_bufg_inst   (.O(clkfbout_bufg),.I(clkfbout));

  MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (M_VALUE),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (M_VALUE),
    .CLKOUT0_PHASE        (CLK_PHASE),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (CLK_IN_PERIOD),
    .REF_JITTER1          (0.010))
  mmcm_adv_inst
    // Output clocks
   (.CLKFBOUT            (clkfbout),
    .CLKFBOUTB           (),
    .CLKOUT0             (clk_out),
    .CLKOUT0B            (),
    .CLKOUT1             (),
    .CLKOUT1B            (),
    .CLKOUT2             (),
    .CLKOUT2B            (),
    .CLKOUT3             (),
    .CLKOUT3B            (),
    .CLKOUT4             (),
    .CLKOUT5             (),
    .CLKOUT6             (),
     // Input clock control
    .CLKFBIN             (clkfbout_bufg),
    .CLKIN1              (clk_in_ibufg),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (),
    .DRDY                (),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (),
    // Other control and status signals
    .LOCKED              (clk_locked),
    .CLKINSTOPPED        (),
    .CLKFBSTOPPED        (),
    .PWRDWN              (1'b0),
    .RST                 (reset));



// synthesis translate_off
initial
begin
   $display ("%m DDR clocking config:: CLK_IN_FREQ = %d, CLK_IN_PERIOD = %f, M_VALUE = %f, VCO = %f",
                 CLK_IN_FREQ, CLK_IN_PERIOD, M_VALUE, CLK_IN_FREQ*M_VALUE);
end
// synthesis translate_on
endmodule
