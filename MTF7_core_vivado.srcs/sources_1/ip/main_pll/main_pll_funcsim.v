// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:32:59 MDT 2014
// Date        : Sun Dec 21 23:07:33 2014
// Host        : WZlap running 64-bit Debian GNU/Linux 8.0 (jessie)
// Command     : write_verilog -force -mode funcsim
//               /home/xl/ise_projects/cern_update/mtf7_core/MTF7_core_vivado.srcs/sources_1/ip/main_pll/main_pll_funcsim.v
// Design      : main_pll
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* core_generation_info = "main_pll,clk_wiz_v5_1,{component_name=main_pll,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=PLL,num_out_clk=4,clkin1_period=25.0,clkin2_period=10.0,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *) 
(* NotValidForBitStream *)
module main_pll
   (clk_in1,
    clk40_aligned,
    clk_200,
    clk_160,
    clk_320);
  input clk_in1;
  output clk40_aligned;
  output clk_200;
  output clk_160;
  output clk_320;

  wire clk40_aligned;
  wire clk_160;
  wire clk_200;
  wire clk_320;
(* IBUF_LOW_PWR *)   wire clk_in1;

main_pll_main_pll_clk_wiz U0
       (.clk40_aligned(clk40_aligned),
        .clk_160(clk_160),
        .clk_200(clk_200),
        .clk_320(clk_320),
        .clk_in1(clk_in1));
endmodule

(* ORIG_REF_NAME = "main_pll_clk_wiz" *) 
module main_pll_main_pll_clk_wiz
   (clk_in1,
    clk40_aligned,
    clk_200,
    clk_160,
    clk_320);
  input clk_in1;
  output clk40_aligned;
  output clk_200;
  output clk_160;
  output clk_320;

  wire CLKFBOUT;
  wire CLKIN1;
  wire CLKOUT0;
  wire CLKOUT1;
  wire CLKOUT2;
  wire CLKOUT3;
  wire LOCKED;
  wire O;
  wire clk40_aligned;
  wire clk_160;
  wire clk_200;
  wire clk_320;
(* IBUF_LOW_PWR *)   wire clk_in1;
  wire n_0_clkout1_buf_en;
  wire n_0_clkout2_buf_en;
  wire n_0_clkout3_buf_en;
  wire n_0_clkout4_buf_en;
(* RTL_KEEP = "TRUE" *) (* async_reg = "true" *)   wire [7:0]seq_reg1;
(* RTL_KEEP = "TRUE" *) (* async_reg = "true" *)   wire [7:0]seq_reg2;
(* RTL_KEEP = "TRUE" *) (* async_reg = "true" *)   wire [7:0]seq_reg3;
(* RTL_KEEP = "TRUE" *) (* async_reg = "true" *)   wire [7:0]seq_reg4;
  wire NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_plle2_adv_inst_DRDY_UNCONNECTED;
  wire [15:0]NLW_plle2_adv_inst_DO_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   BUFG clkf_buf
       (.I(CLKFBOUT),
        .O(O));
(* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   (* box_type = "PRIMITIVE" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     clkin1_ibufg
       (.I(clk_in1),
        .O(CLKIN1));
(* CE_TYPE = "SYNC" *) 
   (* XILINX_LEGACY_PRIM = "BUFGCE" *) 
   (* XILINX_TRANSFORM_PINMAP = "CE:CE0 I:I0" *) 
   (* box_type = "PRIMITIVE" *) 
   BUFGCTRL #(
    .INIT_OUT(0),
    .PRESELECT_I0("TRUE"),
    .PRESELECT_I1("FALSE")) 
     clkout1_buf
       (.CE0(seq_reg1[7]),
        .CE1(1'b0),
        .I0(CLKOUT0),
        .I1(1'b1),
        .IGNORE0(1'b0),
        .IGNORE1(1'b1),
        .O(clk40_aligned),
        .S0(1'b1),
        .S1(1'b0));
(* box_type = "PRIMITIVE" *) 
   BUFH clkout1_buf_en
       (.I(CLKOUT0),
        .O(n_0_clkout1_buf_en));
(* CE_TYPE = "SYNC" *) 
   (* XILINX_LEGACY_PRIM = "BUFGCE" *) 
   (* XILINX_TRANSFORM_PINMAP = "CE:CE0 I:I0" *) 
   (* box_type = "PRIMITIVE" *) 
   BUFGCTRL #(
    .INIT_OUT(0),
    .PRESELECT_I0("TRUE"),
    .PRESELECT_I1("FALSE")) 
     clkout2_buf
       (.CE0(seq_reg2[7]),
        .CE1(1'b0),
        .I0(CLKOUT1),
        .I1(1'b1),
        .IGNORE0(1'b0),
        .IGNORE1(1'b1),
        .O(clk_200),
        .S0(1'b1),
        .S1(1'b0));
(* box_type = "PRIMITIVE" *) 
   BUFH clkout2_buf_en
       (.I(CLKOUT1),
        .O(n_0_clkout2_buf_en));
(* CE_TYPE = "SYNC" *) 
   (* XILINX_LEGACY_PRIM = "BUFGCE" *) 
   (* XILINX_TRANSFORM_PINMAP = "CE:CE0 I:I0" *) 
   (* box_type = "PRIMITIVE" *) 
   BUFGCTRL #(
    .INIT_OUT(0),
    .PRESELECT_I0("TRUE"),
    .PRESELECT_I1("FALSE")) 
     clkout3_buf
       (.CE0(seq_reg3[7]),
        .CE1(1'b0),
        .I0(CLKOUT2),
        .I1(1'b1),
        .IGNORE0(1'b0),
        .IGNORE1(1'b1),
        .O(clk_160),
        .S0(1'b1),
        .S1(1'b0));
(* box_type = "PRIMITIVE" *) 
   BUFH clkout3_buf_en
       (.I(CLKOUT2),
        .O(n_0_clkout3_buf_en));
(* CE_TYPE = "SYNC" *) 
   (* XILINX_LEGACY_PRIM = "BUFGCE" *) 
   (* XILINX_TRANSFORM_PINMAP = "CE:CE0 I:I0" *) 
   (* box_type = "PRIMITIVE" *) 
   BUFGCTRL #(
    .INIT_OUT(0),
    .PRESELECT_I0("TRUE"),
    .PRESELECT_I1("FALSE")) 
     clkout4_buf
       (.CE0(seq_reg4[7]),
        .CE1(1'b0),
        .I0(CLKOUT3),
        .I1(1'b1),
        .IGNORE0(1'b0),
        .IGNORE1(1'b1),
        .O(clk_320),
        .S0(1'b1),
        .S1(1'b0));
(* box_type = "PRIMITIVE" *) 
   BUFH clkout4_buf_en
       (.I(CLKOUT3),
        .O(n_0_clkout4_buf_en));
(* box_type = "PRIMITIVE" *) 
   PLLE2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(40),
    .CLKFBOUT_PHASE(0.000000),
    .CLKIN1_PERIOD(25.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE(40),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT1_DIVIDE(8),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT2_DIVIDE(10),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT3_DIVIDE(5),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.000000),
    .REF_JITTER2(0.000000),
    .STARTUP_WAIT("FALSE")) 
     plle2_adv_inst
       (.CLKFBIN(O),
        .CLKFBOUT(CLKFBOUT),
        .CLKIN1(CLKIN1),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKOUT0(CLKOUT0),
        .CLKOUT1(CLKOUT1),
        .CLKOUT2(CLKOUT2),
        .CLKOUT3(CLKOUT3),
        .CLKOUT4(NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_plle2_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_plle2_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(LOCKED),
        .PWRDWN(1'b0),
        .RST(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[0] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(LOCKED),
        .Q(seq_reg1[0]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[1] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[0]),
        .Q(seq_reg1[1]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[2] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[1]),
        .Q(seq_reg1[2]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[3] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[2]),
        .Q(seq_reg1[3]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[4] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[3]),
        .Q(seq_reg1[4]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[5] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[4]),
        .Q(seq_reg1[5]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[6] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[5]),
        .Q(seq_reg1[6]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg1_reg[7] 
       (.C(n_0_clkout1_buf_en),
        .CE(1'b1),
        .D(seq_reg1[6]),
        .Q(seq_reg1[7]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[0] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(LOCKED),
        .Q(seq_reg2[0]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[1] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[0]),
        .Q(seq_reg2[1]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[2] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[1]),
        .Q(seq_reg2[2]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[3] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[2]),
        .Q(seq_reg2[3]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[4] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[3]),
        .Q(seq_reg2[4]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[5] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[4]),
        .Q(seq_reg2[5]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[6] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[5]),
        .Q(seq_reg2[6]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg2_reg[7] 
       (.C(n_0_clkout2_buf_en),
        .CE(1'b1),
        .D(seq_reg2[6]),
        .Q(seq_reg2[7]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[0] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(LOCKED),
        .Q(seq_reg3[0]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[1] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[0]),
        .Q(seq_reg3[1]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[2] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[1]),
        .Q(seq_reg3[2]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[3] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[2]),
        .Q(seq_reg3[3]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[4] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[3]),
        .Q(seq_reg3[4]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[5] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[4]),
        .Q(seq_reg3[5]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[6] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[5]),
        .Q(seq_reg3[6]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg3_reg[7] 
       (.C(n_0_clkout3_buf_en),
        .CE(1'b1),
        .D(seq_reg3[6]),
        .Q(seq_reg3[7]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[0] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(LOCKED),
        .Q(seq_reg4[0]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[1] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[0]),
        .Q(seq_reg4[1]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[2] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[1]),
        .Q(seq_reg4[2]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[3] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[2]),
        .Q(seq_reg4[3]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[4] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[3]),
        .Q(seq_reg4[4]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[5] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[4]),
        .Q(seq_reg4[5]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[6] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[5]),
        .Q(seq_reg4[6]),
        .R(1'b0));
(* KEEP = "yes" *) 
   FDRE #(
    .INIT(1'b0)) 
     \seq_reg4_reg[7] 
       (.C(n_0_clkout4_buf_en),
        .CE(1'b1),
        .D(seq_reg4[6]),
        .Q(seq_reg4[7]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
