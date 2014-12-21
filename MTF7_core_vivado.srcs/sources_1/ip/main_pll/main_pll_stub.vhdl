-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:32:59 MDT 2014
-- Date        : Sun Dec 21 23:07:33 2014
-- Host        : WZlap running 64-bit Debian GNU/Linux 8.0 (jessie)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/xl/ise_projects/cern_update/mtf7_core/MTF7_core_vivado.srcs/sources_1/ip/main_pll/main_pll_stub.vhdl
-- Design      : main_pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_pll is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk40_aligned : out STD_LOGIC;
    clk_200 : out STD_LOGIC;
    clk_160 : out STD_LOGIC;
    clk_320 : out STD_LOGIC
  );

end main_pll;

architecture stub of main_pll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk40_aligned,clk_200,clk_160,clk_320";
begin
end;
