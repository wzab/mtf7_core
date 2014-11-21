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
use work.CII_SYS_def.all;

package CII_SYS_prv is

  type TCIISYS_prv is record
    CIISYS_DUMMY0                    :TN;
    CIISYS_DUMMY1                    :TN;
  end record;

  constant CIISYS_prv :TCIISYS_prv := (
    0,                               -- dummy item
    0                                -- dummy item
  );

  type TCII_IDENTIFICATOR_prv is record
    CII_IDENTIFICATOR_DUMMY0         :TN;
    CII_IDENTIFICATOR_DUMMY1         :TN;
  end record;

  constant CII_IDENTIFICATOR_prv :TCII_IDENTIFICATOR_prv := (
    0,                               -- dummy item
    0                                -- dummy item
  );

  constant CII_IDENTIFICATOR_tab :TCII :=(
  --  type       ID width number repeat  access wrpos  rdpos                      addrpos                     addrlen  index
    ( CII_COMP,   0,   32,    16,     1, CII_NA,    1,    15,                         207,                           7,    0 ), --  $CII_IDENTIFICATOR
    ( CII_IPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                          32,    1 ), --  IPAR_USER_REG_WIDTH
    ( CII_IPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                   987654321,    2 ), --  IPAR_IDENTYFIER
    ( CII_SPAR,   0,    4,     1,     1, CII_NA,    0,     0,                 TS2TN("EL"),                 TS2TN("WA"),    3 ), --  SPAR_CREATOR
    ( CII_PTRP,   0,    0,     0,     0, CII_NA,   16,    -1,                          -1,                          -1,    4 ), --> SPAR_NAME
    ( CII_PTRP,   0,    0,     0,     0, CII_NA,   18,    -1,                          -1,                          -1,    5 ), --> HPAR_VERSION
    ( CII_LPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    6 ), --  LPAR_IDENTYFIER_CII
    ( CII_LPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    7 ), --  LPAR_CREATOR_CII
    ( CII_LPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    8 ), --  LPAR_NAME_CII
    ( CII_LPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                           1,    9 ), --  LPAR_VERSION_CII
    ( CII_IPAR,   0,    0,     1,     1, CII_NA,    0,     0,                           1,                           2,   10 ), --  IPAR_USER_REG_NUM
    ( CII_WORD,   0,   32,     1,     1, CII_RO,   -1,     0,                           0,                           1,   11 ), --  WORD_IDENTYFIER
    ( CII_WORD,   0,   32,     1,     1, CII_RO,   -1,    32,                           1,                           1,   12 ), --  WORD_CREATOR
    ( CII_WORD,   0,   40,     1,     1, CII_RO,   -1,    64,                           2,                           2,   13 ), --  WORD_NAME
    ( CII_WORD,   0,   40,     1,     1, CII_RO,   -1,   104,                           4,                           2,   14 ), --  WORD_VERSION
    ( CII_WORD,   0,   32,     2,     1, CII_IR,  144,   144,                           6,                           1,   15 ), --  WORD_USER
    ( CII_SPAR,   0,    5,     1,     1, CII_NA,    0,     0,                 TS2TN("lh"),                 TS2TN("ep"),   16 ), --  SPAR_NAME
    ( CII_SPAR,   0,    5,     1,     1, CII_NA,    0,     4,                           0,                  TS2TN("e"),   17 ), --  SPAR_NAME
    ( CII_HPAR,   0,   10,     1,     1, CII_NA,    0,     0,              THV2TN("3456"),              THV2TN("7890"),   18 ), --  HPAR_VERSION
    ( CII_HPAR,   0,   10,     1,     1, CII_NA,    0,     8,                           0,                THV2TN("12"),   19 ), --  HPAR_VERSION
    ( CII_COMP,   0,    0,     0,     0, CII_NA,   -1,    -1,                          -1,                          -1,    0 )  --  end of table
  );

  component CII_IDENTIFICATOR_cii_interface is
    generic(
      constant IICPAR				:TCII;
      constant IICPOS				:TVI
    );
    port(
      put_WORD_IDENTYFIER                       :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
      ren_WORD_IDENTYFIER                       :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
      put_WORD_CREATOR                          :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
      ren_WORD_CREATOR                          :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
      put_WORD_NAME                             :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
      ren_WORD_NAME                             :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
      put_WORD_VERSION                          :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
      ren_WORD_VERSION                          :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
      get_WORD_USER                             :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemNumber-1,0) downto 0);
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

end CII_SYS_prv;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all;

entity CII_IDENTIFICATOR_cii_interface is
  generic(
    constant IICPAR				:TCII;
    constant IICPOS				:TVI
  );
  port(
    put_WORD_IDENTYFIER                         :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
    ren_WORD_IDENTYFIER                         :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
    put_WORD_CREATOR                            :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
    ren_WORD_CREATOR                            :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
    put_WORD_NAME                               :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
    ren_WORD_NAME                               :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
    put_WORD_VERSION                            :in  TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
    ren_WORD_VERSION                            :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
    get_WORD_USER                               :out TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemNumber-1,0) downto 0);
    --
    II_resetN					:in  TSL;
    II_operN					:in  TSL;
    II_writeN					:in  TSL;
    II_strobeN					:in  TSL;
    II_addr					:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0);
    II_data_in					:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0);
    II_data_out					:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
  );
end CII_IDENTIFICATOR_cii_interface;

architecture behaviour of CII_IDENTIFICATOR_cii_interface is

  constant IICPOSCMP				:TVL := IICPAR(IICPOS).ItemWrPos;
  constant II_ADDR_WIDTH			:TVL := TVLcreate(IICPAR(IICPOS).ItemAddrLen);
  constant II_DATA_WIDTH			:TVL := IICPAR(IICPOS).ItemWidth;
  signal   AddrSig				:TSLV(II_ADDR_WIDTH-1 downto 0);
  --
  signal   out_WORD_IDENTYFIER                  :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_CREATOR                     :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_NAME                        :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_VERSION                     :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   out_WORD_USER                        :TSLV(II_DATA_WIDTH-1 downto 0);

begin

  --
  WORD_IDENTYFIER_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+CII_IDENTIFICATOR.WORD_IDENTYFIER),
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
      II_data_out     => out_WORD_IDENTYFIER,
      item_data_in    => put_WORD_IDENTYFIER,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_IDENTYFIER,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_CREATOR_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+CII_IDENTIFICATOR.WORD_CREATOR),
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
      II_data_out     => out_WORD_CREATOR,
      item_data_in    => put_WORD_CREATOR,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_CREATOR,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_NAME_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+CII_IDENTIFICATOR.WORD_NAME),
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
      II_data_out     => out_WORD_NAME,
      item_data_in    => put_WORD_NAME,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_NAME,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_VERSION_comp :CII_ITEM_WORD_EXT
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+CII_IDENTIFICATOR.WORD_VERSION),
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
      II_data_out     => out_WORD_VERSION,
      item_data_in    => put_WORD_VERSION,
      item_bit_in     => open,
      item_data_ren   => ren_WORD_VERSION,
      item_bit_ren    => open,
      item_data_out   => open,
      item_bit_out    => open,
      item_data_wen   => open,
      item_bit_wen    => open
    );
  --
  WORD_USER_comp :CII_ITEM_WORD_REG
    generic map(
      IICITEM        => IICPAR(IICPOSCMP+CII_IDENTIFICATOR.WORD_USER),
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
      II_data_out     => out_WORD_USER,
      item_data       => get_WORD_USER,
      item_bit        => open
    );
  --
  II_data_out <= TSLVnew(II_DATA_WIDTH,'0')
                or out_WORD_IDENTYFIER
                or out_WORD_CREATOR
                or out_WORD_NAME
                or out_WORD_VERSION
                or out_WORD_USER
  ;

end behaviour;

--  --#CII# declaration insert start for 'CII_IDENTIFICATOR' - don't edit below !
--  type TCIIpar                                            is record
--    IPAR_USER_REG_WIDTH                                   :TI;
--    IPAR_IDENTYFIER                                       :TI;
--    SPAR_CREATOR                                          :TS(1 to IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_CREATOR)))).ItemWidth);
--    SPAR_NAME                                             :TS(1 to IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_NAME)))).ItemWidth);
--    HPAR_VERSION                                          :THV(IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.HPAR_VERSION)))).ItemWidth-1 downto 0);
--    LPAR_IDENTYFIER_CII                                   :TL;
--    LPAR_CREATOR_CII                                      :TL;
--    LPAR_NAME_CII                                         :TL;
--    LPAR_VERSION_CII                                      :TL;
--    IPAR_USER_REG_NUM                                     :TI;
--    WORD_IDENTYFIER                                       :TCIIItem;
--    WORD_CREATOR                                          :TCIIItem;
--    WORD_NAME                                             :TCIIItem;
--    WORD_VERSION                                          :TCIIItem;
--    WORD_USER                                             :TCIIItem;
--  end record;
--
--  function CIIpar_get return TCIIpar is
--    variable res: TCIIpar;
--    variable pos, idx, len: TN;
--  begin
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_USER_REG_WIDTH);
--    res.IPAR_USER_REG_WIDTH := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_IDENTYFIER);
--    res.IPAR_IDENTYFIER := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
--    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_CREATOR)));
--    res.SPAR_CREATOR := (others => nul);
--    for cnt in 0 to (res.SPAR_CREATOR'length-1)/4 loop
--      idx := res.SPAR_CREATOR'length-4*cnt;
--      len := minimum(2,idx);
--      res.SPAR_CREATOR(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrLen,len);
--      len := minimum(2,maximum(idx-2,0));
--      if (len>0) then
--        idx := idx-2;
--        res.SPAR_CREATOR(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrPos,len);
--      end if;
--    end loop;
--    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_NAME)));
--    res.SPAR_NAME := (others => nul);
--    for cnt in 0 to (res.SPAR_NAME'length-1)/4 loop
--      idx := res.SPAR_NAME'length-4*cnt;
--      len := minimum(2,idx);
--      res.SPAR_NAME(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrLen,len);
--      len := minimum(2,maximum(idx-2,0));
--      if (len>0) then
--        idx := idx-2;
--        res.SPAR_NAME(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrPos,len);
--      end if;
--    end loop;
--    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.HPAR_VERSION)));
--    res.HPAR_VERSION := (others => '0');
--    for cnt in 0 to (res.HPAR_VERSION'length-1)/8 loop
--      idx := 8*cnt;
--      len := minimum(4,res.HPAR_VERSION'length-8*cnt);
--      res.HPAR_VERSION(idx+len-1 downto idx) := THVconv(IICPAR(pos+cnt).ItemAddrLen,len);
--      len := minimum(4,maximum(res.HPAR_VERSION'length-8*cnt-4,0));
--      if (len>0) then
--        idx := idx+4;
--        res.HPAR_VERSION(idx+len-1 downto idx) := THVconv(IICPAR(pos+cnt).ItemAddrPos,len);
--      end if;
--    end loop;
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_IDENTYFIER_CII);
--    res.LPAR_IDENTYFIER_CII := TLconv(IICPAR(pos).ItemAddrLen);
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_CREATOR_CII);
--    res.LPAR_CREATOR_CII := TLconv(IICPAR(pos).ItemAddrLen);
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_NAME_CII);
--    res.LPAR_NAME_CII := TLconv(IICPAR(pos).ItemAddrLen);
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_VERSION_CII);
--    res.LPAR_VERSION_CII := TLconv(IICPAR(pos).ItemAddrLen);
--    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_USER_REG_NUM);
--    res.IPAR_USER_REG_NUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
--    res.WORD_IDENTYFIER := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_IDENTYFIER));
--    res.WORD_CREATOR := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_CREATOR));
--    res.WORD_NAME := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_NAME));
--    res.WORD_VERSION := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_VERSION));
--    res.WORD_USER := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_USER));
--    return(res);
--  end function;
--
--  constant CIIPar                                         :TCIIpar := CIIpar_get;
--
--  signal   CIIput_WORD_IDENTYFIER                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
--  signal   CIIren_WORD_IDENTYFIER                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
--  signal   CIIput_WORD_CREATOR                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
--  signal   CIIren_WORD_CREATOR                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
--  signal   CIIput_WORD_NAME                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
--  signal   CIIren_WORD_NAME                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
--  signal   CIIput_WORD_VERSION                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
--  signal   CIIren_WORD_VERSION                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
--  signal   CIIget_WORD_USER                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemNumber-1,0) downto 0);
--  --#CII# declaration insert end for 'CII_IDENTIFICATOR' - don't edit above !

--  --#CII# instantation insert start for 'CII_IDENTIFICATOR' - don't edit below !
--  CIIinterf :CII_IDENTIFICATOR_cii_interface
--    generic map (
--      IICPAR                                    => IICPAR,
--      IICPOS                                    => IICPOS
--    )
--    port map (
--      put_WORD_IDENTYFIER                       => CIIput_WORD_IDENTYFIER,
--      ren_WORD_IDENTYFIER                       => CIIren_WORD_IDENTYFIER,
--      put_WORD_CREATOR                          => CIIput_WORD_CREATOR,
--      ren_WORD_CREATOR                          => CIIren_WORD_CREATOR,
--      put_WORD_NAME                             => CIIput_WORD_NAME,
--      ren_WORD_NAME                             => CIIren_WORD_NAME,
--      put_WORD_VERSION                          => CIIput_WORD_VERSION,
--      ren_WORD_VERSION                          => CIIren_WORD_VERSION,
--      get_WORD_USER                             => CIIget_WORD_USER,
--      II_resetN                                 => II_resetN,
--      II_operN                                  => ii_operN,
--      II_writeN                                 => II_writeN,
--      II_strobeN                                => II_strobeN,
--      II_addr                                   => II_addr,
--      II_data_in                                => ii_in_data,
--      II_data_out                               => ii_out_data
--  );
--  --#CII# instantation insert end for 'CII_IDENTIFICATOR' - don't edit above !
