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
    ( CII_COMP,   0,   16,    16,     1, CII_NA,    1,     2,                          -1,                          13,    0 ), --  $MTF7_OPTO
    ( CII_IPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                   271352642,    1 ), --  CHECK_SUM
    ( CII_COMP,   1,   16,    16,     1, CII_NA,    3,    17,                         223,                          13,    2 ), --  COMP_ID(0)/COMP_ID
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                          16,    3 ), --  COMP_ID(0)/IPAR_USER_REG_WIDTH
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                   271352642,    4 ), --  COMP_ID(0)/IPAR_IDENTYFIER
    ( CII_SPAR,   1,    4,     1,     1, CII_NA,    0,     0,                 TS2TN("PE"),                 TS2TN("RG"),    5 ), --  COMP_ID(0)/SPAR_CREATOR
    ( CII_PTRP,   1,    0,     0,     0, CII_NA,   18,    -1,                          -1,                          -1,    6 ), --> COMP_ID(0)/SPAR_NAME
    ( CII_HPAR,   1,    4,     1,     1, CII_NA,    0,     0,                  THV2TN(""),              THV2TN("0001"),    7 ), --  COMP_ID(0)/HPAR_VERSION
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    8 ), --  COMP_ID(0)/LPAR_IDENTYFIER_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    9 ), --  COMP_ID(0)/LPAR_CREATOR_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   10 ), --  COMP_ID(0)/LPAR_NAME_CII
    ( CII_LPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,   11 ), --  COMP_ID(0)/LPAR_VERSION_CII
    ( CII_IPAR,   1,    0,     1,     1, CII_NA,    0,     0,                           1,                           5,   12 ), --  COMP_ID(0)/IPAR_USER_REG_NUM
    ( CII_WORD,   1,   32,     1,     1, CII_RO,   -1,     0,                           0,                           2,   13 ), --  COMP_ID(0)/WORD_IDENTYFIER
    ( CII_WORD,   1,   32,     1,     1, CII_RO,   -1,    32,                           2,                           2,   14 ), --  COMP_ID(0)/WORD_CREATOR
    ( CII_WORD,   1,   64,     1,     1, CII_RO,   -1,    64,                           4,                           4,   15 ), --  COMP_ID(0)/WORD_NAME
    ( CII_WORD,   1,   16,     1,     1, CII_RO,   -1,   128,                           8,                           1,   16 ), --  COMP_ID(0)/WORD_VERSION
    ( CII_WORD,   1,   16,     5,     1, CII_IR,  144,   144,                           9,                           1,   17 ), --  COMP_ID(0)/WORD_USER
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     0,                 TS2TN("OP"),                 TS2TN("TO"),   18 ), --  COMP_ID(0)/SPAR_NAME
    ( CII_SPAR,   1,    8,     1,     1, CII_NA,    0,     4,                 TS2TN("MT"),                 TS2TN("F7"),   19 ), --  COMP_ID(0)/SPAR_NAME
    ( CII_COMP,   0,    0,     0,     0, CII_NA,   -1,    -1,                          -1,                          -1,    0 )  --  end of table
  );

  component MTF7_OPTO_cii_interface is
    generic(
      constant IICPAR				:TCII;
      constant IICPOS				:TVI
    );
    port(
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
  signal   out_COMP_ID                          :TSLV(II_DATA_WIDTH-1 downto 0);

begin

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
                or out_COMP_ID
  ;

end behaviour;

--  --#CII# declaration insert start for 'MTF7_OPTO' - don't edit below !
--  type TCIIpar                                            is record
--    CHECK_SUM                                             :TI;
--    COMP_ID                                               :TCII(0 to maximum(CIICompRepeatGet(IICPAR(CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)))))-1,0));
--  end record;
--
--  function CIIpar_get return TCIIpar is
--    variable res: TCIIpar;
--    variable pos, idx, len: TN;
--  begin
--    pos := CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.CHECK_SUM);
--    res.CHECK_SUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
--    pos := CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)));
--    for num in res.COMP_ID'range loop
--      res.COMP_ID(num) := IICPAR(pos+num);
--    end loop;
--    return(res);
--  end function;
--
--  constant CIIPar                                         :TCIIpar := CIIpar_get;
--
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
