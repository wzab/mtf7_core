-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2005 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

package LPMDiagnostics is

  component LPM_HIST is
    generic (
      constant LPM_DATA_WIDTH		:natural := 0; -- szer szyny adresowej
      constant LPM_COUNT_WIDTH		:natural := 0; -- szer szyny danych
      constant LPM_MDATA_WIDTH		:natural := 0; -- szer szyny danych
      constant INIT_CLEAR_ENA		:boolean := TRUE
    );
    port(
      resetN				:in  TSL := '0';
      clock				:in  TSL := '1';
      data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);  --dane wchodzace do ukladu i podlegajace histogramowaniu
      data_ena				:in  TSL := '1';
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_address			:in  TSLV(LPM_DATA_WIDTH+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
      mem_data_in			:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_wr				:in  TSL;
      mem_str				:in  TSL
  );
  end component;


  component LPM_RATE is
    generic(
      constant LPM_DATA_WIDTH		:integer := 0;
      constant LPM_COUNT_WIDTH		:integer := 0;
      constant LPM_MDATA_WIDTH		:natural := 0;
      constant INIT_CLEAR_ENA		:boolean := TRUE
    );
    port (
      resetN				:in  TSL := '0';
      clock				:in  TSL := '1';
      data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
      data_ena				:in  TSL := '1';
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_address			:in  TSLV(TVLcreate(LPM_DATA_WIDTH-1)+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
      mem_data_in			:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_wr				:in  TSL;     
      mem_str				:in  TSL     
    );
  end component; 

  component LPM_MRATE is
    generic(
      constant LPM_DATA_WIDTH		:integer := 0;
      constant LPM_COUNT_WIDTH		:integer := 0;
      constant LPM_PART_BITS		:integer := 0;
      constant LPM_MDATA_WIDTH		:natural := 0
    );
    port (
      resetN				:in  TSL := '0';
      clock				:in  TSL := '1';
      data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
      data_ena				:in  TSL := '1';
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_address			:in  TSLV(TVLcreate(LPM_DATA_WIDTH-1)+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
      mem_data_in			:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
      mem_wr				:in  TSL;     
      mem_str				:in  TSL     
    );
  end component; 

  function DIAG_DAQ_MemDataWidth (data,trg,mask :TN) return TN;
  function DIAG_DAQ_MemAddrWidth (data,trg,mask,abus,dbus :TN) return TN;

  component LPM_DIAG_DAQ is
    generic (
      constant LPM_DATA_WIDTH		:in natural := 0;
      constant LPM_TRIG_NUM		:in natural := 0;
      constant LPM_TIME_WIDTH		:in natural := 0;
      constant LPM_MASK_WIDTH		:in natural := 0;
      constant LPM_ADDR_WIDTH		:in natural := 0;
      constant LPM_MDATA_WIDTH		:in natural := 0;
      constant DATA_REGISTERED		:in boolean := FALSE;
      constant TIME_REGISTERED		:in boolean := FALSE;
      constant TRIG_REGISTERED		:in boolean := FALSE
  );
    port(
      resetN				:in  TSL := '0';
      clock				:in  TSL := '0';
      data_ena				:in  TSL;
      data				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      trig_ena				:in  TSL := '1';
      trig				:in  TSLV(LPM_TRIG_NUM-1 downto 0);
      time				:in  TSLV(LPM_TIME_WIDTH-1 downto 0);
      mask				:in  TSLV(LPM_MASK_WIDTH*LPM_TRIG_NUM-1 downto 0);
      empty_str				:in  TSL := '0';
      empty				:out TSL;
      empty_ack				:out TSL;
      lost_data_str			:in  TSL := '0';
      lost_data				:out TSL;
      lost_data_ack			:out TSL;
      wr_addr_str			:in  TSL := '0';
      wr_addr				:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      wr_addr_ack			:out TSL;
      rd_addr_str			:in  TSL := '0';
      rd_addr_ena			:in  TSL := '0';
      rd_addr				:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_test_str			:in  TSL;
      rd_addr_test			:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_test_ack			:out TSL;
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_addr				:in  TSLV(DIAG_DAQ_MemAddrWidth(LPM_DATA_WIDTH,
									LPM_TRIG_NUM,
									LPM_MASK_WIDTH,
									LPM_ADDR_WIDTH,
									LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out			:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr				:in  TSL := '0';
      mem_str				:in  TSL := '0'
    );
  end component;

  component LPM_DIAG_DAQ1 is
    generic (
      constant LPM_DATA_WIDTH		:in natural := 4;
      constant LPM_TRIG_NUM		:in natural := 4;
      constant LPM_TIME_WIDTH		:in natural := 8;
      constant LPM_MASK_WIDTH		:in natural := 8;
      constant LPM_ADDR_WIDTH		:in natural := 5;
      constant LPM_MDATA_WIDTH		:in natural := 12;
      constant DATA_REGISTERED		:in boolean := TRUE;
      constant TIME_REGISTERED		:in boolean := TRUE;
      constant TRIG_REGISTERED		:in boolean := TRUE
    
    );
    port(
      resetN				:in  TSL := '1';
      clock				:in  TSL := '0';
      strobeN				:in  TSL := '1';
      data_ena				:in  TSL;
      data				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      trig_ena				:in  TSL := '1';
      trig				:in  TSLV(LPM_TRIG_NUM-1 downto 0);
      time				:in  TSLV(LPM_TIME_WIDTH-1 downto 0);
      mask				:in  TSLV(LPM_MASK_WIDTH*LPM_TRIG_NUM-1 downto 0);
      empty_ren				:in  TSL := '0';
      empty				:out TSL;
      empty_ack				:out TSL;
      lost_data_ren			:in  TSL := '0';
      lost_data				:out TSL;
      lost_data_ack			:out TSL;
      wr_addr_ren			:in  TSL := '0';
      wr_addr				:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      wr_addr_ack			:out TSL;
      rd_addr_wen			:in  TSL := '0';
      rd_addr				:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_test_ren			:in  TSL;
      rd_addr_test			:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
      rd_addr_test_ack			:out TSL;
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_addr				:in  TSLV(DIAG_DAQ_MemAddrWidth(LPM_DATA_WIDTH,
									LPM_TRIG_NUM,
									LPM_MASK_WIDTH,
									LPM_ADDR_WIDTH,
									LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out			:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wen				:in  TSL := '0'
    );
  end component;

  component LPM_DAQ_FLASH is
    generic (
      constant LPM_DATA_WIDTH		:in natural := 0;
      constant LPM_BUFOR_WIDTH		:in natural := 0;
      constant LPM_MDATA_WIDTH		:in natural := 0
    );
    port(
      resetN				:in  TSL := '0';
      clock				:in  TSL := '0';
      clk_ena				:in  TSL := '1';
      data_in				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      bufor_len				:in  TSLV(LPM_BUFOR_WIDTH-1 downto 0);
      trigger				:in  TSL;
      empty_skip			:in  TSL;
      ready				:out TSL;
      sim_loop				:in  TSL := '0';
      proc_req				:in  TSL := '0';
      proc_ack				:out TSL;
      mem_addr				:in  TSLV(LPM_BUFOR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
      mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_data_out			:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
      mem_wr				:in  TSL := '0';
      mem_str				:in  TSL := '0'
    );
  end component;

end LPMDiagnostics;

package body LPMDiagnostics is

  function DIAG_DAQ_MemDataWidth (data,trg,mask :TN) return TN is
  begin
    return(TVLcreate(mask)+trg+data);
  end function;

--------------------------------------------------------------------------
  function DIAG_DAQ_MemAddrWidth (data,trg,mask,abus,dbus :TN) return TN is
  begin
    return(abus+SLVPartAddrExpand(DIAG_DAQ_MemDataWidth(data,trg,mask),dbus));
  end function;

end LPMDiagnostics;

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity LPM_HIST is
  generic (
    constant LPM_DATA_WIDTH		:natural := 4;
    constant LPM_COUNT_WIDTH		:natural := 8;
    constant LPM_MDATA_WIDTH		:natural := 8;
    constant INIT_CLEAR_ENA		:boolean := TRUE
  );
  port(
    resetN				:in  TSL := '0';
    clock				:in  TSL;
    data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    data_ena				:in  TSL;
    sim_loop				:in  TSL := '0';
    proc_req				:in  TSL;
    proc_ack				:out TSL;
    mem_address				:in  TSLV(LPM_DATA_WIDTH+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
    mem_data_in				:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_wr				:in  TSL;
    mem_str				:in  TSL
);
end LPM_HIST;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
--use work.VComponent.all;
use work.LPMComp_UniTechType.all;
use work.LPMComponent.all;
 
architecture behaviour of LPM_HIST is

  signal H				:TSL;
  signal DataEnaInReg			:TSL;
  signal DataInReg			:TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
  signal DataEnaBufReg			:TSL;
  signal DataBufReg			:TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
  signal HistCountSig			:TSLV(LPM_COUNT_WIDTH-1 DOWNTO 0);
  signal HistCountIncSig		:TSLV(LPM_COUNT_WIDTH-1 DOWNTO 0);
  signal ProcReqReg			:TSL;
  signal ProcWorkReg			:TSL;
  signal ProcAckReg			:TSL;
  signal MemEnaReg			:TSL;
  signal MemAckSig			:TSL;

begin

  H <= '1';

  process(clock,resetN)
  begin
    if (resetN = '0') then
      DataEnaInReg  <= '0';
      DataEnaBufReg <= '0';
      DataInReg     <= (others =>'0');
      DataBufReg    <= (others =>'0');
      ProcReqReg    <= '0';
      ProcWorkReg   <= '0';
      MemEnaReg     <= '0';
      ProcAckReg    <= '0';
    elsif (clock'event and clock='1') then
      --
      -- Data input registers
      DataInReg    <= data;
      DataEnaInReg <= data_ena;
      --
      -- process control
      ProcReqReg <= proc_req;
      if (ProcReqReg='1') then
         MemEnaReg   <= '0';
	 ProcWorkReg <= not(MemAckSig);
	 ProcAckReg  <= ProcWorkReg;
      else
	 ProcWorkReg <= '0';
         MemEnaReg   <= not(ProcWorkReg);
	 ProcAckReg  <= not(MemAckSig);
      end if;
      --
      -- Data buffer registers
      DataBufReg    <= DataInReg;
      DataEnaBufReg <= DataEnaInReg;
    end if;
  end process;

  HistCountIncSig <= HistCountSig+1 when (AND_REDUCE(HistCountSig)='0') else
                     (others => '1');

  mem: DPM_PROG 
    generic map(
      LPM_DATA_WIDTH   => LPM_COUNT_WIDTH,
      LPM_ADDR_WIDTH   => LPM_DATA_WIDTH,
      LPM_MDATA_WIDTH  => LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE => TRUE,
      INIT_CLEAR_ENA   => INIT_CLEAR_ENA
   )
    port map(
      resetN          => resetN,
      clk             => clock,
      ena_in          => DataEnaBufReg,
      addr_in         => DataBufReg,
      data_in         => HistCountIncSig,
      ena_out         => H,
      addr_out        => DataInReg,
      data_out        => HistCountSig,
      simulate        => sim_loop,
      mem_ena         => MemEnaReg,
      mem_ena_ack     => MemAckSig,
      mem_addr        => mem_address,
      mem_data_in     => mem_data_in,
      mem_data_out    => mem_data_out,
      mem_wr          => mem_wr,
      mem_str         => mem_str
    );
    
  proc_ack <= ProcAckReg;  
    
end behaviour;

--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_1164.all;	
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
--use work.VComponent.all;
use work.LPMComponent.all;


entity RATE_SHORT_CNT is
  generic(
    constant LPM_DATA_WIDTH		: integer :=8
  );
  port (
    resetN				:in  TSL;
    clock				:in  TSL;
    data_in				:in  TSL;
    set					:in  TSL;
    data_out				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end RATE_SHORT_CNT;

architecture behaviour of RATE_SHORT_CNT is
 signal CountReg			:TSLV(LPM_DATA_WIDTH-1 downto 0);
begin
  process(resetN, clock) is
  begin
    if (resetN='0') then
      CountReg <= (others =>'0'); 
    elsif clock'event and clock='1' then
      if set='1' then
        if (data_in='1') then
          CountReg <= TSLVconv(1,LPM_DATA_WIDTH);
	else
          CountReg <= (others =>'0');
	end if;
      elsif (data_in='1') then
        CountReg <= CountReg+1;
      end if;
    end if;
  end process;
  data_out <= CountReg;
end behaviour; 


--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity LPM_RATE is
  generic(
    LPM_DATA_WIDTH			:integer :=   4;
    LPM_COUNT_WIDTH			:integer :=   4;
    LPM_MDATA_WIDTH			:natural :=   4;
    INIT_CLEAR_ENA			:boolean := TRUE
  );
  port (
    resetN				:in  TSL := '0';
    clock				:in  TSL := '1';
    data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    data_ena				:in  TSL := '1';
    sim_loop				:in  TSL := '0';
    proc_req				:in  TSL := '0';
    proc_ack				:out TSL;
    mem_address				:in  TSLV(TVLcreate(LPM_DATA_WIDTH-1)+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
    mem_data_in				:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_wr				:in  TSL;
    mem_str				:in  TSL
  );
end LPM_RATE; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
--use work.VComponent.all;
use work.LPMComp_UniTechType.all;
use work.LPMComponent.all;

architecture behaviour of LPM_RATE is

  component RATE_SHORT_CNT
    generic (
      constant LPM_DATA_WIDTH		: integer :=0
    );
    port (
      resetN				:in  TSL;
      clock				:in  TSL;
      data_in				:in  TSL;
      set				:in  TSL;
      data_out				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  constant DATA_ADDR_SIZE		:TN  := TVLcreate(LPM_DATA_WIDTH-1);
  constant CNT_DATA_SIZE		:TN  := TVLcreate(LPM_DATA_WIDTH);
  constant MEM_ADDR_SIZE		:TN  := DATA_ADDR_SIZE+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH);
  
  subtype  TShortCount			is TSLV(CNT_DATA_SIZE-1 downto 0);
  type	   TShortCountVec		is array (LPM_DATA_WIDTH-1 downto 0) of TShortCount;
  
  signal   H				:TSL;
  signal   DataInEnaReg			:TSL;
  signal   DataInReg			:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   DataInSig			:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   ShortCountVec		:TShortCountVec;
  signal   ShortCountPipe		:TShortCountVec;
  signal   CountSel			:TSLV(DATA_ADDR_SIZE-1 downto 0);
  signal   CountSelReg			:TSLV(DATA_ADDR_SIZE-1 downto 0);
  signal   AddrOutSig			:TSLV(DATA_ADDR_SIZE-1 downto 0);
  signal   SetCountReg			:TSL;
  signal   RateDataSig       		:TSLV(LPM_COUNT_WIDTH-1 downto 0);
  signal   RateDataAddSig      		:TSLV(LPM_COUNT_WIDTH-1 downto 0);
  signal   ProcReqReg			:TSL;
  signal   ProcWorkReg			:TSL;
  signal   ProcWorkReg1			:TSL; --!!180604 additional delay
  signal   ProcAckReg			:TSL;
  signal   MemEnaReg			:TSL;
  signal   MemAckSig			:TSL;

begin

  H <= '1';
  
  process(clock,resetN)
  begin
    if (resetN = '0') then
      DataInEnaReg   <= '0';
      DataInReg      <= (others => '0');
      ShortCountPipe <= (ShortCountVec'range => (others => '0'));
      CountSel	     <= (others => '0');
      CountSelReg    <= (others => '0');
      SetCountReg    <= '0';
      ProcReqReg     <= '0';
      ProcWorkReg    <= '0';
      ProcWorkReg1   <= '0';
      MemEnaReg      <= '0';
      ProcAckReg     <= '0';
    elsif (clock'event and clock='1') then
      --
      -- Data input registers
      DataInEnaReg   <= data_ena;
      DataInReg      <= data;
      --
      -- process control
      ProcReqReg <= proc_req;
      if (ProcReqReg='1') then
         MemEnaReg    <= '0';
	 ProcWorkReg  <= not(MemAckSig);
	 ProcWorkReg1 <= ProcWorkReg;
	 ProcAckReg   <= ProcWorkReg;
      else
	 ProcWorkReg  <= not(SetCountReg) and ProcWorkReg;
	 ProcWorkReg1 <= not(SetCountReg) and ProcWorkReg;
         MemEnaReg    <= not(ProcWorkReg);
	 ProcAckReg   <= not(MemAckSig);
      end if;
      if (ProcWorkReg='1') then
        --
        -- address drivers
        if (CountSel=LPM_DATA_WIDTH-1) then
          CountSel    <= (others => '0');
      	  CountSelReg <= TSLVconv(LPM_DATA_WIDTH-1,CountSelReg'length);
      	  SetCountReg <= '1';
        else
          CountSel    <= CountSel+1;
          CountSelReg <= CountSel;
      	  SetCountReg <= '0';
        end if;
        --
        -- counter data pipeline
        if (SetCountReg='1') then
          ShortCountPipe <= ShortCountVec;
        else
          ShortCountPipe(LPM_DATA_WIDTH-2 downto 0) <= ShortCountPipe(LPM_DATA_WIDTH-1 downto 1);
        end if;
      end if;
    end if;
  end process;
  --
  -- short counters
  DataInSig <= DataInReg when (DataInEnaReg='1' and ProcReqReg='1' and ProcAckReg='1') else
               (others => '0');
  cnt_loop: for index in 0 to LPM_DATA_WIDTH-1 generate
    ShortCount: RATE_SHORT_CNT
      generic map(
        LPM_DATA_WIDTH => CNT_DATA_SIZE
      )
      port map (
        resetN         => resetN,
        clock          => clock,
        data_in        => DataInSig(index),
        set            => SetCountReg,
        data_out       => ShortCountVec(index)
      );
  end generate;
  --
  RateDataAddSig <= RateDataSig+ShortCountPipe(0) when ((not(RateDataSig))>ShortCountPipe(0)) else
                    (others =>'1');
  --!!180604 AddrOutSig     <= CountSel when ProcWorkReg='1' else CountSelReg;--!!120604
  --
  mem: DPM_PROG 
    generic map(
      LPM_DATA_WIDTH   => LPM_COUNT_WIDTH,
      LPM_ADDR_WIDTH   => DATA_ADDR_SIZE,
      LPM_MDATA_WIDTH  => LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE => FALSE,
      INIT_CLEAR_ENA   => INIT_CLEAR_ENA
    )
    port map(
      resetN          => resetN,
      clk             => clock,
      ena_in          => ProcWorkReg1, --!!180604 ProcWorkReg,
      addr_in         => CountSelReg,
      data_in         => RateDataAddSig,
      ena_out         => ProcWorkReg,--!!180604 H,--!!120604 ProcWorkReg,
      addr_out        => CountSel,--!!180604 AddrOutSig,--!!120604 CountSel,
      data_out        => RateDataSig,
      simulate        => sim_loop,
      mem_ena         => MemEnaReg,
      mem_ena_ack     => MemAckSig ,
      mem_addr        => mem_address,
      mem_data_in     => mem_data_in,
      mem_data_out    => mem_data_out,
      mem_wr          => mem_wr,
      mem_str         => mem_str
    ); 
  --  
  proc_ack <= ProcAckReg;
  
end behaviour;

--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMDiagnostics.all;


entity LPM_MRATE is
  generic(
    LPM_DATA_WIDTH			:integer :=   11;
    LPM_COUNT_WIDTH			:integer :=   8;
    LPM_PART_BITS			:integer :=   2;
    LPM_MDATA_WIDTH			:natural :=   4
  );
  port (
    resetN				:in  TSL := '0';
    clock				:in  TSL := '1';
    data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    data_ena				:in  TSL := '1';
    sim_loop				:in  TSL := '0';
    proc_req				:in  TSL := '0';
    proc_ack				:out TSL;
    mem_address				:in  TSLV(TVLcreate(LPM_DATA_WIDTH-1)+SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH)-1 DOWNTO 0);
    mem_data_in				:in  TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_data_out			:out TSLV (LPM_MDATA_WIDTH-1 DOWNTO 0);
    mem_wr				:in  TSL;
    mem_str				:in  TSL
  );
end LPM_MRATE; 

architecture behaviour of LPM_MRATE is
  constant II_PART_SIZE    :TN  := SLVPartAddrExpand(LPM_COUNT_WIDTH,LPM_MDATA_WIDTH);
  constant PART_WIDTH      :TVL := minimum(pow2(LPM_PART_BITS),LPM_DATA_WIDTH);
  constant PART_NUM        :TP  := SLVPartNum(LPM_DATA_WIDTH,PART_WIDTH);
  constant LPART_WIDTH     :TVL := SLVPartLastSize(LPM_DATA_WIDTH,PART_WIDTH);
  constant PART_SIZE	   :TVL := TVLcreate(PART_WIDTH-1);
  constant LPART_SIZE	   :TVL := TVLcreate(LPART_WIDTH-1);
  type     TMemDataOut     is array (0 to PART_NUM-1) of TSLV(LPM_MDATA_WIDTH-1 DOWNTO 0);
  --
  signal   PartNumSig      :TN;
  signal   ProcAckSig      :TSLV(PART_NUM-1 downto 0);
  signal   MemPartAddrSig  :TSLV(II_PART_SIZE+PART_SIZE-1 downto 0);
  signal   MemLPartAddrSig :TSLV(II_PART_SIZE+LPART_SIZE-1 downto 0);
  signal   MemDataOutSig   :TMemDataOut;
  signal   MemStrSig       :TSLV(PART_NUM-1 downto 0);
begin

  single:
  if PART_NUM=1 generate
    srate :LPM_RATE
      generic map (
        LPM_DATA_WIDTH  => LPM_DATA_WIDTH,
        LPM_COUNT_WIDTH => LPM_COUNT_WIDTH,
        LPM_MDATA_WIDTH => LPM_MDATA_WIDTH
      )
      port map (
        resetN          => resetN,
        clock           => clock,
        data            => data,
        data_ena        => data_ena,
        sim_loop        => sim_loop,
        proc_req        => proc_req,
        proc_ack        => proc_ack,
        mem_address     => mem_address,
        mem_data_in     => mem_data_in,
        mem_data_out    => mem_data_out,
        mem_wr          => mem_wr,
        mem_str         => mem_str
      );
  end generate;

  multi:
  if PART_NUM>1 generate
    --
    ii_single:
    if (II_PART_SIZE=0) generate
      MemPartAddrSig  <= mem_address(PART_SIZE-1 downto 0);
      MemLPartAddrSig <= mem_address(LPART_SIZE-1 downto 0);
    end generate;
    --
    ii_multi:
    if (II_PART_SIZE>0) generate
      MemPartAddrSig  <=   mem_address(mem_address'length-1 downto mem_address'length-II_PART_SIZE)
                         & mem_address(PART_SIZE-1 downto 0);
      MemLPartAddrSig <=   mem_address(mem_address'length-1 downto mem_address'length-II_PART_SIZE)
                         & mem_address(LPART_SIZE-1 downto 0);
    end generate;
    --
    PartNumSig <= TNconv(mem_address(mem_address'length-II_PART_SIZE-1 downto PART_SIZE));
    --
    part_loop:
    for index in 0 to PART_NUM-2 generate
      MemStrSig(index) <= TSLconv(PartNumSig=index) and mem_str;
      mrate_loop :LPM_RATE
        generic map (
          LPM_DATA_WIDTH  => PART_WIDTH,
          LPM_COUNT_WIDTH => LPM_COUNT_WIDTH,
          LPM_MDATA_WIDTH => LPM_MDATA_WIDTH
        )
        port map (
          resetN          => resetN,
          clock           => clock,
          data            => data((index+1)*PART_WIDTH-1 downto index*PART_WIDTH),
          data_ena        => data_ena,
          sim_loop        => sim_loop,
          proc_req        => proc_req,
          proc_ack        => ProcAckSig(index),
          mem_address     => MemPartAddrSig,
          mem_data_in     => mem_data_in,
          mem_data_out    => MemDataOutSig(index),
          mem_wr          => mem_wr,
          mem_str         => MemStrSig(index)
        );
    end generate;
    --
    MemStrSig(PART_NUM-1) <= TSLconv(PartNumSig=PART_NUM-1) and mem_str;
    mrate_last :LPM_RATE
      generic map (
        LPM_DATA_WIDTH  => LPART_WIDTH,
        LPM_COUNT_WIDTH => LPM_COUNT_WIDTH,
        LPM_MDATA_WIDTH => LPM_MDATA_WIDTH
      )
      port map (
        resetN          => resetN,
        clock           => clock,
        data            => data(data'length-1 downto data'length-LPART_WIDTH),
        data_ena        => data_ena,
        sim_loop        => sim_loop,
        proc_req        => proc_req,
        proc_ack        => ProcAckSig(PART_NUM-1),
        mem_address     => MemLPartAddrSig,
        mem_data_in     => mem_data_in,
        mem_data_out    => MemDataOutSig(PART_NUM-1),
        mem_wr          => mem_wr,
        mem_str         => MemStrSig(PART_NUM-1)
      );
    --
    proc_ack <= AND_REDUCE(ProcAckSig);
    process (PartNumSig,MemDataOutSig) begin
      mem_data_out <= (others =>'0');
      for part_inx in 0 to PART_NUM-1 loop
        if (PartNumSig=part_inx) then
          mem_data_out <= MemDataOutSig(part_inx);
	end if;
      end loop;
    end process;
  end generate;
end behaviour;

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMDiagnostics.all;

entity LPM_DIAG_DAQ is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 4;
    constant LPM_TRIG_NUM	:in natural := 4;
    constant LPM_TIME_WIDTH	:in natural := 8;
    constant LPM_MASK_WIDTH	:in natural := 8;
    constant LPM_ADDR_WIDTH	:in natural := 5;
    constant LPM_MDATA_WIDTH	:in natural := 12;
    constant DATA_REGISTERED	:in boolean := TRUE;
    constant TIME_REGISTERED	:in boolean := TRUE;
    constant TRIG_REGISTERED	:in boolean := TRUE

  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    data_ena			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    trig_ena			:in  TSL := '1';
    trig			:in  TSLV(LPM_TRIG_NUM-1 downto 0);
    time			:in  TSLV(LPM_TIME_WIDTH-1 downto 0);
    mask			:in  TSLV(LPM_MASK_WIDTH*LPM_TRIG_NUM-1 downto 0);
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
    mem_addr			:in  TSLV(DIAG_DAQ_MemAddrWidth(LPM_DATA_WIDTH,LPM_TRIG_NUM,LPM_MASK_WIDTH,LPM_ADDR_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0'
  );
end LPM_DIAG_DAQ;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;
use work.KTPComponent.all;

architecture behaviour of LPM_DIAG_DAQ is

  constant TIME_PARTS_NUM 	:TP  := SLVPartNum(LPM_TIME_WIDTH,LPM_DATA_WIDTH);
  constant POS_COUNT_SIZE	:TVL := TVLcreate(LPM_MASK_WIDTH);
  constant MEM_DATA_WIDTH 	:TVL := POS_COUNT_SIZE+LPM_TRIG_NUM+LPM_DATA_WIDTH;
  
  subtype  TFifoData		is TSLV(MEM_DATA_WIDTH-1 downto 0);
  type     TFifoDataPipe	is array (TIME_PARTS_NUM downto 0) of TFifoData;
  
  signal   DataEnaReg		:TSL;
  signal   DataInReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   TrigEnaReg		:TSL;
  signal   TrigInReg		:TSLV(LPM_TRIG_NUM-1 downto 0);
  signal   TrigInSig		:TSLV(LPM_TRIG_NUM-1 downto 0);
  signal   TrigInOrSig		:TSL;
  signal   TimeInReg		:TSLV(LPM_TIME_WIDTH-1 downto 0);
  signal   FifoDataPipe		:TFifoDataPipe;
  signal   FifoDataEnaPipe	:TSLV(TIME_PARTS_NUM downto 0);
  signal   CommMask		:TSLV(LPM_MASK_WIDTH-1 downto 0);
  signal   PosCnt		:TSLV(POS_COUNT_SIZE-1 downto 0);
  signal   BufEmptySig		:TSL;
  signal   DataEmptySig		:TSL;
  signal   FifoFullSig		:TSL;
  signal   ProcReqReg		:TSL;
  signal   ProcAckReg		:TSL;  
  signal   ProcAckFifoSig	:TSL;

begin

  process (clock, resetN, data_ena, data)
  begin
    if (DATA_REGISTERED=TRUE and resetN='0') then
      DataEnaReg <= '0';
      DataInReg	 <= (others => '0');
    elsif (DATA_REGISTERED=FALSE or (clock'event and clock='1')) then
      DataEnaReg <= data_ena;
      DataInReg  <= data;
    end if;
  end process;
  --
  process (clock, resetN, time)
  begin
    if (TIME_REGISTERED=TRUE and resetN='0') then
      TimeInReg	 <= (others => '0');
    elsif (TIME_REGISTERED=FALSE or (clock'event and clock='1')) then
      TimeInReg	 <= time;
    end if;
  end process;
  --
  process (clock, resetN, trig_ena, trig)
  begin
    if (TRIG_REGISTERED=TRUE and resetN='0') then
      TrigEnaReg <= '0';
      TrigInReg	 <= (others => '0');
    elsif (TRIG_REGISTERED=FALSE or (clock'event and clock='1')) then
      TrigEnaReg <= trig_ena;
      TrigInReg  <= trig;
    end if;
  end process;
  --
  TrigInSig    <= TrigInReg when (ProcAckReg='1' and FifoFullSig='0' and TrigEnaReg='1') else (others => '0');
  TrigInOrSig  <= OR_REDUCE(TrigInSig);
  DataEmptySig <= not(TrigInOrSig or OR_REDUCE(CommMask)); 
  BufEmptySig  <= not(OR_REDUCE(FifoDataEnaPipe(TIME_PARTS_NUM-1 downto 0)) or OR_REDUCE(CommMask)); 
  --
  process(clock,resetN)
    variable CommMaskVar	:TSLV(CommMask'range);
  begin
    if (resetN = '0') then
      FifoDataPipe    <= (TFifoDataPipe'range => (others => '0'));
      FifoDataEnaPipe <= (others => '0');
      CommMask	      <= (others => '0');
      PosCnt          <= (others => '0');
      ProcReqReg      <= '0';
      ProcAckReg      <= '0';
    elsif (clock'event and clock='1') then
      --
      -- input/poutpu registering
      --
      ProcReqReg <= proc_req  or not(BufEmptySig);
      ProcAckReg <= ProcAckFifoSig;
      --
      -- common trigger mask builder
      --
      CommMaskVar:=(others=>'0');
      for index in 0 to LPM_TRIG_NUM-1 loop
        if (TrigInSig(index)='1') then
          CommMaskVar := CommMaskVar or SLVPartGet(mask,LPM_MASK_WIDTH,index);
        end if;
      end loop;
      CommMask(LPM_MASK_WIDTH-1)          <= CommMaskVar(LPM_MASK_WIDTH-1);
      CommMask(LPM_MASK_WIDTH-2 downto 0) <= CommMask(LPM_MASK_WIDTH-1 downto 1) or CommMaskVar(LPM_MASK_WIDTH-2 downto 0);
      --
      -- data position counter
      --
       if (PosCnt=LPM_MASK_WIDTH or DataEmptySig='1') then
        PosCnt <= (others => '0');
      else
        PosCnt <= PosCnt+1;
      end if;
      --
      -- fifo data and enable creator
      --
      FifoDataPipe(0)    <= PosCnt & TrigInSig & DataInReg; 
      FifoDataEnaPipe(0) <= TrigInOrSig or (CommMask(0) and DataEnaReg);
      if (BufEmptySig = '0') then
        FifoDataPipe(TIME_PARTS_NUM downto 1)    <= FifoDataPipe(TIME_PARTS_NUM-1 downto 0);
        FifoDataEnaPipe(TIME_PARTS_NUM downto 1) <= FifoDataEnaPipe(TIME_PARTS_NUM-1 downto 0);
      else
	for index in 1 to TIME_PARTS_NUM loop
          FifoDataPipe(index) <= TSLVnew(POS_COUNT_SIZE+LPM_TRIG_NUM,'0') & SLVPartGet(TimeInReg,LPM_DATA_WIDTH,TIME_PARTS_NUM-index,'0');
	end loop;
	FifoDataEnaPipe(TIME_PARTS_NUM downto 1) <= (others => TrigInOrSig);
      end if;
    end if;
  end process;
  --
  fifo			:DPM_PROG_FIFO
  generic map (
    LPM_DATA_WIDTH     => MEM_DATA_WIDTH,
    LPM_ADDR_WIDTH     => LPM_ADDR_WIDTH,
    LPM_MDATA_WIDTH    => LPM_MDATA_WIDTH 
  )
  port map (
    resetN             => resetN,
    clock              => clock,
    data_ena           => FifoDataEnaPipe(TIME_PARTS_NUM),
    data               => FifoDataPipe(TIME_PARTS_NUM),
    block_end          => BufEmptySig,
    full               => FifoFullSig,
    empty_str          => empty_str,
    empty              => empty,
    empty_ack          => empty_ack,
    lost_data_str      => lost_data_str,
    lost_data          => lost_data,
    lost_data_ack      => lost_data_ack,
    wr_addr_str        => wr_addr_str,
    wr_addr            => wr_addr,
    wr_addr_ack        => wr_addr_ack,
    rd_addr_str        => rd_addr_str,
    rd_addr_ena        => rd_addr_ena,
    rd_addr            => rd_addr,
    rd_addr_test_str   => rd_addr_test_str,
    rd_addr_test       => rd_addr_test,
    rd_addr_test_ack   => rd_addr_test_ack,
    sim_loop           => sim_loop,
    proc_req           => ProcReqReg,
    proc_ack           => ProcAckFifoSig,
    mem_addr           => mem_addr,
    mem_data_in        => mem_data_in,
    mem_data_out       => mem_data_out,
    mem_wr             => mem_wr,
    mem_str            => mem_str
  );
  --
  proc_ack <= ProcAckReg;

end behaviour;

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.LPMDiagnostics.all;

entity LPM_DIAG_DAQ1 is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 4;
    constant LPM_TRIG_NUM	:in natural := 4;
    constant LPM_TIME_WIDTH	:in natural := 8;
    constant LPM_MASK_WIDTH	:in natural := 8;
    constant LPM_ADDR_WIDTH	:in natural := 5;
    constant LPM_MDATA_WIDTH	:in natural := 12;
    constant DATA_REGISTERED	:in boolean := TRUE;
    constant TIME_REGISTERED	:in boolean := TRUE;
    constant TRIG_REGISTERED	:in boolean := TRUE

  );
  port(
    resetN			:in  TSL := '1';
    clock			:in  TSL := '0';
    strobeN			:in  TSL := '1';
    data_ena			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    trig_ena			:in  TSL := '1';
    trig			:in  TSLV(LPM_TRIG_NUM-1 downto 0);
    time			:in  TSLV(LPM_TIME_WIDTH-1 downto 0);
    mask			:in  TSLV(LPM_MASK_WIDTH*LPM_TRIG_NUM-1 downto 0);
    empty_ren			:in  TSL := '0';
    empty			:out TSL;
    empty_ack			:out TSL;
    lost_data_ren		:in  TSL := '0';
    lost_data			:out TSL;
    lost_data_ack		:out TSL;
    wr_addr_ren			:in  TSL := '0';
    wr_addr			:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
    wr_addr_ack			:out TSL;
    rd_addr_wen			:in  TSL := '0';
    rd_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    rd_addr_test_ren		:in  TSL;
    rd_addr_test		:out TSLV(LPM_ADDR_WIDTH-1 downto 0);
    rd_addr_test_ack		:out TSL;
    sim_loop			:in  TSL := '0';
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(DIAG_DAQ_MemAddrWidth(LPM_DATA_WIDTH,LPM_TRIG_NUM,LPM_MASK_WIDTH,LPM_ADDR_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wen			:in  TSL := '0'
  );
end LPM_DIAG_DAQ1;

architecture behaviour of LPM_DIAG_DAQ1 is

  signal empty_str        :TSL;
  signal lost_data_str    :TSL;
  signal wr_addr_str      :TSL;
  signal rd_addr_str      :TSL;
  signal rd_addr_test_str :TSL;
  signal mem_str          :TSL;

begin

  empty_str        <= empty_ren        and not(strobeN);
  lost_data_str    <= lost_data_ren    and not(strobeN);
  wr_addr_str      <= wr_addr_ren      and not(strobeN);
  rd_addr_str      <= rd_addr_wen      and not(strobeN);
  rd_addr_test_str <= rd_addr_test_ren and not(strobeN);
  mem_str          <= mem_wen          and not(strobeN);
  --
  DAQDiagMem :LPM_DIAG_DAQ
    generic map(
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_TRIG_NUM	=> LPM_TRIG_NUM,
      LPM_TIME_WIDTH	=> LPM_TIME_WIDTH,
      LPM_MASK_WIDTH	=> LPM_MASK_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_ADDR_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH
  
  )
    port map(
      resetN		=> resetN,
      clock		=> clock,
      data_ena		=> data_ena,
      data		=> data,
      trig_ena		=> trig_ena,
      trig		=> trig,
      time		=> time,
      mask		=> mask,
      empty_str		=> empty_str,
      empty		=> empty,
      empty_ack		=> empty_ack,
      lost_data_str	=> lost_data_str,
      lost_data		=> lost_data,
      lost_data_ack	=> lost_data_ack,
      wr_addr_str	=> wr_addr_str,
      wr_addr		=> wr_addr,
      wr_addr_ack	=> wr_addr_ack,
      rd_addr_str	=> rd_addr_str,
      rd_addr_ena	=> rd_addr_wen,
      rd_addr		=> rd_addr,
      rd_addr_test_str	=> rd_addr_test_str,
      rd_addr_test	=> rd_addr_test,
      rd_addr_test_ack	=> rd_addr_test_ack,
      sim_loop		=> sim_loop,
      proc_req		=> proc_req,
      proc_ack		=> proc_ack,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wen,
      mem_str		=> mem_str
    );

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

entity LPM_DAQ_FLASH is
  generic (
    constant LPM_DATA_WIDTH	:in natural := 8;
    constant LPM_BUFOR_WIDTH	:in natural := 4;
    constant LPM_MDATA_WIDTH	:in natural := 8
  );
  port(
    resetN			:in  TSL := '0';
    clock			:in  TSL := '0';
    clk_ena			:in  TSL := '1';
    data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    bufor_len			:in  TSLV(LPM_BUFOR_WIDTH-1 downto 0);
    trigger			:in  TSL;
    empty_skip			:in  TSL;
    ready			:out TSL;
    sim_loop			:in  TSL := '0';
    proc_req			:in  TSL := '0';
    proc_ack			:out TSL;
    mem_addr			:in  TSLV(LPM_BUFOR_WIDTH+SLVPartAddrExpand(LPM_DATA_WIDTH,LPM_MDATA_WIDTH)-1 downto 0);
    mem_data_in			:in  TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_MDATA_WIDTH-1 downto 0);
    mem_wr			:in  TSL := '0';
    mem_str			:in  TSL := '0'
  );
end LPM_DAQ_FLASH;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComponent.all;

architecture behaviour of LPM_DAQ_FLASH is

  signal L				:TSL;
  signal MemEnaReg			:TSL;
  signal MemAckSig			:TSL;
  signal ClkEnaReg			:TSL;
  signal DataInReg			:TSLV(data_in'range);
  signal DataValidReg			:TSL;
  signal Count				:TSLV(bufor_len'range);
  signal TriggerReg			:TSL;
  signal ReadyReg			:TSL;
  signal PipeClkEnaSig			:TSL;

begin

  L <= '0';

  process(clock, resetN)
  begin
    if(resetN='0') then
      count        <= (others => '0');
      MemEnaReg    <= '0';
      ClkEnaReg    <= '0';
      DataInReg    <= (others => '0');
      DataValidReg <= '0';
      TriggerReg   <= '0';
      ReadyReg     <= '0';
    elsif(clock'event and clock='1') then
      MemEnaReg  <= not(proc_req);
      ClkEnaReg  <= clk_ena;
      DataInReg  <= data_in;
      if (MemEnaReg='1' or MemAckSig='1') then
        DataValidReg <= '0';
        TriggerReg   <= '0';
        ReadyReg     <= '0';
        Count        <= (others => '0');
      elsif (ClkEnaReg='1') then
        if (TriggerReg='0') then
	  TriggerReg <= trigger;
	else
          if (Count=bufor_len) then
	    if (DataValidReg='1' or empty_skip='0' or OR_REDUCE(DataInReg)='1') then
              ReadyReg <= '1';
	    else
	      TriggerReg <= '0';
	    end if;
          else
            Count <= Count + 1;
            DataValidReg <= DataValidReg or OR_REDUCE(DataInReg);
          end if;
	end if;
      end if;
    end if;
  end process;

  PipeClkEnaSig <= ClkEnaReg and not(ReadyReg);
  pipe: component DPM_PROG
    generic map (
      LPM_DATA_WIDTH	=> LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH	=> LPM_BUFOR_WIDTH,
      LPM_MDATA_WIDTH	=> LPM_MDATA_WIDTH,
      ADDRESS_SEPARATE  => FALSE
    )
    port map(
      resetN		=> resetN,
      clk		=> clock,
      ena_in		=> PipeClkEnaSig,
      addr_in		=> Count,
      data_in		=> DataInReg,
      ena_out		=> L,
      addr_out		=> Count,
      data_out		=> open,
      simulate		=> sim_loop,
      mem_ena		=> MemEnaReg,
      mem_ena_ack	=> MemAckSig,
      mem_addr		=> mem_addr,
      mem_data_in	=> mem_data_in,
      mem_data_out	=> mem_data_out,
      mem_wr		=> mem_wr,
      mem_str		=> mem_str
  );

  ready    <= ReadyReg;
  proc_ack <= not(MemAckSig);

end behaviour;

