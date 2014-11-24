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

use work.TTC_decoder_def.all;
use work.CII_OTF_def.all;
use work.CII_OTF_lib.all;
use work.CII_MTF7_def.all;
use work.CII_MTF7_OPTO_def.all;
use work.CII_MTF7_opto_prv.all;
use work.CII_MTF7_opto_lib.all;

entity KTP_MTF7_top is
  port(
    -- TTC signals
    TTC_CLK_p                                   :in    TSL;    -- FCLKA input
    TTC_CLK_n                                   :in    TSL;
    TTC_data_p                                  :in    TSL;    -- Fabric B (port 3) input
    TTC_data_n                                  :in    TSL;
    lhc_clk : out std_logic;
    --
    -- links interface
    link_data					:in    TSLV(MTF7.RPC_LINK_DATA-1 downto 0);
    --
    -- internal bus interface
    II_resetN					:in    TSL;
    II_operN					:in    TSL;
    II_writeN					:in    TSL;
    II_strobeN					:in    TSL;
    II_addr					:in    TSLV(MTF7.II_ADDR_WIDTH-1 downto 0);
    II_in_data					:in    TSLV(MTF7.II_DATA_WIDTH-1 downto 0);
    II_out_data					:out   TSLV(MTF7.II_DATA_WIDTH-1 downto 0)
  );
end KTP_MTF7_top;    

architecture behaviour of KTP_MTF7_top is

  signal Clock40                :std_logic;    -- buffered clock
  signal TTCready               :std_logic;    -- valid TTC stream seen
  signal L1Accept               :std_logic;    -- decoded L1A out
  signal BCntRes                :std_logic;    -- decoded BC0 out
  signal EvCntRes               :std_logic;    -- decoded ECR out
  signal SinErrStr              :std_logic;    -- single-bit hamming error seen
  signal DbErrStr               :std_logic;    -- multi-bit hamming error seen
  signal BrcstStr               :std_logic;    -- broadcast command strobe
  signal Brcst                  :std_logic_vector (7 downto 2); -- broadcast data

begin

lhc_clk <= Clock40;

  TTC: TTC_decoder
    port map (
      TTC_CLK_p                 => TTC_CLK_p,
      TTC_CLK_n                 => TTC_CLK_n,
      TTC_data_p                => TTC_data_p,
      TTC_data_n                => TTC_data_n,
      Clock40                   => Clock40,
      TTCready                  => TTCready,
      L1Accept                  => L1Accept,
      BCntRes                   => BCntRes,
      EvCntRes                  => EvCntRes,
      SinErrStr                 => SinErrStr,
      DbErrStr                  => DbErrStr,
      BrcstStr                  => BrcstStr,
      Brcst                     => Brcst
  );

  opto: CCII_MTF7_opto
    generic map (
      IICPAR                    => MTF7_OPTO_tab,
      IICPOS                    => 0
    )
    port map(
      -- TTC signals 
      clk40			=> Clock40,
      bcn0			=> BCntRes,
      evn0			=> EvCntRes,
      l1a			=> L1Accept,
      pretrg0			=> '0',
      pretrg1			=> '0',
      pretrg2			=> '0',
      --
      -- links interface
      link_data			=> link_data,
      --
      -- internal bus interface
      II_resetN			=> II_resetN,
      II_operN			=> II_operN,
      II_writeN			=> II_writeN,
      II_strobeN		=> II_strobeN,
      II_addr			=> II_addr,
      II_in_data		=> II_in_data,
      II_out_data		=> II_out_data
    );

end behaviour;
