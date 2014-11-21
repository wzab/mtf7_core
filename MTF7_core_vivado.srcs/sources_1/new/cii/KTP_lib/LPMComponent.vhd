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

package LPMComponent is

  component DPM_PROG is
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_ADDR_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      ADDRESS_SEPARATE		:in boolean := FALSE;
      INIT_CLEAR_ENA		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
  end component;

  component LPM_REG_PROG_PIPE
    generic (
      constant LPM_DATA_WIDTH	:in natural := 0;
      constant LPM_DELAY_POS	:in natural := 0;
      constant LPM_DELAY_STEP	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others => '0');
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component LPM_REG_PROG_PIPE1
    generic (
      constant LPM_DELAY_POS	:in natural := 0;
      constant LPM_DELAY_STEP	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := (others => '0');
      data_in			:in  TSL;
      data_out			:out TSL
    );
  end component;

  component LPM_REG_PIPE
    generic (
      constant LPM_DATA_WIDTH	:in natural := 0;
      constant LPM_DELAY_POS	:in natural := 0;
      constant LPM_DELAY_STEP	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component LPM_REG_PIPE1
    generic (
      constant LPM_DATA_WIDTH	:in natural := 0;
      constant LPM_DELAY_POS	:in natural := 0;
      constant LPM_DELAY_STEP	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      data_in			:in  TSL;
      data_out			:out TSL
    );
  end component;

  component LPM_REG_PIPE_CUT is
    generic (
      constant LPM_DATA_WIDTH	:in natural := 0;
      constant LPM_PIPE_LEN	:in natural := 0;
      constant LPM_PIPE_STEP	:in natural := 0;
      constant LPM_CUT_POS	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      cut			:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0) := (others => '0');
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component LPM_REG_PIPE_CUT1 is
    generic (
      constant LPM_PIPE_LEN	:in natural := 0;
      constant LPM_PIPE_STEP	:in natural := 0;
      constant LPM_CUT_POS	:in natural := 0;
      constant IN_REGISTERED	:in boolean := FALSE;
      constant OUT_REGISTERED	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL := '1';
      cut			:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0) := (others => '0');
      data_in			:in  TSL;
      data_out			:out TSL
    );
  end component;

  component DPM_PIPE
    generic (
      constant LPM_DATA_WIDTH	:in natural := 0;
      constant LPM_DELAY_WIDTH	:in natural := 0

    );
    port(
      resetN			:in  TSL;  
      clock			:in  TSL;
      clk_ena			:in  TSL;
      delay			:in  TSLV(LPM_DELAY_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component DPM_PROG_PIPE
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_DELAY_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      OUTPUT_SEPARATE		:in boolean := FALSE;
      OUTPUT_REGISTERED  	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      delay			:in  TSLV(LPM_DELAY_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      sim_loop			:in  TSL;
      proc_req			:in  TSL;
      proc_ack			:out TSL;
      mem_addr			:in  TSLV(LPM_DELAY_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
    );
  end component;

  component DPM_PROG_PULSE
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_PULSE_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      OUTPUT_SEPARATE		:in boolean := FALSE;
      OUTPUT_REGISTERED  	:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      finish			:out TSL;
      pulse_len			:in  TSLV(LPM_PULSE_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      proc_req			:in  TSL;
      proc_ack			:out TSL;
      mem_addr			:in  TSLV(LPM_PULSE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
    );
  end component;

  component DPM_PROG_FIFO is
    generic (
      LPM_DATA_WIDTH		:in natural := 8;
      LPM_ADDR_WIDTH		:in natural := 4;
      LPM_MDATA_WIDTH		:in natural := 8
  
    );
    port(
      resetN			:in  TSL := '0';
      clock			:in  TSL := '0';
      data_ena			:in  TSL := '1';
      data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      block_end			:in  TSL := '0';
      full			:out TSL;
      empty_str			:in  TSL := '0';
      empty			:out TSL;
      empty_ack			:out TSL;
      rd_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_str		:in  TSL := '0';
      rd_addr_ena		:in  TSL := '0';
      rd_addr_test_str		:in  TSL;
      rd_addr_test		:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_test_ack		:out TSL;
      wr_addr_str		:in  TSL := '0';
      wr_addr			:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      wr_addr_ack		:out TSL;
      lost_data_str		:in  TSL := '0';
      lost_data			:out TSL;
      lost_data_ack		:out TSL;
      sim_loop			:in  TSL := '0';
      proc_req			:in  TSL := '0';
      proc_ack			:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL := '0';
      mem_str			:in  TSL := '0'
    );
  end component;

  component LPM_PULSE_GENER is
    generic (
      LPM_PULSE_WIDTH		:natural := 0;
      LPM_TRIGGER_INVERT	:boolean := FALSE;
      LPM_PULSE_INVERT		:boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      trigger			:in  TSL;
      pulse_out			:out TSL
    );
  end component;

  component LPM_PROG_PULSE_GENER is
    generic (
      LPM_DATA_PULSE_WIDTH	:natural := 0;
      LPM_PULSE_INVERT		:boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      trigger			:in  TSL;
      pulse_len			:in  TSLV(LPM_DATA_PULSE_WIDTH-1 downto 0);
      pulse_out			:out TSL
    );
  end component;

  component LPM_CLOCK_DIVIDER is
    generic (
      LPM_DIVIDE_PAR		:natural := 0;
      LPM_STROBE_MODE		:boolean := TRUE -- else: wave
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      div_clock			:out TSL
    );
  end component;

  component LPM_CLOCK_PULSER is
    generic (
      LPM_DIVIDE_PAR		:natural := 0;
      LPM_DATA_PULSE_WIDTH	:natural := 0;
      LPM_PULSE_INVERT		:boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      pulse			:out TSL
    );
  end component;

  component LPM_TIMER is
    generic (
      LPM_RANGE_MAX		:natural := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      count			:out TSLV(TVLcreate(LPM_RANGE_MAX)-1 downto 0);
      stop			:out TSL
    );
  end component;

  component LPM_MODIFY_CLOCK is
    generic(
      constant LPM_MULTIP_CLOCK			:natural := 0;
      constant LPM_DIVIDE_CLOCK			:natural := 0;
      constant CLOCK_IN_FREQ_MHZ		:natural := 0;
      constant LPM_MCLOCK_POS			:integer := 0
    );
    port (
      resetN					:in    TSL;
      in_clock					:in    TSL;
      out_clock					:out   TSL;
      out_clock90				:out   TSL;
      out_mclock				:out   TSL;
      out_mclock90				:out   TSL;
      out_strobe				:out   TSL;
      --
      pll_lock					:out   TSL;
      sresetN_out				:out   TSL;
      strobe_lock				:out   TSL;
      pll_unlock_hold				:out   TSL;
      pll_unlock_read				:in    TSL;
      strobe_unlock_hold			:out   TSL;
      strobe_unlock_read			:in    TSL
    );
  end component;

  component LPM_PROG_COUNTER is
    generic (
      LPM_DATA_SIZE		:natural := 0;
      LPM_COUNT_UP		:boolean := TRUE;
      LPM_COUNT_CONT		:boolean := TRUE
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      load			:in  TSL;
      data			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
      limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
      count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
      finish			:out TSL
    );
  end component;

  component LPM_PROG_TIMER is
    generic (
      LPM_DATA_SIZE		:natural := 0
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
      count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
      stop			:out TSL
    );
  end component;

  component LPM_MPROG_TIMER is
    generic (
      LPM_DATA_SIZE		:natural := 0;
      LPM_MODULE_SIZE		:natural := 0
  );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      init			:in  TSL;
      limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
      count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
      stop			:out TSL
    );
  end component;

  component LPM_PULSE_DELAY is
    generic (
      LPM_DELAY_SIZE		:natural := 4
    );
    port(
      resetN			:in  TSL;
      clock			:in  TSL;
      clk_ena			:in  TSL;
      pulse_in			:in  TSL;
      pulse_out			:out TSL;
      limit			:in  TSLV(LPM_DELAY_SIZE-1 downto 0)
    );
  end component;

  component XDPM_PROG_PIPE_PULSE is
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_PIPE_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      PIPE_PULSE_SEL1		:in string := "?";
      PIPE_PULSE_SEL2		:in string := "?"
    );
    port(
      resetN			:in  TSL := '0';
      clock			:in  TSL := '0';
      switch			:in  TSL := '0';
      clk_ena1			:in  TSL := '1';
      init1			:in  TSL := '0';
      break1			:in  TSL := '0';
      finish1			:out TSL;
      pipe_len1			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
      data_in1			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out1			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      sim_loop1			:in  TSL := '0';
      proc_req1			:in  TSL := '0';
      proc_ack1			:out TSL;
      mem_addr1			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in1		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out1		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr1			:in  TSL := '0';
      mem_str1			:in  TSL := '0';
      mem_count1		:out TSLV(LPM_PIPE_WIDTH-1 downto 0);
      clk_ena2			:in  TSL := '1';
      init2			:in  TSL := '0';
      break2			:in  TSL := '0';
      finish2			:out TSL;
      pipe_len2			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
      data_in2			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out2			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      sim_loop2			:in  TSL := '0';
      proc_req2			:in  TSL := '0';
      proc_ack2			:out TSL;
      mem_addr2			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in2		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out2		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr2			:in  TSL := '0';
      mem_str2			:in  TSL := '0';
      mem_count2		:out TSLV(LPM_PIPE_WIDTH-1 downto 0)
    );
  end component;

  component DPM_PROG_PIPE_PULSE is
    generic (
      constant LPM_DATA_WIDTH	:in natural := 8;
      constant LPM_PIPE_WIDTH	:in natural := 4;
      constant LPM_MDATA_WIDTH	:in natural := 8;
      constant PIPE_PULSE_SEL	:in string := "PIPE"
    );
    port(
      resetN			:in  TSL := '0';
      clock			:in  TSL := '0';
      clk_ena			:in  TSL := '1';
      init			:in  TSL := '0';
      break			:in  TSL := '0';
      finish			:out TSL;
      pipe_len			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      sim_loop			:in  TSL := '0';
      proc_req			:in  TSL := '0';
      proc_ack			:out TSL;
      mem_addr			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL := '0';
      mem_str			:in  TSL := '0';
      mem_count			:out TSLV(LPM_PIPE_WIDTH-1 downto 0)
    );
  end component;

end LPMComponent;

-------------------------------------------------------------------
-- DPM_PIPE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PIPE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_WIDTH	:in natural := 4
  );
  port(
    resetN			:in  TSL := '0';  
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    delay			:in  TSLV(LPM_DELAY_WIDTH-1 downto 0);
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end DPM_PIPE;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
--use work.LPMComp_UniTechType.all;

architecture behaviour of DPM_PIPE is

  signal Count, CountReg	:TSLV(LPM_DELAY_WIDTH-1 downto 0);
  signal ClkEnaReg		:TSL;
  signal DataInReg		:TSLV(LPM_DATA_WIDTH -1 downto 0);
  signal DataOutSig		:TSLV(LPM_DATA_WIDTH -1 downto 0);
  signal LA			:TSLV(LPM_DELAY_WIDTH-1 downto 0);
  signal LD			:TSLV(LPM_DATA_WIDTH -1 downto 0);

begin

  LA <= (others => '0');
  LD <= (others => '0');
  process(clock, resetN)
  begin
    if(resetN='0') then
      count      <= (others => '0');
      CountReg   <= (others => '0');
      ClkEnaReg  <= '0';
      DataInReg  <= (others => '0');
    elsif(clock'event and clock='1') then
      ClkEnaReg  <= clk_ena;
      DataInReg  <= data_in;
      if(ClkEnaReg='1') then
        CountReg <= Count;
        if(count=delay)then
          Count <= (others => '0');
        else
          Count <= Count + 1;
        end if;
      end if;
    end if;
  end process;

  mem: component UTLPM_DPM_PROG
    generic map(
      LPM_DATA_WIDTH    => LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH    => LPM_DELAY_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_DATA_WIDTH,
      ADDRESS_SEPARATE	=> FALSE,
      INIT_CLEAR_ENA    => FALSE
    )
    port map(
      resetN       => resetN,
      clk          => clock,
      wr_ena       => ClkEnaReg,
      wr_addr      => CountReg,
      wr_data      => DataInReg,
      rd_ena       => ClkEnaReg,
      rd_addr      => Count,
      rd_data      => DataOutSig,
      mem_str      => '0',
      mem_wr       => '1',
      mem_addr     => LA,
      mem_data_in  => LD,
      mem_data_out => open,
      mem_ena      => '0',
      mem_ena_ack  => open
    );

  data_out <= DataOutSig;

end behaviour;


-------------------------------------------------------------------
-- LPM_REG_PROG_PIPE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PROG_PIPE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_POS	:in natural := 4;
    constant LPM_DELAY_STEP	:in natural := 1;
    constant IN_REGISTERED	:in boolean := FALSE;
    constant OUT_REGISTERED	:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '0';  
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0);
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_REG_PROG_PIPE;

architecture behaviour of LPM_REG_PROG_PIPE is

  constant DELAY_WIDTH		:TN := TVLcreate(LPM_DELAY_POS);
  constant STEP			:TN := LPM_DELAY_STEP;
  type     TDataPipe		is array (0 to STEP*pow2(DELAY_WIDTH)-1) of TSLV(LPM_DATA_WIDTH -1 downto 0);
  signal   PipeReg		:TDataPipe;
  type     TPipeSwitch		is array (0 to DELAY_WIDTH-1) of TSLV(LPM_DATA_WIDTH -1 downto 0);
  signal   PipeSwitchInSig	:TPipeSwitch;
  signal   PipeSwitchOutSig	:TPipeSwitch;
  signal   ClkEnaReg		:TSL;
  signal   DelaySig		:TSLV(DELAY_WIDTH-1 downto 0);
  signal   DataInReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataOutSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataOutReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  
  function fst(k :TN) return TN is begin
    return(STEP*(pow2(k)-1));
  end function;

  function lst(k :TN) return TN is begin
    return(fst(k+1)-1);
  end function;

begin

  process (clock, resetN, clk_ena, data_in) begin 
    if (IN_REGISTERED=TRUE and resetN='0') then
      ClkEnaReg <= '0';
      DataInReg <= (others => '0');
    elsif (IN_REGISTERED=FALSE or (clock'event and clock='1')) then
      ClkEnaReg <= clk_ena;
      DataInReg <= data_in;
    end if;
  end process;
  --
  PipeSwitchInSig(0) <= DataInReg;
  --
  process(clock, resetN)
  begin
    if(resetN='0') then
      PipeReg <= (PipeReg'range => (others => '0'));
    elsif(clock'event and clock='1') then
      if(ClkEnaReg='1') then
        for index in 0 to DELAY_WIDTH-1 loop
          PipeReg(fst(index)) <= PipeSwitchInSig(index);
          if (STEP>1 or index>0) then
            PipeReg(fst(index)+1 to lst(index)) <= PipeReg(fst(index) to lst(index)-1);
          end if;
        end loop;
      end if;
    end if;
  end process;
  --
  DelaySig <= delay when delay<=LPM_DELAY_POS else TSLVconv(LPM_DELAY_POS,DELAY_WIDTH);
  --
  loop1:
  for index in 0 to DELAY_WIDTH-1 generate
    PipeSwitchOutSig(index) <= PipeSwitchInSig(index) when (DelaySig(index)='0') else PipeReg(lst(index));
  end generate;
  --
  loop2:
  for index in 1 to DELAY_WIDTH-1 generate
    PipeSwitchInSig(index) <= PipeSwitchOutSig(index-1);
  end generate;
  --
  DataOutSig <= PipeSwitchOutSig(DELAY_WIDTH-1);
  --
  process (clock, resetN, DataOutSig) begin 
    if (OUT_REGISTERED and resetN='0') then
      DataOutReg <= (others => '0');
    elsif (OUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      DataOutReg <= DataOutSig;
    end if;
  end process;
  --
  data_out <= DataOutReg;
  
end behaviour;


-------------------------------------------------------------------
-- LPM_REG_PROG_PIPE1
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PROG_PIPE1 is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_POS	:in natural := 4;
    constant LPM_DELAY_STEP	:in natural := 1;
    constant IN_REGISTERED	:in boolean := TRUE;
    constant OUT_REGISTERED	:in boolean := TRUE
  );
  port(
    resetN			:in  TSL := '0';  
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    delay			:in  TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0);
    data_in			:in  TSL;
    data_out			:out TSL
  );
end LPM_REG_PROG_PIPE1;

architecture behaviour of LPM_REG_PROG_PIPE1 is

  signal   data_in_sig		:TSLV(0 downto 0);
  signal   data_out_sig		:TSLV(0 downto 0);

begin

  data_in_sig(0) <= data_in;
  
  delay_comp: LPM_REG_PROG_PIPE
    generic map(
      LPM_DATA_WIDTH  => 1,
      LPM_DELAY_POS   => LPM_DELAY_POS,
      LPM_DELAY_STEP  => LPM_DELAY_STEP,
      IN_REGISTERED   => IN_REGISTERED,
      OUT_REGISTERED  => OUT_REGISTERED
    )
    port map(
      resetN          => resetN,
      clock           => clock,
      clk_ena         => clk_ena,
      delay           => delay,
      data_in         => data_in_sig,
      data_out        => data_out_sig
    );
  
  data_out <= data_out_sig(0);

end behaviour;


-------------------------------------------------------------------
-- LPM_REG_PIPE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PIPE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_POS	:in natural := 4;
    constant LPM_DELAY_STEP	:in natural := 1;
    constant IN_REGISTERED	:in boolean := TRUE;
    constant OUT_REGISTERED	:in boolean := TRUE
  );
  port(
    resetN			:in  TSL := '0';  
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_REG_PIPE;

architecture behaviour of LPM_REG_PIPE is

  constant delay :TSLV(TVLcreate(LPM_DELAY_POS)-1 downto 0) := TSLVconv(LPM_DELAY_POS,TVLcreate(LPM_DELAY_POS));

begin

  delay_comp: LPM_REG_PROG_PIPE
    generic map(
      LPM_DATA_WIDTH  => LPM_DATA_WIDTH,
      LPM_DELAY_POS   => LPM_DELAY_POS,
      LPM_DELAY_STEP  => LPM_DELAY_STEP,
      IN_REGISTERED   => IN_REGISTERED,
      OUT_REGISTERED  => OUT_REGISTERED
    )
    port map(
      resetN          => resetN,
      clock           => clock,
      clk_ena         => clk_ena,
      delay           => delay,
      data_in         => data_in,
      data_out        => data_out
    );

end behaviour;


-------------------------------------------------------------------
-- LPM_REG_PIPE1
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PIPE1 is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_POS	:in natural := 4;
    constant LPM_DELAY_STEP	:in natural := 4;
    constant IN_REGISTERED	:in boolean := TRUE;
    constant OUT_REGISTERED	:in boolean := TRUE
  );
  port(
    resetN			:in  TSL := '0';  
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    data_in			:in  TSL;
    data_out			:out TSL
  );
end LPM_REG_PIPE1;

architecture behaviour of LPM_REG_PIPE1 is

  signal   data_in_sig		:TSLV(0 downto 0);
  signal   data_out_sig		:TSLV(0 downto 0);

begin

  data_in_sig(0) <= data_in;
  
  delay_comp: LPM_REG_PIPE
    generic map(
      LPM_DATA_WIDTH  => 1,
      LPM_DELAY_POS   => LPM_DELAY_POS,
      LPM_DELAY_STEP  => LPM_DELAY_STEP,
      IN_REGISTERED   => IN_REGISTERED,
      OUT_REGISTERED  => OUT_REGISTERED
    )
    port map(
      resetN          => resetN,
      clock           => clock,
      clk_ena         => clk_ena,
      data_in         => data_in_sig,
      data_out        => data_out_sig
    );
  
  data_out <= data_out_sig(0);

end behaviour;


-------------------------------------------------------------------
-- LPM_REG_PIPE_CUT
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PIPE_CUT is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_PIPE_LEN	:in natural := 4;
    constant LPM_PIPE_STEP	:in natural := 4;
    constant LPM_CUT_POS	:in natural := 6;
    constant IN_REGISTERED	:in boolean := FALSE;
    constant OUT_REGISTERED	:in boolean := FALSE
  );
  port(
    resetN			:in  TSL;  
    clock			:in  TSL;
    clk_ena			:in  TSL := '1';
    cut				:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0) := (others => '0');
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_REG_PIPE_CUT;

architecture behaviour of LPM_REG_PIPE_CUT is

  signal cut_sig :TSLV(cut'range);
  signal delay   :TSLV(TVLcreate(LPM_PIPE_LEN)-1 downto 0);
  
begin

  cut_sig <= cut when (cut<=LPM_CUT_POS) else TSLVconv(LPM_CUT_POS,cut_sig'length);
  delay   <= LPM_PIPE_LEN-TSLVresize(cut_sig,delay'length) when (TNconv(cut_sig)<=LPM_PIPE_LEN) else (others => '0');
  --
  delay_comp: LPM_REG_PROG_PIPE
    generic map(
      LPM_DATA_WIDTH  => LPM_DATA_WIDTH,
      LPM_DELAY_POS   => LPM_PIPE_LEN,
      LPM_DELAY_STEP  => LPM_PIPE_STEP,
      IN_REGISTERED   => IN_REGISTERED,
      OUT_REGISTERED  => OUT_REGISTERED
    )
    port map(
      resetN          => resetN,
      clock           => clock,
      clk_ena         => clk_ena,
      delay           => delay,
      data_in         => data_in,
      data_out        => data_out
    );

end behaviour;


-------------------------------------------------------------------
-- LPM_REG_CUT_PIPE1
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_REG_PIPE_CUT1 is
  generic (
    constant LPM_PIPE_LEN	:in natural := 0;
    constant LPM_PIPE_STEP	:in natural := 4;
    constant LPM_CUT_POS	:in natural := 0;
    constant IN_REGISTERED	:in boolean := FALSE;
    constant OUT_REGISTERED	:in boolean := FALSE
  );
  port(
    resetN			:in  TSL;  
    clock			:in  TSL;
    clk_ena			:in  TSL := '1';
    cut				:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0) := (others => '0');
    data_in			:in  TSL;
    data_out			:out TSL
  );
end LPM_REG_PIPE_CUT1;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

architecture behaviour of LPM_REG_PIPE_CUT1 is

  signal   data_in_sig		:TSLV(0 downto 0);
  signal   data_out_sig		:TSLV(0 downto 0);

begin

  data_in_sig(0) <= data_in;
  
  pipe: LPM_REG_PIPE_CUT
    generic map(
      LPM_DATA_WIDTH  => 1,
      LPM_PIPE_LEN    => LPM_PIPE_LEN,
      LPM_PIPE_STEP   => LPM_PIPE_STEP,
      LPM_CUT_POS     => LPM_CUT_POS,
      IN_REGISTERED   => IN_REGISTERED,
      OUT_REGISTERED  => OUT_REGISTERED
    )
    port map(
      resetN          => resetN,
      clock           => clock,
      clk_ena         => clk_ena,
      cut             => cut,
      data_in         => data_in_sig,
      data_out        => data_out_sig
    );
  
  data_out <= data_out_sig(0);

end behaviour;


-------------------------------------------------------------------
-- DPM_PROG
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_part is
  generic (
    LPM_ADDR_WIDTH		:in natural := 4;
    LPM_DATA_WIDTH		:in natural := 6;
    LPM_MDATA_WIDTH		:in natural := 8;
    ADDRESS_SEPARATE		:in boolean := FALSE;
    INIT_CLEAR_ENA		:in boolean := FALSE
  );
  port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
end DPM_PROG_part;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
--use work.KTPComponent.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of DPM_PROG_part is

  function \vr_arr_init\(vlen, plen :TVL) return TVRV is
    variable vr_arr :TVRV(SLVPartNum(vlen,plen)-1 downto 0);
    variable pos :TVI;
  begin
    pos := VEC_INDEX_MIN;
    for index in VEC_INDEX_MIN to vr_arr'left loop
      vr_arr(index).r := pos;
      vr_arr(index).l := pos+SLVPartSize(vlen,plen,index)-1;
      pos := vr_arr(index).l+1;
    end loop;
    return(vr_arr);
  end function;

  constant DPM_PART_NUM :TP := SLVPartNum(LPM_DATA_WIDTH,LPM_MDATA_WIDTH);
  constant ADDR_EXPAND_SIZE :TVL := SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH);
  constant vr_arr :TVRV(DPM_PART_NUM-1 downto 0) := \vr_arr_init\(LPM_DATA_WIDTH,LPM_MDATA_WIDTH);

  signal   DpmWrEnaSig		:TSLV(DPM_PART_NUM-1 downto 0);
  signal   MemWrEnaSig		:TSLV(DPM_PART_NUM-1 downto 0);
  signal   MemDataOutSig	:TSLV(data_in'range);
  signal   MemIndexSig		:TN range 0 to (2**ADDR_EXPAND_SIZE)-1;
  signal   MemAckSig		:TSLV(DPM_PART_NUM-1 downto 0);

begin
	
--  MemIndexSig <= 0 when (DPM_PART_NUM=1) else
--  	       TNconv(mem_addr(ADDR_EXPAND_SIZE+LPM_ADDR_WIDTH-1 downto LPM_ADDR_WIDTH));
  part_one :if (DPM_PART_NUM=1) generate
    MemIndexSig <= 0;
  end generate;
  part_more_one :if (DPM_PART_NUM>1) generate
  	 MemIndexSig <= TNconv(mem_addr(ADDR_EXPAND_SIZE+LPM_ADDR_WIDTH-1 downto LPM_ADDR_WIDTH));
  end generate;

  l1:
  for index in 0 to DPM_PART_NUM-1 generate

    DpmWrEnaSig(index)  <= ena_in and not(simulate);
    MemWrEnaSig(index)  <= mem_wr when MemIndexSig=index else '0';

    mem: component UTLPM_DPM_PROG
      generic map(
        LPM_ADDR_WIDTH   => LPM_ADDR_WIDTH,
        LPM_DATA_WIDTH   => SLVPartSize(LPM_DATA_WIDTH,LPM_MDATA_WIDTH,index),
        LPM_MDATA_WIDTH  => LPM_MDATA_WIDTH,
        ADDRESS_SEPARATE => ADDRESS_SEPARATE,
        INIT_CLEAR_ENA   => INIT_CLEAR_ENA
      )
      port map(
        resetN       => resetN,
        clk          => clk,
        wr_ena       => DpmWrEnaSig(index),
        wr_addr      => addr_in,
        wr_data      => data_in(vr_arr(index).l downto vr_arr(index).r),
        rd_ena       => ena_out,
        rd_addr      => addr_out,
        rd_data      => data_out(vr_arr(index).l downto vr_arr(index).r),
        mem_str      => mem_str,
        mem_wr       => MemWrEnaSig(index),
        mem_addr     => mem_addr(LPM_ADDR_WIDTH-1 downto 0),
        mem_data_in  => mem_data_in(vr_arr(index).l-vr_arr(index).r downto 0),
        mem_data_out => MemDataOutSig(vr_arr(index).l downto vr_arr(index).r),
        mem_ena      => mem_ena,
        mem_ena_ack  => MemAckSig(index)
      );
  end generate;

  process(MemDataOutSig,MemIndexSig) is
    variable data_var : TSLV(mem_data_out'range);
  begin
    data_var := (others => '0');
    for index in 0 to DPM_PART_NUM-1 loop
      if(MemIndexSig=index) then
        data_var := TSLVResize(SLVNorm(MemDataOutSig(vr_arr(index).l downto vr_arr(index).r)),LPM_MDATA_WIDTH);
        exit;
      end if;
    end loop;
    mem_data_out <= data_var;
  end process;

  mem_ena_ack <= AND_REDUCE(MemAckSig) when mem_ena='1' else OR_REDUCE(MemAckSig);

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_single is
  generic (
    LPM_ADDR_WIDTH		:in natural := 6;
    LPM_DATA_WIDTH		:in natural := 14;
    LPM_MDATA_WIDTH		:in natural := 16;
    ADDRESS_SEPARATE		:in boolean := FALSE;
    INIT_CLEAR_ENA		:in boolean := FALSE
  );
  port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
end DPM_PROG_single;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
--use work.KTPComponent.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of DPM_PROG_single is

  constant DPM_PART_NUM :TP := SLVPartNum(LPM_DATA_WIDTH,LPM_MDATA_WIDTH);
  constant ADDR_EXPAND_SIZE :TVL := SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH);

  signal   MemIndexSig		:TN range 0 to DPM_PART_NUM-1;
  signal   DpmWrEnaSig		:TSL;
  signal   MemWrEnaSig		:TSL;
  signal   MemDataInReg		:TSLV((DPM_PART_NUM*LPM_MDATA_WIDTH)-1 downto 0);
  signal   MemDataInSig		:TSLV((DPM_PART_NUM*LPM_MDATA_WIDTH)-1 downto 0);
  signal   MemDataOutSig	:TSLV((DPM_PART_NUM*LPM_MDATA_WIDTH)-1 downto 0);

begin

  MemIndexSig <= 0 when (DPM_PART_NUM=1) else
  	         TNconv(mem_addr(ADDR_EXPAND_SIZE+LPM_ADDR_WIDTH-1 downto LPM_ADDR_WIDTH));
  --
  process (resetN, mem_str)  
  begin
    if(resetN='0') then
      MemDataInReg <= (others =>'0');
    elsif(mem_str'event and mem_str='0') then
      for index in 0 to DPM_PART_NUM-1 loop
        if (index = MemIndexSig) then
          MemDataInReg <= SLVPartPut(MemDataInReg,LPM_MDATA_WIDTH,index,mem_data_in);
        end if;
      end loop;
    end if;
  end process;
  --
  process (MemDataInReg, mem_data_in)
  begin
    if (DPM_PART_NUM=1) then
      MemDataInSig <= MemDataInReg;
    else
      MemDataInSig <=mem_data_in&MemDataInReg(LPM_MDATA_WIDTH*(DPM_PART_NUM-1)-1 downto 0);
    end if;
  end process;
  --
  DpmWrEnaSig <= ena_in and not(simulate);
  MemWrEnaSig <= mem_wr when (MemIndexSig=(DPM_PART_NUM-1)) else '0';
  --
  mem: component UTLPM_DPM_PROG
    generic map(
      LPM_ADDR_WIDTH   => LPM_ADDR_WIDTH,
      LPM_DATA_WIDTH   => LPM_DATA_WIDTH,
      LPM_MDATA_WIDTH  => LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE => ADDRESS_SEPARATE,
      INIT_CLEAR_ENA   => INIT_CLEAR_ENA
    )
    port map(
      resetN       => resetN,
      clk          => clk,
      wr_ena       => DpmWrEnaSig,
      wr_addr      => addr_in,
      wr_data      => data_in,
      rd_ena       => ena_out,
      rd_addr      => addr_out,
      rd_data      => data_out,
      mem_str      => mem_str,
      mem_wr       => MemWrEnaSig,
      mem_addr     => mem_addr(LPM_ADDR_WIDTH-1 downto 0),
      mem_data_in  => MemDataInSig(LPM_DATA_WIDTH-1 downto 0),
      mem_data_out => MemDataOutSig(LPM_DATA_WIDTH-1 downto 0),
      mem_ena      => mem_ena,
      mem_ena_ack  => mem_ena_ack
    );
  --
  process (MemDataOutSig, MemIndexSig)  
    variable data_var : TSLV(mem_data_out'range);
  begin
    data_var := (others => '0');
    for index in 0 to DPM_PART_NUM-1 loop
      if (index = MemIndexSig) then
        data_var := SLVPartGet(MemDataOutSig,LPM_MDATA_WIDTH,index);
      end if;
    end loop;
    mem_data_out <= data_var;
  end process;

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTechType.all;

entity DPM_PROG is
  generic (
    LPM_DATA_WIDTH		:in natural := 6;
    LPM_ADDR_WIDTH		:in natural := 4;
    LPM_MDATA_WIDTH		:in natural := 8;
    ADDRESS_SEPARATE		:in boolean := FALSE;
    INIT_CLEAR_ENA		:in boolean := TRUE
  );
  port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
end DPM_PROG;

architecture behaviour of DPM_PROG is

  component DPM_PROG_part is
    generic (
      LPM_ADDR_WIDTH		:in natural := 0;
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      ADDRESS_SEPARATE		:in boolean := FALSE;
      INIT_CLEAR_ENA		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
  end component;

  component DPM_PROG_single is
    generic (
      LPM_ADDR_WIDTH		:in natural := 0;
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_MDATA_WIDTH		:in natural := 0;
      ADDRESS_SEPARATE		:in boolean := FALSE;
      INIT_CLEAR_ENA		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      ena_in			:in  TSL;
      addr_in			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      ena_out			:in  TSL;
      addr_out			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      simulate			:in  TSL;
      mem_ena			:in  TSL;
      mem_ena_ack		:out TSL;
      mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr			:in  TSL;
      mem_str			:in  TSL
  );
  end component;

begin

  if_dpm_part:
  if (GetUniTechLibraryType /= "KTP_XILINX3_LIB") generate
    dpm_part :DPM_PROG_part
    generic map (
      LPM_ADDR_WIDTH	=> LPM_ADDR_WIDTH,
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE	=> ADDRESS_SEPARATE,
      INIT_CLEAR_ENA	=> INIT_CLEAR_ENA
    )
    port map (
      resetN		=> resetN,
      clk		=> clk,
      ena_in		=> ena_in,
      addr_in		=> addr_in,
      data_in		=> data_in,
      ena_out		=> ena_out,
      addr_out		=> addr_out,
      data_out		=> data_out,
      simulate		=> simulate,
      mem_ena		=> mem_ena,
      mem_ena_ack	=> mem_ena_ack,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
    );
  end generate;

  if_dpm_single:
  if (GetUniTechLibraryType = "KTP_XILINX3_LIB") generate
    dpm_single :DPM_PROG_single
    generic map (
      LPM_ADDR_WIDTH	=> LPM_ADDR_WIDTH,
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE	=> ADDRESS_SEPARATE,
      INIT_CLEAR_ENA	=> INIT_CLEAR_ENA
    )
    port map (
      resetN		=> resetN,
      clk		=> clk,
      ena_in		=> ena_in,
      addr_in		=> addr_in,
      data_in		=> data_in,
      ena_out		=> ena_out,
      addr_out		=> addr_out,
      data_out		=> data_out,
      simulate		=> simulate,
      mem_ena		=> mem_ena,
      mem_ena_ack	=> mem_ena_ack,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
    );
  end generate;

end behaviour;

-------------------------------------------------------------------
-- DPM_PROG_PIPE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_PIPE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_DELAY_WIDTH	:in natural := 4;
    constant LPM_MDATA_WIDTH	:in natural := 8;
    constant OUTPUT_SEPARATE	:in boolean := FALSE;
    constant OUTPUT_REGISTERED  :in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    init			:in  TSL := '0';
    delay			:in  TSLV(LPM_DELAY_WIDTH-1 downto 0);
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    sim_loop			:in  TSL := '0';
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(LPM_DELAY_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0'
  );
end DPM_PROG_PIPE;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of DPM_PROG_PIPE is

  signal clockN				:TSL;
  signal MemEnaReg			:TSL;
  signal MemAckSig			:TSL;
  signal ClkEnaReg			:TSL;
  signal InitReg			:TSL;
  signal DataInReg			:TSLV(data_in'range);
  signal DataOutSig			:TSLV(data_in'range);
  signal DataOutReg			:TSLV(data_in'range);
  signal Count, CountReg		:TSLV(delay'range);

begin

  clockN <= not(clock);
	
  process(clock, resetN)
  begin
    if(resetN='0') then
      count      <= (others => '0');
      CountReg   <= (others => '0');
      MemEnaReg <= '0';
      ClkEnaReg  <= '0';
      InitReg    <= '0';
      DataInReg  <= (others => '0');
    elsif(clock'event and clock='1') then
      MemEnaReg  <= not(proc_req);
      ClkEnaReg  <= clk_ena;
      InitReg    <= init;
      DataInReg  <= data_in;
      if (MemEnaReg='1' or MemAckSig='1' or InitReg='1') then
        CountReg <= delay;
        Count    <= (others => '0');
      elsif (ClkEnaReg='1') then
        CountReg <= Count;
        if (Count=delay) then
          Count <= (others => '0');
        else
          Count <= Count + 1;
        end if;
      end if;
    end if;
  end process;

  pipe: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_DELAY_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> ClkEnaReg,
      addr_in		=> CountReg,
      data_in		=> DataInReg,
      ena_out		=> ClkEnaReg,
      addr_out		=> Count,
      data_out		=> DataOutSig,
      simulate		=> sim_loop,
      mem_ena		=> MemEnaReg,
      mem_ena_ack	=> MemAckSig,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
  );
  --
  process(resetN, clock)
  begin
    if(OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataOutReg <= (others => '0');
    elsif(OUTPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      if (MemAckSig='0' or OUTPUT_SEPARATE=FALSE) then
        DataOutReg <= DataOutSig;
      else
        DataOutReg <= (others => '0');
      end if;
    end if;
  end process;
  --
  data_out <= DataOutReg;
  proc_ack <= not(MemAckSig);

end behaviour;

-------------------------------------------------------------------
-- DPM_PROG_PULSE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_PULSE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_PULSE_WIDTH	:in natural := 4;
    constant LPM_MDATA_WIDTH	:in natural := 8;
    constant OUTPUT_SEPARATE	:in boolean := FALSE;
    constant OUTPUT_REGISTERED  :in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    init			:in  TSL := '0';
    finish			:out TSL;
    pulse_len			:in  TSLV(LPM_PULSE_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(LPM_PULSE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0'
  );
end DPM_PROG_PULSE;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of DPM_PROG_PULSE is

  signal clockN				:TSL;
  signal MemEnaReg			:TSL;
  signal MemAckSig			:TSL;
  signal ClkEnaReg			:TSL;
  signal InitReg			:TSL;
  signal FinishReg			:TSL;
  signal DataInSig			:TSLV(data_out'range);
  signal DataOutSig			:TSLV(data_out'range);
  signal DataOutReg			:TSLV(data_out'range);
  signal AddrInSig			:TSLV(pulse_len'range);
  signal Count				:TSLV(pulse_len'range);

begin

  clockN <= not(clock);
	
  process(clock, resetN)
  begin
    if(resetN='0') then
      count      <= (others => '0');
      MemEnaReg <= '0';
      ClkEnaReg  <= '0';
      InitReg    <= '0';
      FinishReg  <= '0';
    elsif(clock'event and clock='1') then
      MemEnaReg <= not(proc_req);
      ClkEnaReg <= clk_ena;
      if (MemEnaReg='1' or MemAckSig='1') then
        InitReg   <= '0';
        FinishReg <= '0';
        Count     <= (others => '0');
      elsif (InitReg='0') then
        InitReg   <= init;
        FinishReg <= '0';
        Count     <= (others => '0');
      elsif (ClkEnaReg='1') then
        if (Count=pulse_len) then
	  InitReg   <= '0';
          FinishReg <= '1';
          Count     <= (others => '0');
        else
          Count     <= Count + 1;
        end if;
      end if;
    end if;
  end process;

  AddrInSig  <= (others => '0');
  DataInSig  <= (others => '0');
  pipe: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_PULSE_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> '0',
      addr_in		=> AddrInSig,
      data_in		=> DataInSig,
      ena_out		=> ClkEnaReg,
      addr_out		=> Count,
      data_out		=> DataOutSig,
      simulate		=> '1',
      mem_ena		=> MemEnaReg,
      mem_ena_ack	=> MemAckSig,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
  );
  --
  process(resetN, clock)
  begin
    if(OUTPUT_REGISTERED=TRUE and resetN='0') then
      DataOutReg <= (others => '0');
    elsif(OUTPUT_REGISTERED=FALSE or (clock'event and clock='1')) then
      if (MemAckSig='0' or OUTPUT_SEPARATE=FALSE) then
        DataOutReg <= DataOutSig;
      else
        DataOutReg <= (others => '0');
      end if;
    end if;
  end process;
  --
  data_out <= DataOutReg;
  proc_ack <= not(MemAckSig);
  finish   <= FinishReg;

end behaviour;

-------------------------------------------------------------------
-- DPM_PROG_FIFO
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_FIFO is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_ADDR_WIDTH	:in natural := 5;
    constant LPM_MDATA_WIDTH	:in natural := 8
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    data_ena			:in  TSL := '1';
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    block_end			:in  TSL := '0';
    full			:out TSL;
    empty_str			:in  TSL := '0';
    empty			:out TSL;
    empty_ack			:out TSL;
    lost_data_str		:in  TSL := '0';
    lost_data			:out TSL;
    lost_data_ack		:out TSL;
    wr_addr_str			:in  TSL := '0';
    wr_addr			:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
    wr_addr_ack			:out TSL;
    rd_addr_str			:in  TSL := '0';
    rd_addr_ena			:in  TSL := '0';
    rd_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    rd_addr_test_str		:in  TSL;
    rd_addr_test		:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
    rd_addr_test_ack		:out TSL;
    sim_loop			:in  TSL := '0';
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(LPM_ADDR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0'
  );
end DPM_PROG_FIFO;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.KTPComponent.all;

architecture behaviour of DPM_PROG_FIFO is

  signal  LV			:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  DataInReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal  BlockEndReg		:TSL;
  signal  DataInEnaReg		:TSL;
  signal  ClockInvSig		:TSL;
  signal  EmptySig		:TSLV(0 to 0);
  signal  EmptyOutSig		:TSLV(0 to 0);
  signal  AddrWrPrevReg		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  AddrWrReg		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  AddrWrNextCnt		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  AddrLastReg		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  AddrRdSig		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal  AddrRdStrobeSig	:TSL;
  signal  StopReg		:TSL;
  signal  FullReg		:TSL;
  signal  LostReg		:TSL;
  signal  LostSig		:TSLV(0 to 0);
  signal  LostDataOutSig	:TSLV(0 to 0);
  signal  ProcReg1,ProcReg2	:TSL;
  signal  ProcInitSig		:TSL;
  signal  ProcInitInvSig	:TSL;
  signal  ProcWorkSig		:TSL;
  signal  MemWrEnaSig		:TSL;
  signal  MemEnaSig		:TSL;
  signal  MemAckSig		:TSL;

begin

  LV <= (others=>'0');
  ClockInvSig <= not(clock);
  ProcInitSig <=     ProcReg1  and not(ProcReg2);
  ProcWorkSig <=     ProcReg1  and     ProcReg2 ;
  ProcInitInvSig <= not(ProcInitSig);

  rd_addr_comp: KTP_LPM_SYNCH_IN
    generic map (
      LPM_WIDTH => LPM_ADDR_WIDTH
    )
    port map (
      resetN    => resetN,
      setN      => ProcInitInvSig,
      clk       => clock,
      wr_str    => rd_addr_str,
      wr_ena    => rd_addr_ena,
      d	        => rd_addr,
      q         => AddrRdSig,
      strobe    => AddrRdStrobeSig,
      ack       => open
    );

  rd_test_comp: KTP_LPM_SYNCH_OUT
    generic map (
      LPM_WIDTH => LPM_ADDR_WIDTH
    )
    port map (
      resetN    => resetN,
      clk       => clock,
      rd_str    => rd_addr_test_str,
      d	        => AddrRdSig,
      q         => rd_addr_test,
      ack       => rd_addr_test_ack
    );

  EmptySig(0) <= TSLconv(AddrWrPrevReg=AddrRdSig) and not(FullReg) and ProcWorkSig;
  empty_comp: KTP_LPM_SYNCH_OUT
    generic map (
      LPM_WIDTH => 1
    )
    port map (
      resetN    => resetN,
      clk       => clock,
      rd_str    => empty_str,
      d	        => EmptySig,
      q         => EmptyOutSig,
      ack       => empty_ack
    );
  empty <= EmptyOutSig(0);

  wr_addr_comp: KTP_LPM_SYNCH_OUT
    generic map (
      LPM_WIDTH => LPM_ADDR_WIDTH
    )
    port map (
      resetN    => resetN,
      clk       => clock,
      rd_str    => wr_addr_str,
      d	        => AddrLastReg,
      q         => wr_addr,
      ack       => wr_addr_ack
    );

  LostSig(0) <= LostReg;
  lost_comp: KTP_LPM_SYNCH_OUT
    generic map (
      LPM_WIDTH => 1
    )
    port map (
      resetN    => resetN,
      clk       => clock,
      rd_str    => lost_data_str,
      d	        => LostSig,
      q         => LostDataOutSig,
      ack       => lost_data_ack
    );
  lost_data <= LostDataOutSig(0);


process(clock, resetN)
  begin
    if(resetN='0') then
      DataInReg	    <= (others => '0');
      BlockEndReg   <= '0';
      DataInEnaReg  <= '0';
      AddrWrPrevReg <= (others => '0');
      AddrWrReg     <= (others => '0');
      AddrWrNextCnt <= (others => '0');
      AddrLastReg   <= (others => '0');
      StopReg       <= '0';
      FullReg       <= '0';
      LostReg       <= '0';
      ProcReg1      <= '0';
      ProcReg2      <= '0';
    elsif(clock'event and clock='1') then
      DataInReg	    <= data;
      BlockEndReg   <= block_end;
      DataInEnaReg  <= data_ena;
      ProcReg1      <= proc_req;
      ProcReg2      <= ProcReg1;
      if (ProcInitSig='1') then
        AddrWrPrevReg <= (others => '1');
        AddrWrReg     <= (others => '0');
        AddrWrNextCnt <= TSLVconv(1,AddrWrNextCnt'length);
	AddrLastReg   <= (others => '0');
        StopReg       <= '0';
        FullReg       <= '0';
        LostReg       <= '0';
      elsif (ProcWorkSig='1') then
        if (StopReg='0') then
          if (DataInEnaReg='1') then
	    AddrWrNextCnt <= AddrWrNextCnt+1;
	    AddrWrReg     <= AddrWrNextCnt;
	    AddrWrPrevReg <= AddrWrReg;
	    if (AddrWrNextCnt=AddrRdSig) then
	      FullReg     <= '1';
	    end if;
	    if (AddrWrReg=AddrRdSig) then
	      StopReg     <= '1';
	      LostReg     <= not(BlockEndReg);
	      AddrLastReg <= AddrWrReg;
	    elsif (BlockEndReg='1') then
	      AddrLastReg <= AddrWrReg;
	    end if;
	  end if;
	elsif (AddrRdStrobeSig='1') then
	  StopReg  <= '0';
	  LostReg  <= '0';
 	  FullReg  <= '0';
	end if;
      end if;
    end if;
  end process;

  MemWrEnaSig <= ProcWorkSig and not(StopReg) and  DataInEnaReg;
  MemEnaSig   <= not(ProcWorkSig); 
  fifo: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_ADDR_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> MemWrEnaSig,
      addr_in		=> AddrWrReg,
      data_in		=> DataInReg,
      addr_out		=> LV,
      ena_out		=> '0',
      data_out		=> open,
      simulate		=> sim_loop,
      mem_ena		=> MemEnaSig,
      mem_ena_ack	=> MemAckSig,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
    );

  full <= FullReg;
  proc_ack <= ProcWorkSig and not(MemAckSig);

end behaviour;			   


-------------------------------------------------------------------
-- PRIVATE KTP ELEMENTS
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_PULSE_GENER is
  generic (
    LPM_PULSE_WIDTH		:natural := 10;
    LPM_TRIGGER_INVERT		:boolean := FALSE;
    LPM_PULSE_INVERT		:boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    trigger			:in  TSL;
    pulse_out			:out TSL
  );
end LPM_PULSE_GENER;

architecture behaviour of LPM_PULSE_GENER is

  signal   CountReg		:TN range 0 to LPM_PULSE_WIDTH;
  signal   TrgOutReg		:TSL;

begin

  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= 0;
      TrgOutReg <= '0';
    elsif(clock'event and clock='1') then
      if (CountReg <= 1) then
        if((trigger='1') xor (LPM_TRIGGER_INVERT=TRUE)) then
          CountReg <= LPM_PULSE_WIDTH;
	  TrgOutReg <= '1';
	else
          CountReg <= 0;
	  TrgOutReg <= '0';
	end if;
      else
        CountReg <= CountReg - 1;
      end if;
    end if;
  end process;
  
  pulse_out <= TrgOutReg when (LPM_PULSE_INVERT = FALSE) else
               not(TrgOutReg);

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_PROG_PULSE_GENER is
  generic (
    LPM_DATA_PULSE_WIDTH	:natural := 3;
    LPM_PULSE_INVERT		:boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    trigger			:in  TSL;
    pulse_len			:in  TSLV(LPM_DATA_PULSE_WIDTH-1 downto 0);
    pulse_out			:out TSL
  );
end LPM_PROG_PULSE_GENER;

architecture behaviour of LPM_PROG_PULSE_GENER is

  signal   CountReg		:TSLV(LPM_DATA_PULSE_WIDTH-1 downto 0);
  signal   TrgOutReg		:TSL;

begin

  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= (others => '0');
      TrgOutReg <= '0';
    elsif(clock'event and clock='1') then
      if (CountReg <= TSLVconv(1,LPM_DATA_PULSE_WIDTH)) then
        if(trigger='1') then
          CountReg <= pulse_len;
	  TrgOutReg <= '1';
	else
          CountReg <= (others => '0');
	  TrgOutReg <= '0';
	end if;
      else
        CountReg <= CountReg - 1;
      end if;
    end if;
  end process;
  
  pulse_out <= TrgOutReg when (LPM_PULSE_INVERT = FALSE) else
               not(TrgOutReg);

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_CLOCK_DIVIDER is
  generic (
    LPM_DIVIDE_PAR		:natural := 4;
    LPM_STROBE_MODE		:boolean := FALSE -- else: wave
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    div_clock			:out TSL
  );
end LPM_CLOCK_DIVIDER;

architecture behaviour of LPM_CLOCK_DIVIDER is

  signal   CountReg		:TN range 0 to LPM_DIVIDE_PAR-1;
  signal   HCountReg		:TN range 0 to LPM_DIVIDE_PAR/2;
  signal   ClkOutReg		:TSL;

begin

  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= 0;
      HCountReg <= 0;
      ClkOutReg <= '0';
    elsif(clock'event and clock='1') then
      if (CountReg = 0) then
        CountReg <= LPM_DIVIDE_PAR-1;
	HCountReg <= LPM_DIVIDE_PAR/2;
        if (LPM_STROBE_MODE = FALSE) then
          ClkOutReg <= '1';
        end if;
      else
        CountReg <= CountReg - 1;
      end if;
      if (HCountReg /= 0) then
        HCountReg <= HCountReg - 1;
        if (LPM_STROBE_MODE = FALSE and HCountReg = 1) then
          ClkOutReg <= '0';
        end if;
      else
      end if;
      if (LPM_STROBE_MODE = TRUE) then
        ClkOutReg <= TSLconv(CountReg = 0);
      end if;
    end if;
  end process;
  
  div_clock <= ClkOutReg;

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_CLOCK_PULSER is
  generic (
    LPM_DIVIDE_PAR		:natural := 10;
    LPM_DATA_PULSE_WIDTH	:natural := 3;
    LPM_PULSE_INVERT		:boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    pulse			:out TSL
  );
end LPM_CLOCK_PULSER;

architecture behaviour of LPM_CLOCK_PULSER is

  signal   div_clock		:TSL; 

begin

  divider: LPM_CLOCK_DIVIDER
    generic map (
      LPM_DIVIDE_PAR		=> LPM_DIVIDE_PAR,
      LPM_STROBE_MODE		=> TRUE
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      div_clock			=> div_clock
    );

  pulse_gen: LPM_PULSE_GENER
    generic map (
      LPM_PULSE_WIDTH		=> LPM_DATA_PULSE_WIDTH,
      LPM_TRIGGER_INVERT	=> FALSE,
      LPM_PULSE_INVERT		=> LPM_PULSE_INVERT 
    )
    port map (
      resetN			=> resetN,
      clock			=> clock,
      trigger			=> div_clock,
      pulse_out			=> pulse
    );

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_TIMER is
  generic (
    LPM_RANGE_MAX		:natural := 4
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena			:in  TSL;
    init			:in  TSL;
    count			:out TSLV(TVLcreate(LPM_RANGE_MAX)-1 downto 0);
    stop			:out TSL
  );
end LPM_TIMER;

architecture behaviour of LPM_TIMER is

  signal   CountReg		:TN range 0 to LPM_RANGE_MAX;
  signal   StopSig		:TSL;

begin

  StopSig <= TSLconv(CountReg = LPM_RANGE_MAX);
  
  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= 0;
    elsif(clock'event and clock='1') then
      if (clk_ena='1') then
        if (init='1') then
          CountReg <= 0;
        elsif (StopSig='0') then
          CountReg <= CountReg + 1;
        end if;
      end if;
    end if;
  end process;
  
  stop <= StopSig;
  count <= TSLVconv(CountReg,count'length);

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

entity LPM_MODIFY_CLOCK is
  generic(
    constant LPM_MULTIP_CLOCK			:natural := 8;
    constant LPM_DIVIDE_CLOCK			:natural := 1;
    constant CLOCK_IN_FREQ_MHZ			:natural := 40;
    constant LPM_MCLOCK_POS			:integer := 3
  );
  port (
    resetN					:in    TSL;
    in_clock					:in    TSL;
    out_clock					:out   TSL;
    out_clock90					:out   TSL;
    out_mclock					:out   TSL;
    out_mclock90				:out   TSL;
    out_strobe					:out   TSL;
    --
    pll_lock					:out   TSL;
    sresetN_out					:out   TSL;
    strobe_lock					:out   TSL;
    pll_unlock_hold				:out   TSL;
    pll_unlock_read				:in    TSL;
    strobe_unlock_hold				:out   TSL;
    strobe_unlock_read				:in    TSL
  );
end LPM_MODIFY_CLOCK;

architecture behavioural of LPM_MODIFY_CLOCK is

  constant MCLOCK_MULT				:TL := LPM_MULTIP_CLOCK>=LPM_DIVIDE_CLOCK;
  constant MCLOCK_CNT_MAX			:TN := maximum(sel(LPM_MULTIP_CLOCK/LPM_DIVIDE_CLOCK,LPM_DIVIDE_CLOCK/LPM_MULTIP_CLOCK,MCLOCK_MULT)-1,1);
  constant MCLOCK_CNT_WIDTH			:TN := TVLcreate(MCLOCK_CNT_MAX);
  constant MCLOCK_POS				:TN := (10*(MCLOCK_CNT_MAX+1)+LPM_MCLOCK_POS-5) mod (MCLOCK_CNT_MAX+1);
  signal   PllClockSig				:TSL;
  signal   PllClock90Sig			:TSL;
  signal   PllMclockSig				:TSL;
  signal   PllMclock90Sig			:TSL;
  signal   ClockSig				:TSL;
  signal   Clock90Sig				:TSL;
  signal   MclockSig				:TSL;
  signal   Mclock90Sig				:TSL;
  --
  signal   PllLockSig				:TSL;
  --
  signal   ClockRegN				:TSL;
  signal   ClockRegNP				:TSL;
  signal   ClockReg0				:TSL;
  signal   ClockReg1				:TSL;
  signal   StrobeReg				:TSL;
  signal   StrobePosReg				:TSLV(MCLOCK_CNT_WIDTH-1 downto 0);
  signal   StrobePosCnt				:TSLV(MCLOCK_CNT_WIDTH-1 downto 0);
  signal   StrobeDelReg				:TSL;
  signal   StrobeErrCnt				:TSLV(MCLOCK_CNT_WIDTH-1 downto 0);
  signal   StrobeErrNReg1			:TSL;
  signal   StrobeErrNReg2			:TSL;
  signal   StrobeErrNReg			:TSL;
  --
  signal   SynchResetReg			:TSL;
  signal   PllLockHoldReg			:TSL;
  signal   StrobeLockHoldReg			:TSL;

begin

  pll_inst : UTLPM_MODIFY_CLOCK
    generic map (
      LPM_MULTIP_CLOCK  => LPM_MULTIP_CLOCK,
      LPM_DIVIDE_CLOCK  => LPM_DIVIDE_CLOCK,
      CLOCK_IN_FREQ_MHZ => CLOCK_IN_FREQ_MHZ
    )
    port map (
      resetN            => resetN,
      clk_in            => in_clock,
      clk_out           => PllClockSig,
      clk90_out         => PllClock90Sig,
      mclk_out          => PllMclockSig,
      mclk90_out        => PllMclock90Sig,
      locked            => PllLockSig
    );
  --
  ClockSig    <= PllClockSig    when MCLOCK_MULT=TRUE else PllMclockSig;
  Clock90Sig  <= PllClock90Sig  when MCLOCK_MULT=TRUE else PllMclock90Sig;
  MclockSig   <= PllMclockSig   when MCLOCK_MULT=TRUE else PllClockSig;
  Mclock90Sig <= PllMclock90Sig when MCLOCK_MULT=TRUE else PllClock90Sig;
  --
  process(resetN, MclockSig) is
  begin
    if(resetN='0') then
      ClockRegN <= '0';
    elsif(MclockSig'event and MclockSig='0') then
      ClockRegN <= ClockSig;
    end if;
  end process;
  --
  process(resetN, MclockSig)
  begin
    if(resetN='0') then
      ClockRegNP     <= '0';
      ClockReg0      <= '0';
      ClockReg1      <= '0';
      StrobeReg      <= '0';
      StrobePosCnt   <= (others => '0');
      StrobeDelReg   <= '0';
      StrobeErrCnt   <= (others => '0');
      StrobeErrNReg1 <= '0';
      StrobeErrNReg2 <= '0';
      StrobeErrNReg  <= '0';
    elsif(MclockSig'event and MclockSig='1') then
      -- strobe8 generation
      ClockRegNP <= ClockRegN;
      ClockReg0  <= ClockRegNP;
      ClockReg1  <= ClockReg0;
      StrobeReg  <= ClockReg0 and not(ClockReg1);
      -- strobe8 delay
      if (StrobeReg = '1') then
        StrobePosCnt <= (others => '0');
      else
        StrobePosCnt <= StrobePosCnt+1;
      end if;
      if (StrobePosCnt=MCLOCK_POS) then
        StrobeDelReg <= '1';
      else
        StrobeDelReg <= '0';
      end if;
      -- strobe8 monitoring
      if (StrobeDelReg = '1') then
        StrobeErrCnt <= (others => '0');
        if (StrobeErrCnt=MCLOCK_CNT_MAX) then
          StrobeErrNReg1 <= '1';
	else
          StrobeErrNReg1 <= '0';
	end if;
        StrobeErrNReg2 <= StrobeErrNReg1;
        StrobeErrNReg  <= StrobeErrNReg1 and StrobeErrNReg2;
      else
        StrobeErrCnt <= StrobeErrCnt+1;
      end if;
    end if;
  end process;
  --
  process(resetN, MclockSig)
  begin
    if(resetN='0') then
      SynchResetReg <= '0';
    elsif(MclockSig'event and MclockSig='1') then
      if (StrobeDelReg='1') then
        SynchResetReg <= '1';
      end if;
    end if;
  end process;
  --
  process(resetN, PllLockSig, pll_unlock_read)
  begin
    if(resetN='0') then
      PllLockHoldReg <= '0';
    elsif (not(PllLockSig)='1') then
      PllLockHoldReg <= '0';
    elsif(pll_unlock_read'event and pll_unlock_read='0') then
      PllLockHoldReg <= '1';
    end if;
  end process;
  --
  process(resetN, StrobeErrNReg, strobe_unlock_read)
  begin
    if(resetN='0') then
      StrobeLockHoldReg <= '0';
    elsif (StrobeErrNReg='0') then
      StrobeLockHoldReg <= '0';
    elsif(strobe_unlock_read'event and strobe_unlock_read='0') then
      StrobeLockHoldReg <= '1';
    end if;
  end process;
  --
  out_clock          <= ClockSig;
  out_clock90        <= Clock90Sig;
  out_mclock         <= MclockSig;
  out_mclock90       <= Mclock90Sig;
  out_strobe         <= StrobeDelReg;
  pll_lock           <= PllLockSig;
  sresetN_out        <= SynchResetReg;
  strobe_lock        <= StrobeErrNReg;
  pll_unlock_hold    <= not(PllLockHoldReg);
  strobe_unlock_hold <= not(StrobeLockHoldReg);
   
end behavioural;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_PROG_COUNTER is
  generic (
    LPM_DATA_SIZE		:natural := 4;
    LPM_COUNT_UP		:boolean := TRUE;
    LPM_COUNT_CONT		:boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena			:in  TSL;
    init			:in  TSL;
    load			:in  TSL;
    data			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
    limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
    count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
    finish			:out TSL
  );
end LPM_PROG_COUNTER;

architecture behaviour of LPM_PROG_COUNTER is

  signal   CountReg		:TSLV(LPM_DATA_SIZE-1 downto 0);
  signal   FinishSig		:TSL;

begin

  FinishSig <= TSLconv(CountReg = limit) when (LPM_COUNT_UP=TRUE) else
               not(OR_REDUCE(CountReg));
  
  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= (others =>'0');
    elsif(load='1') then
      CountReg <= data;
    elsif(clock'event and clock='1') then
      if (clk_ena='1') then
        if (init='1') then
          CountReg <= data;
        else
	  if(LPM_COUNT_UP=TRUE) then
            if (FinishSig='1') then
	      if (LPM_COUNT_CONT=TRUE) then
                CountReg <= (others => '0');
	      else
	        null;
	      end if;
	    else
              CountReg <= CountReg + 1;
	    end if;
	  else
            if (FinishSig='1') then
	      if (LPM_COUNT_CONT=TRUE) then
                CountReg <= limit;
	      else
	        null;
	      end if;
	    else
              CountReg <= CountReg - 1;
	    end if;
	  end if;
	end if;
      end if;
    end if;
  end process;
  
  finish <= FinishSig;
  count  <= CountReg;

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_PROG_TIMER is
  generic (
    LPM_DATA_SIZE		:natural := 40
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena			:in  TSL;
    init			:in  TSL;
    limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
    count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
    stop			:out TSL
  );
end LPM_PROG_TIMER;

architecture behaviour of LPM_PROG_TIMER is

  signal   CountReg		:TSLV(LPM_DATA_SIZE-1 downto 0);
  signal   StopSig		:TSL;

begin

  StopSig <= TSLconv(CountReg = limit);
  
  process(clock, resetN)
  begin
    if(resetN='0') then
      CountReg <= (others =>'0');
    elsif(clock'event and clock='1') then
      if (clk_ena='1') then
        if (init='1') then
          CountReg <= (others =>'0');
        elsif (StopSig='0') then
          CountReg <= CountReg + 1;
	end if;
      end if;
    end if;
  end process;
  
  stop <= StopSig;
  count <= CountReg;

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_MPROG_TIMER is
  generic (
    LPM_DATA_SIZE		:natural := 40;
    LPM_MODULE_SIZE		:natural := 4
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena			:in  TSL;
    init			:in  TSL;
    limit			:in  TSLV(LPM_DATA_SIZE-1 downto 0);
    count			:out TSLV(LPM_DATA_SIZE-1 downto 0);
    stop			:out TSL
  );
end LPM_MPROG_TIMER;

architecture behaviour of LPM_MPROG_TIMER is

  constant MODELES_NUM		:TN := ((LPM_DATA_SIZE-1)/LPM_MODULE_SIZE)+1;
  constant DATA_SIZE		:TN := MODELES_NUM*LPM_MODULE_SIZE;

  signal   CountSig		:TSLV(DATA_SIZE-1 downto 0);
  signal   LimitSig		:TSLV(DATA_SIZE-1 downto 0);

  signal   ModLimitSig		:TSLV(LPM_MODULE_SIZE-1 downto 0);
  signal   ModInitSig		:TSLV(MODELES_NUM-1 downto 0);
  signal   ModClkEnaSig		:TSLV(MODELES_NUM-1 downto 0);
  signal   ModStopSig		:TSLV(MODELES_NUM-1 downto 0);
  signal   StopSig		:TSL;

begin

  LimitSig <= TSLVresize(limit,DATA_SIZE);
  ModLimitSig <= (others => '1');

  ModClkEnaSig(0) <= clk_ena and (not StopSig);
  
  l1:
  for index in 0 to MODELES_NUM-1 generate
    ModInitSig(index) <= ModStopSig(index) or init;
    time_mod		: LPM_PROG_TIMER
      generic map (
        LPM_DATA_SIZE	=> LPM_MODULE_SIZE
      )
      port map (
        resetN		=> resetN,
        clock		=> clock,
        clk_ena		=> ModClkEnaSig(index),
	init		=> ModInitSig(index),
        limit		=> ModLimitSig,
        count		=> CountSig(index*LPM_MODULE_SIZE+LPM_MODULE_SIZE-1 downto index*LPM_MODULE_SIZE),
        stop		=> ModStopSig(index)
      );
  end generate;

  l2:
  for index in 1 to MODELES_NUM-1 generate
    ModClkEnaSig(index) <= AND_REDUCE(ModStopSig(index-1 downto 0)) and ModClkEnaSig(0);
  end generate;

  StopSig <= TSLconv(CountSig=LimitSig);
  stop <= StopSig;

  count <= CountSig(LPM_DATA_SIZE-1 downto 0);

end behaviour;			   

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

entity LPM_PULSE_DELAY is
  generic (
    LPM_DELAY_SIZE		:natural := 4
  );
  port(
    resetN			:in  TSL;
    clock			:in  TSL;
    clk_ena			:in  TSL;
    pulse_in			:in  TSL;
    pulse_out			:out TSL;
    limit			:in  TSLV(LPM_DELAY_SIZE-1 downto 0)
  );
end LPM_PULSE_DELAY;

architecture behaviour of LPM_PULSE_DELAY is

  signal   LimitSig		:TSLV(LPM_DELAY_SIZE-1 downto 0);
  signal   WorkReg		:TSL;
  signal   TimerInitSig		:TSL;
  signal   TimerStopSig		:TSL;

begin

  process(clock, resetN)
  begin
    if(resetN='0') then
      WorkReg <= '0';
    elsif(clock'event and clock='1') then
      if (WorkReg='0' and pulse_in='1') then
        WorkReg <= '1';
      elsif (TimerStopSig='1') then
        WorkReg <= '0';
      end if;
    end if;
  end process;

  LimitSig     <= (others => '0') when limit=0 else (limit - 1);
  TimerInitSig <= not(WorkReg);
  pulse_out    <= pulse_in and clk_ena when limit=0 else TimerStopSig and WorkReg;

  timer			: LPM_PROG_TIMER
    generic map (
      LPM_DATA_SIZE	=> LPM_DELAY_SIZE
    )
    port map (
      resetN		=> resetN,
      clock		=> clock,
      clk_ena		=> clk_ena,
      init		=> TimerInitSig,
      limit		=> LimitSig,
      stop		=> TimerStopSig
    );
end behaviour;


-------------------------------------------------------------------
-- XDPM_PROG_PIPE_PULSE
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity XDPM_PROG_PIPE_PULSE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_PIPE_WIDTH	:in natural := 4;
    constant LPM_MDATA_WIDTH	:in natural := 8;
    constant PIPE_PULSE_SEL1	:in string := "PULSE";
    constant PIPE_PULSE_SEL2	:in string := "PIPE"
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    switch			:in  TSL := '0';
    clk_ena1			:in  TSL := '1';
    init1			:in  TSL := '0';
    break1			:in  TSL := '0';
    finish1			:out TSL;
    pipe_len1			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
    data_in1			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out1			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    sim_loop1			:in  TSL := '0';
    proc_req1			:in  TSL := '0';
    proc_ack1			:out TSL;
    mem_addr1			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in1		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out1		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr1			:in  TSL := '0';
    mem_str1			:in  TSL := '0';
    mem_count1			:out TSLV(LPM_PIPE_WIDTH-1 downto 0);
    clk_ena2			:in  TSL := '1';
    init2			:in  TSL := '0';
    break2			:in  TSL := '0';
    finish2			:out TSL;
    pipe_len2			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
    data_in2			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out2			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    sim_loop2			:in  TSL := '0';
    proc_req2			:in  TSL := '0';
    proc_ack2			:out TSL;
    mem_addr2			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in2		:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out2		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr2			:in  TSL := '0';
    mem_str2			:in  TSL := '0';
    mem_count2			:out TSLV(LPM_PIPE_WIDTH-1 downto 0)
  );
end XDPM_PROG_PIPE_PULSE;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of XDPM_PROG_PIPE_PULSE is

  constant MDATA1_WIDTH		:TN := LPM_MDATA_WIDTH * TNconv(PIPE_PULSE_SEL1="PIPE" or PIPE_PULSE_SEL1="PULSE");
  constant MDATA2_WIDTH		:TN := LPM_MDATA_WIDTH * TNconv(PIPE_PULSE_SEL2="PIPE" or PIPE_PULSE_SEL2="PULSE");
  --
  signal   DataInReg1		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   ProcReqReg1		:TSL;
  signal   ProcAckSig1		:TSL;
  signal   SimLoopSig1		:TSL;
  signal   ClkEnaSig1		:TSL;
  signal   ClkEnaReg1		:TSL;
  signal   InitReg1		:TSL;
  signal   BreakReg1		:TSL;
  signal   FinishReg1		:TSL;
  signal   DataOutSig1		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   Count1		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountReg1		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountDel1		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  --
  signal   DataInReg2		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   ProcReqReg2		:TSL;
  signal   ProcAckSig2		:TSL;
  signal   SimLoopSig2		:TSL;
  signal   ClkEnaSig2		:TSL;
  signal   ClkEnaReg2		:TSL;
  signal   InitReg2		:TSL;
  signal   BreakReg2		:TSL;
  signal   FinishReg2		:TSL;
  signal   DataOutSig2		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   Count2		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountReg2		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountDel2		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  --
  signal   DataInRegA		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   MemEnaSigA		:TSL;
  signal   MemAckSigA		:TSL;
  signal   SimLoopSigA		:TSL;
  signal   ClkEnaSigA		:TSL;
  signal   ClkEnaRegA		:TSL;
  signal   DataOutSigA		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   CountA		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountRegA		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   mem_addrA		:TSLV(mem_addr1'range);
  signal   mem_data_inA		:TSLV(LPM_MDATA_WIDTH-1 downto 0);
  signal   mem_data_outA	:TSLV(LPM_MDATA_WIDTH-1 downto 0);
  signal   mem_wrA		:TSL;
  signal   mem_strA		:TSL;
  --
  signal   DataInRegB		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   MemEnaSigB		:TSL;
  signal   MemAckSigB		:TSL;
  signal   SimLoopSigB		:TSL;
  signal   ClkEnaSigB		:TSL;
  signal   ClkEnaRegB		:TSL;
  signal   DataOutSigB		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   CountB		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   CountRegB		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   mem_addrB		:TSLV(mem_addr2'range);
  signal   mem_data_inB		:TSLV(LPM_MDATA_WIDTH-1 downto 0);
  signal   mem_data_outB	:TSLV(LPM_MDATA_WIDTH-1 downto 0);
  signal   mem_wrB		:TSL;
  signal   mem_strB		:TSL;

begin

  --
  -- module 1
  --
  process(clock, resetN)
  begin
    if(resetN='0') then
      Count1      <= (others => '0');
      CountReg1   <= (others => '0');
      ProcReqReg1 <= '0';
      ClkEnaReg1  <= '0';
      InitReg1    <= '0';
      BreakReg1   <= '0';
      FinishReg1  <= '0';
      CountDel1   <= (others => '0');
    elsif(clock'event and clock='1') then
      ProcReqReg1 <= proc_req1;
      ClkEnaReg1  <= clk_ena1;
      if (PIPE_PULSE_SEL1="PIPE") then
        DataInReg1  <= data_in1;
        if (ProcReqReg1='0' or ProcAckSig1='0') then
          InitReg1   <= '0';
          BreakReg1  <= '0';
          FinishReg1 <= '0';
          CountReg1  <= (others => '0');
          Count1     <= TSLVconv(1,Count1'length);
          FinishReg1 <= '0';
        elsif (InitReg1='0') then
          InitReg1   <= init1;
          BreakReg1  <= break1;
          CountReg1  <= (others => '0');
          Count1     <= TSLVconv(1,Count1'length);
          FinishReg1 <= not(init1) and FinishReg1;
        elsif (ClkEnaReg1='1') then
          BreakReg1 <= break1;
          CountReg1 <= Count1;
          if (Count1=0 or BreakReg1='1') then
            InitReg1   <= init1;
            FinishReg1 <= not(init1);
            CountReg1  <= (others => '0');
            Count1     <= TSLVconv(1,Count1'length);
          elsif (Count1=pipe_len1) then
            Count1 <= (others => '0');
          else
            Count1 <= Count1 + 1;
          end if;
        end if;
        CountDel1 <= CountReg1;
      elsif (PIPE_PULSE_SEL1="PULSE") then
        if (ProcReqReg1='0' or ProcAckSig1='0') then
          InitReg1   <= '0';
          BreakReg1  <= '0';
          FinishReg1 <= '0';
          Count1     <= (others => '0');
        elsif (InitReg1='0') then
          InitReg1   <= init1;
          BreakReg1  <= break1;
          FinishReg1 <= not(init1) and FinishReg1;
          Count1     <= (others => '0');
        elsif (ClkEnaReg1='1') then
          BreakReg1 <= break1;
          if (Count1=pipe_len1 or BreakReg1='1') then
    	    InitReg1   <= init1;
            FinishReg1 <= not(init1);
            Count1     <= (others => '0');
          else
            Count1     <= Count1 + 1;
          end if;
        end if;
        CountDel1 <= Count1;
      end if;
    end if;
  end process;
  --
  ClkEnaSig1  <= ClkEnaReg1 and InitReg1 when (PIPE_PULSE_SEL1="PIPE") else '0';
  SimLoopSig1 <= sim_loop1               when (PIPE_PULSE_SEL1="PIPE") else '1';
  --
  ClkEnaSigA    <= ClkEnaSig1       when switch='0' else ClkEnaSig2;
  CountRegA     <= CountReg1        when switch='0' else CountReg2;
  DataInRegA    <= DataInReg1       when switch='0' else DataInReg2;
  ClkEnaRegA    <= ClkEnaReg1       when switch='0' else ClkEnaReg2;
  CountA        <= Count1           when switch='0' else Count2;
  DataOutSig1   <= DataOutSigA      when switch='0' else DataOutSigB;
  SimLoopSigA   <= SimLoopSig1      when switch='0' else SimLoopSig2;
  MemEnaSigA    <= not(ProcReqReg1) when switch='0' else not(ProcReqReg2);
  ProcAckSig1   <= not(MemAckSigA)  when switch='0' else not(MemAckSigB);
  mem_addrA     <= mem_addr1        when switch='0' else mem_addr2;
  mem_data_inA  <= mem_data_in1     when switch='0' else mem_data_in2;
  mem_data_out1 <= mem_data_outA    when switch='0' else mem_data_outB;
  mem_wrA       <= mem_wr1          when switch='0' else mem_wr2;
  mem_strA      <= mem_str1         when switch='0' else mem_str2;
  --
  mem1: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_PIPE_WIDTH,
      LPM_MDATA_WIDTH	=> MDATA1_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> ClkEnaSigA,
      addr_in		=> CountRegA,
      data_in		=> DataInRegA,
      ena_out		=> ClkEnaRegA,
      addr_out		=> CountA,
      data_out		=> DataOutSigA,
      simulate		=> SimLoopSigA,
      mem_ena		=> MemEnaSigA,
      mem_ena_ack	=> MemAckSigA,
      mem_addr		=> mem_addrA,
      mem_data_in	=> mem_data_inA,
      mem_data_out	=> mem_data_outA,
      mem_wr		=> mem_wrA,
      mem_str		=> mem_strA
  );
  --
  data_out1  <= DataOutSig1;
  proc_ack1  <= ProcAckSig1;
  finish1    <= FinishReg1;
  mem_count1 <= CountDel1;
  --
  -- module 2
  --
  process(clock, resetN)
  begin
    if(resetN='0') then
      Count2      <= (others => '0');
      CountReg2   <= (others => '0');
      ProcReqReg2 <= '0';
      ClkEnaReg2  <= '0';
      InitReg2    <= '0';
      BreakReg2   <= '0';
      FinishReg2  <= '0';
      CountDel2   <= (others => '0');
    elsif(clock'event and clock='1') then
      ProcReqReg2 <= proc_req2;
      ClkEnaReg2  <= clk_ena2;
      if (PIPE_PULSE_SEL2="PIPE") then
        DataInReg2  <= data_in2;
        if (ProcReqReg2='0' or ProcAckSig2='0') then
          InitReg2   <= '0';
          BreakReg2  <= '0';
          FinishReg2 <= '0';
          CountReg2  <= (others => '0');
          Count2     <= TSLVconv(1,Count2'length);
          FinishReg2 <= '0';
        elsif (InitReg2='0') then
          InitReg2   <= init2;
          BreakReg2  <= break2;
          CountReg2  <= (others => '0');
          Count2     <= TSLVconv(1,Count2'length);
          FinishReg2 <= not(init2) and FinishReg2;
        elsif (ClkEnaReg2='1') then
          BreakReg2 <= break2;
          CountReg2 <= Count2;
          if (Count2=0 or BreakReg2='1') then
            InitReg2   <= init2;
            FinishReg2 <= not(init2);
            CountReg2  <= (others => '0');
            Count2     <= TSLVconv(1,Count2'length);
          elsif (Count2=pipe_len2) then
            Count2 <= (others => '0');
          else
            Count2 <= Count2 + 1;
          end if;
        end if;
        CountDel2 <= CountReg2;
      elsif (PIPE_PULSE_SEL2="PULSE") then
        if (ProcReqReg2='0' or ProcAckSig2='0') then
          InitReg2   <= '0';
          BreakReg2  <= '0';
          FinishReg2 <= '0';
          Count2     <= (others => '0');
        elsif (InitReg2='0') then
          InitReg2   <= init2;
          BreakReg2  <= break2;
          FinishReg2 <= not(init2) and FinishReg2;
          Count2     <= (others => '0');
        elsif (ClkEnaReg2='1') then
          BreakReg2 <= break2;
          if (Count2=pipe_len2 or BreakReg2='1') then
    	    InitReg2   <= init2;
            FinishReg2 <= not(init2);
            Count2     <= (others => '0');
          else
            Count2     <= Count2 + 1;
          end if;
        end if;
        CountDel2 <= Count2;
      end if;
    end if;
  end process;
  --
  ClkEnaSig2  <= ClkEnaReg2 when (PIPE_PULSE_SEL2="PIPE") else '0';
  SimLoopSig2 <= sim_loop2  when (PIPE_PULSE_SEL2="PIPE") else '1';
  --
  ClkEnaSigB    <= ClkEnaSig2       when switch='0' else ClkEnaSig1;
  CountRegB     <= CountReg2        when switch='0' else CountReg1;
  DataInRegB    <= DataInReg2       when switch='0' else DataInReg1;
  ClkEnaRegB    <= ClkEnaReg2       when switch='0' else ClkEnaReg1;
  CountB        <= Count2           when switch='0' else Count1;
  DataOutSig2   <= DataOutSigB      when switch='0' else DataOutSigA;
  SimLoopSigB   <= SimLoopSig2      when switch='0' else SimLoopSig1;
  MemEnaSigB    <= not(ProcReqReg2) when switch='0' else not(ProcReqReg1);
  ProcAckSig2   <= not(MemAckSigB)  when switch='0' else not(MemAckSigA);
  mem_addrB     <= mem_addr2        when switch='0' else mem_addr1;
  mem_data_inB  <= mem_data_in2     when switch='0' else mem_data_in1;
  mem_data_out2 <= mem_data_outB    when switch='0' else mem_data_outA;
  mem_wrB       <= mem_wr2          when switch='0' else mem_wr1;
  mem_strB      <= mem_str2         when switch='0' else mem_str1;
  --
  mem2: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_PIPE_WIDTH,
      LPM_MDATA_WIDTH	=> MDATA2_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> ClkEnaSigB,
      addr_in		=> CountRegB,
      data_in		=> DataInRegB,
      ena_out		=> ClkEnaRegB,
      addr_out		=> CountB,
      data_out		=> DataOutSigB,
      simulate		=> SimLoopSigB,
      mem_ena		=> MemEnaSigB,
      mem_ena_ack	=> MemAckSigB,
      mem_addr		=> mem_addrB,
      mem_data_in	=> mem_data_inB,
      mem_data_out	=> mem_data_outB,
      mem_wr		=> mem_wrB,
      mem_str		=> mem_strB
  );
  --
  data_out2  <= DataOutSig2;
  proc_ack2  <= ProcAckSig2;
  finish2    <= FinishReg2;
  mem_count2 <= CountDel2;

end behaviour;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity DPM_PROG_PIPE_PULSE is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_PIPE_WIDTH	:in natural := 4;
    constant LPM_MDATA_WIDTH	:in natural := 8;
    constant PIPE_PULSE_SEL	:in string := "PIPE"
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    init			:in  TSL := '0';
    break			:in  TSL := '0';
    finish			:out TSL;
    pipe_len			:in  TSLV(LPM_PIPE_WIDTH-1 downto 0);
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    sim_loop			:in  TSL := '0';
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(LPM_PIPE_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0';
    mem_count			:out TSLV(LPM_PIPE_WIDTH-1 downto 0)
  );
end DPM_PROG_PIPE_PULSE;


library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.LPMComponent.all;

architecture behaviour of DPM_PROG_PIPE_PULSE is

  signal   pipe_len0		:TSLV(LPM_PIPE_WIDTH-1 downto 0);
  signal   data_in0		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   mem_addr0		:TSLV(mem_addr'length-1 downto 0);
  signal   mem_data_in0		:TSLV(LPM_MDATA_WIDTH-1 downto 0);

begin

  pipe_len0    <= (others =>'0');
  data_in0     <= (others =>'0');
  mem_addr0    <= (others =>'0');
  mem_data_in0 <= (others =>'0');
  --
  xdpm_comp: XDPM_PROG_PIPE_PULSE
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH, 
      LPM_PIPE_WIDTH	=> LPM_PIPE_WIDTH, 
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      PIPE_PULSE_SEL1	=> PIPE_PULSE_SEL,
      PIPE_PULSE_SEL2	=> "PIPE"
    )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      clk_ena1		=> clk_ena,
      switch		=> '0',
      init1		=> init,
      break1		=> break,
      finish1		=> finish,
      pipe_len1		=> pipe_len,
      data_in1		=> data_in,
      data_out1		=> data_out,
      sim_loop1		=> sim_loop,
      proc_req1		=> proc_req,
      proc_ack1		=> proc_ack,
      mem_addr1		=> mem_addr,
      mem_data_in1	=> mem_data_in,
      mem_data_out1	=> mem_data_out,
      mem_wr1		=> mem_wr,
      mem_str1		=> mem_str,
      clk_ena2		=> '0',
      init2		=> '0',
      break2		=> '0',
      finish2		=> open,
      pipe_len2		=> pipe_len0,
      data_in2		=> data_in0,
      data_out2		=> open,
      sim_loop2		=> '0',
      proc_req2		=> '0',
      proc_ack2		=> open,
      mem_addr2		=> mem_addr0,
      mem_data_in2	=> mem_data_in0,
      mem_data_out2	=> open,
      mem_wr2		=> '0',
      mem_str2		=> '0'
    );

end behaviour;
