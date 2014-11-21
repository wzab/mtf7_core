// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:31:15 MDT 2014
// Date        : Tue Nov  4 13:21:30 2014
// Host        : adrian-lap running 64-bit Debian GNU/Linux testing (jessie)
// Command     : write_verilog -force -mode synth_stub
//               /home/adrian/praca/elka/CMS/firmware/MTF7_core_vivado/MTF7_core_vivado.srcs/sources_1/ip/main_pll/main_pll_stub.v
// Design      : main_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module main_pll(clk_in1, clk40_aligned, clk_200)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk40_aligned,clk_200" */;
  input clk_in1;
  output clk40_aligned;
  output clk_200;
endmodule
