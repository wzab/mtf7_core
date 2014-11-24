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

package LPMSynchro is

  component STREAM_DEMUX2 is
    generic (
      LPM_DATA_WIDTH		:in TN := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      phase_in			:in  TSL;
      data_out			:out TSLV((2*LPM_DATA_WIDTH)-1 downto 0);
      clock_quality		:out TSL;
      phase_quality		:out TSL
    );
  end component;

  component CLOCK_SYNCHRO is
    generic (
      LPM_DATA_WIDTH		:in TN := 0;
      INPUT_REGISTERED		:in TL := TRUE;
      OUTPUT_REGISTERED		:in TL := TRUE
    );
    port(
      resetN			:in  TSL;
      clock_in			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      clock_out			:in  TSL;
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      phase_out			:out TSL
    );
  end component;

  component CLOCK_STROBE is
    generic (
      LPM_CLOCK_MULTIPL		:in TI := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mclock			:in  TSL;
      strobe			:out TSL
    );
  end component;

  component WINDOW_PULSER is
    generic (
      LPM_DATA_WIDTH		:in TN := 0;
      OUTPUT_REGISTERED		:in TL := TRUE
    );
    port(
      resetN			:in  TSL;
      win_open			:in  TSL;
      win_close			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      full_out_switch		:in  TSL;
      edge_pulse_switch		:in  TSL;
      data_win_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_prog_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component WINDOW_SYNCHRO is
    generic (
      LPM_DATA_WIDTH		:in TN := 0;
      OUTPUT_REGISTERED		:in TL := TRUE
    );
    port(
      resetN			:in  TSL;
      win_open			:in  TSL;
      win_close			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      clock_out			:in  TSL;
      full_out_switch		:in  TSL;
      edge_pulse_switch		:in  TSL;
      data_win_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_prog_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      phase_out			:out TSL
    );
  end component;

  component BCN0_SYNCHRO is
    generic (
      LPM_DATA_WIDTH		:in TN := 0;
      LPM_PIPE_LEN		:in TN := 0;
      INPUT_REGISTERED		:in TL := TRUE;
      BCN0_REGISTERED		:in TL := TRUE;
      OUTPUT_REGISTERED		:in TL := TRUE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      bcn0_in			:in  TSL;
      bcn0			:in  TSL;
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      pos_out			:out TSLV(TVLcreate(LPM_PIPE_LEN)-1 downto 0);
      synch_out			:out TSL
    );
  end component;

  component FFDELAY is
    port(
      data_in			:in  TSL;
      data_out			:out TSL;
      delay_strobe		:out TSL
    );
  end component;

  component STREAM_DELAY is
    generic (
      LPM_DATA_WIDTH		:in TN := 0
    );
    port(
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      delay_strobe		:out TSL
    );
  end component;

  component LPM_TIMER_ENGINE is
    generic (
      LPM_TIMER_SIZE		:in TN := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena_in		:in  TSL;
      clk_ena_out		:out TSL;
      start			:in  TSL;
      trigger			:in  TSL;
      repeat			:in  TSL;
      stop			:out TSL;
      limit			:in  TSLv(LPM_TIMER_SIZE-1 downto 0);
      count			:out TSLv(LPM_TIMER_SIZE-1 downto 0)
    );
  end component;

  component LPM_FILL_SPS2001_ENGINE is
    generic (
      SPS_START_DELAY_SIZE	:TN := 0;
      SPS_FILL_COUNT_LIMIT	:TN := 0;
      SPS_REVOL_COUNT_SIZE	:TN := 0;
      SPS_ACTIVE_COUNT_SIZE	:TN := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      start			:in  TSL;
      start_delay		:in  TSLV(SPS_START_DELAY_SIZE-1 downto 0);
      revol_limit		:in  TSLV(SPS_REVOL_COUNT_SIZE-1 downto 0);
      active_limit		:in  TSLV(SPS_ACTIVE_COUNT_SIZE-1 downto 0);
      fill_ena			:out TSL;
      fill_pos			:out TSLV(TVLcreate(SPS_FILL_COUNT_LIMIT)-1 downto 0)
    );
  end component;

  component LPM_OVERSAMPLING is
    generic (
      LPM_DATA_WIDTH		:TN := 0;
      LPM_FCLK_NUM		:TN := 0;
      LPM_FCLK_PERIODS		:TN := 0
    );
    port(
      resetN			:in  TSL;
      fclk			:in  TSLV(LPM_FCLK_NUM-1 downto 0);
      clk			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      fclk_sel			:in  TSLV(TVLcreate(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1)-1 downto 0);
      fclk_valid_ena		:in  TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
      fclk_valid		:out TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_valid		:out TSL;
      fclk_validN		:out TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
      data_outN			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_validN		:out TSL
    );
  end component;

  component LPM_DATA_PHASE is
    generic (
      LPM_MUX_WIDTH		:TN := 4;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := TRUE;
      LPM_MCLK180_ADD		:TL := TRUE;
      LPM_MCLK270_ADD		:TL := TRUE
    );
    port(
      resetN			:in  TSL;
      mclk0			:in  TSL;
      mclk90			:in  TSL := '0';
      mclk180			:in  TSL := '0';
      mclk270			:in  TSL := '0';
      din			:in  TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
      mdout			:out TSLV(LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_DATA_REPHASE is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := FALSE;
      LPM_MCLK180_ADD		:TL := TRUE;
      LPM_MCLK270_ADD		:TL := TRUE
    );
    port(
      resetN			:in  TSL;
      mclk0			:in  TSL;
      mclk90			:in  TSL := '0';
      mclk180			:in  TSL := '0';
      mclk270			:in  TSL := '0';
      mdin			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      dout			:out TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_DATA_TRANSPHASE_SIMM is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := FALSE;
      LPM_CLK180_ADD		:TL := TRUE;
      LPM_CLK270_ADD		:TL := TRUE
    );
    port(
      resetN			:in    TSL;
      clk0			:in    TSL;
      clk90			:in    TSL := '0';
      clk180			:in    TSL := '0';
      clk270			:in    TSL := '0';
      din			:in    TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0) := (others => (others => '0'));
      dout			:out   TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
      mtriN			:inout TSLV(LPM_MUX_WIDTH-1 downto 0);
      mtriP			:inout TSLV(LPM_MUX_WIDTH-1 downto 0);
      mtrie			:in    TSL := '0'
    );
  end component;

  component LPM_DATA_MUX_V1 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_CLOCK_MULTIPL		:TN := 0;
      SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      INPUT_REGISTERED		:TL := FALSE;
      INPUT_MUX_REGISTERED	:TL := FALSE;
      STROBE_ASET_ENA		:TL := FALSE;
      OUTPUT_MUX_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mux_clock			:in  TSL;
      clock_inv			:in  TSL;
      strobe			:in  TSL;
      data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
      mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_DATA_MUX_V2 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_EXT_PHASE_ENA		:TL := FALSE;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := FALSE;
      LPM_MCLK180_ADD		:TL := TRUE;
      LPM_MCLK270_ADD		:TL := TRUE;
      LPM_OVERCLOCK_MULTIPL	:TI := 0;
      SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      INPUT_REGISTERED		:TL := FALSE;
      INPUT_MUX_REGISTERED	:TL := FALSE;
      STROBE_AUTO_ENA		:TL := FALSE;
      OUTPUT_MUX_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mux_clock			:in  TSL;
      mux_clock90		:in  TSL := '0';
      mux_clock180		:in  TSL := '0';
      mux_clock270		:in  TSL := '0';
      clock_inv			:in  TSL := '0';
      strobe			:in  TSL := '0';
      data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
      mux_data			:out TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_DATA_DEMUX_V1 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_CLOCK_MULTIPL		:TN := 0;
      SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      CLOCK_PIPE_ENA		:TL := FALSE;
      STROBE_ENABLE		:TL := FALSE;
      STROBE_REGISTERED		:TL := FALSE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      mux_clock			:in  TSL;
      mux_clock90		:in  TSL;
      clock			:in  TSL;
      strobe			:in  TSL;
      mux_data_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_clk90		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_reg_add		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_delay		:in  TSLV(TVLcreate(LPM_MUX_MULTIPL*LPM_CLOCK_MULTIPL-1)-1 downto 0);
      clock_inv			:in  TSL;
      mux_data			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_DATA_DEMUX_V2 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_EXT_PHASE_ENA		:TL := FALSE;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := FALSE;
      LPM_MCLK180_ADD		:TL := TRUE;
      LPM_MCLK270_ADD		:TL := TRUE;
      LPM_OVERCLOCK_MULTIPL	:TN := 0;
      LPM_LAT_DELAY_POS		:TN := 0;
      SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      STROBE_ENABLE		:TL := FALSE;
      STROBE_REGISTERED		:TL := FALSE;
      PROCESS_REGISTERED	:TL := TRUE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      mux_clock			:in  TSL;
      mux_clock90		:in  TSL := '0';
      mux_clock180		:in  TSL := '0';
      mux_clock270		:in  TSL := '0';
      clock			:in  TSL;
      strobe			:in  TSL := '0';
      mux_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others => '0');
      mux_clk90			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others => '0');
      mux_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_MUX_MULTIPL*LPM_OVERCLOCK_MULTIPL-1)-1 downto 0) := (others => '0');
      lat_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_LAT_DELAY_POS)-1 downto 0);
      mux_data			:in  TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0);
      data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0)
    );
  end component;

  component LPM_PART_DATA_SENDER_V1 is
    generic (
      LPM_PART_WIDTH		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      INPUT_REGISTERED		:TL := FALSE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      part_ena			:in  TSL;
      check_ena			:in  TSL;
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
      out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      test_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      test_ena			:in  TSL;
      check_data_ena	:in  TSL;
      test_rand_ena		:in  TSL
    );
  end component;

  component LPM_PART_DATA_SENDER_V2 is
    generic (
      LPM_PART_WIDTH		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      INPUT_REGISTERED		:TL := FALSE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      part_ena			:in  TSL := '0';
      check_ena			:in  TSL := '0';
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
      out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      test_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0) := (others => '0');
      test_ena			:in  TSL := '0';
      check_data_ena		:in  TSL := '0';
      test_data_rnd_ena		:in  TSL := '0';
      test_part_rnd_ena		:in  TSL := '0'
    );
  end component;

  component LPM_MUX_DATA_SENDER_V1 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_CLOCK_MULTIPL		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      MUX_SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      PART_INPUT_REGISTERED	:TL := FALSE;
      PART_OUTPUT_REGISTERED	:TL := FALSE;
      MUX_INPUT_REGISTERED	:TL := FALSE;
      MUX_STROBE_ASET_ENA	:TL := FALSE;
      MUX_OUTPUT_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mux_clock			:in  TSL;
      clock_inv			:in  TSL;
      strobe			:in  TSL;
      part_ena			:in  TSL;
      check_ena			:in  TSL;
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL;
      data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
      mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0);
      test_data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
      test_ena			:in  TSL;
      test_rand_ena		:in  TSL
    );
  end component;

  component LPM_MUX_DATA_SENDER_V2 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_OVERCLOCK_MULTIPL	:TI := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      MUX_SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      PART_INPUT_REGISTERED	:TL := FALSE;
      PART_OUTPUT_REGISTERED	:TL := FALSE;
      MUX_INPUT_REGISTERED	:TL := FALSE;
      MUX_STROBE_AUTO_ENA	:TL := FALSE;
      MUX_OUTPUT_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mux_clock			:in  TSL := '0';
      mux_clock90		:in  TSL := '0';
      mux_clock180		:in  TSL := '0';
      mux_clock270		:in  TSL := '0';
      clock_inv			:in  TSL := '0';
      strobe			:in  TSL := '0';
      part_ena			:in  TSL := '0';
      check_ena			:in  TSL := '0';
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL := '0';
      data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
      mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0);
      test_data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0) := (others => '0');
      test_ena			:in  TSL := '0';
      test_data_rnd_ena		:in  TSL := '0';
      test_part_rnd_ena		:in  TSL := '0'
    );
  end component;

  component LPM_PART_DATA_RECEIVER_V1 is
    generic (
      LPM_PART_WIDTH		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      LPM_DELAY_WIDTH		:TN := 0;
      INPUT_REGISTERED		:TL := FALSE;
      CHECK_REGISTERED		:TL := FALSE;
      INPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clock_inv			:in  TSL;
      data_delay		:in  TSLV(maximum(LPM_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
      part_ena			:in  TSL;
      check_ena			:in  TSL;
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL;
      in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
      test_ena			:in  TSL;
      test_rand_ena		:in  TSL;
      test_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      data_valid		:out TSL;
      test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
      test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
    );
  end component;

  component LPM_PART_DATA_RECEIVER_V2 is
    generic (
      LPM_PART_WIDTH		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      LPM_DELAY_POS		:TN := 0;
      INPUT_REGISTERED		:TL := FALSE;
      CHECK_REGISTERED		:TL := FALSE;
      INPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_REGISTERED		:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clock_inv			:in  TSL := '0';
      data_delay		:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others =>'0');
      part_ena			:in  TSL := '0';
      check_ena			:in  TSL := '0';
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL := '0';
      in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
      test_ena			:in  TSL := '0';
      test_data_rnd_ena		:in  TSL := '0';
      test_part_rnd_ena		:in  TSL := '0';
      test_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
      data_valid		:out TSL;
      test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
      test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0);
      sync_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
      sync_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
    );
  end component;

  component LPM_MUX_DATA_RECEIVER_V1 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_CLOCK_MULTIPL		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_DELAY_WIDTH		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      MUX_SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      DEMUX_CLOCK_PIPE_ENA	:TL := FALSE;
      DEMUX_STROBE_ENABLE	:TL := FALSE;
      DEMUX_STROBE_REGISTERED	:TL := FALSE;
      DEMUX_OUTPUT_REGISTERED	:TL := FALSE;
      INPUT_PART_REGISTERED	:TL := FALSE;
      CHECK_PART_REGISTERED	:TL := FALSE;
      INPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_DELAY_REGISTERED	:TL := FALSE;
      OUTPUT_PART_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clock_inv			:in  TSL;
      mux_clock			:in  TSL;
      mux_clock90			:in  TSL;
      strobe			:in  TSL;
      mux_data_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_clk90		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_reg_add		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      mux_data_delay		:in  TSLV(TVLcreate(LPM_MUX_MULTIPL*LPM_CLOCK_MULTIPL-1)-1 downto 0);
      data_delay		:in  TSLV(maximum(LPM_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
      part_ena			:in  TSL;
      check_ena			:in  TSL;
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL;
      mux_data			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
      data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
      test_ena			:in  TSL;
      test_rand_ena		:in  TSL;
      test_data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
      data_valid		:out TSL;
      test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
      test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
    );
  end component;

  component LPM_MUX_DATA_RECEIVER_V2 is
    generic (
      LPM_MUX_WIDTH		:TN := 0;
      LPM_MUX_MULTIPL		:TN := 0;
      LPM_EXT_PHASE_ENA		:TL := FALSE;
      LPM_PHASE_POS		:TL := TRUE;
      LPM_QPHASE_ENA		:TL := FALSE;
      LPM_MCLK180_ADD		:TL := TRUE;
      LPM_MCLK270_ADD		:TL := TRUE;
      LPM_OVERCLOCK_MULTIPL	:TI := 0;
      LPM_LAT_DELAY_POS		:TN := 0;
      LPM_PART_NUM		:TN := 0;
      LPM_DELAY_POS		:TN := 0;
      LPM_CHECK_WIDTH		:TN := 0;
      MUX_SYMMETRIZATION_ENA	:TL := FALSE;
      MUX_PART_MODE_ENA		:TL := FALSE;
      MUX_DECREASE_ENA		:TL := FALSE;
      DEMUX_STROBE_ENABLE	:TL := FALSE;
      DEMUX_STROBE_REGISTERED	:TL := FALSE;
      DEMUX_PROCESS_REGISTERED	:TL := TRUE;
      DEMUX_OUTPUT_REGISTERED	:TL := FALSE;
      PART_INPUT_REGISTERED	:TL := FALSE;
      PART_CHECK_REGISTERED	:TL := FALSE;
      PART_IN_DELAY_REGISTERED	:TL := FALSE;
      PART_OUT_DELAY_REGISTERED	:TL := FALSE;
      PART_OUTPUT_REGISTERED	:TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      mux_clock			:in  TSL;
      mux_clock90		:in  TSL := '0';
      mux_clock180		:in  TSL := '0';
      mux_clock270		:in  TSL := '0';
      strobe			:in  TSL := '0';
      mux_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others =>'0');
      mux_clk90			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others =>'0');
      mux_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_MUX_MULTIPL*LPM_OVERCLOCK_MULTIPL-1)-1 downto 0);
      lat_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_LAT_DELAY_POS)-1 downto 0);
      data_delay		:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others =>'0');
      part_ena			:in  TSL := '0';
      check_ena			:in  TSL := '0';
      check_data		:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
      check_data_ena		:in  TSL := '0';
      mux_data			:in  TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0);
      data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
      test_ena			:in  TSL := '0';
      test_data_rnd_ena		:in  TSL := '0';
      test_part_rnd_ena		:in  TSL := '0';
      test_data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
      data_valid		:out TSL;
      test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
      test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0);
      sync_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
      sync_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
    );
  end component;

  component LPM_DATA_MUXER is
    generic (
      LPM_DATA_WIDTH		:TN := 4;
      LPM_DATA_NUM		:TN := 16
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      data_in			:in  TSLV(LPM_DATA_WIDTH*LPM_DATA_NUM-1 downto 0);
      data_in_valid		:in  TSLV(LPM_DATA_NUM-1 downto 0);
      data_in_next		:out TSLV(LPM_DATA_NUM-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out_num		:out TSLV(TVLcreate(LPM_DATA_NUM-1)-1 downto 0);
      data_out_valid		:out TSL;
      data_out_next		:in  TSL
    );
  end component;

end LPMSynchro;


-------------------------------------------------------------------
-- CLOCK_SYNCHRO
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity CLOCK_SYNCHRO is
  generic (
    LPM_DATA_WIDTH		:in TN := 4;
    INPUT_REGISTERED		:in TL := FALSE;
    OUTPUT_REGISTERED		:in TL := TRUE
  );
  port(
    resetN			:in  TSL := '0';
    clock_in			:in  TSL := '0';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    clock_out			:in  TSL := '0';
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    phase_out			:out TSL
  );
end CLOCK_SYNCHRO;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of CLOCK_SYNCHRO is

  signal   InPosDataReg			:TSLV(data_in'range);
  signal   InInvDataReg			:TSLV(data_in'range);
  signal   OutPosDataReg		:TSLV(data_in'range);
  signal   OutInvDataReg		:TSLV(data_in'range);
  signal   OutDataReg			:TSLV(data_in'range);
  signal   ClockReg1			:TSL;
  signal   ClockReg2			:TSL;

begin

  l1:if (INPUT_REGISTERED=TRUE) generate
    process(clock_in, resetN) begin
      if (resetN='0') then
        InPosDataReg <= (others => '0');
      elsif (clock_in'event and clock_in='1') then
        InPosDataReg <= data_in;
      end if;
    end process;
  end generate;
  
  l2:if (INPUT_REGISTERED=FALSE) generate
    InPosDataReg <= data_in;
  end generate;

  process(clock_in, resetN) begin
    if (resetN='0') then
      InInvDataReg <= (others => '0');
    elsif (clock_in'event and clock_in='0') then
      InInvDataReg <= InPosDataReg;
    end if;
  end process;  

  process(clock_out, resetN) begin
    if (resetN='0') then
      OutPosDataReg <= (others => '0');
      OutInvDataReg <= (others => '0');
      ClockReg1     <= '0';
    elsif (clock_out'event and clock_out='0') then
      OutPosDataReg <= InPosDataReg;
      OutInvDataReg <= InInvDataReg;
      ClockReg1     <= clock_in;
    end if;
  end process;
  
  l3:if (OUTPUT_REGISTERED=TRUE) generate
    process(clock_out, resetN) begin
      if (resetN='0') then
        OutDataReg    <= (others => '0');
        ClockReg2     <= '0';
      elsif (clock_out'event and clock_out='1') then
        if (ClockReg1='0') then
          OutDataReg  <= OutPosDataReg;
        else
          OutDataReg  <= OutInvDataReg;
        end if;
	ClockReg2 <= ClockReg1;
      end if;
    end process;
  end generate;

  l4:if (OUTPUT_REGISTERED=FALSE) generate
    OutDataReg <= OutPosDataReg when ClockReg1='0' else OutInvDataReg;
    ClockReg2  <= ClockReg1;
  end generate;

  data_out <= OutDataReg;
  phase_out <= not(ClockReg2);

end behaviour;			   

-------------------------------------------------------------------
-- CLOCK_STROBE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity CLOCK_STROBE is
  generic (
    LPM_CLOCK_MULTIPL		:in TI := 8
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mclock			:in  TSL;
    strobe			:out TSL
  );
end CLOCK_STROBE;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of CLOCK_STROBE is

  signal ClockReg   :TSL;
  signal StrobePipe :TSLV(0 to maximum(LPM_CLOCK_MULTIPL,1)-1);
  signal StrobeReg  :TSL;

begin

  lab1: if (LPM_CLOCK_MULTIPL>=2) generate
    process(mclock, resetN) begin
      if (resetN='0') then
        ClockReg   <= '0';
        StrobePipe <= (others => '0');
      elsif (mclock'event and mclock='0') then
        ClockReg <= clock;
        StrobePipe(0) <= clock and not(ClockReg);
        StrobePipe(1 to StrobePipe'length-1) <= StrobePipe(0 to StrobePipe'length-2);
      end if;
    end process;
    process(mclock, resetN) begin
      if (resetN='0') then
        StrobeReg <= '0';
      elsif (mclock'event and mclock='1') then
        StrobeReg <= StrobePipe(LPM_CLOCK_MULTIPL-2);
      end if;
    end process;
    strobe <= StrobeReg;
  end generate;
  --
  lab2: if (LPM_CLOCK_MULTIPL<2) generate
    strobe <= '1';
  end generate;

end behaviour;			   

-------------------------------------------------------------------
-- WINDOW_PULSER
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity WINDOW_PULSER is
  generic (
    LPM_DATA_WIDTH		:in TN := 8;
    OUTPUT_REGISTERED		:in TL := TRUE
  );
  port(
    resetN			:in  TSL := '0';
    win_open			:in  TSL := '0';
    win_close			:in  TSL := '0';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    full_out_switch		:in  TSL;
    edge_pulse_switch		:in  TSL;
    data_win_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_prog_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end WINDOW_PULSER;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMSynchro.all;

architecture behaviour of WINDOW_PULSER is

  signal   OpenDataReg1		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   OpenDataReg2		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   CloseDataReg1	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   CloseDataReg2	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataOpenReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataWinInReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataWinOutReg	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataWinFullReg	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataEdgeProgSig	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataPulseProgReg	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataProgSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataProgReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);

begin

  process(win_open, resetN) begin
    if (resetN='0') then
      OpenDataReg1  <= (others => '0');
      OpenDataReg2  <= (others => '0');
    elsif (win_open'event and win_open='1') then
      OpenDataReg1  <= data_in;
      OpenDataReg2  <= OpenDataReg1;
    end if;
  end process;
  
  process(win_close, resetN) begin
    if (resetN='0') then
      CloseDataReg1  <= (others => '0');
      CloseDataReg2  <= (others => '0');
      DataOpenReg    <= (others => '0');
      DataWinInReg   <= (others => '0');
      DataWinFullReg <= (others => '0');
    elsif (win_close'event and win_close='1') then
      CloseDataReg1  <= data_in;
      CloseDataReg2  <= CloseDataReg1;
      DataOpenReg    <= OpenDataReg2;
      DataWinInReg   <= not(OpenDataReg2) and     CloseDataReg1;
      DataWinFullReg <=     CloseDataReg1 and not(CloseDataReg2);
      DataPulseProgReg <= (DataPulseProgReg or DataEdgeProgSig) and CloseDataReg1; 
    end if;
  end process;
  
  DataEdgeProgSig <= DataWinFullReg                       when (full_out_switch='0') else
                     DataWinFullReg and not(DataWinInReg);

  DataProgSig <= DataEdgeProgSig or (DataPulseProgReg and TSLVnew(DataPulseProgReg'length,edge_pulse_switch));
  
  process (win_close, resetN,DataWinInReg,DataProgSig) begin
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataWinOutReg <= (others=>'0');
      DataProgReg   <= (others=>'0');
    elsif (OUTPUT_REGISTERED=FALSE or (win_close'event and win_close='1')) then
      DataWinOutReg <= not(OpenDataReg2) and     CloseDataReg1; --KTP latency DataWinInReg;
      DataProgReg   <= DataProgSig;
    end if;
  end process;

  data_win_pulse  <= DataWinOutReg;
  data_prog_pulse <= DataProgSig;

end behaviour;			   

-------------------------------------------------------------------
-- WINDOW_SYNCHRO
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity WINDOW_SYNCHRO is
  generic (
    LPM_DATA_WIDTH		:in TN := 8;
    OUTPUT_REGISTERED		:in TL := TRUE
  );
  port(
    resetN			:in  TSL := '0';
    win_open			:in  TSL := '0';
    win_close			:in  TSL := '0';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    clock_out			:in  TSL := '0';
    full_out_switch		:in  TSL;
    edge_pulse_switch		:in  TSL;
    data_win_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_prog_pulse		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    phase_out			:out TSL
  );
end WINDOW_SYNCHRO;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMSynchro.all;

architecture behaviour of WINDOW_SYNCHRO is

  signal   DataWinPulseSig	:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataProgSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataInClkSynSig	:TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  signal   DataOutClkSynSig	:TSLV(2*LPM_DATA_WIDTH-1 downto 0);

begin

  win_puls: WINDOW_PULSER
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      OUTPUT_REGISTERED	=> FALSE
    )
    port map (
      resetN		=> resetN,
      win_open		=> win_open,
      win_close		=> win_close,
      data_in		=> data_in,
      full_out_switch	=> full_out_switch,
      edge_pulse_switch	=> edge_pulse_switch,
      data_win_pulse	=> DataWinPulseSig,
      data_prog_pulse	=> DataProgSig
    );
  
  DataInClkSynSig <= (DataProgSig & DataWinPulseSig);

  clk_syn: CLOCK_SYNCHRO
    generic map (
      LPM_DATA_WIDTH	=> 2*LPM_DATA_WIDTH,
      INPUT_REGISTERED	=> FALSE,
      OUTPUT_REGISTERED	=> OUTPUT_REGISTERED
    )
    port map (
      resetN		=> resetN,
      clock_in		=> win_close,
      data_in		=> DataInClkSynSig,
      clock_out		=> clock_out,
      data_out		=> DataOutClkSynSig,
      phase_out		=> phase_out
    );

    data_prog_pulse <= DataOutClkSynSig(2*LPM_DATA_WIDTH-1 downto 1*LPM_DATA_WIDTH);
    data_win_pulse  <= DataOutClkSynSig(1*LPM_DATA_WIDTH-1 downto 0*LPM_DATA_WIDTH);

end behaviour;			   

-------------------------------------------------------------------
-- BCN0_SYNCHRO
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity BCN0_SYNCHRO is
  generic (
    LPM_DATA_WIDTH		:in TN := 4;
    LPM_PIPE_LEN		:in TN := 4;
    INPUT_REGISTERED		:in TL := TRUE;
    BCN0_REGISTERED		:in TL := TRUE;
    OUTPUT_REGISTERED		:in TL := TRUE
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    bcn0_in			:in  TSL := '0';
    bcn0			:in  TSL := '0';
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    pos_out			:out TSLV(TVLcreate(LPM_PIPE_LEN)-1 downto 0);
    synch_out			:out TSL
  );
end BCN0_SYNCHRO;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of BCN0_SYNCHRO is

  subtype  TDataVec             is TSLV(data_in'range);
  type     TDataArr		is array (LPM_PIPE_LEN-1 downto 0) of TDataVec;

  procedure \sel\(signal BCN0     :in  TSL;
                  signal BCN0In   :in  TSL;
                  signal BCN0Pipe :in  TSLV;
                  signal DataIn   :in  TSLV;
		  signal DataPipe :in  TDataArr;
		  signal DataOut  :out TSLV;
		  signal PosOut   :out TSLV;
		  signal SynchOut :out TSL) is
  begin
    if(BCN0='1') then
      for index in BCN0Pipe'range loop
        if (BCN0Pipe(index)='1') then
          DataOut  <= DataPipe(index);
	  PosOut   <= TSLVconv(index+1,pos_out'length);
	  SynchOut <= '1';
	  return;
        end if;
      end loop;
    end if;
    DataOut  <= DataIn;
    PosOut   <= TSLVconv(0,pos_out'length);
    SynchOut <= BCN0 and BCN0In;
  end procedure;

  signal   DataInReg		:TSLV(data_in'range);
  signal   BCN0InReg		:TSL;
  signal   BCN0Reg		:TSL;
  signal   BCN0InPipe		:TSLV(LPM_PIPE_LEN-1 downto 0);
  signal   DataInPipe		:TDataArr;
  signal   DataOutSig		:TSLV(data_in'range);
  signal   DataOutReg		:TSLV(data_in'range);
  signal   PosOutReg		:TSLV(pos_out'range);
  signal   SynchOutReg		:TSL;

begin

  l1:if (INPUT_REGISTERED=TRUE) generate
    process(clock, resetN) begin
      if (resetN='0') then
        DataInReg <= (others => '0');
        BCN0InReg <= '0';
      elsif (clock'event and clock='1') then
        DataInReg <= data_in;
	BCN0InReg <= bcn0_in;
      end if;
    end process;
  end generate;
  
  l2:if (INPUT_REGISTERED=FALSE) generate
    DataInReg <= data_in;
    BCN0InReg <= bcn0_in;
  end generate;

  l3:if (BCN0_REGISTERED=TRUE) generate
    process(clock, resetN) begin
      if (resetN='0') then
        BCN0Reg <= '0';
      elsif (clock'event and clock='1') then
        BCN0Reg <= bcn0;
      end if;
    end process;
  end generate;
  
  l4:if (INPUT_REGISTERED=FALSE) generate
    BCN0Reg <= bcn0;
  end generate;

  process(clock, resetN)
    variable PosOutVar		:TSLV(pos_out'range);
    variable SynchOutVar	:TSL;
  begin
    if (resetN='0') then
      BCN0InPipe  <= (others => '0');
      DataInPipe  <= (TDataArr'range => (others => '0'));
      PosOutReg   <= (others => '0');
      SynchOutReg <= '0';
    elsif (clock'event and clock='1') then
      BCN0InPipe(0) <= BCN0InReg;
      BCN0InPipe(LPM_PIPE_LEN-1 downto 1) <= BCN0InPipe(LPM_PIPE_LEN-2 downto 0);
      DataInPipe(0) <= DataInReg;
      DataInPipe(LPM_PIPE_LEN-1 downto 1) <= DataInPipe(LPM_PIPE_LEN-2 downto 0);
      if(BCN0Reg='1') then
	PosOutVar   := TSLVconv(0,pos_out'length);
	SynchOutVar := BCN0InReg;
        for index in BCN0InPipe'range loop
          if (BCN0InPipe(index)='1') then
	    PosOutVar   := TSLVconv(index+1,pos_out'length);
	    SynchOutVar := '1';
	    exit;
          end if;
        end loop;
        PosOutReg   <= PosOutVar;
        SynchOutReg <= SynchOutVar;
      end if;
    end if;
  end process;
  
  DataOutSig <= DataInReg when (TNconv(PosOutReg)=0) else DataInPipe(TNconv(PosOutReg)-1); 
  
  l5:if (OUTPUT_REGISTERED=TRUE) generate
    process(clock, resetN) begin
      if (resetN='0') then
        DataOutReg  <= (others => '0');
      elsif (clock'event and clock='1') then
        DataOutReg  <= DataOutSig;
      end if;
    end process;
  end generate;

  l6:if (OUTPUT_REGISTERED=FALSE) generate
    DataOutReg  <= DataOutSig;
  end generate;

  data_out  <= DataOutReg;
  pos_out   <= PosOutReg;
  synch_out <= SynchOutReg;

end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;

entity BCN0_POSITION is
  generic (
    LPM_POS_WIDTH		:in TN := 4;
    LPM_BCN0_ADJ		:in integer := 0;
    INPUT_REGISTERED		:in TL := TRUE
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    bcn0_in			:in  TSL := '0';
    bcn0_ref			:in  TSL := '0';
    position			:out TSLV(LPM_POS_WIDTH-1 downto 0);
    bcn0_in_start		:out TSL
  );
end BCN0_POSITION;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of BCN0_POSITION is

  signal BCN0InReg		:TSL;
  signal BCN0RefReg		:TSL;
  signal BCN0InPipe		:TSL;
  signal BCN0RefPipe		:TSL;
  signal BCNOPipe		:TSLV(maximum(abs(LPM_BCN0_ADJ),1)-1 downto 0);
  signal BCN0Cnt		:TSLV(LPM_POS_WIDTH-1 downto 0);
  signal BCN0InCntStart		:TSL;
  signal CntStart		:TSL;
  signal BCN0Pos		:TSLV(LPM_POS_WIDTH-1 downto 0);
  signal BCN0InStart		:TSL;

begin

  process (resetN, clock, bcn0_in, bcn0_ref)
  begin
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      BCN0InReg  <= '0';
      BCN0RefReg <= '0';
    elsif (INPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      BCN0InReg  <= bcn0_in;
      BCN0RefReg <= bcn0_ref;
    end if;
  end process;

  process (resetN, clock, BCN0InReg, BCN0RefReg)
  begin
    if (LPM_BCN0_ADJ=0 and resetN='0') then
      BCN0InPipe  <= '0';
      BCN0RefPipe <= '0';
      BCNOPipe	  <= (others =>'0');
    elsif (LPM_BCN0_ADJ=0 or (clock'event and clock='1')) then
      if (LPM_BCN0_ADJ=0) then
        BCN0InPipe  <= BCN0InReg;
        BCN0RefPipe <= BCN0RefReg;
       else
         if (BCNOPipe'length>1) then
           BCNOPipe(BCNOPipe'length-1 downto 1) <= BCNOPipe(BCNOPipe'length-2 downto 0);
	 end if;
         if (LPM_BCN0_ADJ>0) then
           BCN0InPipe  <= BCN0InReg;
	   BCNOPipe(0) <= BCN0RefReg;
           BCN0RefPipe <= BCNOPipe(BCNOPipe'length-1);
	 else
           BCN0RefPipe <= BCN0RefReg;
	   BCNOPipe(0) <= BCN0InReg;
           BCN0InPipe  <= BCNOPipe(BCNOPipe'length-1);
	 end if;
       end if;
    end if;
  end process;

  process (resetN, clock)
  begin
    if (resetN='0') then
      BCN0Cnt        <= (others => '0');
      BCN0InCntStart <= '0';
      CntStart       <= '0';
      BCN0Pos        <= (others => '0');
      BCN0InStart    <= '0';
    elsif (clock'event and clock='1') then
      if (BCN0InPipe='1' and BCN0RefPipe='1') then
        BCN0Cnt        <= (others => '0');
        BCN0InCntStart <= '0';
        CntStart       <= '0';
        BCN0Pos        <= (others => '0');
        BCN0InStart    <= '1';
      elsif (CntStart='0' and (BCN0InPipe='1' or BCN0RefPipe='1')) then  
        BCN0Cnt        <= BCN0Cnt+1;
        BCN0InCntStart <= BCN0InPipe;
        CntStart       <= '1';
      elsif (CntStart='1' and ((BCN0InPipe='1' and BCN0InCntStart='0') or (BCN0RefPipe='1'and BCN0InCntStart='1'))) then
        BCN0Cnt        <= (others => '0');
        BCN0InCntStart <= '0';
        CntStart       <= '0';
        BCN0Pos        <= BCN0Cnt;
        BCN0InStart    <= BCN0InCntStart;
      elsif (CntStart='1') then
        if (AND_REDUCE(BCN0Cnt)='0') then
          BCN0Cnt     <= BCN0Cnt+1;
	else
          CntStart    <= '0';
          BCN0Cnt     <= (others => '0');
          BCN0Pos     <= BCN0Cnt;
          BCN0InStart <= BCN0InCntStart;
	end if;
      end if;
    end if;
  end process;

  position      <= BCN0Pos;
  bcn0_in_start <= BCN0InStart;

end behaviour;			   


-------------------------------------------------------------------
-- FFDELAY
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity FFDELAY is
  port(
    data_in			:in  TSL;
    data_out			:out TSL;
    delay_strobe		:out TSL
  );
end FFDELAY;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of FFDELAY is

  signal   PosReg		:TSL;
  signal   NegReg		:TSL;
  signal   ResetSig		:TSL;

begin

  process(ResetSig, data_in)
  begin
    if(ResetSig='0') then
      NegReg <= '0';
    elsif(data_in'event and data_in='0') then
      NegReg <= '1';
    end if;
  end process;

  process(ResetSig, data_in)
  begin
    if(ResetSig='0') then
      PosReg <= '0';
    elsif(data_in'event and data_in='1') then
      PosReg <= '1';
    end if;
  end process;

  ResetSig <= not (NegReg or PosReg);

  delay_strobe <= NegReg or PosReg;
  data_out <= (NegReg or PosReg) xor data_in;

end behaviour;			   

-------------------------------------------------------------------
-- STREAM_DELAY
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity STREAM_DELAY is
  generic (
    LPM_DATA_WIDTH		:in TN := 4
  );
  port(
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    delay_strobe		:out TSL
  );
end STREAM_DELAY;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMSynchro.all;

architecture behaviour of STREAM_DELAY is

  signal   StrobeSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);

begin

  l1:for index in LPM_DATA_WIDTH-1 downto 0 generate
    FFDelayCmp: component FFDELAY
      port map(
        data_in	     => data_in(index),
        data_out     => data_out(index),
        delay_strobe => StrobeSig(index)
      );
  end generate;
  
  delay_strobe <= OR_REDUCE(StrobeSig);

end behaviour;			   

-------------------------------------------------------------------
-- STREAM_DEMUX2
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity STREAM_DEMUX2 is
  generic (
    LPM_DATA_WIDTH		:in TN := 4
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    phase_in			:in  TSL := '0';
    data_out			:out TSLV((2*LPM_DATA_WIDTH)-1 downto 0);
    clock_quality		:out TSL;
    phase_quality		:out TSL
  );
end STREAM_DEMUX2;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

architecture behaviour of STREAM_DEMUX2 is

  signal   InPosDataReg			:TSLV(data_in'range);
  signal   InInvDataReg			:TSLV(data_in'range);
  signal   InInvPosDataReg		:TSLV(data_in'range);
  signal   OutDataReg			:TSLV(data_out'range);
  signal   InPosPhaseReg		:TSL;
  signal   InInvPhaseReg		:TSL;
  signal   InInvPosPhaseReg		:TSL;

  signal   InTestSig			:TSL;
  signal   InPosTestReg			:TSL;
  signal   InInvTestReg			:TSL;
  signal   InInvPosTestReg		:TSL;
  signal   ClockQualityReg		:TSL;
  signal   PhaseQualityReg		:TSL;


begin

  DelayCmp: component STREAM_DELAY
    generic map(
      LPM_DATA_WIDTH  => LPM_DATA_WIDTH
    )
    port map(
      data_in	      => data_in,
      delay_strobe    => InTestSig
    );

  process(clock, resetN) begin
    if (resetN='0') then
      InInvDataReg     <= (others => '0');
      InInvPhaseReg    <= '0';
      InInvTestReg     <= '0';
    elsif (clock'event and clock='0') then
      InInvDataReg     <= data_in;
      InInvPhaseReg    <= phase_in;
      InInvTestReg     <= InTestSig;
    end if;
  end process;  

  process(clock, resetN)
  
 --   variable QualityVar			:TSL;

  begin
    if (resetN='0') then
      InPosDataReg     <= (others => '0');
      InInvPosDataReg  <= (others => '0');
      InInvPosPhaseReg <= '0';
      InPosTestReg     <= '0';
      InInvPosTestReg  <= '0';
      ClockQualityReg  <= '0';
      PhaseQualityReg  <= '0';
    elsif (clock'event and clock='1') then
      InPosDataReg     <= data_in;
      InInvPosDataReg  <= InInvDataReg;
      InPosPhaseReg    <= phase_in;
      InInvPosPhaseReg <= InInvPhaseReg;
      OutDataReg       <= SLVBitMux(InInvPosDataReg,InPosDataReg);
      InPosTestReg     <= InTestSig;
      InInvPosTestReg  <= InInvTestReg;
      ClockQualityReg  <= TSLconv((InInvPosTestReg ='0') and (InPosTestReg = '0'));
      PhaseQualityReg  <= TSLconv((InInvPosPhaseReg = '0') and (InPosPhaseReg = '1'));
    end if;

  end process;

  data_out             <= OutDataReg;
  clock_quality        <= ClockQualityReg;
  phase_quality        <= PhaseQualityReg;

end behaviour;			   

-------------------------------------------------------------------
-- LPM_TIMER_ENGINE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity LPM_TIMER_ENGINE is
  generic (
    LPM_TIMER_SIZE		:in TN := 4
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena_in			:in  TSL;
    clk_ena_out			:out TSL;
    start			:in  TSL;
    trigger			:in  TSL;
    repeat			:in  TSL;
    stop			:out TSL;
    limit			:in  TSLv(LPM_TIMER_SIZE-1 downto 0);
    count			:out TSLv(LPM_TIMER_SIZE-1 downto 0)
  );
end LPM_TIMER_ENGINE;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

architecture behaviour of LPM_TIMER_ENGINE is

  signal   ClkEnaInReg		:TSL;
  signal   StartReg		:TSL;
  signal   RepeatReg		:TSL;
  signal   TriggerReg		:TSL;
  signal   TriggerHoldReg	:TSL;
  signal   ClkEnaOutReg		:TSL;
  signal   TimerClkEnaReg	:TSL;
  signal   TimerInitReg		:TSL;
  signal   TimerStopSig		:TSL;
  signal   TimerStopReg		:TSL;
  
begin

  process(resetN, clock) is
  begin
    if(resetN='0') then
      ClkEnaInReg    <= '0';
      StartReg       <= '0';
      RepeatReg      <= '0';
      TriggerReg     <= '0';
      TriggerHoldReg <= '0';
      ClkEnaOutReg   <= '0';
      TimerClkEnaReg <= '0';
      TimerInitReg   <= '0';
      TimerStopReg   <= '0';
    elsif(clock'event and clock='1') then
      ClkEnaInReg  <= clk_ena_in;
      StartReg     <= start;
      RepeatReg    <= repeat;
      TimerStopReg <= TimerStopSig;
      TriggerReg   <= trigger;
      if (StartReg='0' or (RepeatReg='1' and TimerStopSig='1')) then
        ClkEnaOutReg   <= '0';
        TimerClkEnaReg <= '1';
        TimerInitReg   <= '1';
        TriggerHoldReg     <= trigger;
      else
        TimerInitReg   <= '0';
        if (TriggerHoldReg='0' and ClkEnaInReg='1') then
	  TriggerHoldReg <= TriggerReg;
	end if;
	if ((TriggerReg='1' and ClkEnaInReg='1') or TriggerHoldReg='1') then
          if (TimerStopSig='0') then
            ClkEnaOutReg   <= ClkEnaInReg;
            TimerClkEnaReg <= ClkEnaInReg;
	  else
            ClkEnaOutReg   <= '0';
            TimerClkEnaReg <= '0';
	  end if;
	else
          TimerClkEnaReg <= '0';
	end if;
      end if;
    end if;
  end process;

  Timer: LPM_PROG_TIMER
    generic map(
      LPM_DATA_SIZE	=> LPM_TIMER_SIZE
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> TimerClkEnaReg,
      init		=> TimerInitReg,
      limit		=> limit,
      count		=> count,
      stop		=> TimerStopSig
    );
    
  clk_ena_out <= ClkEnaOutReg;
  stop <= TimerStopReg;

end behaviour;			   

-------------------------------------------------------------------
-- LPM_FILL_SPS2001_ENGINE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity LPM_FILL_SPS2001_ENGINE is
  generic (
    SPS_START_DELAY_SIZE	:TN := 2;
    SPS_FILL_COUNT_LIMIT	:TN := 5;
    SPS_REVOL_COUNT_SIZE	:TN := 4;
    SPS_ACTIVE_COUNT_SIZE	:TN := 3
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    start			:in  TSL;
    start_delay			:in  TSLV(SPS_START_DELAY_SIZE-1 downto 0);
    revol_limit			:in  TSLV(SPS_REVOL_COUNT_SIZE-1 downto 0);
    active_limit		:in  TSLV(SPS_ACTIVE_COUNT_SIZE-1 downto 0);
    fill_ena			:out TSL;
    fill_pos			:out TSLV(TVLcreate(SPS_FILL_COUNT_LIMIT)-1 downto 0)
  );
end LPM_FILL_SPS2001_ENGINE;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

architecture behaviour of LPM_FILL_SPS2001_ENGINE is

  constant SPS_FILL_COUNT_SIZE : TN := TVLcreate(SPS_FILL_COUNT_LIMIT);

  type     TSpsFillMachine is
           (
             SpsFillMachine_Idle,
             SpsFillMachine_Delay,
             SpsFillMachine_Fill,
             SpsFillMachine_Wait
	   );

  signal   H				:TSL;
  signal   SpsFillMachineCurState	:TSpsFillMachine;
  signal   SpsFillMachineNewState	:TSpsFillMachine;

  signal   SpsStartDelCountInitSig	:TSL;
  signal   SpsStartDelCountStopSig	:TSL;
  signal   SpsFillCountInitSig		:TSL;
  signal   SpsFillCountStopSig		:TSL;
  signal   SpsFillCountDataSig		:TSLV(SPS_FILL_COUNT_SIZE-1 downto 0);
  signal   SpsRevolCountInitSig		:TSL;
  signal   SpsRevolCountStopSig		:TSL;
  signal   SpsActiveCountEnaSig		:TSL;
  signal   SpsActiveCountInitSig	:TSL;
  signal   SpsActiveCountStopSig	:TSL;

begin

  H <= '1';

  SpsStartDelCount: LPM_PROG_TIMER
    generic map(
      LPM_DATA_SIZE	=> SPS_START_DELAY_SIZE
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> H,
      init		=> SpsStartDelCountInitSig,
      limit		=> start_delay,
      stop		=> SpsStartDelCountStopSig
    );

  SpsFillCount: LPM_TIMER
    generic map(
      LPM_RANGE_MAX	=> SPS_FILL_COUNT_LIMIT
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> H,
      init		=> SpsFillCountInitSig,
      count		=> SpsFillCountDataSig,
      stop		=> SpsFillCountStopSig
    );

  SpsRevolCount: LPM_PROG_TIMER
    generic map(
      LPM_DATA_SIZE	=> SPS_REVOL_COUNT_SIZE
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> H,
      init		=> SpsRevolCountInitSig,      
      limit		=> revol_limit,
      stop		=> SpsRevolCountStopSig
    );

  SpsActivesCount: LPM_PROG_TIMER
    generic map(
      LPM_DATA_SIZE	=> SPS_ACTIVE_COUNT_SIZE
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> SpsActiveCountEnaSig,
      init		=> SpsActiveCountInitSig,      
      limit		=> active_limit,
      stop		=> SpsActiveCountStopSig
    );
  
  process(resetN, clock) is
  begin
    if(resetN='0') then
      SpsFillMachineCurState <= SpsFillMachine_Idle;
    elsif(clock'event and clock='1') then
      SpsFillMachineCurState <= SpsFillMachineNewState;
    end if;
  end process;

  process(SpsFillMachineCurState,
          start,
          SpsStartDelCountStopSig,
	  SpsFillCountStopSig,
	  SpsRevolCountStopSig,
	  SpsActiveCountStopSig) is
  begin
    case SpsFillMachineCurState is
      when SpsFillMachine_Idle =>
        SpsFillCountInitSig        <= '1';
        SpsRevolCountInitSig       <= '1';
        SpsActiveCountEnaSig       <= '1';
        SpsActiveCountInitSig      <= '1';
	if (start='0') then
          SpsStartDelCountInitSig  <= '1';
	  SpsFillMachineNewState   <= SpsFillMachine_Idle;
	else
          SpsStartDelCountInitSig  <= '0';
	  SpsFillMachineNewState   <= SpsFillMachine_Delay;
        end if;
      when SpsFillMachine_Delay =>
        SpsFillCountInitSig        <= '1';
        SpsRevolCountInitSig       <= '1';
        SpsActiveCountEnaSig       <= '1';
        SpsActiveCountInitSig      <= '1';
        if (SpsStartDelCountStopSig='0') then
          SpsStartDelCountInitSig  <= '0';
	  SpsFillMachineNewState   <= SpsFillMachine_Delay;
	else
          SpsStartDelCountInitSig  <= '1';
	  SpsFillMachineNewState   <= SpsFillMachine_Fill;
	end if;
      when SpsFillMachine_Fill =>
        SpsStartDelCountInitSig    <= '1';
        SpsRevolCountInitSig       <= '0';
        SpsActiveCountEnaSig       <= '0';
        SpsActiveCountInitSig      <= '0';
	if (SpsFillCountStopSig='0') then
	  SpsFillMachineNewState   <= SpsFillMachine_Fill;
          SpsFillCountInitSig      <= '0';
	else
	  SpsFillMachineNewState   <= SpsFillMachine_Wait;
          SpsFillCountInitSig      <= '1';
	end if;
      when SpsFillMachine_Wait =>
        SpsStartDelCountInitSig    <= '1';
        SpsFillCountInitSig        <= '1';
        SpsActiveCountInitSig      <= '0';
        if (SpsRevolCountStopSig='0') then
          SpsFillMachineNewState   <= SpsFillMachine_Wait;
          SpsRevolCountInitSig     <= '0';
          SpsActiveCountEnaSig     <= '0';
	else
          SpsRevolCountInitSig     <= '1';
          SpsActiveCountEnaSig     <= '1';
          if (SpsActiveCountStopSig='0') then
	    SpsFillMachineNewState <= SpsFillMachine_Fill;
	  else
	    SpsFillMachineNewState <= SpsFillMachine_Idle;
	  end if;
	end if;
    end case;
  end process;

  fill_ena <= not(SpsFillCountInitSig) or SpsFillCountStopSig;
  fill_pos <= SpsFillCountDataSig;

end behaviour;			   


-------------------------------------------------------------------
-- LPM OVERSAMPLING
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_OVERSAMPLING is
  generic (
    LPM_DATA_WIDTH		:TN := 4;
    LPM_FCLK_NUM		:TN := 2;
    LPM_FCLK_PERIODS		:TN := 2
  );
  port(
    resetN			:in  TSL;
    fclk			:in  TSLV(LPM_FCLK_NUM-1 downto 0);
    clk				:in  TSL;
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    fclk_sel			:in  TSLV(TVLcreate(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1)-1 downto 0);
    fclk_valid_ena		:in  TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
    fclk_valid			:out TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_valid			:out TSL;
    fclk_validN			:out TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
    data_outN			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_validN			:out TSL
  );
end LPM_OVERSAMPLING;

architecture behaviour of LPM_OVERSAMPLING is

  type   TClkData    is array (0 to LPM_FCLK_NUM*LPM_FCLK_PERIODS-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClkDataReg  :TClkData;
  signal ClkDataRegN :TClkData;
  type   TData       is array (0 to 2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal DataReg1    :TData;
  signal DataReg2    :TData;
  signal DataReg3    :TData;
  signal SelReg2     :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal SelReg3     :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal SelReg4     :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClkValReg3  :TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
  signal ClkValReg4  :TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
  signal ValidReg4   :TSL;
  signal SelRegN     :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClkValRegN  :TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
  signal ValidRegN   :TSL;
  signal SelRegNP    :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClkValRegNP :TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
  signal ValidRegNP  :TSL;
  signal SelRegP     :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClkValRegP  :TSLV(2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 downto 0);
  signal ValidRegP   :TSL;

begin

  clk_loop:
  for index in 0 to LPM_FCLK_NUM-1 generate
    --
    process (resetN, fclk(index)) is
    begin
      if (resetN='0') then
        ClkDataReg(index) <= (others=>'0');
      elsif(fclk(index)'event and fclk(index)='1') then
        ClkDataReg(index) <= data_in;
      end if;
    end process;
    --
    process (resetN, fclk(index)) is
    begin
      if (resetN='0') then
        ClkDataRegN(index) <= (others=>'0');
      elsif(fclk(index)'event and fclk(index)='0') then
        ClkDataRegN(index) <= data_in;
      end if;
    end process;
    --
  end generate;
  --
  process (resetN, fclk(0)) is
  begin
    if (resetN='0') then
      DataReg1   <= (TData'range => (others=>'0'));
      DataReg2   <= (TData'range => (others=>'0'));
      DataReg3   <= (TData'range => (others=>'0'));
      SelReg2    <= (others=>'0');
      SelReg3    <= (others=>'0');
      SelReg4    <= (others=>'0');
      ClkValReg3 <= (others=>'0');
      ClkValReg4 <= (others=>'0');
      ValidReg4  <= '0';
    elsif(fclk(0)'event and fclk(0)='1') then
      -- level 1
      for index in 0 to LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 loop
        DataReg1(2*index)   <= ClkDataReg(index);
        DataReg1(2*index+1) <= ClkDataRegN(index);
      end loop;
      -- level 2
      for index in 0 to 2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 loop
        if (fclk_sel=index) then
          SelReg2 <= DataReg1(index);
          exit;
        end if;
      end loop;
      DataReg2 <= DataReg1;
      -- level 3
      DataReg3 <= DataReg2;
      SelReg3  <= SelReg2; 
      for index in 0 to 2*LPM_FCLK_NUM*LPM_FCLK_PERIODS-1 loop
        ClkValReg3(index) <= TSLconv(SelReg2 = DataReg2(index));
      end loop;
      -- level 4
      SelReg4    <= SelReg3;
      ClkValReg4 <= ClkValReg3;
      ValidReg4  <= TSLconv(ClkValReg3 = fclk_valid_ena);
    end if;
  end process;
  --
  process (resetN, clk) is
  begin
    if (resetN='0') then
      SelRegN    <= (others=>'0');
      ClkValRegN <= (others=>'0');
      ValidRegN  <= '0';
    elsif(clk'event and clk='0') then
      SelRegN    <= SelReg4;
      ClkValRegN <= ClkValReg4;
      ValidRegN  <= ValidReg4;
    end if;
  end process;
  --
  process (resetN, clk) is
  begin
    if (resetN='0') then
      SelRegNP    <= (others=>'0');
      ClkValRegNP <= (others=>'0');
      ValidRegNP  <= '0';
      SelRegP     <= (others=>'0');
      ClkValRegP  <= (others=>'0');
      ValidRegP   <= '0';
    elsif(clk'event and clk='1') then
      SelRegNP    <= SelRegN;
      ClkValRegNP <= ClkValRegN;
      ValidRegNP  <= ValidRegN;
      SelRegP     <= SelReg4;
      ClkValRegP  <= ClkValReg4;
      ValidRegP   <= ValidReg4;
    end if;
  end process;
  --
  data_out    <= SelRegP;
  fclk_valid  <= ClkValRegP;
  data_valid  <= ValidRegP;
  data_outN   <= SelRegNP;
  fclk_validN <= ClkValRegNP;
  data_validN <= ValidRegNP;
    
end behaviour;			   


-------------------------------------------------------------------
-- LPM MUXED DATA TRANSFER
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

entity LPM_DATA_PHASE is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := TRUE;
    LPM_MCLK180_ADD		:TL := TRUE;
    LPM_MCLK270_ADD		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    mclk0			:in  TSL;
    mclk90			:in  TSL;
    mclk180			:in  TSL;
    mclk270			:in  TSL;
    din				:in  TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
    mdout			:out TSLV(LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_PHASE;

architecture behaviour of LPM_DATA_PHASE is

  signal mclk180sig             :TSL;
  signal mclk90sig              :TSL;
  signal mclk270sig             :TSL;
  signal data0reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data90reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data180reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data270reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data0regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data90regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data180regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data270regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data0regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data90regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data180regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal data270regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdatasig		:TSLV(LPM_MUX_WIDTH-1 downto 0);

begin
  --                       
  mclk180sig <= not(mclk0)     when LPM_MCLK180_ADD=TRUE else mclk180;
  mclk90sig  <= mclk90         when LPM_PHASE_POS=TRUE   else not(mclk90);
  mclk270sig <= not(mclk90sig) when LPM_MCLK270_ADD=TRUE else mclk270 when LPM_PHASE_POS=TRUE else not(mclk270);
  --
  qphaseT:
  if (LPM_QPHASE_ENA=TRUE) generate
    --
    process (mclk0, resetN) begin
      if (resetN='0') then
        data270reg <= (others=>'0');
        data180reg <= (others=>'0');
        data90reg  <= (others=>'0');
        data0reg   <= (others=>'0');
        data90regB <= (others=>'0');
        data0regB  <= (others=>'0');
      elsif (mclk0'event and mclk0='1') then
        data270reg <= TSLVgetX(din,0);
        data180reg <= TSLVgetX(din,1);
        data90reg  <= TSLVgetX(din,2);
        data0reg   <= TSLVgetX(din,3);
        data90regB <= data90reg xor data180reg xor data270reg;
        data0regB  <= data0reg xor data90reg xor data180reg xor data270reg;
      end if;
    end process;
    --
    process (mclk180sig, resetN) begin
      if (resetN='0') then
        data270regB <= (others=>'0');
        data180regB <= (others=>'0');
      elsif (mclk180sig'event and mclk180sig='1') then
        data270regB <= data270reg;
        data180regB <= data180reg xor data270reg;
      end if;
    end process;
    --
    --
    process (mclk270sig, resetN) begin
      if (resetN='0') then
        data270regP <= (others=>'0');
      elsif (mclk270sig'event and mclk270sig='1') then
        data270regp <= data270regB;
      end if;
    end process;
    --
    process (mclk180sig, resetN) begin
      if (resetN='0') then
        data180regP <= (others=>'0');
      elsif (mclk180sig'event and mclk180sig='1') then
        data180regP <= data180regB;
      end if;
    end process;
    --
    process (mclk90sig, resetN) begin
      if (resetN='0') then
        data90regP <= (others=>'0');
      elsif (mclk90sig'event and mclk90sig='1') then
        data90regP <= data90regB;
      end if;
    end process;
    --
    process (mclk0, resetN) begin
      if (resetN='0') then
        data0regP <= (others=>'0');
      elsif (mclk0'event and mclk0='1') then
        data0regP <= data0regB;
      end if;
    end process;
    --
    mdatasig <= data0regP xor data90regP xor data180regP xor data270regP;
    --
  end generate;
  --
  qphaseN:
  if (LPM_QPHASE_ENA=FALSE) generate
    --
    data180reg <= TSLVgetX(din,1);
    data0reg   <= TSLVgetX(din,3);
    --
    buf: UTLPM_BUSOUT_SER2
      generic map (
        LPM_WIDTH        => LPM_MUX_WIDTH,
        CLK180_ADD       => FALSE
      )
      port map (
        rN         => resetN,
        c0         => mclk0,
        c180       => mclk180sig,
        i0         => data180reg,
        i180       => data0reg,
        o          => mdatasig 
      );
    --
  end generate;
  --
  mdout <= mdatasig;
  --
end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

entity LPM_DATA_REPHASE is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := TRUE;
    LPM_MCLK180_ADD		:TL := TRUE;
    LPM_MCLK270_ADD		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    mclk0			:in  TSL;
    mclk90			:in  TSL;
    mclk180			:in  TSL;
    mclk270			:in  TSL;
    mdin			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    dout			:out TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_REPHASE;

architecture behaviour of LPM_DATA_REPHASE is

  signal mclk180sig             :TSL;
  signal mclk90sig              :TSL;
  signal mclk270sig             :TSL;
  signal mdata0reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata90reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata180reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata270reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata180regB0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata90regB270		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata270regB0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata0reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata90reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata180reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdata270reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);

begin
  --                       
  mclk180sig <= not(mclk0)     when LPM_MCLK180_ADD=TRUE else mclk180;
  mclk90sig  <= mclk90         when LPM_PHASE_POS=TRUE   else not(mclk90);
  mclk270sig <= not(mclk90sig) when LPM_MCLK270_ADD=TRUE else mclk270 when LPM_PHASE_POS=TRUE else not(mclk270);
  --
  qphaseT:
  if (LPM_QPHASE_ENA=TRUE) generate
    --
    process (mclk270sig, resetN) begin
      if (resetN='0') then
        mdata270reg    <= (others=>'0');
        mdata90regB270 <= (others=>'0');
      elsif (mclk270sig'event and mclk270sig='1') then
        mdata270reg    <= mdin;
        mdata90regB270 <= mdata90reg;
      end if;
    end process;
    --
    process (mclk180sig, resetN) begin
      if (resetN='0') then
        mdata180reg <= (others=>'0');
      elsif (mclk180sig'event and mclk180sig='1') then
        mdata180reg <= mdin;
      end if;
    end process;
    --
    process (mclk90sig, resetN) begin
      if (resetN='0') then
        mdata90reg <= (others=>'0');
      elsif (mclk90sig'event and mclk90sig='1') then
        mdata90reg <= mdin;
      end if;
    end process;
    --
    process (mclk0, resetN) begin
      if (resetN='0') then
        mdata0reg     <= (others=>'0');
        mdata0reg0    <= (others=>'0');
        mdata90reg0   <= (others=>'0');
        mdata180regB0 <= (others=>'0');
        mdata180reg0  <= (others=>'0');
        mdata270regB0 <= (others=>'0');
        mdata270reg0  <= (others=>'0');
      elsif (mclk0'event and mclk0='1') then
        mdata0reg     <= mdin;
        mdata0reg0    <= mdata0reg;
        mdata90reg0   <= mdata90regB270;
        mdata180regB0 <= mdata180reg;
        mdata180reg0  <= mdata180regB0;
        mdata270regB0 <= mdata270reg;
        mdata270reg0  <= mdata270regB0;
      end if;
    end process;
    --
  end generate;
  --
  qphaseN:
  if (LPM_QPHASE_ENA=FALSE) generate
    --
    buf: UTLPM_BUSIN_SER2
      generic map (
        LPM_WIDTH  => LPM_MUX_WIDTH,
        CLK180_ADD => FALSE
      )
      port map (
        rN         => resetN,
        c0         => mclk0,
        c180       => mclk180sig,
        i          => mdin,
        o0         => mdata0reg0,
        o180       => mdata180reg0 
      );
    mdata90reg0  <= mdata0reg0;
    mdata270reg0 <= mdata180reg0;
    --
  end generate;
  --
  process(mdata0reg0, mdata90reg0, mdata180reg0, mdata270reg0) is
    variable res: TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
  begin
    res := TSLAset(res,'0');
    res := TSLAputX(res,0,mdata270reg0);
    res := TSLAputX(res,1,mdata180reg0);
    res := TSLAputX(res,2,mdata90reg0);
    res := TSLAputX(res,3,mdata0reg0);
    dout <= res;
  end process;
  --
end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_DATA_MUX_V1 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_CLOCK_MULTIPL	:TI := 1;
    SYMMETRIZATION_ENA		:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    INPUT_REGISTERED		:TL := TRUE;
    INPUT_MUX_REGISTERED	:TL := TRUE;
    STROBE_ASET_ENA		:TL := TRUE;
    OUTPUT_MUX_REGISTERED	:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mux_clock			:in  TSL;
    clock_inv			:in  TSL;
    strobe			:in  TSL;
    data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_MUX_V1;

architecture behaviour of LPM_DATA_MUX_V1 is

  constant PIPELEN		:TN := LPM_MUX_MULTIPL*LPM_CLOCK_MULTIPL;
  type     TDataPipe		is array(LPM_MUX_WIDTH-1 downto 0) of TSLV(PIPELEN-1 downto 0);
  
  signal   InRegN		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   InReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   StrobeReg		:TSL;
  signal   DataPipe		:TDataPipe;
  signal   MuxDataSig		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataReg		:TSLV(LPM_MUX_WIDTH-1 downto 0);

begin

  process (clock, resetN) begin
    if (resetN='0') then
      InRegN   <= (others=>'0');
    elsif (clock'event and clock='0') then
      InRegN   <= data;
    end if;
  end process;
  --
  process (clock, resetN, data, InRegN, clock_inv) begin
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      InReg   <= (others=>'0');
    elsif (INPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      InReg <= sel(InRegN, data, clock_inv);
    end if;
  end process;
  --
  process (mux_clock, resetN, InReg, strobe)
    variable DataPartVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable DataInVar   :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  begin
    if (INPUT_MUX_REGISTERED=TRUE and resetN='0') then
      DataReg   <= (others=>'0');
      StrobeReg <= '0';
    elsif (INPUT_MUX_REGISTERED=FALSE or (mux_clock'event and mux_clock='1')) then
      DataInVar := InReg;
      if (MUX_DECREASE_ENA=TRUE and LPM_MUX_MULTIPL>2) then
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          for midx in 0 to LPM_MUX_MULTIPL-1 loop
            DataInVar(widx*LPM_MUX_MULTIPL+midx) := InReg(widx*LPM_MUX_MULTIPL+LPM_MUX_MULTIPL-1-midx);
          end loop;
        end loop;
      end if;
      DataPartVar := DataInVar;
      if (MUX_PART_MODE_ENA=TRUE) then
        for midx in 0 to LPM_MUX_MULTIPL-1 loop
          for widx in 0 to LPM_MUX_WIDTH-1 loop
            DataPartVar(widx*LPM_MUX_MULTIPL+midx) := DataInVar(midx*LPM_MUX_WIDTH+widx);
          end loop;
        end loop;
      end if;
      if (SYMMETRIZATION_ENA=TRUE) then
        for index in 0 to LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 loop
          DataPartVar(index) := DataPartVar(index) xor TSLconv(((index/2)*2)=index) xor TSLconv((((index/LPM_MUX_MULTIPL)/2)*2)=(index/LPM_MUX_MULTIPL));
        end loop;
      end if;
      DataReg   <= DataPartVar;
      StrobeReg <= strobe;
    end if;
  end process;
  --
  greate_mux2:
  if (LPM_MUX_MULTIPL>2) generate
  --
    process(mux_clock, resetN, StrobeReg, DataReg)
      variable DataVar :TSLV(LPM_MUX_MULTIPL-1 downto 0);
    begin
      if(resetN='0') then
        DataPipe <= (TDataPipe'range => (others =>'0'));
      elsif(STROBE_ASET_ENA=TRUE and StrobeReg='1') then
        for index in 0 to LPM_MUX_WIDTH-1 loop
          for pos in 0 to PIPELEN-1 loop
	    DataPipe(index)(pos) <= SLVnorm(SLVPartGet(DataReg,LPM_MUX_MULTIPL,index))(pos/LPM_CLOCK_MULTIPL);
	  end loop;
        end loop;
      elsif(mux_clock'event and mux_clock='1') then
        for index in 0 to LPM_MUX_WIDTH-1 loop
          if (STROBE_ASET_ENA=FALSE and StrobeReg='1') then
	    DataVar := SLVPartGet(DataReg,LPM_MUX_MULTIPL,index);
            for pos in 0 to PIPELEN-1 loop
	      DataPipe(index)(pos) <= DataVar(pos/LPM_CLOCK_MULTIPL);
	    end loop;
	  else
	    DataPipe(index)(PIPELEN-2 downto 0) <= DataPipe(index)(PIPELEN-1 downto 1);
	    DataPipe(index)(PIPELEN-1) <= '0';
	  end if;
        end loop;
      end if;
    end process;
    --
    process (mux_clock, resetN, DataPipe) begin
      if (OUTPUT_MUX_REGISTERED=TRUE and resetN='0') then
        MuxDataReg <= (others =>'0');
      elsif (OUTPUT_MUX_REGISTERED=FALSE or (mux_clock'event and mux_clock='1')) then
        for index in 0 to LPM_MUX_WIDTH-1 loop
	  MuxDataReg(index) <= DataPipe(index)(0);
        end loop;
      end if;
    end process;
  --
  end generate;
  --
  mux2:
  if (LPM_MUX_MULTIPL=2) generate
    process (clock, DataReg)
      constant ClkLevel :TSL := TSLconv(MUX_DECREASE_ENA=FALSE);
      variable x :TSL;
    begin
      x := ClkLevel;
      for index in 0 to LPM_MUX_WIDTH-1 loop
        if (clock=ClkLevel) then
	  MuxDataSig(index) <= DataReg(LPM_MUX_MULTIPL*index+0);
	else
	  MuxDataSig(index) <= DataReg(LPM_MUX_MULTIPL*index+1);
	end if;
      end loop;
    end process;
    --
    dcreg_yes:
    if (OUTPUT_MUX_REGISTERED=TRUE) generate
      regdc :KTP_LPM_REGDC
        generic map (
          LPM_WIDTH => LPM_MUX_WIDTH
        )
        port map(
          resetN    => resetN,
          setN      => '1',
          clk       => clock,
          ena       => '1',
          d         => MuxDataSig,
          q         => MuxDataReg
        );
    end generate;
    dcreg_no:
    if (OUTPUT_MUX_REGISTERED=FALSE) generate
      MuxDataReg <= MuxDataSig;
    end generate;
  --
  end generate;
  --
  mux_data <= MuxDataReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_DATA_MUX_V2 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_EXT_PHASE_ENA		:TL := FALSE;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := FALSE;
    LPM_MCLK180_ADD		:TL := TRUE;
    LPM_MCLK270_ADD		:TL := TRUE;
    LPM_OVERCLOCK_MULTIPL	:TI := 1;
    SYMMETRIZATION_ENA		:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    INPUT_REGISTERED		:TL := TRUE;
    INPUT_MUX_REGISTERED	:TL := TRUE;
    STROBE_AUTO_ENA		:TL := TRUE;
    OUTPUT_MUX_REGISTERED	:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL;
    mux_clock180		:in  TSL;
    mux_clock270		:in  TSL;
    clock_inv			:in  TSL;
    strobe			:in  TSL;
    data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    mux_data			:out TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_MUX_V2;

architecture behaviour of LPM_DATA_MUX_V2 is

  constant OVERCLOCK_MULTIPL	:TN := maximum(LPM_OVERCLOCK_MULTIPL,1);
  constant UNDERCLOCK_MULTIPL	:TN := maximum(-LPM_OVERCLOCK_MULTIPL,1);
  constant MUX_MULTIPL  	:TN := LPM_MUX_MULTIPL/UNDERCLOCK_MULTIPL;
  constant MUX_WIDTH  	        :TN := LPM_MUX_WIDTH*UNDERCLOCK_MULTIPL;
  constant PIPELEN		:TN := MUX_MULTIPL*OVERCLOCK_MULTIPL;
  type     TDataPipe		is array(MUX_WIDTH-1 downto 0) of TSLV(PIPELEN-1 downto 0);
  
  signal   InRegN		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   InReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataSig		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   StrobeSig		:TSL;
  signal   StrobeReg		:TSL;
  signal   DataPipe		:TDataPipe := (TDataPipe'range => (others =>'0'));
  signal   MuxDataSig		:TSLV(LPM_MUX_WIDTH-1 downto 0) := (others =>'0');
  signal   MuxDataReg		:TSLV(mux_data'range);
  signal   PhaseDatasig		:TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);

begin

  process (clock, resetN) begin
    if (resetN='0') then
      InRegN   <= (others=>'0');
    elsif (clock'event and clock='0') then
      InRegN   <= data;
    end if;
  end process;
  --
  process (clock, resetN, data, InRegN, clock_inv)
    variable vclk :TL;
  begin
    if (INPUT_REGISTERED=FALSE) then vclk := TRUE; else vclk := (clock'event and clock='1'); end if;
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      InReg   <= (others=>'0');
    elsif (vclk) then
      InReg <= sel(InRegN, data, clock_inv);
    end if;
  end process;
  --
  process (InReg)
    variable DataPartVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable DataInVar   :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  begin
    DataInVar := InReg;
    if (MUX_DECREASE_ENA=TRUE and LPM_MUX_MULTIPL>2) then
      for widx in 0 to LPM_MUX_WIDTH-1 loop
        for midx in 0 to LPM_MUX_MULTIPL-1 loop
          DataInVar(widx*LPM_MUX_MULTIPL+midx) := InReg(widx*LPM_MUX_MULTIPL+LPM_MUX_MULTIPL-1-midx);
        end loop;
      end loop;
    end if;
    DataPartVar := DataInVar;
    if (MUX_PART_MODE_ENA=TRUE) then
      for midx in 0 to LPM_MUX_MULTIPL-1 loop
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          DataPartVar(widx*LPM_MUX_MULTIPL+midx) := DataInVar(midx*LPM_MUX_WIDTH+widx);
        end loop;
      end loop;
    end if;
    if (SYMMETRIZATION_ENA=TRUE) then
      for index in 0 to LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 loop
        DataPartVar(index) := DataPartVar(index) xor TSLconv(((index/2)*2)=index) xor TSLconv((((index/LPM_MUX_MULTIPL)/2)*2)=(index/LPM_MUX_MULTIPL));
      end loop;
    end if;
    DataSig <= DataPartVar;
  end process;
  --
  autostrT: if(STROBE_AUTO_ENA=TRUE) generate
    clkstr: CLOCK_STROBE
      generic map (
       LPM_CLOCK_MULTIPL => MUX_MULTIPL*OVERCLOCK_MULTIPL
      )
      port map (
        resetN           => resetN,
        clock            => clock,
        mclock           => mux_clock,
        strobe           => StrobeSig
    );
  end generate;
  autostrF: if(STROBE_AUTO_ENA=FALSE) generate
    StrobeSig <= strobe;
  end generate;
  --
  process (mux_clock, resetN, DataSig, strobe) 
    variable clkv :TL;
  begin
    if (INPUT_MUX_REGISTERED=FALSE) then clkv := TRUE; else clkv := (mux_clock'event and mux_clock='1'); end if;
    if (INPUT_MUX_REGISTERED=TRUE and resetN='0') then
      DataReg   <= (others=>'0');
      StrobeReg <= '0';
    elsif (clkv) then
      DataReg   <= DataSig;
      StrobeReg <= StrobeSig;
    end if;
  end process;
  --
  process(mux_clock, resetN, StrobeReg, DataReg)
    variable DataVar :TSLV(MUX_MULTIPL-1 downto 0);
  begin
    if(PIPELEN>1 aND resetN='0') then
      DataPipe <= (TDataPipe'range => (others =>'0'));
    elsif(PIPELEN=1) then
      for index in 0 to MUX_WIDTH-1 loop
        for pos in 0 to PIPELEN-1 loop
         DataPipe(index)(pos) <= SLVnorm(SLVPartGet(DataReg,MUX_MULTIPL,index))(pos/OVERCLOCK_MULTIPL);
        end loop;
      end loop;
    elsif(mux_clock'event and mux_clock='1') then
      for index in 0 to MUX_WIDTH-1 loop
        if (StrobeReg='1') then
          DataVar := SLVPartGet(DataReg,MUX_MULTIPL,index);
          for pos in 0 to PIPELEN-1 loop
            DataPipe(index)(pos) <= DataVar(pos/OVERCLOCK_MULTIPL);
          end loop;
        else
          DataPipe(index)(PIPELEN-2 downto 0) <= DataPipe(index)(PIPELEN-1 downto 1);
          DataPipe(index)(PIPELEN-1) <= '0';
        end if;
      end loop;
    end if;
  end process;
  --
  --
  overP:
  if (LPM_OVERCLOCK_MULTIPL>=0) generate
    process (mux_clock, resetN, DataPipe)
      variable res: TSLV(MUX_WIDTH-1 downto 0);
    begin
      if (OUTPUT_MUX_REGISTERED=TRUE and resetN='0') then
        MuxDataReg <= (others =>'0');
      elsif (OUTPUT_MUX_REGISTERED=FALSE or (mux_clock'event and mux_clock='1')) then
        for index in 0 to MUX_WIDTH-1 loop
          res(index) := DataPipe(index)(0);
        end loop;
        if (LPM_EXT_PHASE_ENA=FALSE) then
          MuxDataReg <= res;
        else
          MuxDataReg <= res & res & res & res;
        end if;
      end if;
    end process;
  end generate;
  --
  --
  overN:
  if (LPM_OVERCLOCK_MULTIPL=-2 or LPM_OVERCLOCK_MULTIPL=-4) generate
    --
    process (DataPipe) is
    begin
      if (LPM_OVERCLOCK_MULTIPL=-2) then
        PhaseDatasig <= TSLAset(PhaseDatasig,'0');
        for index in 0 to LPM_MUX_WIDTH-1 loop
          PhaseDatasig(1,index) <= DataPipe(2*index+0)(0);
          PhaseDatasig(3,index) <= DataPipe(2*index+1)(0);
        end loop;
      else
        for index in 0 to LPM_MUX_WIDTH-1 loop
          PhaseDatasig(0,index) <= DataPipe(4*index+0)(0);
          PhaseDatasig(1,index) <= DataPipe(4*index+1)(0);
          PhaseDatasig(2,index) <= DataPipe(4*index+2)(0);
          PhaseDatasig(3,index) <= DataPipe(4*index+3)(0);
        end loop;
      end if;
    end process;
    --
    extF:
    if (LPM_EXT_PHASE_ENA=FALSE) generate
      phase :LPM_DATA_PHASE
        generic map (
          LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
          LPM_PHASE_POS		=> LPM_PHASE_POS,
          LPM_QPHASE_ENA	=> LPM_QPHASE_ENA,
          LPM_MCLK180_ADD	=> LPM_MCLK180_ADD,
          LPM_MCLK270_ADD	=> LPM_MCLK270_ADD
        )
        port map (
          resetN		=> resetN,
          mclk0			=> mux_clock,
          mclk90		=> mux_clock90,
          mclk180		=> mux_clock180,
          mclk270		=> mux_clock270,
          din			=> PhaseDatasig,
          mdout			=> MuxDataReg
        );
    end generate;
    --
    extT:
    if (LPM_EXT_PHASE_ENA=TRUE) generate
      MuxDataReg <= TSLVget(PhaseDatasig);
    end generate;
    --
  end generate;
  --
  --
  mux_data <= MuxDataReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_DATA_DEMUX_V1 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_CLOCK_MULTIPL		:TN := 1;
    SYMMETRIZATION_ENA		:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    CLOCK_PIPE_ENA		:TL := FALSE;
    STROBE_ENABLE		:TL := TRUE;
    STROBE_REGISTERED		:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL;
    clock			:in  TSL;
    strobe			:in  TSL;
    mux_data_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_clk90		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_reg_add		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_delay		:in  TSLV(TVLcreate(LPM_MUX_MULTIPL*LPM_CLOCK_MULTIPL-1)-1 downto 0);
    clock_inv			:in  TSL;
    mux_data			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_DEMUX_V1;

architecture behaviour of LPM_DATA_DEMUX_V1 is

  constant PIPELEN		:TN := (LPM_MUX_MULTIPL-1)*LPM_CLOCK_MULTIPL+1;
  type     TMuxPipe		is array(LPM_MUX_WIDTH-1 downto 0) of TSLV(PIPELEN-1 downto 0);

  signal   H			:TSL;
  signal   MuxDataRegN90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegN90P	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegPP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegNP90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP90P	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegN		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegNP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataSelReg	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataAddReg	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataReg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataDelReg	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxPipe		:TMuxPipe;
  signal   MuxOutReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataRegN		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   StrReg		:TSL;

begin

  H <= '1';
  --
  process (mux_clock90, resetN) begin
    if (resetN='0') then
      MuxDataRegN90 <= (others=>'0');
    elsif (mux_clock90'event and mux_clock90='0') then
      MuxDataRegN90 <= mux_data;
    end if;
  end process;
  --
  process (mux_clock, resetN) begin
    if (resetN='0') then
      MuxDataRegP <= (others=>'0');
    elsif (mux_clock'event and mux_clock='1') then
      MuxDataRegP <= mux_data;
    end if;
  end process;
  --
  process (mux_clock90, resetN) begin
    if (resetN='0') then
      MuxDataRegP90  <= (others=>'0');
      MuxDataRegNP90 <= (others=>'0');
    elsif (mux_clock90'event and mux_clock90='1') then
      MuxDataRegP90  <= mux_data;
      MuxDataRegNP90 <= MuxDataRegN90;
    end if;
  end process;
  --
  process (mux_clock, resetN) begin
    if (resetN='0') then
      MuxDataRegN <= (others=>'0');
    elsif (mux_clock'event and mux_clock='0') then
      MuxDataRegN <= mux_data;
    end if;
  end process;
  --
  process (mux_clock, resetN) is
  begin
    if (resetN='0') then
      MuxDataRegN90P  <= (others=>'0');
      MuxDataRegPP    <= (others=>'0');
      MuxDataRegP90P  <= (others=>'0');
      MuxDataRegNP    <= (others=>'0');
      MuxDataSelReg   <= (others=>'0');
      MuxDataAddReg   <= (others=>'0');
      MuxDataReg      <= (others=>'0');
    elsif (mux_clock'event and mux_clock='1') then
      MuxDataRegN90P  <= sel(MuxDataRegNP90,MuxDataRegN90,CLOCK_PIPE_ENA);
      MuxDataRegPP    <= sel(MuxDataRegP,mux_data,CLOCK_PIPE_ENA);
      MuxDataRegP90P  <= MuxDataRegP90;
      MuxDataRegNP    <= MuxDataRegN;
      for index in 0 to LPM_MUX_WIDTH-1 loop
        if (mux_data_clk_inv(index) = '0') then
          if (mux_data_clk90(index) = '0') then
            MuxDataSelReg(index) <= MuxDataRegPP(index);
          else
            MuxDataSelReg(index) <= MuxDataRegP90P(index);
          end if;
        else
          if (mux_data_clk90(index) = '0') then
            MuxDataSelReg(index) <= MuxDataRegNP(index);
          else
            MuxDataSelReg(index) <= MuxDataRegN90P(index);
          end if;
        end if;
        MuxDataAddReg(index) <= MuxDataSelReg(index);
        if (mux_data_reg_add(index) = '0') then
          MuxDataReg(index) <= MuxDataSelReg(index);
        else
          MuxDataReg(index) <= MuxDataAddReg(index);
        end if;
      end loop;
    end if;
  end process;
  --
  delay_comp: LPM_REG_PROG_PIPE
    generic map(
      LPM_DATA_WIDTH  => LPM_MUX_WIDTH,
      LPM_DELAY_POS   => PIPELEN-1,
      LPM_DELAY_STEP  => 1,
      IN_REGISTERED   => FALSE,
      OUT_REGISTERED  => FALSE
    )
    port map(
      resetN          => resetN,
      clock           => mux_clock,
      clk_ena         => H,
      delay           => mux_data_delay,
      data_in         => MuxDataReg,
      data_out        => MuxDataDelReg
    );
  --
  process(mux_clock, resetN)
  begin
    if(resetN='0') then
      MuxPipe <= (TMuxPipe'range => (others =>'0'));
    elsif(mux_clock'event and mux_clock='1') then
      for index in 0 to LPM_MUX_WIDTH-1 loop
	MuxPipe(index)(PIPELEN-2 downto 0) <= MuxPipe(index)(PIPELEN-1 downto 1);
	MuxPipe(index)(PIPELEN-1) <= MuxDataDelReg(index);
      end loop;
    end if;
  end process;
  --
  process (mux_clock, resetN, strobe)
  begin
    if (STROBE_REGISTERED=TRUE and resetN='0') then
      StrReg  <= '0';
    elsif (STROBE_REGISTERED=FALSE or (mux_clock'event and mux_clock='1')) then
      StrReg  <= strobe;
    end if;
  end process;
  --
  process (mux_clock, resetN, StrReg, MuxPipe)
    variable DataVar : TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable PipeData :TSLV(LPM_MUX_MULTIPL-1 downto 0);
  begin
    if (STROBE_ENABLE=TRUE and resetN='0') then
      MuxOutReg   <= (others=>'0');
    elsif (STROBE_ENABLE=FALSE or (mux_clock'event and mux_clock='1')) then
      DataVar := (others =>'0');
      if (STROBE_ENABLE=FALSE or StrReg='1') then
        for index in 0 to LPM_MUX_WIDTH-1 loop
	  for pos in 0 to LPM_MUX_MULTIPL-1 loop
	    PipeData(pos) := MuxPipe(index)(pos*LPM_CLOCK_MULTIPL);
	  end loop;
          DataVar := SLVPartPut(DataVar,LPM_MUX_MULTIPL,index,PipeData);
	end loop;
        MuxOutReg <= DataVar;
      end if;
    end if;
  end process;
  --
  process (clock, resetN) begin
    if (resetN='0') then
      DataRegN <= (others=>'0');
    elsif (clock'event and clock='0') then
      DataRegN <= MuxOutReg;
    end if;
  end process;
  --
  process (clock, resetN, DataRegN, MuxOutReg, clock_inv) begin
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataReg   <= (others=>'0');
    elsif (OUTPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      DataReg <= sel(DataRegN, MuxOutReg, clock_inv);
    end if;
  end process;
  --
  process (DataReg)
    variable DataSymmVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable DataPartVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  begin
    DataSymmVar := DataReg;
    if (SYMMETRIZATION_ENA=TRUE) then
      for index in 0 to LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 loop
        DataSymmVar(index) := DataSymmVar(index) xor TSLconv(((index/2)*2)=index) xor TSLconv((((index/LPM_MUX_MULTIPL)/2)*2)=(index/LPM_MUX_MULTIPL));
      end loop;
    end if;
    DataPartVar := DataSymmVar;
    if (MUX_PART_MODE_ENA=TRUE) then
      for midx in 0 to LPM_MUX_MULTIPL-1 loop
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          DataPartVar(midx*LPM_MUX_WIDTH+widx) := DataSymmVar(widx*LPM_MUX_MULTIPL+midx);
        end loop;
      end loop;
    end if;
    if (MUX_DECREASE_ENA=TRUE) then
      if (LPM_MUX_MULTIPL>2 or MUX_PART_MODE_ENA=FALSE) then
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          for midx in 0 to LPM_MUX_MULTIPL-1 loop
            data(widx*LPM_MUX_MULTIPL+midx) <= DataPartVar(widx*LPM_MUX_MULTIPL+LPM_MUX_MULTIPL-1-midx);
          end loop;
        end loop;
      else
        for midx in 0 to LPM_MUX_MULTIPL-1 loop
          for widx in 0 to LPM_MUX_WIDTH-1 loop
            data(midx*LPM_MUX_WIDTH+widx) <= DataPartVar((LPM_MUX_MULTIPL-1-midx)*LPM_MUX_WIDTH+widx);
          end loop;
        end loop;
      end if;
    else 
      data <= DataPartVar;
    end if;
  end process;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_DATA_DEMUX_V2 is
  generic (
    LPM_MUX_WIDTH		:TN := 0;
    LPM_MUX_MULTIPL		:TN := 0;
    LPM_EXT_PHASE_ENA		:TL := FALSE;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := FALSE;
    LPM_MCLK180_ADD		:TL := TRUE;
    LPM_MCLK270_ADD		:TL := TRUE;
    LPM_OVERCLOCK_MULTIPL	:TN := 0;
    LPM_LAT_DELAY_POS		:TN := 0;
    SYMMETRIZATION_ENA		:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    STROBE_ENABLE		:TL := FALSE;
    STROBE_REGISTERED		:TL := FALSE;
    PROCESS_REGISTERED		:TL := TRUE;
    OUTPUT_REGISTERED		:TL := FALSE
  );
  port(
    resetN			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL := '0';
    mux_clock180		:in  TSL := '0';
    mux_clock270		:in  TSL := '0';
    clock			:in  TSL;
    strobe			:in  TSL := '0';
    mux_clk_inv			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others => '0');
    mux_clk90			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others => '0');
    mux_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_MUX_MULTIPL*LPM_OVERCLOCK_MULTIPL-1)-1 downto 0) := (others => '0');
    lat_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_LAT_DELAY_POS)-1 downto 0);
    mux_data			:in  TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0);
    data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0)
  );
end LPM_DATA_DEMUX_V2;

architecture behaviour of LPM_DATA_DEMUX_V2 is

  constant PIPELEN		:TN := LPM_MUX_MULTIPL*LPM_OVERCLOCK_MULTIPL;
  constant PIPESIZE		:TN := TVLcreate(PIPELEN-1);
  type     TMuxPipe		is array(LPM_MUX_WIDTH-1 downto 0) of TSLV(PIPELEN-1 downto 0);
  constant POSSIZE		:TN := TVLcreate(LPM_LAT_DELAY_POS);

  signal   MuxDataRegN90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegN90P	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegPP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegNP90	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegP90P	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegN		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataRegNP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   PhaseDataSig		:TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataReg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxDataDelSig	:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal   MuxPipe		:TMuxPipe;
  signal   MuxOutReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   DataDelReg		:TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  signal   StrReg		:TSL;

begin
  --
  extphF:
  if (LPM_EXT_PHASE_ENA=FALSE) generate
    rxph :LPM_DATA_REPHASE
      generic map (
        LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
        LPM_PHASE_POS		=> LPM_PHASE_POS,
        LPM_QPHASE_ENA		=> LPM_QPHASE_ENA,
        LPM_MCLK180_ADD		=> LPM_MCLK180_ADD,
        LPM_MCLK270_ADD		=> LPM_MCLK270_ADD
      )
      port map (
        resetN			=> resetN,
        mclk0			=> mux_clock,
        mclk90			=> mux_clock90,
        mclk180			=> mux_clock180,
        mclk270			=> mux_clock270,
        mdin			=> mux_data,
        dout			=> PhaseDataSig
      );
  end generate;
  --
  extphT:
  if (LPM_EXT_PHASE_ENA=TRUE) generate
    PhaseDataSig <= TSLAput(PhaseDataSig,mux_data);
  end generate;
  --
  process (mux_clock, resetN) is
    variable MuxVar :TSL;
  begin
    if (resetN='0') then
      MuxDataReg      <= (others=>'0');
    elsif (mux_clock'event and mux_clock='1') then
      for index in 0 to LPM_MUX_WIDTH-1 loop
        MuxVar := '0';
        if (mux_clk_inv(index) = '0') then
          if (mux_clk90(index) = '0') then
            MuxVar := PhaseDataSig(0,index);
	  else
            MuxVar := PhaseDataSig(1,index);
          end if;
        else
          if (mux_clk90(index) = '0') then
            MuxVar := PhaseDataSig(2,index);
	  else
            MuxVar := PhaseDataSig(3,index);
          end if;
        end if;
        MuxDataReg(index) <= MuxVar;
      end loop;
    end if;
  end process;
  --
  mdel:
  for index in 0 to LPM_MUX_WIDTH-1 generate
    delay_comp: LPM_REG_PROG_PIPE1
      generic map(
        LPM_DELAY_POS   => PIPELEN-1,
        LPM_DELAY_STEP  => 1,
        IN_REGISTERED   => FALSE,
        OUT_REGISTERED  => TRUE
      )
      port map(
        resetN          => resetN,
        clock           => mux_clock,
        clk_ena         => '1',
        delay           => mux_delay((index+1)*PIPESIZE-1 downto index*PIPESIZE),
        data_in         => MuxDataReg(index),
        data_out        => MuxDataDelSig(index)
      );
  end generate;
  --
  process(mux_clock, resetN)
  begin
    if(resetN='0') then
      MuxPipe <= (TMuxPipe'range => (others =>'0'));
    elsif(mux_clock'event and mux_clock='1') then
      for index in 0 to LPM_MUX_WIDTH-1 loop
        if (PIPELEN>1) then
	  MuxPipe(index)(PIPELEN-2 downto 0) <= MuxPipe(index)(PIPELEN-1 downto 1);
        end if;
	MuxPipe(index)(PIPELEN-1) <= MuxDataDelSig(index);
      end loop;
    end if;
  end process;
  --
  process (mux_clock, resetN, strobe)
  begin
    if (STROBE_REGISTERED=TRUE and resetN='0') then
      StrReg  <= '0';
    elsif (STROBE_REGISTERED=FALSE or (mux_clock'event and mux_clock='1')) then
      StrReg  <= strobe;
    end if;
  end process;
  --
  process (mux_clock, resetN, StrReg, MuxPipe)
    variable DataVar : TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable PipeVar :TSLV(LPM_MUX_MULTIPL-1 downto 0);
  begin
    if (STROBE_ENABLE=TRUE and resetN='0') then
      MuxOutReg   <= (others=>'0');
    elsif (STROBE_ENABLE=FALSE or (mux_clock'event and mux_clock='1')) then
      DataVar := (others =>'0');
      if (STROBE_ENABLE=FALSE or StrReg='1') then
        for index in 0 to LPM_MUX_WIDTH-1 loop
	  for pos in 0 to LPM_MUX_MULTIPL-1 loop
	    PipeVar(pos) := MuxPipe(index)(pos*LPM_OVERCLOCK_MULTIPL);
	  end loop;
          DataVar := SLVPartPut(DataVar,LPM_MUX_MULTIPL,index,PipeVar);
	end loop;
        MuxOutReg <= DataVar;
      end if;
    end if;
  end process;
  --
  process (clock, resetN, MuxOutReg)
    variable clkv :TL;
  begin
    if (PROCESS_REGISTERED=FALSE) then clkv := TRUE; else clkv := (clock'event and clock='1'); end if;
    if (PROCESS_REGISTERED=TRUE and resetN='0') then
      DataReg  <= (others=>'0');
    elsif (clkv) then
      DataReg  <= MuxOutReg;
    end if;
  end process;
  --
  pdel:
  for index in 0 to LPM_MUX_WIDTH-1 generate
    delay_comp: LPM_REG_PROG_PIPE
      generic map(
        LPM_DATA_WIDTH	=> LPM_MUX_MULTIPL,
        LPM_DELAY_POS   => LPM_LAT_DELAY_POS,
        LPM_DELAY_STEP  => 1,
        IN_REGISTERED   => FALSE,
        OUT_REGISTERED  => OUTPUT_REGISTERED
      )
      port map(
        resetN          => resetN,
        clock           => clock,
        clk_ena         => '1',
        delay           => lat_delay((index+1)*POSSIZE-1 downto index*POSSIZE),
        data_in         => DataReg(LPM_MUX_MULTIPL*(index+1)-1 downto LPM_MUX_MULTIPL*index),
        data_out        => DataDelReg(LPM_MUX_MULTIPL*(index+1)-1 downto LPM_MUX_MULTIPL*index)
      );
  end generate;
  --
  process (DataDelReg)
    variable DataSymmVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    variable DataPartVar :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
  begin
    DataSymmVar := DataDelReg;
    if (SYMMETRIZATION_ENA=TRUE) then
      for index in 0 to LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 loop
        DataSymmVar(index) := DataSymmVar(index) xor TSLconv(((index/2)*2)=index) xor TSLconv((((index/LPM_MUX_MULTIPL)/2)*2)=(index/LPM_MUX_MULTIPL));
      end loop;
    end if;
    DataPartVar := DataSymmVar;
    if (MUX_PART_MODE_ENA=TRUE) then
      for midx in 0 to LPM_MUX_MULTIPL-1 loop
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          DataPartVar(midx*LPM_MUX_WIDTH+widx) := DataSymmVar(widx*LPM_MUX_MULTIPL+midx);
        end loop;
      end loop;
    end if;
    if (MUX_DECREASE_ENA=TRUE) then
      if (LPM_MUX_MULTIPL>2 or MUX_PART_MODE_ENA=FALSE) then
        for widx in 0 to LPM_MUX_WIDTH-1 loop
          for midx in 0 to LPM_MUX_MULTIPL-1 loop
            data(widx*LPM_MUX_MULTIPL+midx) <= DataPartVar(widx*LPM_MUX_MULTIPL+LPM_MUX_MULTIPL-1-midx);
          end loop;
        end loop;
      else
        for midx in 0 to LPM_MUX_MULTIPL-1 loop
          for widx in 0 to LPM_MUX_WIDTH-1 loop
            data(midx*LPM_MUX_WIDTH+widx) <= DataPartVar((LPM_MUX_MULTIPL-1-midx)*LPM_MUX_WIDTH+widx);
          end loop;
        end loop;
      end if;
    else 
      data <= DataPartVar;
    end if;
  end process;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_PART_DATA_SENDER_V1 is
  generic (
    LPM_PART_WIDTH		:TN := 7;
    LPM_PART_NUM		:TN := 8;--7;
    LPM_CHECK_WIDTH		:TN := 8;--9;
    INPUT_REGISTERED		:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL;
    in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
    out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    test_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    test_ena			:in  TSL;
    test_rand_ena		:in  TSL
  );
end LPM_PART_DATA_SENDER_V1;

architecture behaviour of LPM_PART_DATA_SENDER_V1 is

  constant DATA_WIDTH		:TN := LPM_PART_WIDTH*LPM_PART_NUM;
  constant DATA_CHECK_WIDTH	:TN := DATA_WIDTH-LPM_CHECK_WIDTH;
  constant CHECK_WIDTH		:TN := maximum(LPM_CHECK_WIDTH,1);
  constant MUX_CHECK_WIDTH	:TN := SLVPartNum(DATA_CHECK_WIDTH,CHECK_WIDTH);
  --
  constant CHECK_PART_NUM	:TN := maximum(div(LPM_PART_NUM,CHECK_WIDTH),1);
  constant CHECK_PART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_PART_NUM;
  constant CHECK_PART_SIZE	:TN := maximum(div(CHECK_WIDTH,LPM_PART_NUM),1);
  constant CHECK_PART_REP	:TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(LPM_PART_NUM,CHECK_PART_NUM),CHECK_WIDTH)-1);
  constant CHECK_LPART_NUM	:TN := LPM_PART_NUM-CHECK_PART_REP*CHECK_PART_NUM;
  constant CHECK_LPART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_LPART_NUM;
  constant CHECK_LPART_SIZE	:TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
  --
  signal RndSig			:TSLV(DATA_WIDTH-1 downto 0);
  signal DataInReg		:TSLV(DATA_CHECK_WIDTH-1 downto 0);
  signal CheckInReg		:TSLV(maximum(LPM_CHECK_WIDTH,1)-1 downto 0);
  signal DataSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataReg		:TSLV(DATA_WIDTH-1 downto 0);

begin

  process (clock, resetN, check_data, in_data)
  begin
    if (INPUT_REGISTERED=FALSE) then
      DataInReg  <= in_data;
      CheckInReg <= check_data;
    elsif (resetN='0') then
      DataInReg  <= (others=>'0');
      CheckInReg <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataInReg  <= in_data;
      CheckInReg <= check_data;
    end if;
  end process;
  --
  process (DataInReg, CheckInReg, RndSig, test_data, part_ena, check_ena, check_data_ena, test_ena, test_rand_ena)
    variable DataMoveVar  :TSLV(DATA_WIDTH-1 downto 0);
    variable DataCheckVar :TSLV(DATA_WIDTH-1 downto 0);
  begin
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH=0) then
        DataMoveVar := DataInReg;
      elsif (check_data_ena='1') then
        DataMoveVar := TSLVcut(CheckInReg & DataInReg,DATA_WIDTH);
      else
        DataMoveVar := TSLVcut(TSLVnew(CheckInReg'length,'0') & DataInReg,DATA_WIDTH);
      end if;
    else
      if (test_rand_ena='0') then
        DataMoveVar := test_data;
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          DataMoveVar := DataMoveVar xor TSLVnew(DataMoveVar'length,CheckInReg);
          if (CheckInReg'length>1) then
            DataMoveVar := DataMoveVar xor TSLVrot(TSLVnew(DataMoveVar'length,CheckInReg),CheckInReg'length/2);
          end if;
        end if;
      else
        DataMoveVar := RndSig;
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          for index in 0 to LPM_PART_NUM-1 loop
            DataMoveVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index)
            := DataMoveVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index) xor TSLVresize(CheckInReg,LPM_PART_WIDTH,'0');
          end loop;
        end if;
      end if;
    end if;
    DataCheckVar := DataMoveVar;
    if (LPM_CHECK_WIDTH > 0 and check_ena='1') then
      for index in 0 to CHECK_PART_REP-1 loop
        DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
      end loop;
      DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)));
    end if;
    DataMoveVar := DataCheckVar;
    if (part_ena='1' and test_ena='0') then
      if (LPM_CHECK_WIDTH = 0) then
        for y in 0 to LPM_PART_WIDTH-1 loop
          for x in 0 to LPM_PART_NUM-1 loop
               DataMoveVar(A2DIndex(LPM_PART_NUM,LPM_PART_WIDTH,x,y)) -->
            := DataCheckVar(A2DIndex(LPM_PART_WIDTH,LPM_PART_NUM,y,x));
          end loop;
        end loop;
      else
        for rep in 0 to CHECK_PART_REP-1 loop
	  DataMoveVar := SLVPartPut(DataMoveVar,rep,   (SLVPartGet(SLVnorm(DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_WIDTH)),CHECK_PART_SIZE,rep)
	                                             & SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,rep)));
	end loop;
	DataMoveVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_WIDTH)
	:=   DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
           & DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE);
      end if;
    end if;
    DataSig <= DataMoveVar;
  end process;
  --
  process (clock, resetN, DataSig)
  begin
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataReg  <= (others=>'0');
    elsif (OUTPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      DataReg  <= DataSig;
    end if;
  end process;
  out_data <= DataReg;
  --
  rnd_loop:
  for index in 0 to LPM_PART_NUM-1 generate
    rnd_gen :LPM_RAND_GEN_TRANS_V1
      generic map (
        LPM_DATA_WIDTH		=> LPM_PART_WIDTH
      )
      port map (
        resetN			=> resetN,
        clock			=> clock,
        initN			=> test_rand_ena,
        val			=> test_data(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index),
        gen_out			=> RndSig(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index),
        step			=> open
      );
  end generate;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_PART_DATA_SENDER_V2 is
  generic (
    LPM_PART_WIDTH		:TN := 7;
    LPM_PART_NUM		:TN := 8;--7;
    LPM_CHECK_WIDTH		:TN := 8;--9;
    INPUT_REGISTERED		:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL;
    in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
    out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    test_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    test_ena			:in  TSL;
    test_data_rnd_ena		:in  TSL;
    test_part_rnd_ena		:in  TSL
  );
end LPM_PART_DATA_SENDER_V2;

architecture behaviour of LPM_PART_DATA_SENDER_V2 is

  constant DATA_WIDTH		:TN := LPM_PART_WIDTH*LPM_PART_NUM;
  constant DATA_CHECK_WIDTH	:TN := DATA_WIDTH-LPM_CHECK_WIDTH;
  constant CHECK_WIDTH		:TN := maximum(LPM_CHECK_WIDTH,1);
  constant MUX_CHECK_WIDTH	:TN := SLVPartNum(DATA_CHECK_WIDTH,CHECK_WIDTH);
  --
  constant CHECK_PART_NUM	:TN := maximum(div(LPM_PART_NUM,CHECK_WIDTH),1);
  constant CHECK_PART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_PART_NUM;
  constant CHECK_PART_SIZE	:TN := maximum(div(CHECK_WIDTH,LPM_PART_NUM),1);
  constant CHECK_PART_REP	:TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(LPM_PART_NUM,CHECK_PART_NUM),CHECK_WIDTH)-1);
  constant CHECK_LPART_NUM	:TN := LPM_PART_NUM-CHECK_PART_REP*CHECK_PART_NUM;
  constant CHECK_LPART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_LPART_NUM;
  constant CHECK_LPART_SIZE	:TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
  --
  signal RndPartSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal RndDataSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataInReg		:TSLV(DATA_CHECK_WIDTH-1 downto 0);
  signal CheckInReg		:TSLV(maximum(LPM_CHECK_WIDTH,1)-1 downto 0);
  signal DataSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataReg		:TSLV(DATA_WIDTH-1 downto 0);

begin

  process (clock, resetN, check_data, in_data)
  begin
    if (INPUT_REGISTERED=FALSE) then
      DataInReg  <= in_data;
      CheckInReg <= check_data;
    elsif (resetN='0') then
      DataInReg  <= (others=>'0');
      CheckInReg <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataInReg  <= in_data;
      CheckInReg <= check_data;
    end if;
  end process;
  --
  data_rnd_gen :LPM_RAND_GEN_TRANS_V2
    generic map (
      LPM_GEN_WIDTH	=> 8,
      LPM_RND_INIT	=> 0,
      LPM_DATA_WIDTH	=> DATA_WIDTH,
      LPM_STROBE_ENA	=> FALSE
    )
    port map (
      resetN		=> resetN,
      clock		=> clock,
      gen_ena		=> test_data_rnd_ena,
      gen_strobe	=> open,
      gen_init	=> open,
      gen_out		=> RndDataSig,
      gen_in		=> open,
      valid		=> open,
      valid_ena	=> open
    );
  --
  rnd_loop:
  for index in 0 to LPM_PART_NUM-1 generate
    part_rnd_gen :LPM_RAND_GEN_TRANS_V2
      generic map (
        LPM_GEN_WIDTH	=> 8,
        LPM_RND_INIT	=> 3*(index+13),
        LPM_DATA_WIDTH	=> LPM_PART_WIDTH,
        LPM_STROBE_ENA	=> FALSE
      )
      port map (
        resetN		=> resetN,
        clock		=> clock,
        gen_ena		=> test_part_rnd_ena,
        gen_strobe	=> open,
        gen_init	=> open,
        gen_out		=> RndPartSig(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index),
        gen_in		=> open,
        valid		=> open,
        valid_ena	=> open
      );
  end generate;
  --
  process (DataInReg, CheckInReg, RndDataSig, RndPartSig, test_data, part_ena, check_ena, check_data_ena, test_ena, test_data_rnd_ena, test_part_rnd_ena)
    variable DataMoveVar  :TSLV(DATA_WIDTH-1 downto 0);
    variable DataCheckVar :TSLV(DATA_WIDTH-1 downto 0);
  begin
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH=0) then
        DataMoveVar := DataInReg;
      elsif (check_data_ena='1') then
        DataMoveVar := TSLVcut(SLVnorm(CheckInReg & DataInReg),DATA_WIDTH);
      else
        DataMoveVar := TSLVcut(SLVnorm(TSLVnew(CheckInReg'length,'0') & DataInReg),DATA_WIDTH);
      end if;
    else
      if (test_data_rnd_ena='0' and test_part_rnd_ena='0') then
        DataMoveVar := test_data;
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          DataMoveVar := DataMoveVar xor TSLVnew(DataMoveVar'length,CheckInReg);
          if (CheckInReg'length>1) then
            DataMoveVar := DataMoveVar xor TSLVrot(TSLVnew(DataMoveVar'length,CheckInReg),CheckInReg'length/2);
          end if;
        end if;
      else
        if (test_data_rnd_ena='1') then DataMoveVar := RndDataSig; else DataMoveVar := RndPartSig; end if;
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          for index in 0 to LPM_PART_NUM-1 loop
            DataMoveVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index)
            := DataMoveVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index) xor TSLVresize(CheckInReg,LPM_PART_WIDTH,'0');
          end loop;
        end if;
      end if;
    end if;
    DataCheckVar := DataMoveVar;
    if (LPM_CHECK_WIDTH > 0 and check_ena='1') then
      for index in 0 to CHECK_PART_REP-1 loop
        DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
      end loop;
      DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)));
    end if;
    DataMoveVar := DataCheckVar;
    if (part_ena='1' and test_ena='0') then
      if (LPM_CHECK_WIDTH = 0) then
        for y in 0 to LPM_PART_WIDTH-1 loop
          for x in 0 to LPM_PART_NUM-1 loop
               DataMoveVar(A2DIndex(LPM_PART_NUM,LPM_PART_WIDTH,x,y)) -->
            := DataCheckVar(A2DIndex(LPM_PART_WIDTH,LPM_PART_NUM,y,x));
          end loop;
        end loop;
      else
        for rep in 0 to CHECK_PART_REP-1 loop
	  DataMoveVar := SLVPartPut(DataMoveVar,rep,   (SLVPartGet(SLVnorm(DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_WIDTH)),CHECK_PART_SIZE,rep)
	                                             & SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,rep)));
	end loop;
	DataMoveVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_WIDTH)
	:=   DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
           & DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE);
      end if;
    end if;
    DataSig <= DataMoveVar;
  end process;
  --
  process (clock, resetN, DataSig)
    variable clkv :TL;
  begin
    if (OUTPUT_REGISTERED=FALSE) then clkv := TRUE; else clkv := (clock'event and clock='1'); end if;
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataReg  <= (others=>'0');
    elsif (clkv) then
      DataReg  <= DataSig;
    end if;
  end process;
  out_data <= DataReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_MUX_DATA_SENDER_V1 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_CLOCK_MULTIPL		:TN := 1;
    LPM_PART_NUM		:TN := 4;
    LPM_CHECK_WIDTH		:TN := 5;
    MUX_SYMMETRIZATION_ENA	:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    PART_INPUT_REGISTERED	:TL := TRUE;
    PART_OUTPUT_REGISTERED	:TL := TRUE;
    MUX_INPUT_REGISTERED	:TL := TRUE;
    MUX_STROBE_ASET_ENA		:TL := TRUE;
    MUX_OUTPUT_REGISTERED	:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mux_clock			:in  TSL;
    clock_inv			:in  TSL;
    strobe			:in  TSL;
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL;
    data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
    mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0);
    test_data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    test_ena			:in  TSL;
    test_rand_ena		:in  TSL
  );
end LPM_MUX_DATA_SENDER_V1;

architecture behaviour of LPM_MUX_DATA_SENDER_V1 is

  constant PART_WIDTH   :TP := SLVPartNum(LPM_MUX_MULTIPL*LPM_MUX_WIDTH,LPM_PART_NUM);
  signal   SendDataSig  :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);

begin

  sender :LPM_PART_DATA_SENDER_V1
    generic map (
      LPM_PART_WIDTH		=> PART_WIDTH,
      LPM_PART_NUM		=> LPM_PART_NUM,
      LPM_CHECK_WIDTH		=> LPM_CHECK_WIDTH,
      INPUT_REGISTERED		=> PART_INPUT_REGISTERED,
      OUTPUT_REGISTERED		=> PART_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      part_ena			=> part_ena,
      check_ena			=> check_ena,
      check_data		=> check_data,
      in_data			=> data,
      out_data			=> SendDataSig,
      test_data			=> test_data,
      check_data_ena		=> check_data_ena,
      test_ena			=> test_ena,
      test_rand_ena		=> test_rand_ena
    );
  --
  mux :LPM_DATA_MUX_V1
    generic map (
      LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
      LPM_MUX_MULTIPL		=> LPM_MUX_MULTIPL,
      LPM_CLOCK_MULTIPL		=> LPM_CLOCK_MULTIPL,
      SYMMETRIZATION_ENA	=> MUX_SYMMETRIZATION_ENA,
      MUX_PART_MODE_ENA		=> MUX_PART_MODE_ENA,
      MUX_DECREASE_ENA		=> MUX_DECREASE_ENA,
      INPUT_REGISTERED		=> FALSE,
      INPUT_MUX_REGISTERED	=> MUX_INPUT_REGISTERED,
      STROBE_ASET_ENA		=> MUX_STROBE_ASET_ENA,
      OUTPUT_MUX_REGISTERED	=> MUX_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      mux_clock			=> mux_clock,
      clock_inv			=> clock_inv,
      strobe			=> strobe,
      data			=> SendDataSig,
      mux_data			=> mux_data
    );

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_MUX_DATA_SENDER_V2 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_OVERCLOCK_MULTIPL	:TN := 1;
    LPM_PART_NUM		:TN := 4;
    LPM_CHECK_WIDTH		:TN := 5;
    MUX_SYMMETRIZATION_ENA	:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    PART_INPUT_REGISTERED	:TL := TRUE;
    PART_OUTPUT_REGISTERED	:TL := TRUE;
    MUX_INPUT_REGISTERED	:TL := TRUE;
    MUX_STROBE_AUTO_ENA		:TL := TRUE;
    MUX_OUTPUT_REGISTERED	:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL;
    mux_clock180		:in  TSL;
    mux_clock270		:in  TSL;
    clock_inv			:in  TSL;
    strobe			:in  TSL;
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL;
    data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
    mux_data			:out TSLV(LPM_MUX_WIDTH-1 downto 0);
    test_data			:in  TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    test_ena			:in  TSL;
    test_data_rnd_ena		:in  TSL;
    test_part_rnd_ena		:in  TSL
  );
end LPM_MUX_DATA_SENDER_V2;

architecture behaviour of LPM_MUX_DATA_SENDER_V2 is

  constant PART_WIDTH   :TP := SLVPartNum(LPM_MUX_MULTIPL*LPM_MUX_WIDTH,LPM_PART_NUM);
  signal   SendDataSig  :TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);

begin

  sender :LPM_PART_DATA_SENDER_V2
    generic map (
      LPM_PART_WIDTH		=> PART_WIDTH,
      LPM_PART_NUM		=> LPM_PART_NUM,
      LPM_CHECK_WIDTH		=> LPM_CHECK_WIDTH,
      INPUT_REGISTERED		=> PART_INPUT_REGISTERED,
      OUTPUT_REGISTERED		=> PART_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      part_ena			=> part_ena,
      check_ena			=> check_ena,
      check_data		=> check_data,
      in_data			=> data,
      out_data			=> SendDataSig,
      test_data			=> test_data,
      check_data_ena		=> check_data_ena,
      test_ena			=> test_ena,
      test_data_rnd_ena		=> test_data_rnd_ena,
      test_part_rnd_ena		=> test_part_rnd_ena
    );
  --
  mux :LPM_DATA_MUX_V2
    generic map (
      LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
      LPM_MUX_MULTIPL		=> LPM_MUX_MULTIPL,
      LPM_OVERCLOCK_MULTIPL	=> LPM_OVERCLOCK_MULTIPL,
      SYMMETRIZATION_ENA	=> MUX_SYMMETRIZATION_ENA,
      MUX_PART_MODE_ENA		=> MUX_PART_MODE_ENA,
      MUX_DECREASE_ENA		=> MUX_DECREASE_ENA,
      INPUT_REGISTERED		=> FALSE,
      INPUT_MUX_REGISTERED	=> MUX_INPUT_REGISTERED,
      STROBE_AUTO_ENA		=> MUX_STROBE_AUTO_ENA,
      OUTPUT_MUX_REGISTERED	=> MUX_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      mux_clock			=> mux_clock,
      mux_clock90		=> mux_clock90,
      mux_clock180		=> mux_clock180,
      mux_clock270		=> mux_clock270,
      clock_inv			=> clock_inv,
      strobe			=> strobe,
      data			=> SendDataSig,
      mux_data			=> mux_data
    );

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_PART_DATA_RECEIVER_V1 is
  generic (
    LPM_PART_WIDTH		:TN := 8;
    LPM_PART_NUM		:TN := 14;
    LPM_CHECK_WIDTH		:TN := 4;
    LPM_DELAY_WIDTH		:TN := 0;
    INPUT_REGISTERED		:TL := TRUE;
    CHECK_REGISTERED		:TL := TRUE;
    INPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clock_inv			:in  TSL;
    data_delay			:in  TSLV(maximum(LPM_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
    check_data_ena		:in  TSL;
    test_ena			:in  TSL;
    test_rand_ena		:in  TSL;
    test_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    data_valid			:out TSL;
    test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
    test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
  );
end LPM_PART_DATA_RECEIVER_V1;

architecture behaviour of LPM_PART_DATA_RECEIVER_V1 is

  constant DATA_WIDTH		:TN := LPM_PART_WIDTH*LPM_PART_NUM;
  constant DATA_CHECK_WIDTH	:TN := DATA_WIDTH-LPM_CHECK_WIDTH;
  constant CHECK_WIDTH		:TN := maximum(LPM_CHECK_WIDTH,1);
  constant MUX_CHECK_WIDTH	:TN := SLVPartNum(DATA_CHECK_WIDTH,maximum(LPM_CHECK_WIDTH,1));
  --
  constant CHECK_PART_NUM	:TN := maximum(div(LPM_PART_NUM,CHECK_WIDTH),1);
  constant CHECK_PART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_PART_NUM;
  constant CHECK_PART_SIZE	:TN := maximum(div(CHECK_WIDTH,LPM_PART_NUM),1);
  constant CHECK_PART_REP	:TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(LPM_PART_NUM,CHECK_PART_NUM),CHECK_WIDTH)-1);
  constant CHECK_LPART_NUM	:TN := LPM_PART_NUM-CHECK_PART_REP*CHECK_PART_NUM;
  constant CHECK_LPART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_LPART_NUM;
  constant CHECK_LPART_SIZE	:TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
  --
  signal L, H			:TSL;
  signal ResVec	  		:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataRegN		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataDel		:TSLV(DATA_WIDTH-1 downto 0);
  signal RndSig			:TSLV(DATA_WIDTH-1 downto 0);
  signal CheckDataReg		:TSLV(check_data'range);
  signal DataOutSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataOutReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataValidSig		:TSL;
  signal DataValidReg		:TSL;
  signal DataCheckSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataCheckReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestORDataSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestORDataRegN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestORreadSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestOthers0	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestOthers1	:TSLV(LPM_PART_NUM-1 downto 0);

begin

  L <= '0'; H <= '1';
  ResVec <= (others => resetN);
  DataTestOthers0 <= (others => '0');
  DataTestOthers1 <= (others => '1');

  process (clock, resetN) begin
    if (resetN='0') then
      DataRegN <= (others=>'0');
    elsif (clock'event and clock='0') then
      DataRegN <= in_data;
    end if;
  end process;

  process (clock, resetN, clock_inv, in_data, DataRegN)
    variable clkv :TL;
  begin
    if (INPUT_REGISTERED=FALSE) then clkv := TRUE; else clkv := rising_edge(clock); end if;
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      DataReg <= (others=>'0');
    elsif (clkv) then
      if (clock_inv = '0') then
        DataReg <= in_data;
      else
        DataReg <= DataRegN;
      end if;
    end if;
  end process;

  delay_yes:
  if (LPM_DELAY_WIDTH>0) generate
    dalay :LPM_REG_PROG_PIPE
      generic map (
        LPM_DATA_WIDTH		=> DATA_WIDTH,
        LPM_DELAY_POS		=> 2**LPM_DELAY_WIDTH-1,
        LPM_DELAY_STEP    	=> 1,
        IN_REGISTERED		=> INPUT_DELAY_REGISTERED,
        OUT_REGISTERED		=> OUTPUT_DELAY_REGISTERED
      )
      port map (
      resetN			=> resetN,
      clock			=> clock,
        clk_ena			=> H,
        delay			=> data_delay,
        data_in			=> DataReg,
        data_out		=> DataDel
      );
  end generate;
  --
  delay_no:
  if (LPM_DELAY_WIDTH=0) generate
    DataDel <= DataReg;
  end generate;
  --
  process (clock, resetN, check_data)
    variable clkv :TL;
  begin
    if (CHECK_REGISTERED=FALSE) then clkv := TRUE; else clkv := rising_edge(clock); end if;
    if (CHECK_REGISTERED=TRUE and resetN='0') then
      CheckDataReg <= (others=>'0');
    elsif (clkv) then
      CheckDataReg <= check_data;
    end if;
  end process;
  --
  process (CheckDataReg, DataDel, RndSig, part_ena, check_ena, check_data_ena, test_ena, test_rand_ena)
    variable DataMoveVar  :TSLV(DATA_WIDTH-1 downto 0);
    variable DataCheckVar :TSLV(DATA_WIDTH-1 downto 0);
    constant LPos         :TVI := DATA_WIDTH-1;
    constant RPos         :TVI := DATA_WIDTH-LPM_CHECK_WIDTH;
    variable DataPartVar  :TSLV(CHECK_PART_WIDTH-1 downto 0);
  begin
    DataMoveVar := DataDel;
    if (part_ena='1' and test_ena='0') then
      if (LPM_CHECK_WIDTH = 0) then
        for y in 0 to LPM_PART_WIDTH-1 loop
          for x in 0 to LPM_PART_NUM-1 loop
               DataMoveVar(A2DIndex(LPM_PART_WIDTH,LPM_PART_NUM,y,x)) -->
            := DataDel(A2DIndex(LPM_PART_NUM,LPM_PART_WIDTH,x,y));
          end loop;
        end loop;
      else
        for rep in 0 to CHECK_PART_REP-1 loop
          DataPartVar  := SLVPartGet(DataDel,CHECK_PART_WIDTH,rep);
          DataCheckVar := SLVPartPut(DataCheckVar,rep,DataPartVar(CHECK_PART_WIDTH-1 downto CHECK_PART_WIDTH-CHECK_PART_SIZE));
          DataMoveVar  := SLVPartPut(DataMoveVar,rep,DataPartVar(CHECK_PART_WIDTH-CHECK_PART_SIZE-1 downto 0));
        end loop;
        DataCheckVar(LPM_CHECK_WIDTH-1 downto LPM_CHECK_WIDTH-CHECK_LPART_SIZE) := DataDel(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE);
        DataMoveVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)
        := DataDel(DATA_WIDTH-CHECK_LPART_SIZE-1 downto DATA_WIDTH-CHECK_LPART_WIDTH);
        DataMoveVar := DataCheckVar(LPM_CHECK_WIDTH-1 downto 0) & DataMoveVar(DATA_CHECK_WIDTH-1 downto 0);
      end if;
    end if;
    --
    DataCheckVar := DataMoveVar;
    if (LPM_CHECK_WIDTH>0 and check_ena='1') then
      for index in 0 to CHECK_PART_REP-1 loop
        DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
      end loop;
      DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)));
    end if;
    --
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
        DataCheckVar := (DataCheckVar(DATA_WIDTH-1 downto DATA_CHECK_WIDTH) xor CheckDataReg) & DataCheckVar(DATA_CHECK_WIDTH-1 downto 0);
      end if;
      DataOutSig   <= DataCheckVar;
      DataTestSig  <= DataCheckVar;
    else
      DataOutSig   <= (others => '0');
      if (test_rand_ena='0') then
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          DataCheckVar := DataCheckVar xor TSLVnew(DataCheckVar'length,CheckDataReg);
          if (check_data'length>1) then
            DataCheckVar := DataCheckVar xor TSLVrot(TSLVnew(DataCheckVar'length,CheckDataReg),CheckDataReg'length/2);
          end if;
        end if;
        DataTestSig  <= DataCheckVar;
      else
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          for index in 0 to LPM_PART_NUM-1 loop
            DataCheckVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index)
            := DataCheckVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index) xor TSLVresize(CheckDataReg,LPM_PART_WIDTH,'0');
          end loop;
        end if;
        DataTestSig  <= DataCheckVar xor RndSig;
      end if;
    end if;
    DataCheckSig <= DataCheckVar;
  end process;
  --
  process (clock, resetN)
  begin
    if (resetN='0') then
      DataCheckReg <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataCheckReg <= DataCheckSig;
    end if;
  end process;
  --
  rnd_loop:
  for index in 0 to LPM_PART_NUM-1 generate
    rnd_gen :LPM_RAND_GEN_TRANS_V1
      generic map (
        LPM_DATA_WIDTH		=> LPM_PART_WIDTH
      )
      port map (
        resetN			=> H,
        clock			=> L,
        initN			=> H,
        val			=> DataCheckReg(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index),
        gen_out			=> open,
        step			=> RndSig(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index)
      );
  end generate;
  --
  process (DataTestSig, part_ena, check_ena, check_data_ena, test_ena, test_rand_ena)
  begin
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH>0 and (check_ena='1' or check_data_ena='1')) then
        if (part_ena='0') then
          DataTestORdataSigN <= TSLVnew(LPM_PART_NUM,not(OR_REDUCE(DataTestSig(DATA_WIDTH-1 downto DATA_CHECK_WIDTH))));
	else
          for rep in 0 to CHECK_PART_REP-1 loop
	    DataTestORdataSigN(CHECK_PART_NUM*(rep+1)-1 downto CHECK_PART_NUM*rep)
	    <= TSLVnew(CHECK_PART_NUM,not(OR_REDUCE(DataTestSig(CHECK_PART_SIZE*(rep+1)+DATA_CHECK_WIDTH-1 downto CHECK_PART_SIZE*rep+DATA_CHECK_WIDTH))));
	  end loop;
	  DataTestORdataSigN(LPM_PART_NUM-1 downto LPM_PART_NUM-CHECK_LPART_NUM)
	  <= TSLVnew(CHECK_LPART_NUM,not(OR_REDUCE(DataTestSig(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE))));
        end if;
      else
        DataTestORdataSigN <= (others => '1');
      end if;
    else
      for index in 0 to LPM_PART_NUM-1 loop
        DataTestORdataSigN(index) <= not(OR_REDUCE(SLVPartGet(DataTestSig,LPM_PART_WIDTH,index)));
      end loop;
    end if;
  end process;
  --
  process (resetN, clock)
  begin
    if (resetN='0') then
      DataTestORdataRegN <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataTestORdataRegN <= DataTestORdataSigN;
    end if;
  end process;
  --
  DataTestORreadSigN <= not(test_or_read);
  or_reg :KTP_LPM_DFF
    generic map(
      LPM_WIDTH => LPM_PART_NUM
    )
    port map(
      resetN    => ResVec,
      setN      => DataTestORdataRegN,
      clk       => DataTestORreadSigN,
      ena       => DataTestOthers1,
      d         => DataTestOthers0,
      q		=> test_or_data
  );
  --
  DataValidSig <= AND_REDUCE(DataTestORdataSigN);
  process (clock, resetN, DataOutSig, DataTestSig, DataValidSig, test_ena, check_ena, check_data_ena)
    variable clkv :TL;
  begin
    if (OUTPUT_REGISTERED=FALSE) then clkv := TRUE; else clkv := rising_edge(clock); end if;
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataOutReg   <= (others=>'0');
      DataValidReg <= '0';
      DataTestReg  <= (others=>'0');
    elsif (clkv) then
      if (DataValidSig='1' and test_ena='0') then
        DataOutReg <= DataOutSig;
      else
        DataOutReg <= (others =>'0');
      end if;
      DataValidReg <= DataValidSig or (test_ena and not(check_ena) and not(check_data_ena));
      DataTestReg  <= DataTestSig;
    end if;
  end process;
  --
  out_data   <= DataOutReg(DATA_CHECK_WIDTH-1 downto 0);
  data_valid <= DataValidReg;
  test_data  <= DataTestReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;

entity LPM_PART_DATA_RECEIVER_V2 is
  generic (
    LPM_PART_WIDTH		:TN := 8;
    LPM_PART_NUM		:TN := 14;
    LPM_CHECK_WIDTH		:TN := 4;
    LPM_DELAY_POS		:TN := 0;
    INPUT_REGISTERED		:TL := TRUE;
    CHECK_REGISTERED		:TL := TRUE;
    INPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clock_inv			:in  TSL;
    data_delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others =>'0');
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    in_data			:in  TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    out_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-LPM_CHECK_WIDTH-1 downto 0);
    check_data_ena		:in  TSL;
    test_ena			:in  TSL;
    test_data_rnd_ena		:in  TSL;
    test_part_rnd_ena		:in  TSL;
    test_data			:out TSLV(LPM_PART_WIDTH*LPM_PART_NUM-1 downto 0);
    data_valid			:out TSL;
    test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
    test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0);
    sync_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
    sync_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
  );
end LPM_PART_DATA_RECEIVER_V2;

architecture behaviour of LPM_PART_DATA_RECEIVER_V2 is

  constant DATA_WIDTH		:TN := LPM_PART_WIDTH*LPM_PART_NUM;
  constant DATA_CHECK_WIDTH	:TN := DATA_WIDTH-LPM_CHECK_WIDTH;
  constant CHECK_WIDTH		:TN := maximum(LPM_CHECK_WIDTH,1);
  constant MUX_CHECK_WIDTH	:TN := SLVPartNum(DATA_CHECK_WIDTH,maximum(LPM_CHECK_WIDTH,1));
  --
  constant CHECK_PART_NUM	:TN := maximum(div(LPM_PART_NUM,CHECK_WIDTH),1);
  constant CHECK_PART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_PART_NUM;
  constant CHECK_PART_SIZE	:TN := maximum(div(CHECK_WIDTH,LPM_PART_NUM),1);
  constant CHECK_PART_REP	:TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(LPM_PART_NUM,CHECK_PART_NUM),CHECK_WIDTH)-1);
  constant CHECK_LPART_NUM	:TN := LPM_PART_NUM-CHECK_PART_REP*CHECK_PART_NUM;
  constant CHECK_LPART_WIDTH	:TN := LPM_PART_WIDTH*CHECK_LPART_NUM;
  constant CHECK_LPART_SIZE	:TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
  --
  signal L, H			:TSL;
  signal ResVec	  		:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataRegN		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataDel		:TSLV(DATA_WIDTH-1 downto 0);
  signal RndDataValSig		:TSL;
  signal RndDataValEnaSig	:TSL;
  signal RndPartValSig		:TSLV(LPM_PART_NUM-1 downto 0);
  signal RndPartValEnaSig	:TSLV(LPM_PART_NUM-1 downto 0);
  signal CheckDataReg		:TSLV(check_data'range);
  signal DataOutSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataOutReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataValidSig		:TSL;
  signal DataValidReg		:TSL;
  signal DataCheckSig		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataCheckReg		:TSLV(DATA_WIDTH-1 downto 0);
  signal DataTestORDataSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestORDataRegN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataTestORreadSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataSyncORDataSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataSyncORDataRegN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataSyncORreadSigN	:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataORothers0		:TSLV(LPM_PART_NUM-1 downto 0);
  signal DataORothers1		:TSLV(LPM_PART_NUM-1 downto 0);

begin

  L <= '0'; H <= '1';
  ResVec <= (others => resetN);
  DataORothers0 <= (others => '0');
  DataORothers1 <= (others => '1');

  process (clock, resetN) begin
    if (resetN='0') then
      DataRegN <= (others=>'0');
    elsif (clock'event and clock='0') then
      DataRegN <= in_data;
    end if;
  end process;

  process (clock, resetN, clock_inv, in_data, DataRegN)
    variable clkv :TL;
  begin
    if (INPUT_REGISTERED=FALSE) then clkv := TRUE; else clkv := (clock'event and clock='1'); end if;
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      DataReg <= (others=>'0');
    elsif (clkv) then
      if (clock_inv = '0') then
        DataReg <= in_data;
      else
        DataReg <= DataRegN;
      end if;
    end if;
  end process;
  --
  dalay :LPM_REG_PROG_PIPE
    generic map (
      LPM_DATA_WIDTH	=> DATA_WIDTH,
      LPM_DELAY_POS	=> LPM_DELAY_POS,
      LPM_DELAY_STEP    => 1,
      IN_REGISTERED	=> INPUT_DELAY_REGISTERED,
      OUT_REGISTERED	=> OUTPUT_DELAY_REGISTERED
    )
    port map (
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> H,
      delay		=> data_delay,
      data_in		=> DataReg,
      data_out		=> DataDel
    );
  --
  process (clock, resetN, check_data) begin
    if (CHECK_REGISTERED=TRUE and resetN='0') then
      CheckDataReg <= (others=>'0');
    elsif (CHECK_REGISTERED=FALSE or (clock'event and clock='1')) then
      CheckDataReg <= check_data;
    end if;
  end process;
  --
  process (CheckDataReg, DataDel, part_ena, check_ena, check_data_ena, test_ena, test_data_rnd_ena, test_part_rnd_ena)
    variable DataMoveVar  :TSLV(DATA_WIDTH-1 downto 0);
    variable DataCheckVar :TSLV(DATA_WIDTH-1 downto 0);
    constant LPos         :TVI := DATA_WIDTH-1;
    constant RPos         :TVI := DATA_WIDTH-LPM_CHECK_WIDTH;
    variable DataPartVar  :TSLV(CHECK_PART_WIDTH-1 downto 0);
  begin
    DataMoveVar := DataDel;
    if (part_ena='1' and test_ena='0') then
      if (LPM_CHECK_WIDTH = 0) then
        for y in 0 to LPM_PART_WIDTH-1 loop
          for x in 0 to LPM_PART_NUM-1 loop
               DataMoveVar(A2DIndex(LPM_PART_WIDTH,LPM_PART_NUM,y,x)) -->
            := DataDel(A2DIndex(LPM_PART_NUM,LPM_PART_WIDTH,x,y));
          end loop;
        end loop;
      else
        for rep in 0 to CHECK_PART_REP-1 loop
          DataPartVar  := SLVPartGet(DataDel,CHECK_PART_WIDTH,rep);
          DataCheckVar := SLVPartPut(DataCheckVar,rep,DataPartVar(CHECK_PART_WIDTH-1 downto CHECK_PART_WIDTH-CHECK_PART_SIZE));
          DataMoveVar  := SLVPartPut(DataMoveVar,rep,DataPartVar(CHECK_PART_WIDTH-CHECK_PART_SIZE-1 downto 0));
        end loop;
        DataCheckVar(LPM_CHECK_WIDTH-1 downto LPM_CHECK_WIDTH-CHECK_LPART_SIZE) := DataDel(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE);
        DataMoveVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)
        := DataDel(DATA_WIDTH-CHECK_LPART_SIZE-1 downto DATA_WIDTH-CHECK_LPART_WIDTH);
        DataMoveVar := DataCheckVar(LPM_CHECK_WIDTH-1 downto 0) & DataMoveVar(DATA_CHECK_WIDTH-1 downto 0);
      end if;
    end if;
    --
    DataCheckVar := DataMoveVar;
    if (LPM_CHECK_WIDTH>0 and check_ena='1') then
      for index in 0 to CHECK_PART_REP-1 loop
        DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
        xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
      end loop;
      DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
      xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH+CHECK_LPART_SIZE)));
    end if;
    --
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
        DataCheckVar := (DataCheckVar(DATA_WIDTH-1 downto DATA_CHECK_WIDTH) xor CheckDataReg) & DataCheckVar(DATA_CHECK_WIDTH-1 downto 0);
      end if;
      DataOutSig   <= DataCheckVar;
      DataTestSig  <= DataCheckVar;
    else
      DataOutSig   <= (others => '0');
      if (test_data_rnd_ena='0' and test_part_rnd_ena='0') then
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          DataCheckVar := DataCheckVar xor TSLVnew(DataCheckVar'length,CheckDataReg);
          if (check_data'length>1) then
            DataCheckVar := DataCheckVar xor TSLVrot(TSLVnew(DataCheckVar'length,CheckDataReg),CheckDataReg'length/2);
          end if;
        end if;
        DataTestSig  <= DataCheckVar;
      else
        if (LPM_CHECK_WIDTH>0 and check_data_ena='1') then
          for index in 0 to LPM_PART_NUM-1 loop
            DataCheckVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index)
            := DataCheckVar(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index) xor TSLVresize(CheckDataReg,LPM_PART_WIDTH,'0');
          end loop;
        end if;
        DataTestSig  <= DataCheckVar;
      end if;
    end if;
    DataCheckSig <= DataCheckVar;
  end process;
  --
  process (clock, resetN)
  begin
    if (resetN='0') then
      DataCheckReg <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataCheckReg <= DataCheckSig;
    end if;
  end process;
  --
  data_rnd_gen :LPM_RAND_GEN_TRANS_V2
    generic map (
      LPM_GEN_WIDTH	=> 8,
      LPM_RND_INIT	=> 0,
      LPM_DATA_WIDTH	=> DATA_WIDTH,
      LPM_STROBE_ENA	=> FALSE
    )
    port map (
      resetN		=> resetN,
      clock		=> clock,
      gen_ena		=> L,
      gen_strobe	=> open,
      gen_init		=> open,
      gen_out		=> open,
      gen_in		=> DataTestSig,
      valid		=> RndDataValSig,
      valid_ena		=> RndDataValEnaSig
    );
  --
  rnd_loop:
  for index in 0 to LPM_PART_NUM-1 generate
    part_rnd_gen :LPM_RAND_GEN_TRANS_V2
      generic map (
        LPM_GEN_WIDTH	=> 8,
        LPM_RND_INIT	=> 0,
        LPM_DATA_WIDTH	=> LPM_PART_WIDTH,
        LPM_STROBE_ENA	=> FALSE
      )
      port map (
        resetN		=> resetN,
        clock		=> clock,
        gen_ena		=> L,
        gen_strobe	=> open,
        gen_init	=> open,
        gen_out		=> open,
        gen_in		=> DataTestSig(LPM_PART_WIDTH*(index+1)-1 downto LPM_PART_WIDTH*index),
        valid		=> RndPartValSig(index),
        valid_ena	=> RndPartValEnaSig(index)
      );
  end generate;
  --
  process (DataTestSig, RndDataValSig, RndDataValEnaSig, RndPartValSig, RndPartValEnaSig, part_ena, check_ena, check_data_ena, test_ena, test_data_rnd_ena, test_part_rnd_ena)
  begin
    if (test_ena='0') then
      if (LPM_CHECK_WIDTH>0 and (check_ena='1' or check_data_ena='1')) then
        if (part_ena='0') then
          DataTestORdataSigN <= TSLVnew(LPM_PART_NUM,not(OR_REDUCE(DataTestSig(DATA_WIDTH-1 downto DATA_CHECK_WIDTH))));
	else
          for rep in 0 to CHECK_PART_REP-1 loop
	    DataTestORdataSigN(CHECK_PART_NUM*(rep+1)-1 downto CHECK_PART_NUM*rep)
	    <= TSLVnew(CHECK_PART_NUM,not(OR_REDUCE(DataTestSig(CHECK_PART_SIZE*(rep+1)+DATA_CHECK_WIDTH-1 downto CHECK_PART_SIZE*rep+DATA_CHECK_WIDTH))));
	  end loop;
	  DataTestORdataSigN(LPM_PART_NUM-1 downto LPM_PART_NUM-CHECK_LPART_NUM)
	  <= TSLVnew(CHECK_LPART_NUM,not(OR_REDUCE(DataTestSig(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE))));
        end if;
      else
        DataTestORdataSigN <= (others => '1');
      end if;
    else
      if (test_data_rnd_ena='0' and test_part_rnd_ena='0') then
        for index in 0 to LPM_PART_NUM-1 loop
          DataTestORdataSigN(index) <= not(OR_REDUCE(SLVPartGet(DataTestSig,LPM_PART_WIDTH,index)));
        end loop;
      elsif (test_data_rnd_ena='1') then
        DataTestORdataSigN <= (others => RndDataValSig or not(RndDataValEnaSig));
        DataSyncORdataSigN <= (others => '1');
      else
        DataTestORdataSigN <= RndPartValSig or not(RndPartValEnaSig);
        DataSyncORdataSigN(0) <= RndPartValSig(0) or not(RndPartValEnaSig(0));
        for index in 1 to LPM_PART_NUM-1 loop
          DataSyncORdataSigN(index) <= (RndPartValSig(index) and RndPartValSig(index-1) and RndPartValEnaSig(index-1)) or not(RndPartValEnaSig(index));
        end loop;
      end if;
    end if;
  end process;
  --
  process (resetN, clock)
  begin
    if (resetN='0') then
      DataTestORdataRegN <= (others=>'0');
      DataSyncORdataRegN <= (others=>'0');
    elsif (clock'event and clock='1') then
      DataTestORdataRegN <= DataTestORdataSigN;
      DataSyncORdataRegN <= DataSyncORdataSigN;
    end if;
  end process;
  --
  DataTestORreadSigN <= not(test_or_read);
  test_or_reg :KTP_LPM_DFF
    generic map(
      LPM_WIDTH => LPM_PART_NUM
    )
    port map(
      resetN    => ResVec,
      setN      => DataTestORdataRegN,
      clk       => DataTestORreadSigN,
      ena       => DataORothers1,
      d         => DataORothers0,
      q		=> test_or_data
  );
  --
  DataSyncORreadSigN <= not(sync_or_read);
  sync_or_reg :KTP_LPM_DFF
    generic map(
      LPM_WIDTH => LPM_PART_NUM
    )
    port map(
      resetN    => ResVec,
      setN      => DataSyncORdataRegN,
      clk       => DataSyncORreadSigN,
      ena       => DataORothers1,
      d         => DataORothers0,
      q		=> sync_or_data
  );
  --
  DataValidSig <= AND_REDUCE(DataTestORdataSigN);
  process (clock, resetN, DataOutSig, DataTestSig, DataValidSig, test_ena, check_ena, check_data_ena)
    variable clkv :TL;
  begin
    if (OUTPUT_REGISTERED=FALSE) then clkv := TRUE; else clkv := (clock'event and clock='1'); end if;
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataOutReg   <= (others=>'0');
      DataValidReg <= '0';
      DataTestReg  <= (others=>'0');
    elsif (clkv) then
      if (DataValidSig='1' and test_ena='0') then
        DataOutReg <= DataOutSig;
      else
        DataOutReg <= (others =>'0');
      end if;
      DataValidReg <= DataValidSig or (test_ena and not(check_ena) and not(check_data_ena));
      DataTestReg  <= DataTestSig;
    end if;
  end process;
  --
  out_data   <= DataOutReg(DATA_CHECK_WIDTH-1 downto 0);
  data_valid <= DataValidReg;
  test_data  <= DataTestReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_MUX_DATA_RECEIVER_V1 is
  generic (
    LPM_MUX_WIDTH		:TN := 4;
    LPM_MUX_MULTIPL		:TN := 8;
    LPM_CLOCK_MULTIPL		:TN := 1;
    LPM_PART_NUM		:TN := 4;
    LPM_DELAY_WIDTH		:TN := 0;
    LPM_CHECK_WIDTH		:TN := 4;
    MUX_SYMMETRIZATION_ENA	:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    DEMUX_CLOCK_PIPE_ENA	:TL := FALSE;
    DEMUX_STROBE_ENABLE		:TL := TRUE;
    DEMUX_STROBE_REGISTERED	:TL := TRUE;
    DEMUX_OUTPUT_REGISTERED	:TL := TRUE;
    INPUT_PART_REGISTERED	:TL := TRUE;
    CHECK_PART_REGISTERED	:TL := TRUE;
    INPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_DELAY_REGISTERED	:TL := TRUE;
    OUTPUT_PART_REGISTERED	:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clock_inv			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL;
    strobe			:in  TSL;
    mux_data_clk_inv		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_clk90		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_reg_add		:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    mux_data_delay		:in  TSLV(TVLcreate(LPM_MUX_MULTIPL*LPM_CLOCK_MULTIPL-1)-1 downto 0);
    data_delay			:in  TSLV(maximum(LPM_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
    part_ena			:in  TSL;
    check_ena			:in  TSL;
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL;
    mux_data			:in  TSLV(LPM_MUX_WIDTH-1 downto 0);
    data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
    test_ena			:in  TSL;
    test_rand_ena		:in  TSL;
    test_data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    data_valid			:out TSL;
    test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0);
    test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
  );
end LPM_MUX_DATA_RECEIVER_V1;

architecture behaviour of LPM_MUX_DATA_RECEIVER_V1 is

  constant PART_WIDTH :TP := SLVPartNum(LPM_MUX_MULTIPL*LPM_MUX_WIDTH,LPM_PART_NUM);
  constant DATA_WIDTH :TP := LPM_MUX_MULTIPL*LPM_MUX_WIDTH;
  signal   L              :TSL;
  signal   DataDemuxSig   :TSLV(DATA_WIDTH-1 downto 0);

begin
  L <= '0';
  --
  demux :LPM_DATA_DEMUX_V1
    generic map (
      LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
      LPM_MUX_MULTIPL		=> LPM_MUX_MULTIPL,
      LPM_CLOCK_MULTIPL		=> LPM_CLOCK_MULTIPL,
      SYMMETRIZATION_ENA	=> MUX_SYMMETRIZATION_ENA,
      MUX_PART_MODE_ENA		=> MUX_PART_MODE_ENA,
      MUX_DECREASE_ENA		=> MUX_DECREASE_ENA,
      CLOCK_PIPE_ENA		=> DEMUX_CLOCK_PIPE_ENA,
      STROBE_ENABLE		=> DEMUX_STROBE_ENABLE,
      STROBE_REGISTERED		=> DEMUX_STROBE_REGISTERED,
      OUTPUT_REGISTERED		=> DEMUX_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      mux_clock			=> mux_clock,
      mux_clock90		=> mux_clock90,
      clock			=> clock,
      strobe			=> strobe,
      mux_data_clk_inv		=> mux_data_clk_inv,
      mux_data_clk90		=> mux_data_clk90,
      mux_data_reg_add		=> mux_data_reg_add,
      mux_data_delay		=> mux_data_delay,
      mux_data			=> mux_data,
      clock_inv			=> L,
      data			=> DataDemuxSig
  );
  --
  receiver :LPM_PART_DATA_RECEIVER_V1
    generic map (
      LPM_PART_WIDTH		=> PART_WIDTH,
      LPM_PART_NUM		=> LPM_PART_NUM,
      LPM_CHECK_WIDTH		=> LPM_CHECK_WIDTH,
      LPM_DELAY_WIDTH		=> LPM_DELAY_WIDTH,
      INPUT_REGISTERED		=> INPUT_PART_REGISTERED,
      CHECK_REGISTERED		=> CHECK_PART_REGISTERED,
      INPUT_DELAY_REGISTERED	=> INPUT_DELAY_REGISTERED,
      OUTPUT_DELAY_REGISTERED	=> OUTPUT_DELAY_REGISTERED,
      OUTPUT_REGISTERED		=> OUTPUT_PART_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      clock_inv			=> L,
      data_delay		=> data_delay,
      part_ena			=> part_ena,
      check_ena			=> check_ena,
      check_data		=> check_data,
      in_data			=> DataDemuxSig,
      out_data			=> data,
      check_data_ena		=> check_data_ena,
      test_ena			=> test_ena,
      test_rand_ena		=> test_rand_ena,
      test_data			=> test_data,
      data_valid		=> data_valid,
      test_or_read		=> test_or_read,
      test_or_data		=> test_or_data
    );

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_MUX_DATA_RECEIVER_V2 is
  generic (
    LPM_MUX_WIDTH		:TN := 0;
    LPM_MUX_MULTIPL		:TN := 0;
    LPM_EXT_PHASE_ENA		:TL := FALSE;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := FALSE;
    LPM_MCLK180_ADD		:TL := TRUE;
    LPM_MCLK270_ADD		:TL := TRUE;
    LPM_OVERCLOCK_MULTIPL	:TI := 0;
    LPM_LAT_DELAY_POS		:TN := 0;
    LPM_PART_NUM		:TN := 0;
    LPM_DELAY_POS		:TN := 0;
    LPM_CHECK_WIDTH		:TN := 0;
    MUX_SYMMETRIZATION_ENA	:TL := FALSE;
    MUX_PART_MODE_ENA		:TL := FALSE;
    MUX_DECREASE_ENA		:TL := FALSE;
    DEMUX_STROBE_ENABLE	:TL 	:= FALSE;
    DEMUX_STROBE_REGISTERED	:TL := FALSE;
    DEMUX_PROCESS_REGISTERED	:TL := TRUE;
    DEMUX_OUTPUT_REGISTERED	:TL := FALSE;
    PART_INPUT_REGISTERED	:TL := FALSE;
    PART_CHECK_REGISTERED	:TL := FALSE;
    PART_IN_DELAY_REGISTERED	:TL := FALSE;
    PART_OUT_DELAY_REGISTERED	:TL := FALSE;
    PART_OUTPUT_REGISTERED	:TL := FALSE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    mux_clock			:in  TSL;
    mux_clock90			:in  TSL := '0';
    mux_clock180		:in  TSL := '0';
    mux_clock270		:in  TSL := '0';
    strobe			:in  TSL := '0';
    mux_clk_inv			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others =>'0');
    mux_clk90			:in  TSLV(LPM_MUX_WIDTH-1 downto 0) := (others =>'0');
    mux_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_MUX_MULTIPL*LPM_OVERCLOCK_MULTIPL-1)-1 downto 0);
    lat_delay			:in  TSLV(LPM_MUX_WIDTH*TVLcreate(LPM_LAT_DELAY_POS)-1 downto 0);
    data_delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others =>'0');
    part_ena			:in  TSL := '0';
    check_ena			:in  TSL := '0';
    check_data			:in  TSLV(maximum(LPM_CHECK_WIDTH-1,0) downto 0) := (others => '0');
    check_data_ena		:in  TSL := '0';
    mux_data			:in  TSLV((3*TNconv(LPM_EXT_PHASE_ENA)+1)*LPM_MUX_WIDTH-1 downto 0);
    data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-LPM_CHECK_WIDTH-1 downto 0);
    test_ena			:in  TSL := '0';
    test_data_rnd_ena		:in  TSL := '0';
    test_part_rnd_ena		:in  TSL := '0';
    test_data			:out TSLV(LPM_MUX_MULTIPL*LPM_MUX_WIDTH-1 downto 0);
    data_valid			:out TSL;
    test_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
    test_or_data		:out TSLV(LPM_PART_NUM-1 downto 0);
    sync_or_read		:in  TSLV(LPM_PART_NUM-1 downto 0) := (others =>'0');
    sync_or_data		:out TSLV(LPM_PART_NUM-1 downto 0)
  );
end LPM_MUX_DATA_RECEIVER_V2;

architecture behaviour of LPM_MUX_DATA_RECEIVER_V2 is

  constant PART_WIDTH :TP := SLVPartNum(LPM_MUX_MULTIPL*LPM_MUX_WIDTH,LPM_PART_NUM);
  constant DATA_WIDTH :TP := LPM_MUX_MULTIPL*LPM_MUX_WIDTH;
  signal   L              :TSL;
  signal   DataDemuxSig   :TSLV(DATA_WIDTH-1 downto 0);

begin
  L <= '0';
  --
  demux :LPM_DATA_DEMUX_V2
    generic map (
      LPM_MUX_WIDTH		=> LPM_MUX_WIDTH,
      LPM_MUX_MULTIPL		=> LPM_MUX_MULTIPL,
      LPM_EXT_PHASE_ENA		=> LPM_EXT_PHASE_ENA,
      LPM_PHASE_POS		=> LPM_PHASE_POS,
      LPM_QPHASE_ENA		=> LPM_QPHASE_ENA,
      LPM_MCLK180_ADD		=> LPM_MCLK180_ADD,
      LPM_MCLK270_ADD		=> LPM_MCLK270_ADD,
      LPM_OVERCLOCK_MULTIPL	=> LPM_OVERCLOCK_MULTIPL,
      LPM_LAT_DELAY_POS         => LPM_LAT_DELAY_POS,
      SYMMETRIZATION_ENA	=> MUX_SYMMETRIZATION_ENA,
      MUX_PART_MODE_ENA		=> MUX_PART_MODE_ENA,
      MUX_DECREASE_ENA		=> MUX_DECREASE_ENA,
      STROBE_ENABLE		=> DEMUX_STROBE_ENABLE,
      STROBE_REGISTERED		=> DEMUX_STROBE_REGISTERED,
      PROCESS_REGISTERED	=> DEMUX_PROCESS_REGISTERED,
      OUTPUT_REGISTERED		=> DEMUX_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      mux_clock			=> mux_clock,
      mux_clock90		=> mux_clock90,
      mux_clock180		=> mux_clock180,
      mux_clock270		=> mux_clock270,
      clock			=> clock,
      strobe			=> strobe,
      mux_clk_inv		=> mux_clk_inv,
      mux_clk90			=> mux_clk90,
      mux_delay			=> mux_delay,
      lat_delay			=> lat_delay,
      mux_data			=> mux_data,
      data			=> DataDemuxSig
  );
  --
  receiver :LPM_PART_DATA_RECEIVER_V2
    generic map (
      LPM_PART_WIDTH		=> PART_WIDTH,
      LPM_PART_NUM		=> LPM_PART_NUM,
      LPM_CHECK_WIDTH		=> LPM_CHECK_WIDTH,
      LPM_DELAY_POS		=> LPM_DELAY_POS,
      INPUT_REGISTERED		=> PART_INPUT_REGISTERED,
      CHECK_REGISTERED		=> PART_CHECK_REGISTERED,
      INPUT_DELAY_REGISTERED	=> PART_IN_DELAY_REGISTERED,
      OUTPUT_DELAY_REGISTERED	=> PART_OUT_DELAY_REGISTERED,
      OUTPUT_REGISTERED		=> PART_OUTPUT_REGISTERED
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      clock_inv			=> L,
      data_delay		=> data_delay,
      part_ena			=> part_ena,
      check_ena			=> check_ena,
      check_data		=> check_data,
      in_data			=> DataDemuxSig,
      out_data			=> data,
      check_data_ena		=> check_data_ena,
      test_ena			=> test_ena,
      test_data_rnd_ena		=> test_data_rnd_ena,
      test_part_rnd_ena		=> test_part_rnd_ena,
      test_data			=> test_data,
      data_valid		=> data_valid,
      test_or_read		=> test_or_read,
      test_or_data		=> test_or_data,
      sync_or_read		=> sync_or_read,
      sync_or_data		=> sync_or_data
    );

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_DATA_MUXERx is
  generic (
    LPM_DATA_WIDTH		:TN := 4;
    LPM_DATA_NUM		:TN := 16;
    INPUT_REGISTERED		:TL := TRUE;
    INPUT_BUFFERED		:TL := TRUE;
    OUTPUT_REGISTERED		:TL := TRUE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    data_in			:in  TSLV(LPM_DATA_WIDTH*LPM_DATA_NUM-1 downto 0);
    data_in_valid		:in  TSLV(LPM_DATA_NUM-1 downto 0);
    data_in_busy		:out TSLV(LPM_DATA_NUM-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out_num		:out TSLV(TVLcreate(LPM_DATA_NUM-1)-1 downto 0);
    data_out_valid		:out TSL;
    data_out_busy		:in  TSL
  );
end LPM_DATA_MUXERx;

architecture behaviour of LPM_DATA_MUXERx is

  constant NUM_SIZE             :TN := data_out_num'length;
  constant MUX_LEVEL            :TN := NUM_SIZE;
  constant MUX_CHAN             :TN := 2**MUX_LEVEL;
  --
  type     TDataIn              is array(0 to LPM_DATA_NUM-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataInReg            :TDataIn;
  signal   DataInValReg         :TSLV(LPM_DATA_NUM-1 downto 0);
  signal   DataInBusyReg        :TSLV(LPM_DATA_NUM-1 downto 0);
  signal   DataOutReg           :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataOutNumReg        :TSLV(MUX_LEVEL-1 downto 0);
  signal   DataOutValReg        :TSL;
  signal   DataOutBusyReg       :TSL;
  type     TFlagMux             is array(0 to MUX_LEVEL) of TSLV(MUX_CHAN-1 downto 0);
  signal   ValMux               :TFlagMux;
  type     TDataLevel           is array(0 to MUX_CHAN-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  type     TDataMux             is array(0 to MUX_LEVEL) of TDataLevel;
  signal   DataMux              :TDataMux;
  type     TNumLevel            is array(0 to MUX_CHAN-1) of TSLV(NUM_SIZE-1 downto 0);
  type     TNumMux              is array(0 to MUX_LEVEL) of TNumLevel;
  signal   NumMux               :TNumMux;

begin

  process (clock, resetN, data_in, data_in_valid) begin
    if (INPUT_REGISTERED=TRUE and resetN='0') then
      DataInReg    <= (DataInReg'range => (others=>'0'));
      DataInValReg <= (others=>'0');
    elsif (INPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      for index in 0 to LPM_DATA_NUM-1 loop
        DataInReg(index) <= SLVpartGet(data_in,LPM_DATA_WIDTH,index);
      end loop;
      DataInValReg <= data_in_valid;
    end if;
  end process;

  process (clock, resetN, data_out_busy) begin
    if (OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataOutBusyReg <= '0';
    elsif (OUTPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      DataOutBusyReg <= data_out_busy;
    end if;
  end process;

  process (clock, resetN)
    variable DataMuxVar :TDataMux;
    variable NumMuxVar  :TNumMux;
    variable ValMuxVar  :TFlagMux;
  begin
    if (resetN='0') then
      DataMux       <= (DataMux'range => (DataMux(0)'range => (others=>'0')));
      NumMux        <= (NumMux'range => (NumMux(0)'range => (others=>'0')));
      ValMux        <= (ValMux'range => (others=>'0'));
      DataInBusyReg <= (others=>'0');
      DataOutReg    <= (others=>'0');
      DataOutNumReg <= (others=>'0');
      DataOutValReg <= '0';
    elsif (clock'event and clock='1') then
      DataMuxVar    := DataMux;
      NumMuxVar     := NumMux;
      ValMuxVar     := ValMux;
      DataMuxVar(0) := (DataMuxVar(0)'range => (others=>'0'));
      NumMuxVar(0)  := (NumMuxVar(0)'range => (others => '0'));
      for index in 0 to LPM_DATA_NUM-1 loop
        DataMuxVar(0)(index) := DataInReg(index);
        if (INPUT_BUFFERED=FALSE or DataInValReg(index)='1') then
          ValMuxVar(0)(index)  := DataInValReg(index);
        end if;
      end loop;
      if (ValMuxVar(MUX_LEVEL)(0)='1' and DataOutBusyReg='0') then
        ValMuxVar(MUX_LEVEL)(0) := '0';
      end if;
      for index in MUX_LEVEL-1 downto 0 loop
        for pos in 0 to 2**(MUX_LEVEL-1-index)-1 loop
          if (ValMuxVar(index+1)(pos)='0') then
            if (ValMuxVar(index)(2*pos)='1') then
              DataMuxVar(index+1)(pos) := DataMuxVar(index)(2*pos);
              NumMuxVar(index+1)(pos)  := NumMuxVar(index)(2*pos);
              NumMuxVar(index+1)(pos)(index) := '0';
              ValMuxVar(index+1)(pos)    := '1';
              ValMuxVar(index)(2*pos)    := '0';
            elsif (ValMuxVar(index)(2*pos+1)='1') then
              DataMuxVar(index+1)(pos) := DataMuxVar(index)(2*pos+1);
              NumMuxVar(index+1)(pos)  := NumMuxVar(index)(2*pos+1);
              NumMuxVar(index+1)(pos)(index) := '1';
              ValMuxVar(index+1)(pos)    := '1';
              ValMuxVar(index)(2*pos+1)  := '0';
            end if;
          end if;  
        end loop;
      end loop;
      DataMux       <= DataMuxVar;             
      NumMux        <= NumMuxVar;
      ValMux        <= ValMuxVar;
      DataInBusyReg <= ValMuxVar(0)(LPM_DATA_NUM-1 downto 0);
      DataOutReg    <= DataMuxVar(MUX_LEVEL)(0);
      DataOutNumReg <= NumMuxVar(MUX_LEVEL)(0);
      DataOutValReg <= ValMuxVar(MUX_LEVEL)(0);
    end if;
  end process;
  
  data_in_busy   <= DataInBusyReg;
  data_out       <= DataOutReg;
  data_out_num   <= DataOutNumReg;
  data_out_valid <= DataOutValReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;
use work.LPMSynchro.all;

entity LPM_DATA_MUXER is
  generic (
    LPM_DATA_WIDTH		:TN := 4;
    LPM_DATA_NUM		:TN := 16
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    data_in			:in  TSLV(LPM_DATA_WIDTH*LPM_DATA_NUM-1 downto 0);
    data_in_valid		:in  TSLV(LPM_DATA_NUM-1 downto 0);
    data_in_next		:out TSLV(LPM_DATA_NUM-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out_num		:out TSLV(TVLcreate(LPM_DATA_NUM-1)-1 downto 0);
    data_out_valid		:out TSL;
    data_out_next		:in  TSL
  );
end LPM_DATA_MUXER;

architecture behaviour of LPM_DATA_MUXER is

  constant NUM_SIZE             :TN := data_out_num'length;
  constant MUX_LEVEL            :TN := NUM_SIZE;
  constant MUX_CHAN             :TN := 2**MUX_LEVEL;
  --
  type     TDataIn              is array(0 to LPM_DATA_NUM-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataInReg            :TDataIn;
  signal   DataInValSig         :TSLV(LPM_DATA_NUM-1 downto 0);
  signal   DataInNextReg        :TSLV(LPM_DATA_NUM-1 downto 0);
  signal   DataOutReg           :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataOutNumReg        :TSLV(MUX_LEVEL-1 downto 0);
  signal   DataOutValReg        :TSL;
  signal   DataOutBusyReg       :TSL;
  type     TFlagMux             is array(0 to MUX_LEVEL) of TSLV(MUX_CHAN-1 downto 0);
  signal   ValMux               :TFlagMux;
  signal   MoveMux              :TFlagMux;
  type     TDataLevel           is array(0 to MUX_CHAN-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  type     TDataMux             is array(0 to MUX_LEVEL) of TDataLevel;
  signal   DataMux              :TDataMux;
  type     TNumLevel            is array(0 to MUX_CHAN-1) of TSLV(NUM_SIZE-1 downto 0);
  type     TNumMux              is array(0 to MUX_LEVEL) of TNumLevel;
  signal   NumMux               :TNumMux;

begin

  process (clock, resetN) begin
    if (resetN='0') then
      DataInReg <= (DataInReg'range => (others=>'0'));
    elsif (clock'event and clock='1') then
      for index in 0 to LPM_DATA_NUM-1 loop
        DataInReg(index) <= SLVpartGet(data_in,LPM_DATA_WIDTH,index);
      end loop;
    end if;
  end process;
  DataInValSig <= data_in_valid;

  process (clock, resetN)
    variable ValMuxVar  :TFlagMux;
    variable MoveMuxVar :TFlagMux;
  begin
    if (resetN='0') then
      ValMux        <= (ValMux'range => (others=>'0'));
      MoveMux       <= (ValMux'range => (others=>'0'));
      DataInNextReg <= (others => '0');
    elsif (clock'event and clock='1') then
      ValMuxVar     := ValMux;
      MoveMuxVar    := (ValMux'range => (others=>'0'));
      if (ValMuxVar(MUX_LEVEL)(0)='1' and data_out_next='1') then
        ValMuxVar(MUX_LEVEL)(0) := '0';
      end if;
      for index in MUX_LEVEL-1 downto 0 loop
        for pos in 0 to 2**(MUX_LEVEL-1-index)-1 loop
          if (ValMuxVar(index+1)(pos)='0') then
            if (ValMuxVar(index)(2*pos)='1') then
              ValMuxVar(index+1)(pos)  := '1';
              ValMuxVar(index)(2*pos)  := '0';
              MoveMuxVar(index)(2*pos) := '1';
            elsif (ValMuxVar(index)(2*pos+1)='1') then
              ValMuxVar(index+1)(pos)    := '1';
              ValMuxVar(index)(2*pos+1)  := '0';
              MoveMuxVar(index)(2*pos+1) := '1';
            end if;
          end if;  
        end loop;
      end loop;
      DataInNextReg <= (others => '0');
      for index in 0 to LPM_DATA_NUM-1 loop
        if (ValMuxVar(0)(index)='0') then
          DataInNextReg(index) <= '1';
          ValMuxVar(0)(index)  := DataInValSig(index);
        end if;
      end loop;
      ValMux        <= ValMuxVar;
      MoveMux       <= MoveMuxVar; 
    end if;
  end process;
  
  process (clock, resetN)
    variable DataMuxVar :TDataMux;
    variable NumMuxVar  :TNumMux;
  begin
    if (resetN='0') then
      DataMux       <= (DataMux'range => (DataMux(0)'range => (others=>'0')));
      NumMux        <= (NumMux'range => (NumMux(0)'range => (others=>'0')));
      DataOutReg    <= (others=>'0');
      DataOutNumReg <= (others=>'0');
      DataOutValReg <= '0';
    elsif (clock'event and clock='1') then
      DataMuxVar    := DataMux;
      NumMuxVar     := NumMux;
      NumMuxVar(0)  := (NumMuxVar(0)'range => (others => '0'));
      for index in MUX_LEVEL-1 downto 0 loop
        for pos in 0 to 2**(MUX_LEVEL-1-index)-1 loop
          if (MoveMux(index)(2*pos)='1') then
            DataMuxVar(index+1)(pos) := DataMuxVar(index)(2*pos);
            NumMuxVar(index+1)(pos)  := NumMuxVar(index)(2*pos);
            NumMuxVar(index+1)(pos)(index) := '0';
          elsif (MoveMux(index)(2*pos+1)='1') then
            DataMuxVar(index+1)(pos) := DataMuxVar(index)(2*pos+1);
            NumMuxVar(index+1)(pos)  := NumMuxVar(index)(2*pos+1);
            NumMuxVar(index+1)(pos)(index) := '1';
          end if;
        end loop;  
      end loop;
      for index in 0 to LPM_DATA_NUM-1 loop
        if (DataInNextReg(index)='1') then
          DataMuxVar(0)(index) := DataInReg(index);
        end if;
      end loop;
      DataMux       <= DataMuxVar;             
      NumMux        <= NumMuxVar;
      DataOutReg    <= DataMuxVar(MUX_LEVEL)(0);
      DataOutNumReg <= NumMuxVar(MUX_LEVEL)(0);
      DataOutValReg <= ValMux(MUX_LEVEL)(0);
    end if;
  end process;
  
  data_in_next   <= DataInNextReg;
  data_out       <= DataOutReg;
  data_out_num   <= DataOutNumReg;
  data_out_valid <= DataOutValReg;

end behaviour;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

entity LPM_DATA_TRANSPHASE_SIMM is
  generic (
    LPM_MUX_WIDTH		:TN := 0;
    LPM_PHASE_POS		:TL := TRUE;
    LPM_QPHASE_ENA		:TL := FALSE;
    LPM_CLK180_ADD		:TL := TRUE;
    LPM_CLK270_ADD		:TL := TRUE
  );
  port(
    resetN			:in    TSL;
    clk0			:in    TSL;
    clk90			:in    TSL;
    clk180			:in    TSL;
    clk270			:in    TSL;
    din				:in    TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
    dout			:out   TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
    mtriN			:inout TSLV(LPM_MUX_WIDTH-1 downto 0);
    mtriP			:inout TSLV(LPM_MUX_WIDTH-1 downto 0);
    mtrie			:in    TSL
  );
end LPM_DATA_TRANSPHASE_SIMM;

architecture behaviour of LPM_DATA_TRANSPHASE_SIMM is

  signal clk180sig              :TSL;
  signal clk90sig               :TSL;
  signal clk270sig              :TSL;
  signal dtx0reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx90reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx180reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx270reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx0regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx90regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx180regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx270regB		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx0regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx90regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx180regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal dtx270regP		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdtxsig		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal mdrxsig		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx0reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx90reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx180reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx270reg		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx180regB0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx90regB270		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx270regB0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx0reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx90reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx180reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);
  signal drx270reg0		:TSLV(LPM_MUX_WIDTH-1 downto 0);


begin
  --                       
  clk180sig <= not(clk0)       when LPM_CLK180_ADD=TRUE else clk180;
  clk90sig  <= clk90           when LPM_PHASE_POS=TRUE   else not(clk90);
  clk270sig <= not(clk90sig)   when LPM_CLK270_ADD=TRUE else clk270 when LPM_PHASE_POS=TRUE else not(clk270);
  --
  qphaseT:
  if (LPM_QPHASE_ENA=TRUE) generate
    --
    process (clk0, resetN) begin
      if (resetN='0') then
        dtx270reg <= (others=>'0');
        dtx180reg <= (others=>'0');
        dtx90reg  <= (others=>'0');
        dtx0reg   <= (others=>'0');
        dtx90regB <= (others=>'0');
        dtx0regB  <= (others=>'0');
      elsif (clk0'event and clk0='1') then
        dtx270reg <= TSLVgetX(din,0);
        dtx180reg <= TSLVgetX(din,1);
        dtx90reg  <= TSLVgetX(din,2);
        dtx0reg   <= TSLVgetX(din,3);
        dtx90regB <= dtx90reg xor dtx180reg xor dtx270reg;
        dtx0regB  <= dtx0reg xor dtx90reg xor dtx180reg xor dtx270reg;
      end if;
    end process;
    --
    process (clk180sig, resetN) begin
      if (resetN='0') then
        dtx270regB <= (others=>'0');
        dtx180regB <= (others=>'0');
      elsif (clk180sig'event and clk180sig='1') then
        dtx270regB <= dtx270reg;
        dtx180regB <= dtx180reg xor dtx270reg;
      end if;
    end process;
    --
    --
    process (clk270sig, resetN) begin
      if (resetN='0') then
        dtx270regP <= (others=>'0');
      elsif (clk270sig'event and clk270sig='1') then
        dtx270regp <= dtx270regB;
      end if;
    end process;
    --
    process (clk180sig, resetN) begin
      if (resetN='0') then
        dtx180regP <= (others=>'0');
      elsif (clk180sig'event and clk180sig='1') then
        dtx180regP <= dtx180regB;
      end if;
    end process;
    --
    process (clk90sig, resetN) begin
      if (resetN='0') then
        dtx90regP <= (others=>'0');
      elsif (clk90sig'event and clk90sig='1') then
        dtx90regP <= dtx90regB;
      end if;
    end process;
    --
    process (clk0, resetN) begin
      if (resetN='0') then
        dtx0regP <= (others=>'0');
      elsif (clk0'event and clk0='1') then
        dtx0regP <= dtx0regB;
      end if;
    end process;
    --
    mdtxsig <= dtx0regP xor dtx90regP xor dtx180regP xor dtx270regP;
    --
    --
    process (clk270sig, resetN) begin
      if (resetN='0') then
        drx270reg    <= (others=>'0');
        drx90regB270 <= (others=>'0');
      elsif (clk270sig'event and clk270sig='1') then
        drx270reg    <= mdrxsig;
        drx90regB270 <= drx90reg;
      end if;
    end process;
    --
    process (clk180sig, resetN) begin
      if (resetN='0') then
        drx180reg <= (others=>'0');
      elsif (clk180sig'event and clk180sig='1') then
        drx180reg <= mdrxsig;
      end if;
    end process;
    --
    process (clk90sig, resetN) begin
      if (resetN='0') then
        drx90reg <= (others=>'0');
      elsif (clk90sig'event and clk90sig='1') then
        drx90reg <= mdrxsig;
      end if;
    end process;
    --
    process (clk0, resetN) begin
      if (resetN='0') then
        drx0reg     <= (others=>'0');
        drx0reg0    <= (others=>'0');
        drx90reg0   <= (others=>'0');
        drx180regB0 <= (others=>'0');
        drx180reg0  <= (others=>'0');
        drx270regB0 <= (others=>'0');
        drx270reg0  <= (others=>'0');
      elsif (clk0'event and clk0='1') then
        drx0reg     <= mdrxsig;
        drx0reg0    <= drx0reg;
        drx90reg0   <= drx90regB270;
        drx180regB0 <= drx180reg;
        drx180reg0  <= drx180regB0;
        drx270regB0 <= drx270reg;
        drx270reg0  <= drx270regB0;
      end if;
    end process;
    --
    --
    btri: UTLPM_BUSTRI_SIMM
      generic map (
        LPM_WIDTH => LPM_MUX_WIDTH
      )
      port map (
        i         => mdtxsig,
        o         => mdrxsig,
        p_p       => mtriP,
        p_n       => mtriN,
        o_e       => open,
        e         => mtrie
      );
    --
  end generate;
  --
  qphaseN:
  if (LPM_QPHASE_ENA=FALSE) generate
    --
    dtx180reg <= TSLVgetX(din,1);
    dtx0reg   <= TSLVgetX(din,3);
    --
    sbuf: UTLPM_BUSTRI_SER2_SIMM
      generic map (
        LPM_WIDTH        => LPM_MUX_WIDTH,
        CLK180_ADD       => LPM_CLK180_ADD
      )
      port map (
        rN               => resetN,
        c0               => clk0,
        c180             => clk180sig,
        i0               => dtx0reg,
        i180             => dtx180reg,
        o0               => drx0reg0,
        o180             => drx180reg0,
        p_p              => mtriP,
        p_n              => mtriN,
        e0               => open,
        e180             => open,
        e                => mtrie
      );
    --
    drx90reg0  <= drx0reg0;
    drx270reg0 <= drx180reg0;
    --
  end generate;
  --
  --
  process(drx0reg0, drx90reg0, drx180reg0, drx270reg0) is
    variable res: TSLA(0 to 3, LPM_MUX_WIDTH-1 downto 0);
  begin
    res := TSLAset(res,'0');
    res := TSLAputX(res,0,drx270reg0);
    res := TSLAputX(res,1,drx180reg0);
    res := TSLAputX(res,2,drx90reg0);
    res := TSLAputX(res,3,drx0reg0);
    dout <= res;
  end process;
  --
end behaviour;


