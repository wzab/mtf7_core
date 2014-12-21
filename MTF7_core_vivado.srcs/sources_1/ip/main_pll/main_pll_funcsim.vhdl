-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:32:59 MDT 2014
-- Date        : Sun Dec 21 23:07:34 2014
-- Host        : WZlap running 64-bit Debian GNU/Linux 8.0 (jessie)
-- Command     : write_vhdl -force -mode funcsim
--               /home/xl/ise_projects/cern_update/mtf7_core/MTF7_core_vivado.srcs/sources_1/ip/main_pll/main_pll_funcsim.vhdl
-- Design      : main_pll
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity main_pll_main_pll_clk_wiz is
  port (
    clk_in1 : in STD_LOGIC;
    clk40_aligned : out STD_LOGIC;
    clk_200 : out STD_LOGIC;
    clk_160 : out STD_LOGIC;
    clk_320 : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of main_pll_main_pll_clk_wiz : entity is "main_pll_clk_wiz";
end main_pll_main_pll_clk_wiz;

architecture STRUCTURE of main_pll_main_pll_clk_wiz is
  signal CLKFBOUT : STD_LOGIC;
  signal CLKIN1 : STD_LOGIC;
  signal CLKOUT0 : STD_LOGIC;
  signal CLKOUT1 : STD_LOGIC;
  signal CLKOUT2 : STD_LOGIC;
  signal CLKOUT3 : STD_LOGIC;
  signal LOCKED : STD_LOGIC;
  signal O : STD_LOGIC;
  signal n_0_clkout1_buf_en : STD_LOGIC;
  signal n_0_clkout2_buf_en : STD_LOGIC;
  signal n_0_clkout3_buf_en : STD_LOGIC;
  signal n_0_clkout4_buf_en : STD_LOGIC;
  signal seq_reg1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal seq_reg2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal seq_reg3 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal seq_reg4 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute box_type : string;
  attribute box_type of clkf_buf : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufg : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufg : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufg : label is "AUTO";
  attribute box_type of clkin1_ibufg : label is "PRIMITIVE";
  attribute CE_TYPE : string;
  attribute CE_TYPE of clkout1_buf : label is "SYNC";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of clkout1_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of clkout1_buf : label is "CE:CE0 I:I0";
  attribute box_type of clkout1_buf : label is "PRIMITIVE";
  attribute box_type of clkout1_buf_en : label is "PRIMITIVE";
  attribute CE_TYPE of clkout2_buf : label is "SYNC";
  attribute XILINX_LEGACY_PRIM of clkout2_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP of clkout2_buf : label is "CE:CE0 I:I0";
  attribute box_type of clkout2_buf : label is "PRIMITIVE";
  attribute box_type of clkout2_buf_en : label is "PRIMITIVE";
  attribute CE_TYPE of clkout3_buf : label is "SYNC";
  attribute XILINX_LEGACY_PRIM of clkout3_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP of clkout3_buf : label is "CE:CE0 I:I0";
  attribute box_type of clkout3_buf : label is "PRIMITIVE";
  attribute box_type of clkout3_buf_en : label is "PRIMITIVE";
  attribute CE_TYPE of clkout4_buf : label is "SYNC";
  attribute XILINX_LEGACY_PRIM of clkout4_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP of clkout4_buf : label is "CE:CE0 I:I0";
  attribute box_type of clkout4_buf : label is "PRIMITIVE";
  attribute box_type of clkout4_buf_en : label is "PRIMITIVE";
  attribute box_type of plle2_adv_inst : label is "PRIMITIVE";
  attribute KEEP : string;
  attribute KEEP of \seq_reg1_reg[0]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[1]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[2]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[3]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[4]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[5]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[6]\ : label is "yes";
  attribute KEEP of \seq_reg1_reg[7]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[0]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[1]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[2]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[3]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[4]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[5]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[6]\ : label is "yes";
  attribute KEEP of \seq_reg2_reg[7]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[0]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[1]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[2]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[3]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[4]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[5]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[6]\ : label is "yes";
  attribute KEEP of \seq_reg3_reg[7]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[0]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[1]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[2]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[3]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[4]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[5]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[6]\ : label is "yes";
  attribute KEEP of \seq_reg4_reg[7]\ : label is "yes";
begin
clkf_buf: unisim.vcomponents.BUFG
    port map (
      I => CLKFBOUT,
      O => O
    );
clkin1_ibufg: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => clk_in1,
      O => CLKIN1
    );
clkout1_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false
    )
    port map (
      CE0 => seq_reg1(7),
      CE1 => '0',
      I0 => CLKOUT0,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk40_aligned,
      S0 => '1',
      S1 => '0'
    );
clkout1_buf_en: unisim.vcomponents.BUFH
    port map (
      I => CLKOUT0,
      O => n_0_clkout1_buf_en
    );
clkout2_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false
    )
    port map (
      CE0 => seq_reg2(7),
      CE1 => '0',
      I0 => CLKOUT1,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk_200,
      S0 => '1',
      S1 => '0'
    );
clkout2_buf_en: unisim.vcomponents.BUFH
    port map (
      I => CLKOUT1,
      O => n_0_clkout2_buf_en
    );
clkout3_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false
    )
    port map (
      CE0 => seq_reg3(7),
      CE1 => '0',
      I0 => CLKOUT2,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk_160,
      S0 => '1',
      S1 => '0'
    );
clkout3_buf_en: unisim.vcomponents.BUFH
    port map (
      I => CLKOUT2,
      O => n_0_clkout3_buf_en
    );
clkout4_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false
    )
    port map (
      CE0 => seq_reg4(7),
      CE1 => '0',
      I0 => CLKOUT3,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk_320,
      S0 => '1',
      S1 => '0'
    );
clkout4_buf_en: unisim.vcomponents.BUFH
    port map (
      I => CLKOUT3,
      O => n_0_clkout4_buf_en
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 40,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 25.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 40,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 8,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 10,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 5,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.000000,
      REF_JITTER2 => 0.000000,
      STARTUP_WAIT => "FALSE"
    )
    port map (
      CLKFBIN => O,
      CLKFBOUT => CLKFBOUT,
      CLKIN1 => CLKIN1,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => CLKOUT0,
      CLKOUT1 => CLKOUT1,
      CLKOUT2 => CLKOUT2,
      CLKOUT3 => CLKOUT3,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6) => '0',
      DADDR(5) => '0',
      DADDR(4) => '0',
      DADDR(3) => '0',
      DADDR(2) => '0',
      DADDR(1) => '0',
      DADDR(0) => '0',
      DCLK => '0',
      DEN => '0',
      DI(15) => '0',
      DI(14) => '0',
      DI(13) => '0',
      DI(12) => '0',
      DI(11) => '0',
      DI(10) => '0',
      DI(9) => '0',
      DI(8) => '0',
      DI(7) => '0',
      DI(6) => '0',
      DI(5) => '0',
      DI(4) => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => LOCKED,
      PWRDWN => '0',
      RST => '0'
    );
\seq_reg1_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => LOCKED,
      Q => seq_reg1(0),
      R => '0'
    );
\seq_reg1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(0),
      Q => seq_reg1(1),
      R => '0'
    );
\seq_reg1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(1),
      Q => seq_reg1(2),
      R => '0'
    );
\seq_reg1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(2),
      Q => seq_reg1(3),
      R => '0'
    );
\seq_reg1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(3),
      Q => seq_reg1(4),
      R => '0'
    );
\seq_reg1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(4),
      Q => seq_reg1(5),
      R => '0'
    );
\seq_reg1_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(5),
      Q => seq_reg1(6),
      R => '0'
    );
\seq_reg1_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout1_buf_en,
      CE => '1',
      D => seq_reg1(6),
      Q => seq_reg1(7),
      R => '0'
    );
\seq_reg2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => LOCKED,
      Q => seq_reg2(0),
      R => '0'
    );
\seq_reg2_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(0),
      Q => seq_reg2(1),
      R => '0'
    );
\seq_reg2_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(1),
      Q => seq_reg2(2),
      R => '0'
    );
\seq_reg2_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(2),
      Q => seq_reg2(3),
      R => '0'
    );
\seq_reg2_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(3),
      Q => seq_reg2(4),
      R => '0'
    );
\seq_reg2_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(4),
      Q => seq_reg2(5),
      R => '0'
    );
\seq_reg2_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(5),
      Q => seq_reg2(6),
      R => '0'
    );
\seq_reg2_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout2_buf_en,
      CE => '1',
      D => seq_reg2(6),
      Q => seq_reg2(7),
      R => '0'
    );
\seq_reg3_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => LOCKED,
      Q => seq_reg3(0),
      R => '0'
    );
\seq_reg3_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(0),
      Q => seq_reg3(1),
      R => '0'
    );
\seq_reg3_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(1),
      Q => seq_reg3(2),
      R => '0'
    );
\seq_reg3_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(2),
      Q => seq_reg3(3),
      R => '0'
    );
\seq_reg3_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(3),
      Q => seq_reg3(4),
      R => '0'
    );
\seq_reg3_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(4),
      Q => seq_reg3(5),
      R => '0'
    );
\seq_reg3_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(5),
      Q => seq_reg3(6),
      R => '0'
    );
\seq_reg3_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout3_buf_en,
      CE => '1',
      D => seq_reg3(6),
      Q => seq_reg3(7),
      R => '0'
    );
\seq_reg4_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => LOCKED,
      Q => seq_reg4(0),
      R => '0'
    );
\seq_reg4_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(0),
      Q => seq_reg4(1),
      R => '0'
    );
\seq_reg4_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(1),
      Q => seq_reg4(2),
      R => '0'
    );
\seq_reg4_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(2),
      Q => seq_reg4(3),
      R => '0'
    );
\seq_reg4_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(3),
      Q => seq_reg4(4),
      R => '0'
    );
\seq_reg4_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(4),
      Q => seq_reg4(5),
      R => '0'
    );
\seq_reg4_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(5),
      Q => seq_reg4(6),
      R => '0'
    );
\seq_reg4_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => n_0_clkout4_buf_en,
      CE => '1',
      D => seq_reg4(6),
      Q => seq_reg4(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity main_pll is
  port (
    clk_in1 : in STD_LOGIC;
    clk40_aligned : out STD_LOGIC;
    clk_200 : out STD_LOGIC;
    clk_160 : out STD_LOGIC;
    clk_320 : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of main_pll : entity is true;
  attribute core_generation_info : string;
  attribute core_generation_info of main_pll : entity is "main_pll,clk_wiz_v5_1,{component_name=main_pll,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=PLL,num_out_clk=4,clkin1_period=25.0,clkin2_period=10.0,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}";
end main_pll;

architecture STRUCTURE of main_pll is
begin
U0: entity work.main_pll_main_pll_clk_wiz
    port map (
      clk40_aligned => clk40_aligned,
      clk_160 => clk_160,
      clk_200 => clk_200,
      clk_320 => clk_320,
      clk_in1 => clk_in1
    );
end STRUCTURE;
