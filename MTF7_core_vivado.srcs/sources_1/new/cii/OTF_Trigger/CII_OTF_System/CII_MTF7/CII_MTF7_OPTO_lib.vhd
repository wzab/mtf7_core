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

use work.ComponentII.all;

use work.CII_OTF_def.all;
use work.CII_OTF_lib.all;
use work.CII_MTF7_def.all;
use work.CII_MTF7_OPTO_def.all;
use work.CII_MTF7_OPTO_prv.all;

package CII_MTF7_OPTO_lib is

  component CCII_MTF7_opto is
    generic (
      constant IICPAR				:TCII := MTF7_OPTO_tab;
      constant IICPOS				:TVI := 0
    );
    port(
      -- TTC signals
      clk40					:in    TSL;
      bcn0					:in    TSL;
      evn0					:in    TSL;
      l1a					:in    TSL;
      pretrg0					:in    TSL;
      pretrg1					:in    TSL;
      pretrg2					:in    TSL;
      --
      -- links interface
      link_data					:in    TSLV(MTF7.RPC_LINK_DATA-1 downto 0);
      --
      -- internal bus interface
      II_resetN					:in    TSL;
      II_operN					:in    TSL;
      II_writeN					:in    TSL;
      II_strobeN				:in    TSL;
      II_addr					:in    TSLV(MTF7.II_ADDR_WIDTH-1 downto 0);
      II_in_data				:in    TSLV(MTF7.II_DATA_WIDTH-1 downto 0);
      II_out_data				:out   TSLV(MTF7.II_DATA_WIDTH-1 downto 0)
    );
  end component;

end CII_MTF7_OPTO_lib;

