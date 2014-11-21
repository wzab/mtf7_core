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
module axi_chip2chip_v4_2_sio_input
#(
    parameter   C_FAMILY       = "kintex7",
    parameter   C_MASTER_PHY   = 1,
    parameter   CLK_IN_FREQ    = 100,
    parameter   DDR_MODE       = 0,
    parameter   DATA_WIDTH     = 32, // defines data width
    parameter   INPUT_PINS     = 32, // defines number of pins
    parameter   DIS_DESKEW     = 0,
    parameter   DIS_CLK_SHIFT  = 0,
    parameter   C_USE_DIFF_CLK = 0, // defines use of differential clock input
    parameter   C_USE_DIFF_IO  = 0  // defines use of differential data input
)
(
  input  wire                     idelay_ref_clk,
  output wire                     idelay_ready,

  input  wire                     clk_in,
  input  wire                     clk_in_p,
  input  wire                     clk_in_n,
  input  wire                     reset_in,
  output wire                     clk_locked,

  input  wire  [INPUT_PINS-1:0]   data_in,
  input  wire  [INPUT_PINS-1:0]   data_in_p,
  input  wire  [INPUT_PINS-1:0]   data_in_n,
  output wire                     clk_out,
  output reg   [DATA_WIDTH-1:0]   data_out,
  output reg   [DATA_WIDTH-1:0]   data_neg_out,

  input  wire  [4:0]              delay_tap,
  input  wire  [DATA_WIDTH-1:0]   delay_load
);

wire [INPUT_PINS-1:0] data_in_ibuf;
wire [INPUT_PINS-1:0] data_in_ibuf_idelay;
wire [DATA_WIDTH-1:0] data_in_iddr;

//-----------------------------------------------------
// idelay controller if deskew is used
//-----------------------------------------------------
generate if ( DIS_DESKEW == 0 )
begin : idelayctrl_gen

(* IODELAY_GROUP = "C2C_PHY_group" *)
   IDELAYCTRL IDELAYCTRL_inst (
             .RDY    (idelay_ready),
             .REFCLK (idelay_ref_clk),
             .RST    (reset_in));
end
else
begin : no_idelay_gen

   assign idelay_ready = 1'b 1;
end
endgenerate

//----------------------------------------------------
//       FAMILY SUPPORT
//----------------------------------------------------
localparam real REFCLK_FREQ = ( ( C_FAMILY == "kintexu" ) | ( C_FAMILY == "virtexu" ) ) ? 300.0 : 200.0;
localparam EN_8SER = ( ( C_FAMILY == "kintexu" ) | ( C_FAMILY == "virtexu" ) ) ? 1 : 0;
//-----------------------------------------------------
// decide clock phase shift to be generated
//-----------------------------------------------------
localparam CLK_PHASE = ( DIS_CLK_SHIFT == 1 ) ? 0 : ( ( DDR_MODE == 1 ) ? 90 : 180 );

//-----------------------------------------------------
// use mmcm to generate 180 or 90 clock to latch data
// the same clock will used as RX clock
// some use cases can disable phase shift
//-----------------------------------------------------
axi_chip2chip_v4_2_clk_gen
#(
   .C_FAMILY       ( C_FAMILY ),
   .CLK_IN_FREQ    ( CLK_IN_FREQ ),
   .CLK_PHASE      ( CLK_PHASE ),
   .C_USE_DIFF_CLK ( C_USE_DIFF_CLK )
) axi_chip2chip_clk_gen_inst
(
   .clk_in     ( clk_in ),
   .clk_in_p   ( clk_in_p ),
   .clk_in_n   ( clk_in_n ),
   .reset      ( reset_in ),
   .clk_ph_out ( clk_out ),
   .clk_locked ( clk_locked )
);

//----------------------------------------------------------
// ibuf / ibufds instance
//----------------------------------------------------------
genvar in_pin_count;

generate if ( C_USE_DIFF_IO == 1 )
begin : diff_input_gen
   for (in_pin_count = 0; in_pin_count < INPUT_PINS; in_pin_count = in_pin_count + 1)
   begin: diff_in
      IBUFDS IBUFDS_inst ( .O ( data_in_ibuf[in_pin_count] ), .I ( data_in_p[in_pin_count] ), .IB ( data_in_n[in_pin_count] ) );
   end
end
else
begin : single_end_input_gen
   for (in_pin_count = 0; in_pin_count < INPUT_PINS; in_pin_count = in_pin_count + 1)
   begin: signle_end_in
      IBUF IBUF_inst ( .O ( data_in_ibuf[in_pin_count] ), .I ( data_in[in_pin_count] ) );
   end
end
endgenerate

//----------------------------------------------------------
// idelay or ibuf usage based on DIS_DESKEW
//----------------------------------------------------------
genvar pin_count0;

generate if ( ( DIS_DESKEW == 0 ) & ( DDR_MODE == 0 ) )
begin : sdr_idelay_gen

   for (pin_count0 = 0; pin_count0 < INPUT_PINS; pin_count0 = pin_count0 + 1)
   begin: sdr_idelay_inst
       if(EN_8SER) begin :gen_idelaye3

          (* IODELAY_GROUP = "C2C_PHY_group" *)
            IDELAYE3
                # (
                .DELAY_SRC              ("IDATAIN"),        // IDATAIN, DATAIN
                .DELAY_FORMAT           ("COUNT"),             // TIME, COUNT
                .DELAY_TYPE             ("VAR_LOAD"),          // FIXED, VARIABLE, or VAR_LOADABLE
                .DELAY_VALUE            (0),                // 0 to 31
                .REFCLK_FREQUENCY       (REFCLK_FREQ))
            IDELAYE3_inst
                (
                .CASC_OUT               (),
                .CASC_IN                (1'b0),
                .CASC_RETURN            (1'b0),
                .DATAOUT                (data_in_ibuf_idelay[pin_count0]),  // Delayed clock
                .DATAIN                 (1'b1),              // Data from FPGA logic
                .CLK                    (clk_out),    //1'b0),
                .CE                     (1'b0),          //clock_enable), 
                .INC                    (1'b0),
                .IDATAIN                (data_in_ibuf[pin_count0]),
                .LOAD                   (delay_load[pin_count0]),
                .RST                    (1'b0),
                .CNTVALUEIN             ({4'h0,delay_tap}),  //5'b00000),
                .CNTVALUEOUT            (),
                .EN_VTC                 (1'b0)
             );
     end else begin: gen_idelaye2

         (* IODELAY_GROUP = "C2C_PHY_group" *)
         IDELAYE2 #(
                   .CINVCTRL_SEL         ("FALSE"),
                   .DELAY_SRC            ("IDATAIN"),
                   .HIGH_PERFORMANCE_MODE("TRUE"),
                   .IDELAY_TYPE          ("VAR_LOAD"),
                   .IDELAY_VALUE         (0),
                   .PIPE_SEL             ("FALSE"),
                   .REFCLK_FREQUENCY     (REFCLK_FREQ),
                   .SIGNAL_PATTERN       ("DATA")
         )
         IDELAYE2_inst (
                   .CNTVALUEOUT (),
                   .DATAOUT     (data_in_ibuf_idelay[pin_count0]), // 1-bit output: Delayed data output
                   .C           (clk_out),
                   .CE          (1'b 0),
                   .CINVCTRL    (1'b 0),
                   .CNTVALUEIN  (delay_tap),
                   .DATAIN      (1'b 1),
                   .IDATAIN     (data_in_ibuf[pin_count0]),
                   .INC         (1'b 0),
                   .LD          (delay_load[pin_count0]),
                   .LDPIPEEN    (1'b 0),
                   .REGRST      (1'b 0)
         );
     end
   end
end
else if ( ( DIS_DESKEW == 0 ) & ( DDR_MODE == 1 ) )
begin : ddr_idelay_gen

   for (pin_count0 = 0; pin_count0 < INPUT_PINS; pin_count0 = pin_count0 + 1)
   begin: ddr_idelay_inst

       if(EN_8SER) begin :gen_idelaye3

          (* IODELAY_GROUP = "C2C_PHY_group" *)
            IDELAYE3
                # (
                .DELAY_SRC              ("IDATAIN"),        // IDATAIN, DATAIN
                .DELAY_FORMAT           ("COUNT"),             // TIME, COUNT
                .DELAY_TYPE             ("VAR_LOAD"),          // FIXED, VARIABLE, or VAR_LOADABLE
                .DELAY_VALUE            (0),                // 0 to 31
                .REFCLK_FREQUENCY       (REFCLK_FREQ))
            IDELAYE3_inst
                (
                .CASC_OUT               (),
                .CASC_IN                (1'b0),
                .CASC_RETURN            (1'b0),
                .DATAOUT                (data_in_ibuf_idelay[pin_count0]),  // Delayed clock
                .DATAIN                 (1'b1),              // Data from FPGA logic
                .CLK                    (clk_out),    //1'b0),
                .CE                     (1'b0),          //clock_enable), 
                .INC                    (1'b0),
                .IDATAIN                (data_in_ibuf[pin_count0]),
                .LOAD                   (delay_load[pin_count0]),
                .RST                    (1'b0),
                .CNTVALUEIN             ({4'h0,delay_tap}),  //5'b00000),
                .CNTVALUEOUT            (),
                .EN_VTC                 (1'b0)
             );
     end else begin: gen_idelaye2

            (* IODELAY_GROUP = "C2C_PHY_group" *)
            IDELAYE2 #(
                      .CINVCTRL_SEL         ("FALSE"),
                      .DELAY_SRC            ("IDATAIN"),
                      .HIGH_PERFORMANCE_MODE("TRUE"),
                      .IDELAY_TYPE          ("VAR_LOAD"),
                      .IDELAY_VALUE         (0),
                      .PIPE_SEL             ("FALSE"),
                      .REFCLK_FREQUENCY     (REFCLK_FREQ),
                      .SIGNAL_PATTERN       ("DATA")
              )
            IDELAYE2_inst (
                      .CNTVALUEOUT (),
                      .DATAOUT     (data_in_ibuf_idelay[pin_count0]), // 1-bit output: Delayed data output
                      .C           (clk_out),
                      .CE          (1'b 0),
                      .CINVCTRL    (1'b 0),
                      .CNTVALUEIN  (delay_tap),
                      .DATAIN      (1'b 1),
                      .IDATAIN     (data_in_ibuf[pin_count0]),
                      .INC         (1'b 0),
                      .LD          (delay_load[(pin_count0*2)]),
                      .LDPIPEEN    (1'b 0),
                      .REGRST      (1'b 0)
            );
      end
   end
end
else
begin : no_deskew_gen
   assign data_in_ibuf_idelay = data_in_ibuf;
end
endgenerate

//----------------------------------------------------------
// IDDR instances
//----------------------------------------------------------
genvar pin_count;

generate if ( DDR_MODE == 0 )
begin: sdr_iddr_gen
   wire [DATA_WIDTH-1:0] data_neg_in_iddr;

   for (pin_count = 0; pin_count < INPUT_PINS; pin_count = pin_count + 1)
   begin: sdr_iddr_inst
      if(EN_8SER) begin :gen_iddre1
           IDDRE1
            #(.DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED")) //"OPPOSITE_EDGE", "SAME_EDGE, "SAME_EDGE_PIPELINED
            iddr_inst
             (.Q1             (data_in_iddr[pin_count]),
              .Q2             (data_neg_in_iddr[pin_count]),
              .C              (clk_out), 
              .CB             (~clk_out), 
              .D              (data_in_ibuf_idelay[pin_count]),
              .R              (1'b0));

      end else begin: gen_iddr
           IDDR
            #(.DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED"), //"OPPOSITE_EDGE",  "SAME_EDGE, "SAME_EDGE_PIPELINED"
              .INIT_Q1        (1'b0),
              .INIT_Q2        (1'b0),
              .SRTYPE         ("ASYNC"))
            iddr_inst
             (.Q1             (data_in_iddr[pin_count]),
              .Q2             (data_neg_in_iddr[pin_count]),
              .C              (clk_out),
              .CE             (1'b 1),
              .D              (data_in_ibuf_idelay[pin_count]),
              .R              (1'b 0),
              .S              (1'b 0));
      end
   end

   //----------------------------------------------------------
   // transfer data to posedge of fabric clock
   //----------------------------------------------------------
   always @ ( posedge clk_out )
   begin
      data_neg_out  <= data_neg_in_iddr;
   end
end
else if ( DDR_MODE == 1 )
begin: ddr_iddr_gen

   for (pin_count = 0; pin_count < INPUT_PINS; pin_count = pin_count + 1)
   begin: input_ddr_inst
      if(EN_8SER) begin :gen_iddre1
           IDDRE1
            #(.DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED")) //"OPPOSITE_EDGE", "SAME_EDGE, "SAME_EDGE_PIPELINED
            iddr_inst
             (.Q1             (data_in_iddr[(pin_count*2)]),
              .Q2             (data_in_iddr[(pin_count*2)+1]),
              .C              (clk_out), 
              .CB             (~clk_out), 
              .D              (data_in_ibuf_idelay[pin_count]),
              .R              (1'b0));

      end else begin: gen_iddr
           IDDR
            #(.DDR_CLK_EDGE   ("SAME_EDGE_PIPELINED"), //"OPPOSITE_EDGE",  "SAME_EDGE, "SAME_EDGE_PIPELINED"
              .INIT_Q1        (1'b0),
              .INIT_Q2        (1'b0),
              .SRTYPE         ("ASYNC"))
            iddr_inst
             (.Q1             (data_in_iddr[(pin_count*2)]),
              .Q2             (data_in_iddr[(pin_count*2)+1]),
              .C              (clk_out),
              .CE             (1'b 1),
              .D              (data_in_ibuf_idelay[pin_count]),
              .R              (1'b 0),
              .S              (1'b 0));
      end
   end

   always @ ( data_in_iddr )
   begin
      data_neg_out = { DATA_WIDTH { 1'b 0 } };
   end
end
endgenerate

//----------------------------------------------------------
// transfer data to posedge of fabric clock
//----------------------------------------------------------
always @ ( posedge clk_out )
begin
   data_out  <= data_in_iddr;
end

endmodule
