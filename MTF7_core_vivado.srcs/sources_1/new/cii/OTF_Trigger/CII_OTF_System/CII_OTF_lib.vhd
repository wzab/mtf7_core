-- **************************************************************************************
-- *											*
-- *		  RPC Trigger System, written by Krzysztof Pozniak, 2014		*
-- *			   Global definitions for whole OTF System			*
-- *											*
-- **************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

use work.std_logic_1164_ktp.all;

use work.CII_OTF_def.all;

package CII_OTF_lib is

  component CII_OTF_TTC_cnt is
    generic(
      constant BCN0_DELAY_WIDTH			:natural := 0;
      constant EVN0_DELAY_WIDTH			:natural := 0;
      constant BCN0_WIDTH			:natural := 8;
      constant BCN_WIDTH			:natural := 0;
      constant EVN_WIDTH			:natural := 0
    );
    port (
      resetN					:in    TSL;
      clock					:in    TSL;
      bcn0					:in    TSL;
      evn0					:in    TSL;
      bcn0_del					:out   TSL;
      evn0_del					:out   TSL;
      bcn0_cnt					:out   TSLV(BCN0_WIDTH-1 downto 0);
      bcn					:out   TSLV(BCN_WIDTH-1 downto 0);
      evn					:out   TSLV(EVN_WIDTH-1 downto 0);
      --
      event_in					:in    TSL := '0';
      event_out					:out   TSL;
      bcn0_delay				:in    TSLV(maximum(BCN0_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
      evn0_delay				:in    TSLV(maximum(EVN0_DELAY_WIDTH,1)-1 downto 0) := (others =>'0')
    );
  end component;

end CII_OTF_lib;

package body CII_OTF_lib is

end CII_OTF_lib;

-------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.std_logic_1164_ktp.all;
use work.KTPcomponent.all;
use work.LPMcomponent.all;

entity CII_OTF_TTC_cnt is
  generic(
    constant BCN0_DELAY_WIDTH			:natural := 12;
    constant EVN0_DELAY_WIDTH			:natural := 12;
    constant BCN0_WIDTH				:natural := 8;
    constant BCN_WIDTH				:natural := 12;
    constant EVN_WIDTH				:natural := 24
  );
  port (
    resetN					:in    TSL;
    clock					:in    TSL;
    bcn0					:in    TSL;
    evn0					:in    TSL;
    bcn0_del					:out   TSL;
    evn0_del					:out   TSL;
    bcn0_cnt					:out   TSLV(BCN0_WIDTH-1 downto 0);
    bcn						:out   TSLV(BCN_WIDTH-1 downto 0);
    evn						:out   TSLV(EVN_WIDTH-1 downto 0);
    --
    event_in					:in    TSL := '0';
    event_out					:out   TSL;
    bcn0_delay					:in    TSLV(maximum(BCN0_DELAY_WIDTH,1)-1 downto 0) := (others =>'0');
    evn0_delay					:in    TSLV(maximum(EVN0_DELAY_WIDTH,1)-1 downto 0) := (others =>'0')
  );
end CII_OTF_TTC_cnt;

architecture behavioural of CII_OTF_TTC_cnt is

  signal BCN0DelSig				:TSL;
  signal EVN0DelSig				:TSL;
  signal BCN0Reg				:TSL;
  signal EVN0Reg				:TSL;
  signal EventReg				:TSL;
  signal BCN0cnt				:TSLV(BCN0_WIDTH-1 downto 0);
  signal BCNcnt					:TSLV(BCN_WIDTH-1 downto 0);
  signal EVNcnt					:TSLV(EVN_WIDTH-1 downto 0);

begin
  bcn0_del_true:
  if (BCN0_DELAY_WIDTH>0) generate
    bcn0_del_cmp: LPM_PULSE_DELAY
      generic map (
        LPM_DELAY_SIZE	=> BCN0_DELAY_WIDTH
      )
      port map(
        resetN    => resetN,
        clock     => clock,
        clk_ena   => '1',
        pulse_in  => bcn0,
        pulse_out => BCN0DelSig,
        limit     => bcn0_delay
      );
  end generate;
  --
  process(resetN, clock)
  begin
    if(resetN='0') then
      BCN0cnt  <= (others => '0');
    elsif(clock'event and clock='1') then
      if (bcn0='1') then
        BCN0cnt  <= BCN0cnt+1;
      end if;
    end if;
  end process;
  --
  bcn0_del_false:
  if (BCN0_DELAY_WIDTH=0) generate
    BCN0DelSig <= bcn0;
  end generate;
  --
  evn0_del_true:
  if (EVN0_DELAY_WIDTH>0) generate
    evn0_del_cmp: LPM_PULSE_DELAY
      generic map (
        LPM_DELAY_SIZE	=> EVN0_DELAY_WIDTH
      )
      port map(
        resetN    => resetN,
        clock     => clock,
        clk_ena   => '1',
        pulse_in  => evn0,
        pulse_out => EVN0DelSig,
        limit     => evn0_delay
      );
  end generate;
  evn0_del_false:
  if (EVN0_DELAY_WIDTH=0) generate
    EVN0DelSig <= evn0;
  end generate;
  --
  process(resetN, clock)
  begin
    if(resetN='0') then
      BCN0Reg  <= '0';
      EVN0Reg  <= '0';
      EventReg <= '0';
      BCNcnt  <= (others => '0');
      EVNcnt  <= (others => '0');
    elsif(clock'event and clock='1') then
      if (BCN0DelSig='1') then
        BCNcnt  <= (others => '0');
	BCN0Reg <= '1';
      else
        BCNcnt  <= BCNcnt+1;
	BCN0Reg <= '0';
      end if;
      --
      if (EVN0DelSig='1') then
        EVNcnt   <= (others => '0');
	EVN0Reg  <= '1';
	EventReg <= '0';
      else
	EVN0Reg <= '0';
        if (event_in='1') then
          EVNcnt <= EVNcnt+1;
	  EventReg <= '1';
	else
	  EventReg <= '0';
	end if;
      end if;
    end if;
  end process;
  --
  bcn0_del  <= BCN0Reg;
  evn0_del  <= EVN0Reg;
  bcn0_cnt  <= BCN0cnt;
  bcn       <= BCNcnt;
  evn       <= EVNcnt;
  event_out <= EventReg;

end behavioural;
