-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2005 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

package LPMComp_UniTech is

  type     TUT_IOMODE     is (NOT_CONN,
                              IN_WIRE,      OUT_WIRE,
                              IN_LVDS_25,   OUT_LVDS_25,
                              IN_LVDS_33,   OUT_LVDS_33,
                              IN_LVCMOS25,  OUT_LVCMOS25,  TRI_LVCMOS25,
                              IN_LVCMOS33,  OUT_LVCMOS33,  TRI_LVCMOS33,
                              IN_BLVDS_25,  OUT_BLVDS_25,  TRI_BLVDS_25,
                              IN_UNDEF_SIM, OUT_UNDEF_SIM, TRI_UNDEF_SIM
                           );

  type     TUTV_IOMODE		is array(TN range <>) of TUT_IOMODE;

  component UT_TRI_MODE is
    generic (
      UT_IOMODE			:TUT_IOMODE
    );
    port(
      p_p			:inout TSL;
      p_n			:inout TSL;
      o_p               	:out   TSL;
      o_n			:out   TSL;
      o		        	:out   TSL;
      i_p               	:in    TSL := '0';
      i_n               	:in    TSL := '0';
      i                 	:in    TSL := '0';
      e_p               	:in    TSL := '0';
      e_n               	:in    TSL := '0';
      e                 	:in    TSL := '0'
    );
  end component UT_TRI_MODE;

  component UT_GLOBAL is
    port(
      i				:in    TSL;
      o				:out   TSL
    );
  end component;

  component UT_IN_SIMM is
    port(
      p_p			:in    TSL;
      p_n			:in    TSL;
      o				:out   TSL
    );
  end component;

  component UT_GIN_SIMM is
    port(
      p_p			:in    TSL;
      p_n			:in    TSL;
      o				:out   TSL
    );
  end component;

  component UT_OUT_SIMM is
    port(
      i				:in    TSL;
      p_p			:out   TSL;
      p_n			:out   TSL
    );
  end component;

  component UT_TRI_SIMM is
    port(
      i				:in    TSL;
      o				:out   TSL;
      p_p			:inout TSL;
      p_n			:inout TSL;
      e				:in    TSL
    );
  end component;

  component UT_TRI is
    port(
      i				:in    TSL;
      o				:out   TSL;
      p				:inout TSL;
      e				:in    TSL
    );
  end component;

  component UT_IN_SER2 is
    generic (
      CLK180_ADD                :TL := TRUE
    );
    port (
      rN                        :in  TSL;
      c0                        :in  TSL;
      c180                      :in  TSL := '0';
      i                         :in  TSL;
      o0                        :out TSL;
      o180                      :out TSL
    );
  end component;

  component UT_OUT_SER2 is
    generic (
      CLK180_ADD                :TL := TRUE
    );
    port (
      rN                        :in  TSL;
      c0                        :in  TSL;
      c180                      :in  TSL := '0';
      i0                        :in  TSL;
      i180                      :in  TSL;
      o                         :out TSL
    );
  end component;

  component UT_TRI_SER2_SIMM is
    generic (
      CLK180_ADD                :TL := TRUE
    );
    port (
      rN                        :in    TSL;
      c0                        :in    TSL;
      c180                      :in    TSL := '0';
      i0                        :in    TSL := '0';
      i180                      :in    TSL := '0';
      o0                        :out   TSL;
      o180                      :out   TSL;
      p_p                       :inout TSL;
      p_n                       :inout TSL;
      e0                        :in    TSL := '0';
      e180                      :in    TSL := '0'
    );
  end component;

  component UTLPM_DPM_SYNCH
    generic (
      LPM_DATA_WIDTH		:in TN := 0;
      LPM_ADDR_WIDTH		:in TN := 0
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      wr_ena1			:in  TSL;
      addr1			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in1			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out1			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      wr_ena2			:in  TSL;
      addr2			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in2			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out2			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;
  
  component UTLPM_DPM_PROG
    generic (
      LPM_ADDR_WIDTH		:in TN := 0;
      LPM_DATA_WIDTH		:in TN := 0;
      LPM_MDATA_WIDTH		:in TN := 0;
      ADDRESS_SEPARATE		:in boolean := FALSE;
      INIT_CLEAR_ENA		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      wr_ena			:in  TSL;
      wr_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      wr_data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      rd_ena			:in  TSL;
      rd_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_data			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_str			:in  TSL;
      mem_wr			:in  TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      mem_data_in		:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;
  
  component UTLPM_MODIFY_CLOCK
    generic (
      LPM_MULTIP_CLOCK		:in TN := 0;
      LPM_DIVIDE_CLOCK		:in TN := 0;
      CLOCK_IN_FREQ_MHZ		:in TN := 0
    );
    port(
      resetN			:in  TSL;
      clk_in			:in  TSL;
      clk_out			:out TSL;
      clk90_out			:out TSL;
      mclk_out			:out TSL;
      mclk90_out		:out TSL;
      locked			:out TSL
    );
  end component;

  component UTLPM_BUSTRI_MODE is
    generic (
      LPM_IOMODE		:TUTV_IOMODE;
      LPM_WIDTH			:TN := 0
    );
    port(
      p_p			:inout TSLV(LPM_WIDTH-1 downto 0);
      p_n			:inout TSLV(LPM_WIDTH-1 downto 0);
      o_p               	:out   TSLV(LPM_WIDTH-1 downto 0);
      o_n               	:out   TSLV(LPM_WIDTH-1 downto 0);
      o                 	:out   TSLV(LPM_WIDTH-1 downto 0);
      i_p               	:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      i_n			:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      i		        	:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e_p               	:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e_n               	:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e                 	:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0')
    );
  end component UTLPM_BUSTRI_MODE;

  component UTLPM_BUS_GLOBAL is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      i				:in  TSLV(LPM_WIDTH-1 downto 0);
      o				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component UTLPM_BUSIN_SIMM is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      p_p			:in  TSLV(LPM_WIDTH-1 downto 0);
      p_n			:in  TSLV(LPM_WIDTH-1 downto 0);
      o				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component UTLPM_BUSOUT_SIMM is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      i				:in  TSLV(LPM_WIDTH-1 downto 0);
      p_p			:out TSLV(LPM_WIDTH-1 downto 0);
      p_n			:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component UTLPM_BUSTRI_SIMM is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      i				:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      o				:out   TSLV(LPM_WIDTH-1 downto 0);
      p_p			:inout TSLV(LPM_WIDTH-1 downto 0);
      p_n			:inout TSLV(LPM_WIDTH-1 downto 0);
      o_e			:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e				:in    TSL := '0'
    );
  end component;

  component UTLPM_BUSTRI is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      i				:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      o				:out   TSLV(LPM_WIDTH-1 downto 0);
      p				:inout TSLV(LPM_WIDTH-1 downto 0);
      o_e			:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e				:in    TSL := '0'
    );
  end component;

  component UTLPM_BUSOC is
    generic (
      LPM_WIDTH			:TN := 0
    );
    port(
      i				:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      o				:out   TSLV(LPM_WIDTH-1 downto 0);
      p				:inout TSLV(LPM_WIDTH-1 downto 0);
      o_e			:in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e				:in    TSL := '0'
    );
  end component;

  component UTLPM_BUSIN_SER2 is
    generic (
      LPM_WIDTH			:TN := 0;
      CLK180_ADD                :TL := TRUE
    );
    port(
      rN                        :in  TSL;
      c0                        :in  TSL;
      c180                      :in  TSL := '0';
      i                         :in  TSLV(LPM_WIDTH-1 downto 0);
      o0                        :out TSLV(LPM_WIDTH-1 downto 0);
      o180                      :out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component UTLPM_BUSOUT_SER2 is
    generic (
      LPM_WIDTH			:TN := 0;
      CLK180_ADD                :TL := TRUE
    );
    port(
      rN                        :in  TSL;
      c0                        :in  TSL;
      c180                      :in  TSL := '0';
      i0                        :in  TSLV(LPM_WIDTH-1 downto 0);
      i180                      :in  TSLV(LPM_WIDTH-1 downto 0);
      o                         :out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component UTLPM_BUSTRI_SER2_SIMM is
    generic (
      LPM_WIDTH                 :TN := 0;
      CLK180_ADD                :TL := TRUE
    );
    port (
      rN                        :in    TSL;
      c0                        :in    TSL;
      c180                      :in    TSL := '0';
      i0                        :in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      i180                      :in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      o0                        :out   TSLV(LPM_WIDTH-1 downto 0);
      o180                      :out   TSLV(LPM_WIDTH-1 downto 0);
      p_p                       :inout TSLV(LPM_WIDTH-1 downto 0);
      p_n                       :inout TSLV(LPM_WIDTH-1 downto 0);
      e0                        :in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e180                      :in    TSLV(LPM_WIDTH-1 downto 0) := (others =>'0');
      e                         :in    TSL := '0'
    );
  end component;

end LPMComp_UniTech;


