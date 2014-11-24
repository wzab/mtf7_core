-- /***********************************************************************\
-- *                                                                       *
-- * This file was created by Component Internal Interface Engine software *
-- *  Copyright(c) 2000-2012 by Krzysztof Pozniak (pozniak@ise.pw.edu.pl)  *
-- *                           All Rights Reserved.                        *
-- *                                                                       *
-- \***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_MTF7_OPTO_def.all;

package CII_MTF7_OPTO_prv is

  type TMTF7_OPTO_prv is record
    MTF7_OPTO_DUMMY0                 :TN;
    MTF7_OPTO_DUMMY1                 :TN;
  end record;

  constant MTF7_OPTO_prv :TMTF7_OPTO_prv := (
    0,                               -- dummy item
    0                                -- dummy item
  );

  constant MTF7_OPTO_tab :TCII :=(
  --  type       ID width number repeat  access wrpos  rdpos                      addrpos                     addrlen  index
    ( CII_COMP,   0,   32,    16,     1, CII_NA,    1,    12,                          91,                          19,    0 ), --  $MTF7_OPTO
    ( CII_IPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                  1873850505,    1 ), --  CHECK_SUM
    ( CII_BITS,   0,    4,     1,     1, CII_RO,   -1,     0,                           0,                           0,    2 ), --  BITS_TEST_CNT_CLK40
    ( CII_BITS,   0,    4,     1,     1, CII_RO,   -1,     4,                           0,                           4,    3 ), --  BITS_TEST_CNT_BCN0
    ( CII_WORD,   0,    1,     1,     1, CII_IR,    8,     8,                           1,                           1,    4 ), --  WORD_REC_CHECK_ENA
    ( CII_WORD,   0,    1,     1,     1, CII_IR,    9,     9,                           2,                           1,    5 ), --  WORD_REC_CHECK_DATA_ENA
    ( CII_WORD,   0,    1,     1,     1, CII_IR,   10,    10,                           3,                           1,    6 ), --  WORD_REC_TEST_ENA
    ( CII_WORD,   0,    1,     1,     1, CII_IR,   11,    11,                           4,                           1,    7 ), --  WORD_REC_TEST_RND_ENA
    ( CII_WORD,   0,   32,     1,     1, CII_RO,   -1,    12,                           5,                           1,    8 ), --  WORD_REC_TEST_DATA
    ( CII_WORD,   0,    4,     1,     1, CII_RO,   -1,    44,                           6,                           1,    9 ), --  WORD_REC_TEST_OR_DATA
    ( CII_WORD,   0,   16,     1,     1, CII_RW,   48,    64,                           7,                           1,   10 ), --  WORD_REC_ERROR_COUNT
    ( CII_WORD,   0,   12,     1,     1, CII_IR,   80,    80,                           8,                           1,   11 ), --  WORD_BCN0_DELAY
    ( CII_COMP,   1,   32,    16,     1, CII_NA,   13,    27,                         335,                          19,   12 ), --  COMP_ID(0)/COMP_ID
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                          32,   13 ), --  COMP_ID(0)/IPAR_USER_REG_WIDTH
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                  1873850505,   14 ), --  COMP_ID(0)/IPAR_IDENTYFIER
    ( CII_PTRP,   1,    0,     0,     0, CII_NA,   28,    -1,                          -1,                          -1,   15 ), --> COMP_ID(0)/SPAR_CREATOR
    ( CII_PTRP,   1,    0,     0,     0, CII_NA,   30,    -1,                          -1,                          -1,   16 ), --> COMP_ID(0)/SPAR_NAME
    ( CII_HPAR,   1,    4,     1,     1, CII_NA,    0,     0,                  THV2TN(""),              THV2TN("0001"),   17 ), --  COMP_ID(0)/HPAR_VERSION
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   18 ), --  COMP_ID(0)/LPAR_IDENTYFIER_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   19 ), --  COMP_ID(0)/LPAR_CREATOR_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   20 ), --  COMP_ID(0)/LPAR_NAME_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   21 ), --  COMP_ID(0)/LPAR_VERSION_CII
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           5,   22 ), --  COMP_ID(0)/IPAR_USER_REG_NUM
    ( CII_WORD,   1,   32,     1,     1, CII_RO,   -1,     0,                           9,                           1,   23 ), --  COMP_ID(0)/WORD_IDENTYFIER
    ( CII_WORD,   1,   64,     1,     1, CII_RO,   -1,    32,                          10,                           2,   24 ), --  COMP_ID(0)/WORD_CREATOR
    ( CII_WORD,   1,   64,     1,     1, CII_RO,   -1,    96,                          12,                           2,   25 ), --  COMP_ID(0)/WORD_NAME
    ( CII_WORD,   1,   16,     1,     1, CII_RO,   -1,   160,                          14,                           1,   26 ), --  COMP_ID(0)/WORD_VERSION
    ( CII_WORD,   1,   32,     5,     1, CII_IR,  176,   176,                          15,                           1,   27 ), --  COMP_ID(0)/WORD_USER
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     0,                 TS2TN("PW"),                 TS2TN("UT"),   28 ), --  COMP_ID(0)/SPAR_CREATOR
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     4,                 TS2TN("EL"),                 TS2TN("HE"),   29 ), --  COMP_ID(0)/SPAR_CREATOR
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     0,                 TS2TN("OP"),                 TS2TN("TO"),   30 ), --  COMP_ID(0)/SPAR_NAME
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     4,                 TS2TN("MT"),                 TS2TN("F7"),   31 ), --  COMP_ID(0)/SPAR_NAME
    ( CII_COMP,   0,    0,     0,     0, CII_NA,   -1,    -1,                          -1,                          -1,    0 )  --  end of table
  );

  component MTF7_OPTO_cii_interface is
    generic(
      constant IICPAR				:TCII;
      constant IICPOS				:TVI
    );
    port(
      put_BITS_TEST_CNT_CLK40                   :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemNumber-1,0) downto 0);
      ren_BITS_TEST_CNT_CLK40                   :out TSL;
      put_BITS_TEST_CNT_BCN0                    :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemNumber-1,0) downto 0);
      ren_BITS_TEST_CNT_BCN0                    :out TSL;
      get_WORD_REC_CHECK_ENA                    :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemNumber-1,0) downto 0);
      get_WORD_REC_CHECK_DATA_ENA               :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemNumber-1,0) downto 0);
      get_WORD_REC_TEST_ENA                     :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemNumber-1,0) downto 0);
      get_WORD_REC_TEST_RND_ENA                 :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemNumber-1,0) downto 0);
      put_WORD_REC_TEST_DATA                    :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
      ren_WORD_REC_TEST_DATA                    :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
      put_WORD_REC_TEST_OR_DATA                 :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
      ren_WORD_REC_TEST_OR_DATA                 :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
      put_WORD_REC_ERROR_COUNT                  :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
      ren_WORD_REC_ERROR_COUNT                  :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
      get_WORD_REC_ERROR_COUNT                  :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
      wen_WORD_REC_ERROR_COUNT                  :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
      get_WORD_BCN0_DELAY                       :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemNumber-1,0) downto 0);
      cpd_COMP_ID                               :in  TSLV(maximum(CIICompDataWidthGet(IICPAR(IICPOS))*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat-1,0) downto 0);
      --
      II_resetN					:in  TSL;
      II_operN					:in  TSL;
      II_writeN					:in  TSL;
      II_strobeN				:in  TSL;
      II_addr					:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0);
      II_data_in				:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0);
      II_data_out				:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
    );
  end component;

end CII_MTF7_OPTO_prv;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_MTF7_OPTO_def.all;

entity MTF7_OPTO_cii_interface is
  generic(
    constant IICPAR				:TCII;
    constant IICPOS				:TVI
  );
  port(
    put_BITS_TEST_CNT_CLK40                     :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemNumber-1,0) downto 0);
    ren_BITS_TEST_CNT_CLK40                     :out TSL;
    put_BITS_TEST_CNT_BCN0                      :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemNumber-1,0) downto 0);
    ren_BITS_TEST_CNT_BCN0                      :out TSL;
    get_WORD_REC_CHECK_ENA                      :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemNumber-1,0) downto 0);
    get_WORD_REC_CHECK_DATA_ENA                 :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemNumber-1,0) downto 0);
    get_WORD_REC_TEST_ENA                       :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemNumber-1,0) downto 0);
    get_WORD_REC_TEST_RND_ENA                   :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemNumber-1,0) downto 0);
    put_WORD_REC_TEST_DATA                      :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
    ren_WORD_REC_TEST_DATA                      :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
    put_WORD_REC_TEST_OR_DATA                   :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
    ren_WORD_REC_TEST_OR_DATA                   :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
    put_WORD_REC_ERROR_COUNT                    :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
    ren_WORD_REC_ERROR_COUNT                    :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
    get_WORD_REC_ERROR_COUNT                    :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
    wen_WORD_REC_ERROR_COUNT                    :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
    get_WORD_BCN0_DELAY                         :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemNumber-1,0) downto 0);
    cpd_COMP_ID                                 :in  TSLV(maximum(CIICompDataWidthGet(IICPAR(IICPOS))*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat-1,0) downto 0);
    --
    II_resetN					:in  TSL;
    II_operN					:in  TSL;
    II_writeN					:in  TSL;
    II_strobeN					:in  TSL;
    II_addr					:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0);
    II_data_in					:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0);
    II_data_out					:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
  );
end MTF7_OPTO_cii_interface;

architecture behaviour of MTF7_OPTO_cii_interface is

  constant IICPOSCMP				:TVL := IICPAR(IICPOS).ItemWrPos;
  constant II_ADDR_WIDTH			:TVL := TVLcreate(IICPAR(IICPOS).ItemAddrLen);
  constant II_DATA_WIDTH			:TVL := IICPAR(IICPOS).ItemWidth;
  signal   AddrSig				:TSLV(II_ADDR_WIDTH-1 downto 0);
  --
  signal   out_BITS_TEST_CNT_CLK40              :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_BITS_TEST_CNT_BCN0               :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_CHECK_ENA               :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_CHECK_DATA_ENA          :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_TEST_ENA                :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_TEST_RND_ENA            :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_TEST_DATA               :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_TEST_OR_DATA            :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_REC_ERROR_COUNT             :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_BCN0_DELAY                  :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_COMP_ID                          :TSLV(II_DATA_WIDTH-1 downto 0);

begin

  --
  BITS_TEST_CNT_CLK40_comp :CII_ITEM_BITS_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.BITS_TEST_CNT_CLK40),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH,
      SINGLE_BIT     => FALSE
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_BITS_TEST_CNT_CLK40,
      item_data_in    => put_BITS_TEST_CNT_CLK40,
      item_bit_in     => open,
      item_ren        => ren_BITS_TEST_CNT_CLK40,
      item_data_out   => open,
      item_bit_out    => open,
      item_wen        => open
    );
  --
  BITS_TEST_CNT_BCN0_comp :CII_ITEM_BITS_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.BITS_TEST_CNT_BCN0),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH,
      SINGLE_BIT     => FALSE
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_BITS_TEST_CNT_BCN0,
      item_data_in    => put_BITS_TEST_CNT_BCN0,
      item_bit_in     => open,
      item_ren        => ren_BITS_TEST_CNT_BCN0,
      item_data_out   => open,
      item_bit_out    => open,
      item_wen        => open
    );
  --
  WORD_REC_CHECK_ENA_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_CHECK_ENA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_CHECK_ENA,
      item_data       => get_WORD_REC_CHECK_ENA,
      item_bit        => open
    );
  --
  WORD_REC_CHECK_DATA_ENA_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_CHECK_DATA_ENA,
      item_data       => get_WORD_REC_CHECK_DATA_ENA,
      item_bit        => open
    );
  --
  WORD_REC_TEST_ENA_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_TEST_ENA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_TEST_ENA,
      item_data       => get_WORD_REC_TEST_ENA,
      item_bit        => open
    );
  --
  WORD_REC_TEST_RND_ENA_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_TEST_RND_ENA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_TEST_RND_ENA,
      item_data       => get_WORD_REC_TEST_RND_ENA,
      item_bit        => open
    );
  --
  WORD_REC_TEST_DATA_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_TEST_DATA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH,
      SINGLE_BIT     => FALSE
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_TEST_DATA,
      item_data_in    => put_WORD_REC_TEST_DATA,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_REC_TEST_DATA,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_REC_TEST_OR_DATA_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_TEST_OR_DATA),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH,
      SINGLE_BIT     => FALSE
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_TEST_OR_DATA,
      item_data_in    => put_WORD_REC_TEST_OR_DATA,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_REC_TEST_OR_DATA,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_REC_ERROR_COUNT_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_REC_ERROR_COUNT),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH,
      SINGLE_BIT     => FALSE
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_REC_ERROR_COUNT,
      item_data_in    => put_WORD_REC_ERROR_COUNT,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_REC_ERROR_COUNT,
      item_bit_ren    => open,
      item_data_out   => get_WORD_REC_ERROR_COUNT,
      item_bit_out    => open,
      item_data_wen   => wen_WORD_REC_ERROR_COUNT,
      item_bit_wen    => open
    );
  --
  WORD_BCN0_DELAY_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+MTF7_OPTO.WORD_BCN0_DELAY),
      II_ADDR_WIDTH  => II_ADDR_WIDTH,
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      II_resetN       => II_resetN,
      II_operN        => II_operN,
      II_writeN       => II_writeN,
      II_strobeN      => II_strobeN,
      II_addr         => II_addr(II_ADDR_WIDTH-1 downto 0),
      II_data_in      => II_data_in,
      II_data_out     => out_WORD_BCN0_DELAY,
      item_data       => get_WORD_BCN0_DELAY,
      item_bit        => open
    );
  --
  COMP_ID_comp :CII_ITEM_COMP
    generic map(
      IICITEM        => IICPAR(CIICompPtrGet(IICPAR(IICPOSCMP+MTF7_OPTO.COMP_ID))),
      II_DATA_WIDTH  => II_DATA_WIDTH
    )
    port map(
      item_data_in    => cpd_COMP_ID,
      II_data_out     => out_COMP_ID
    );
  --
  II_data_out <= TSLVnew(II_DATA_WIDTH,'0')
                or out_BITS_TEST_CNT_CLK40
                or out_BITS_TEST_CNT_BCN0
                or out_WORD_REC_CHECK_ENA
                or out_WORD_REC_CHECK_DATA_ENA
                or out_WORD_REC_TEST_ENA
                or out_WORD_REC_TEST_RND_ENA
                or out_WORD_REC_TEST_DATA
                or out_WORD_REC_TEST_OR_DATA
                or out_WORD_REC_ERROR_COUNT
                or out_WORD_BCN0_DELAY
                or out_COMP_ID
  ;

end behaviour;

--  --#CII# declaration insert start for 'MTF7_OPTO' - don't edit below !
--  type TCIIpar                                            is record
--    CHECK_SUM                                             :TI;
--    BITS_TEST_CNT_CLK40                                   :TCIIItem;
--    BITS_TEST_CNT_BCN0                                    :TCIIItem;
--    WORD_REC_CHECK_ENA                                    :TCIIItem;
--    WORD_REC_CHECK_DATA_ENA                               :TCIIItem;
--    WORD_REC_TEST_ENA                                     :TCIIItem;
--    WORD_REC_TEST_RND_ENA                                 :TCIIItem;
--    WORD_REC_TEST_DATA                                    :TCIIItem;
--    WORD_REC_TEST_OR_DATA                                 :TCIIItem;
--    WORD_REC_ERROR_COUNT                                  :TCIIItem;
--    WORD_BCN0_DELAY                                       :TCIIItem;
--    COMP_ID                                               :TCII(0 to maximum(CIICompRepeatGet(IICPAR(CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)))))-1,0));
--  end record;
--
--  function CIIpar_get return TCIIpar is
--    variable res: TCIIpar;
--    variable pos, idx, len: TN;
--  begin
--    pos := CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.CHECK_SUM);
--    res.CHECK_SUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
--    res.BITS_TEST_CNT_CLK40 := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.BITS_TEST_CNT_CLK40));
--    res.BITS_TEST_CNT_BCN0 := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.BITS_TEST_CNT_BCN0));
--    res.WORD_REC_CHECK_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_CHECK_ENA));
--    res.WORD_REC_CHECK_DATA_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_CHECK_DATA_ENA));
--    res.WORD_REC_TEST_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_ENA));
--    res.WORD_REC_TEST_RND_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_RND_ENA));
--    res.WORD_REC_TEST_DATA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_DATA));
--    res.WORD_REC_TEST_OR_DATA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_OR_DATA));
--    res.WORD_REC_ERROR_COUNT := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_ERROR_COUNT));
--    res.WORD_BCN0_DELAY := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_BCN0_DELAY));
--    pos := CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)));
--    for num in res.COMP_ID'range loop
--      res.COMP_ID(num) := IICPAR(pos+num);
--    end loop;
--    return(res);
--  end function;
--
--  constant CIIPar                                         :TCIIpar := CIIpar_get;
--
--  signal   CIIput_BITS_TEST_CNT_CLK40                     :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemNumber-1,0) downto 0);
--  signal   CIIren_BITS_TEST_CNT_CLK40                     :TSL;
--  signal   CIIput_BITS_TEST_CNT_BCN0                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemNumber-1,0) downto 0);
--  signal   CIIren_BITS_TEST_CNT_BCN0                      :TSL;
--  signal   CIIget_WORD_REC_CHECK_ENA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemNumber-1,0) downto 0);
--  signal   CIIget_WORD_REC_CHECK_DATA_ENA                 :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemNumber-1,0) downto 0);
--  signal   CIIget_WORD_REC_TEST_ENA                       :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemNumber-1,0) downto 0);
--  signal   CIIget_WORD_REC_TEST_RND_ENA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemNumber-1,0) downto 0);
--  signal   CIIput_WORD_REC_TEST_DATA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
--  signal   CIIren_WORD_REC_TEST_DATA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
--  signal   CIIput_WORD_REC_TEST_OR_DATA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
--  signal   CIIren_WORD_REC_TEST_OR_DATA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
--  signal   CIIput_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
--  signal   CIIren_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
--  signal   CIIget_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
--  signal   CIIwen_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
--  signal   CIIget_WORD_BCN0_DELAY                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemNumber-1,0) downto 0);
--  type     TCIIcpd_COMP_ID                                is array(0 to maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat,1)-1) of TSLV(maximum(IICPAR(CIICompPtrGet(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID))).ItemWidth,1)-1 downto 0);
--  signal   CIIcpd_COMP_ID                                 :TCIIcpd_COMP_ID := (TCIIcpd_COMP_ID'range => (others =>'0'));
--  signal   CIIcpdv_COMP_ID                                :TSLV(maximum(CIICompDataWidthGet(IICPAR(IICPOS))*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat-1,0) downto 0);
--  function CIIcpdv_COMP_ID_get(d :TCIIcpd_COMP_ID) return TSLV is constant L :TN := d(0)'length; variable r :TSLV(TCIIcpd_COMP_ID'length*L-1 downto 0); begin for i in TCIIcpd_COMP_ID'range loop r(L*(i+1)-1 downto L*i) := d(i); end loop; return(r); end function;
--  --#CII# declaration insert end for 'MTF7_OPTO' - don't edit above !

--  --#CII# instantation insert start for 'MTF7_OPTO' - don't edit below !
--  CIIinterf :MTF7_OPTO_cii_interface
--    generic map (
--      IICPAR                                    => IICPAR,
--      IICPOS                                    => IICPOS
--    )
--    port map (
--      put_BITS_TEST_CNT_CLK40                   => CIIput_BITS_TEST_CNT_CLK40,
--      ren_BITS_TEST_CNT_CLK40                   => CIIren_BITS_TEST_CNT_CLK40,
--      put_BITS_TEST_CNT_BCN0                    => CIIput_BITS_TEST_CNT_BCN0,
--      ren_BITS_TEST_CNT_BCN0                    => CIIren_BITS_TEST_CNT_BCN0,
--      get_WORD_REC_CHECK_ENA                    => CIIget_WORD_REC_CHECK_ENA,
--      get_WORD_REC_CHECK_DATA_ENA               => CIIget_WORD_REC_CHECK_DATA_ENA,
--      get_WORD_REC_TEST_ENA                     => CIIget_WORD_REC_TEST_ENA,
--      get_WORD_REC_TEST_RND_ENA                 => CIIget_WORD_REC_TEST_RND_ENA,
--      put_WORD_REC_TEST_DATA                    => CIIput_WORD_REC_TEST_DATA,
--      ren_WORD_REC_TEST_DATA                    => CIIren_WORD_REC_TEST_DATA,
--      put_WORD_REC_TEST_OR_DATA                 => CIIput_WORD_REC_TEST_OR_DATA,
--      ren_WORD_REC_TEST_OR_DATA                 => CIIren_WORD_REC_TEST_OR_DATA,
--      put_WORD_REC_ERROR_COUNT                  => CIIput_WORD_REC_ERROR_COUNT,
--      ren_WORD_REC_ERROR_COUNT                  => CIIren_WORD_REC_ERROR_COUNT,
--      get_WORD_REC_ERROR_COUNT                  => CIIget_WORD_REC_ERROR_COUNT,
--      wen_WORD_REC_ERROR_COUNT                  => CIIwen_WORD_REC_ERROR_COUNT,
--      get_WORD_BCN0_DELAY                       => CIIget_WORD_BCN0_DELAY,
--      cpd_COMP_ID                               => CIIcpdv_COMP_ID,
--      II_resetN                                 => II_resetN,
--      II_operN                                  => ii_operN,
--      II_writeN                                 => II_writeN,
--      II_strobeN                                => II_strobeN,
--      II_addr                                   => II_addr,
--      II_data_in                                => ii_in_data,
--      II_data_out                               => ii_out_data
--  );
--  CIIcpdv_COMP_ID                               <= CIIcpdv_COMP_ID_get(CIIcpd_COMP_ID);
--  --#CII# instantation insert end for 'MTF7_OPTO' - don't edit above !
