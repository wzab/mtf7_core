-- file: main_pll_clk_wiz.vhd
-- 
-- (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
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
-- 
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- None
--
------------------------------------------------------------------------------
--  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
--   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
------------------------------------------------------------------------------
-- CLK_OUT1____40.000______0.000______50.0______130.435____132.071
-- CLK_OUT2___200.000______0.000______50.0______105.065____132.071
-- CLK_OUT3___160.000______0.000______50.0______108.158____132.071
-- CLK_OUT4___320.000______0.000______50.0_______98.955____132.071
--
------------------------------------------------------------------------------
-- Input Clock   Freq (MHz)    Input Jitter (UI)
------------------------------------------------------------------------------
-- __primary__________40.000____________0.010

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity main_pll_clk_wiz is
port
 (-- Clock in ports
  clk_in1           : in     std_logic;
  -- Clock out ports
  clk40_aligned          : out    std_logic;
  clk_200          : out    std_logic;
  clk_160          : out    std_logic;
  clk_320          : out    std_logic
 );
end main_pll_clk_wiz;

architecture xilinx of main_pll_clk_wiz is
  -- Input clock buffering / unused connectors
  signal clk_in1_main_pll      : std_logic;
  -- Output clock buffering / unused connectors
  signal clkfbout_main_pll         : std_logic;
  signal clkfbout_buf_main_pll     : std_logic;
  signal clkfboutb_unused : std_logic;
  signal clk40_aligned_main_pll          : std_logic;
  signal clk40_aligned_main_pll_en_clk   : std_logic;
  signal clkout0b_unused         : std_logic;
  signal clk_200_main_pll          : std_logic;
  signal clk_200_main_pll_en_clk   : std_logic;
  signal clkout1b_unused         : std_logic;
  signal clk_160_main_pll          : std_logic;
  signal clk_160_main_pll_en_clk   : std_logic;
  signal clkout2b_unused         : std_logic;
  signal clk_320_main_pll          : std_logic;
  signal clk_320_main_pll_en_clk   : std_logic;
  signal clkout3b_unused  : std_logic;
  signal clkout4_unused   : std_logic;
  signal clkout5_unused   : std_logic;
  signal clkout6_unused   : std_logic;
  -- Dynamic programming unused signals
  signal do_unused        : std_logic_vector(15 downto 0);
  signal drdy_unused      : std_logic;
  -- Dynamic phase shift unused signals
  signal psdone_unused    : std_logic;
  signal locked_int : std_logic;
  -- Unused status signals
  signal clkfbstopped_unused : std_logic;
  signal clkinstopped_unused : std_logic;
  signal seq_reg1       : std_logic_vector(7 downto 0) := (others => '0');
  signal seq_reg2       : std_logic_vector(7 downto 0) := (others => '0');
  signal seq_reg3       : std_logic_vector(7 downto 0) := (others => '0');
  signal seq_reg4       : std_logic_vector(7 downto 0) := (others => '0');
  attribute ASYNC_REG   : string;
  attribute ASYNC_REG of seq_reg1: signal is "TRUE";
  attribute keep: boolean;
  attribute keep of seq_reg1: signal is true;
  attribute ASYNC_REG of seq_reg2: signal is "TRUE";
  attribute keep of seq_reg2: signal is true;
  attribute ASYNC_REG of seq_reg3: signal is "TRUE";
  attribute keep of seq_reg3: signal is true;
  attribute ASYNC_REG of seq_reg4: signal is "TRUE";
  attribute keep of seq_reg4: signal is true;

begin


  -- Input buffering
  --------------------------------------
  clkin1_ibufg : IBUF
  port map
   (O => clk_in1_main_pll,
    I => clk_in1);



  -- Clocking PRIMITIVE
  --------------------------------------
  -- Instantiation of the MMCM PRIMITIVE
  --    * Unused inputs are tied off
  --    * Unused outputs are labeled unused
  plle2_adv_inst : PLLE2_ADV
  generic map
   (BANDWIDTH            => "OPTIMIZED",
    COMPENSATION         => "ZHOLD",
    DIVCLK_DIVIDE        => 1,
    CLKFBOUT_MULT        => 40,
    CLKFBOUT_PHASE       => 0.000,
    CLKOUT0_DIVIDE       => 40,
    CLKOUT0_PHASE        => 0.000,
    CLKOUT0_DUTY_CYCLE   => 0.500,
    CLKOUT1_DIVIDE       => 8,
    CLKOUT1_PHASE        => 0.000,
    CLKOUT1_DUTY_CYCLE   => 0.500,
    CLKOUT2_DIVIDE       => 10,
    CLKOUT2_PHASE        => 0.000,
    CLKOUT2_DUTY_CYCLE   => 0.500,
    CLKOUT3_DIVIDE       => 5,
    CLKOUT3_PHASE        => 0.000,
    CLKOUT3_DUTY_CYCLE   => 0.500,
    CLKIN1_PERIOD        => 25.0)
  port map
    -- Output clocks
   (
    CLKFBOUT            => clkfbout_main_pll,
    CLKOUT0             => clk40_aligned_main_pll,
    CLKOUT1             => clk_200_main_pll,
    CLKOUT2             => clk_160_main_pll,
    CLKOUT3             => clk_320_main_pll,
    CLKOUT4             => clkout4_unused,
    CLKOUT5             => clkout5_unused,
    -- Input clock control
    CLKFBIN             => clkfbout_buf_main_pll,
    CLKIN1              => clk_in1_main_pll,
    CLKIN2              => '0',
    -- Tied to always select the primary input clock
    CLKINSEL            => '1',
    -- Ports for dynamic reconfiguration
    DADDR               => (others => '0'),
    DCLK                => '0',
    DEN                 => '0',
    DI                  => (others => '0'),
    DO                  => do_unused,
    DRDY                => drdy_unused,
    DWE                 => '0',
    -- Other control and status signals
    LOCKED              => locked_int,
    PWRDWN              => '0',
    RST                 => '0');


  -- Output buffering
  -------------------------------------

  clkf_buf : BUFG
  port map
   (O => clkfbout_buf_main_pll,
    I => clkfbout_main_pll);



  clkout1_buf : BUFGCE
  port map
   (O   => clk40_aligned,
    CE  => seq_reg1(7),
    I   => clk40_aligned_main_pll);

  clkout1_buf_en : BUFH
  port map
   (O   => clk40_aligned_main_pll_en_clk,
    I   => clk40_aligned_main_pll);
   
  process(clk40_aligned_main_pll_en_clk)
  begin
     if clk40_aligned_main_pll_en_clk'event and clk40_aligned_main_pll_en_clk = '1' then
        seq_reg1 <= seq_reg1(6 downto 0) & locked_int;
     end if;
  end process;


  clkout2_buf : BUFGCE
  port map
   (O   => clk_200,
    CE  => seq_reg2(7),
    I   => clk_200_main_pll);

  clkout2_buf_en : BUFH
  port map
   (O   => clk_200_main_pll_en_clk,
    I   => clk_200_main_pll);
   
  process(clk_200_main_pll_en_clk)
  begin
     if clk_200_main_pll_en_clk'event and clk_200_main_pll_en_clk = '1' then
        seq_reg2 <= seq_reg2(6 downto 0) & locked_int;
     end if;
  end process;

  clkout3_buf : BUFGCE
  port map
   (O   => clk_160,
    CE  => seq_reg3(7),
    I   => clk_160_main_pll);

  clkout3_buf_en : BUFH
  port map
   (O   => clk_160_main_pll_en_clk,
    I   => clk_160_main_pll);
   
  process(clk_160_main_pll_en_clk)
  begin
     if clk_160_main_pll_en_clk'event and clk_160_main_pll_en_clk = '1' then
        seq_reg3 <= seq_reg3(6 downto 0) & locked_int;
     end if;
  end process;

  clkout4_buf : BUFGCE
  port map
   (O   => clk_320,
    CE  => seq_reg4(7),
    I   => clk_320_main_pll);

  clkout4_buf_en : BUFH
  port map
   (O   => clk_320_main_pll_en_clk,
    I   => clk_320_main_pll);
   
  process(clk_320_main_pll_en_clk)
  begin
     if clk_320_main_pll_en_clk'event and clk_320_main_pll_en_clk = '1' then
        seq_reg4 <= seq_reg4(6 downto 0) & locked_int;
     end if;
  end process;
   

end xilinx;
