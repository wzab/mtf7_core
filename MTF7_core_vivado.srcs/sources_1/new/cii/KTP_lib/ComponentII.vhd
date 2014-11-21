-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) by Krzysztof Pozniak		               *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library std;
USE std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

package ComponentII is
  
  constant CII_COMP :TN := 0;
  constant CII_PTRC :TN := 1;
  constant CII_IPAR :TN := 2;
  constant CII_LPAR :TN := 3;
  constant CII_HPAR :TN := 4;
  constant CII_SPAR :TN := 5;
  constant CII_VPAR :TN := 6;
  constant CII_MPAR :TN := 7;
  constant CII_OPAR :TN := 8;
  constant CII_PTRP :TN := 9;
  constant CII_AREA :TN := 10;
  constant CII_WORD :TN := 11;
  constant CII_VECT :TN := 12;
  constant CII_BITS :TN := 13;
  
  constant CII_NA :TN := 0;
  constant CII_WO :TN := 1;
  constant CII_RO :TN := 2;
  constant CII_RW :TN := 3;
  constant CII_IR :TN := 4;
  constant CII_RC :TN := 5;

  type TCIIItem is record
    ItemType				:TN;
    ItemID				:TN;
    ItemWidth				:TN;
    ItemNumber				:TN;
    ItemRepeat				:TN;
    ItemAccessType			:TN;
    ItemWrPos				:TI;
    ItemRdPos				:TI;
    ItemAddrPos				:TI;
    ItemAddrLen				:TI;
    ItemIndex				:TN;
  end record;
  type TCII is array (TN range<>) of TCIIItem;
  constant CII_null :TCII := ((0,0,0,0,0,0,0,0,0,0,0),(0,0,0,0,0,0,0,0,0,0,0));

--     impure function HeaderInitWrite(constant msg :in TS) return TL;
--     impure function CIIItemWrite(constant item :in TCIIItem; constant msg :in TS) return TL;
--     impure function TIWrite(constant val :in TI; constant msg :in TS) return TL;

  pure function TCIIItemcreate(constant hitem :TBV; constant header, key :TBV; constant index :TN) return TCIIItem;
  
  pure function CIICompDataWidthGet(constant item :TCIIItem) return TVL;
  pure function CIICompAddrWidthGet(constant item :TCIIItem) return TVL;
  pure function CIICompAddrRangeGet(constant item :TCIIItem) return TVL;
  pure function CIICompRepeatGet   (constant item :TCIIItem) return TN;
  pure function CIICompPosGet      (constant item :TCIIItem) return TVI;
  pure function CIICompPtrGet      (constant item :TCIIItem) return TVI;
  pure function CIIParamPtrGet     (constant item :TCIIItem) return TVI;
  pure function CIIParamIntGet     (constant item :TCIIItem) return TI;
  pure function CIIParamIntGet     (constant ctab :TCII; cpos :TVI; item :TN) return TI;
  pure function CIIInterfExistGet  (constant item :TCIIItem) return TL;
  
  pure function CIIItemPosGet      (constant citem :TCIIItem; CompID :TVI) return TVI;

  component CII_ITEM_BITS_REG is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_ADDR_WIDTH		:natural;
      constant II_DATA_WIDTH		:natural
    );
    port(
      II_resetN				:in  TSL;
      II_operN				:in  TSL;
      II_writeN				:in  TSL;
      II_strobeN			:in  TSL;
      II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
      II_data_in			:in  TSLV(II_DATA_WIDTH-1 downto 0);
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit   			:out TSL
    );
  end component;

  component CII_ITEM_WORD_REG is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_ADDR_WIDTH		:natural;
      constant II_DATA_WIDTH		:natural
    );
    port(
      II_resetN				:in  TSL;
      II_operN				:in  TSL;
      II_writeN				:in  TSL;
      II_strobeN			:in  TSL;
      II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
      II_data_in			:in  TSLV(II_DATA_WIDTH-1 downto 0);
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit   			:out TSL
    );
  end component;

  component CII_ITEM_BITS_EXT is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_ADDR_WIDTH		:natural;
      constant II_DATA_WIDTH		:natural;
      constant SINGLE_BIT		:boolean
    );
    port(
      II_resetN				:in  TSL;
      II_operN				:in  TSL;
      II_writeN				:in  TSL;
      II_strobeN			:in  TSL;
      II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
      II_data_in			:in  TSLV(II_DATA_WIDTH-1 downto 0);
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0) := (others => '0');
      item_bit_in   			:in  TSL := '0';
      item_ren       			:out TSL;
      item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit_out   			:out TSL;
      item_wen   			:out TSL
    );
  end component;

  component CII_ITEM_WORD_EXT is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_ADDR_WIDTH		:natural;
      constant II_DATA_WIDTH		:natural;
      constant SINGLE_BIT		:boolean
    );
    port(
      II_resetN				:in  TSL;
      II_operN				:in  TSL;
      II_writeN				:in  TSL;
      II_strobeN			:in  TSL;
      II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
      II_data_in			:in  TSLV(II_DATA_WIDTH-1 downto 0);
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0) := (others => '0');
      item_bit_in   			:in  TSL := '0';
      item_data_ren   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit_ren   			:out TSL;
      item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit_out   			:out TSL;
      item_data_wen   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
      item_bit_wen   			:out TSL
    );
  end component;

  component CII_ITEM_AREA_EXT is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_ADDR_WIDTH		:natural;
      constant II_DATA_WIDTH		:natural;
      constant SINGLE_BIT		:boolean
    );
    port(
      II_resetN				:in  TSL;
      II_operN				:in  TSL;
      II_writeN				:in  TSL;
      II_strobeN			:in  TSL;
      II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
      II_data_in			:in  TSLV(II_DATA_WIDTH-1 downto 0);
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0) := (others => '0');
      item_bit_in   			:in  TSL := '0';
      item_data_ren   			:out TSLV(maximum(IICITEM.ItemRepeat-1,0) downto 0);
      item_bit_ren   			:out TSL;
      item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0);
      item_bit_out   			:out TSL;
      item_data_wen   			:out TSLV(maximum(IICITEM.ItemRepeat-1,0) downto 0);
      item_bit_wen   			:out TSL
    );
  end component;

  component CII_ITEM_COMP is	  
    generic(
      constant IICITEM    		:TCIIItem;
      constant II_DATA_WIDTH		:natural
    );
    port(
      II_data_out			:out TSLV(II_DATA_WIDTH-1 downto 0);
      item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0)
    );
  end component;

  component II_PARALLEL_DRIVER is	  
    generic(
      II_ADDR_WIDTH	                :in  TN := 0;
      II_DATA_WIDTH	                :in  TN := 0;
      II_RESETN_SYNCH_ENA		:in  TL := FALSE;
      CLOCK_kHz		                :in  TN := 0;
      BUS_OPER_WAIT_ns                  :in  TN := 0;
      OPER_STROBE_WAIT_ns               :in  TN := 0;
      STROBE_WAIT_ns                    :in  TN := 0;
      STROBE_OPER_WAIT_ns               :in  TN := 0;
      OPER_BUS_WAIT_ns                  :in  TN := 0;
      INPUT_REGISTERED                  :in  TL := FALSE;
      RESETN_GLOBAL_ENA                 :in  TL := FALSE;
      OPERN_GLOBAL_ENA                  :in  TL := FALSE;
      WRITEN_GLOBAL_ENA                 :in  TL := FALSE;
      STROBEN_GLOBAL_ENA                :in  TL := FALSE
    );
    port(
      resetN                            :in  TSL;
      clk                               :in  TSL;
      addr                              :in  TSLV(II_ADDR_WIDTH-1 downto 0);
      data_out                          :out TSLV(II_DATA_WIDTH-1 downto 0);
      data_in                           :in  TSLV(II_DATA_WIDTH-1 downto 0);
      enable                            :in  TSL;
      write                             :in  TSL;
      read                              :in  TSL;
      ready                             :out TSL;
      error                             :out TSL;
      --
      II_resetN	                        :out TSL;
      II_operN	                        :out TSL;
      II_writeN	                        :out TSL;
      II_strobeN                        :out TSL;
      II_addr                           :out TSLV(II_ADDR_WIDTH-1 downto 0);
      II_out_data                       :out TSLV(II_DATA_WIDTH-1 downto 0);
      II_in_data                        :in  TSLV(II_DATA_WIDTH-1 downto 0)
    );
 end component;

  component UART_inode_II is
    generic (
      CLOCK_kHz                         :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0;
      II_ADDR_WIDTH                     :in    TN := 0;
      II_DATA_WIDTH                     :in    TN := 0;
      II_RESETN_SYNCH_ENA	        :in    TL := FALSE;
      II_BUS_OPER_WAIT_ns               :in    TN := 0;
      II_OPER_STROBE_WAIT_ns            :in    TN := 0;
      II_STROBE_WAIT_ns                 :in    TN := 0;
      II_STROBE_OPER_WAIT_ns            :in    TN := 0;
      II_OPER_BUS_WAIT_ns               :in    TN := 0;
      II_INPUT_REGISTERED               :in    TL := FALSE;
      II_RESETN_GLOBAL_ENA              :in    TL := FALSE;
      II_OPERN_GLOBAL_ENA               :in    TL := FALSE;
      II_WRITEN_GLOBAL_ENA              :in    TL := FALSE;
      II_STROBEN_GLOBAL_ENA             :in    TL := FALSE
    );
    port (
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSL;
      TX                                :out   TSL;
      --
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
      initN                             :in    TSL;
      ready                             :out   TSL;
      -- internal interface bus
      II_resetN                         :out   TSL;
      II_operN                          :out   TSL;
      II_writeN                         :out   TSL;
      II_strobeN                        :out   TSL;
      II_addr                           :out   TSLV(II_ADDR_WIDTH-1 downto 0);
      II_out_data                       :out   TSLV(II_DATA_WIDTH-1 downto 0);
      II_in_data                        :in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0')
    );
  end component;

  component UART_mult_inode_II is
    generic (
      MULT_NUM	                        :in    TN := 0;
      CLOCK_kHz                         :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0;
      II_ADDR_WIDTH                     :in    TN := 0;
      II_DATA_WIDTH                     :in    TN := 0;
      II_RESETN_SYNCH_ENA	        :in    TL := FALSE;
      II_BUS_OPER_WAIT_ns               :in    TN := 0;
      II_OPER_STROBE_WAIT_ns            :in    TN := 0;
      II_STROBE_WAIT_ns                 :in    TN := 0;
      II_STROBE_OPER_WAIT_ns            :in    TN := 0;
      II_OPER_BUS_WAIT_ns               :in    TN := 0;
      II_INPUT_REGISTERED               :in    TL := FALSE;
      II_RESETN_GLOBAL_ENA              :in    TL := FALSE;
      II_OPERN_GLOBAL_ENA               :in    TL := FALSE;
      II_WRITEN_GLOBAL_ENA              :in    TL := FALSE;
      II_STROBEN_GLOBAL_ENA             :in    TL := FALSE
    );
    port (
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSLV(MULT_NUM-1 downto 0);
      TX                                :out   TSLV(MULT_NUM-1 downto 0);
      --
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
      initN                             :in    TSL;
      ready                             :out   TSL;
      -- internal interface bus
      II_resetN                         :out   TSL;
      II_operN                          :out   TSL;
      II_writeN                         :out   TSL;
      II_strobeN                        :out   TSL;
      II_addr                           :out   TSLV(II_ADDR_WIDTH-1 downto 0);
      II_out_data                       :out   TSLV(II_DATA_WIDTH-1 downto 0);
      II_in_data                        :in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0')
    );
  end component;

end ComponentII;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;
use work.ktp_consistency.all;

package body ComponentII is

--  constant CII_COMP :TN := 0;
--  constant CII_PTRC :TN := 1;

--  constant FILE_NAME :TS := "CompileInfo.txt";
--
--  impure function HeaderInitWrite(constant msg :in TS) return TL is
--   File FileID :TEXT open WRITE_MODE is FILE_NAME;
--   variable l : LINE;
--  begin
--    write(l,msg);
--    writeline(FileID,l);
--    return(TRUE);
--  end;
--
--  impure function CIIItemWrite(constant item :in TCIIItem; constant msg :in TS) return TL is
--   File FileID :TEXT open APPEND_MODE is FILE_NAME;
--   variable l : LINE;
--  begin
--    write(l,msg);
--    write(l," [CIIItem] Type: ");
--    write(l,item.ItemType);
--    write(l,", Width: ");
--    write(l,item.ItemWidth);
--    write(l,", Number: ");
--    write(l,item.ItemNumber);
--    write(l,", Repeat: ");
--    write(l,item.ItemRepeat);
--    write(l,", AccessType: ");
--    write(l,item.ItemAccessType);
--    write(l,", WrPos: ");
--    write(l,item.ItemWrPos);
--    write(l,", RdPos: ");
--    write(l,item.ItemRdPos);
--    write(l,", AddrPos: ");
--    write(l,item.ItemAddrPos);
--    write(l,", AddrLen: ");
--    write(l,item.ItemAddrLen);
--    write(l,", Index: ");
--    write(l,item.ItemIndex);
--    writeline(FileID,l);
--    return(TRUE);
--  end;
--
--  impure function TIWrite(constant val :in TI; constant msg :in TS) return TL is
--   File FileID :TEXT open APPEND_MODE is FILE_NAME;
--   variable l : LINE;
--  begin
--    write(l,msg);
--    write(l," [TI]: ");
--    write(l,val);
--    writeline(FileID,l);
--    return(TRUE);
--  end;

  pure function TCIIItemcreate(constant hitem :TBV; constant header, key :TBV; constant index :TN) return TCIIItem is
    constant hres  :TBV(hitem'range) := Consistency(hitem,key,header,index,index);
  begin
    if (TNconv(hres(40 to 43))=index and TNconv(hres(44 to 47))=0) then
      return(TNconv(hres( 0 to  3)),
             TNconv(hres( 4 to  7)),
             TNconv(hres( 8 to 11)),
             TNconv(hres(12 to 15)),
             TNconv(hres(16 to 19)),
             TNconv(hres(20 to 23)),
             TNconv(hres(24 to 27)),
             TNconv(hres(28 to 31)),
             TNconv(hres(32 to 35)),
             TNconv(hres(36 to 39)),
             index
            );
    else
      assert FALSE report "Detected inconsistency data" severity error;
      return(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    end if;
  end;


  pure function \ItemCompTest\(constant item :TCIIItem) return TL is
  begin
    if (item.ItemType=CII_COMP) then
      return(TRUE);
    end if;
    return(FALSE);
  end;

  pure function \ItemCptrTest\(constant item :TCIIItem) return TL is
  begin
    if (item.ItemType=CII_PTRC) then
      return(TRUE);
    end if;
    return(FALSE);
  end;

  pure function \ItemInterfTest\(constant item :TCIIItem) return TL is
  begin
    if (item.ItemType=CII_BITS or item.ItemType=CII_WORD or item.ItemType=CII_AREA) then
      return(TRUE);
    end if;
    return(FALSE);
  end;

  pure function \ItemPosGet\(constant cpar :TCII; constant CompPos, CompID :TVI) return TVI is
    variable PosVar :TN;
  begin
    PosVar := cpar(CompPos).ItemWrPos+CompID;
    if (    cpar(CompPos).ItemType=CII_COMP and cpar(CompPos).ItemWidth>0 and cpar(CompPos).ItemNumber>0
        and (cpar(PosVar).ItemType=CII_COMP or cpar(PosVar).ItemID = cpar(CompPos).ItemID)) then
      return(PosVar);
    end if;
    return(cpar'length); --!!! invalid index is generated
  end;

  pure function CIICompAddrWidthGet(constant item :TCIIItem) return TVL is
  begin
    if (\ItemCompTest\(item)=FALSE) then return(0); end if;
    return(item.ItemNumber);
  end;

  pure function CIICompDataWidthGet(constant item :TCIIItem) return TVL is
  begin
    if (\ItemCompTest\(item)=FALSE) then return(0); end if;
    return(item.ItemWidth);
  end;

  pure function CIICompAddrRangeGet(constant item :TCIIItem) return TVL is
  begin
    if (\ItemCompTest\(item)=FALSE) then return(0); end if;
    return(TVLcreate(item.ItemAddrLen));
  end;

  pure function CIICompRepeatGet(constant item :TCIIItem) return TN is
  begin
    if (\ItemCompTest\(item)=FALSE) then return(0); end if;
    return(item.ItemRepeat);
  end;

  pure function CIICompPosGet(constant item :TCIIItem) return TVI is
  begin
    if (\ItemCompTest\(item)=FALSE) then return(NO_VEC_INDEX); end if;
    return(item.ItemIndex);
  end;

  pure function CIICompPtrGet(constant item :TCIIItem) return TVI is
  begin
    if (item.ItemType=CII_COMP) then return (item.ItemIndex); end if;
    if (item.ItemType=CII_PTRC) then
      if (item.ItemRepeat=0) then return(item.ItemIndex); end if;
      return (item.ItemWrPos);
    end if;
    assert FALSE report "Invalid CII component item" severity error;
    return(NO_VEC_INDEX);
  end;

  pure function CIIParamPtrGet(constant item :TCIIItem) return TVI is
  begin
    if ((   item.ItemType=CII_IPAR or item.ItemType=CII_LPAR or item.ItemType=CII_HPAR
         or item.ItemType=CII_SPAR or item.ItemType=CII_VPAR or item.ItemType=CII_MPAR)
        and item.ItemWrPos=0 and item.ItemRdPos=0) then
      return (item.ItemIndex);
    end if;
    if (item.ItemType=CII_PTRP) then return (item.ItemWrPos); end if;
    assert FALSE report "Invalid CII parameter item" severity error;
    return(NO_VEC_INDEX);
  end;

  pure function CIIParamIntGet(constant item :TCIIItem) return TI is
    variable tmp :TL;
  begin
    --tmp := CIIItemWrite(item, "CII IPAR item in function 'CIIItemIParGet'");
    if (item.ItemType/=CII_IPAR) then
      --tmp := TIWrite(NO_VEC_INDEX, "invalid CII IPAR item in function 'CIIItemIParGet'");
      assert FALSE report "Invalid CII IPAR item" severity error;
      return(NO_VEC_INDEX);
    end if;
    --tmp := TIWrite(item.ItemAddrPos * item.ItemAddrLen, "valid CII IPAR item in function 'CIIItemIParGet'");
    return(item.ItemAddrPos * item.ItemAddrLen);
  end;

  pure function CIIParamIntGet(constant ctab :TCII; cpos :TVI; item :TN) return TI is
  begin
    return(CIIParamIntGet(ctab(ctab(cpos).ItemWrPos+item)));
  end;

  pure function CIIInterfExistGet(constant item :TCIIItem) return TL is
  begin
    if (\ItemInterfTest\(item)=FALSE) then
      assert FALSE report "Invalid CII INTERFACE item" severity error;
      return(FALSE);
    end if;
    return((item.ItemWidth*item.ItemNumber*item.ItemRepeat)>0);
  end;

  pure function CIIItemPosGet(constant citem :TCIIItem; CompID :TVI) return TVI is
    variable tmp :TL;
    constant Res :TN := citem.ItemWrPos+CompID;
  begin
      --tmp := CIIItemWrite(item, "'CIICompPosGet'");
      --tmp := TIWrite(CompID, "'CIICompPosGet' - input");
    if (\ItemCompTest\(citem)=FALSE) then
      assert FALSE report "Invalid CII component item" severity error;
      return(NO_VEC_INDEX);
    end if;
    --tmp := TIWrite(Res, "'CIICompPosGet' - output");
    return(Res);
  end;

end ComponentII;

-------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_BITS_REG is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_ADDR_WIDTH		:natural;
    constant II_DATA_WIDTH		:natural
  );
  port(
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
    II_data_in				:in  TSLV(II_DATA_WIDTH-1 downto 0);
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit   				:out TSL
  );
end CII_ITEM_BITS_REG;

architecture behaviour of CII_ITEM_BITS_REG is

  constant ZeroCon :TSLV(II_data_out'range) := (others =>'0');
  signal   AddrCmp :TSL;
  signal   DataReg :TSLV(item_data'range);

begin 

  cond_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth/=0) generate
    --
    AddrCmp <= '1' when (II_addr=IICITEM.ItemAddrPos) else '0';
    --
    process(II_resetN, II_strobeN)
      variable StepVar :TN;
    begin
      if(II_resetN='0') then
        DataReg <= (others => '0');
      elsif(II_strobeN'event and II_strobeN='1') then
        if(II_operN='0' and II_writeN='0') then
          if (AddrCmp='1') then
            DataReg <= II_data_in(item_data'length+IICITEM.ItemAddrLen-1 downto IICITEM.ItemAddrLen);
          end if;
        end if;
      end if;
    end process;
    --
    item_data <= DataReg;
    item_bit  <= DataReg(0);
    --
    process(AddrCmp, DataReg) is
    begin
      II_data_out <= (others => '0');
      if (AddrCmp='1') then
        II_data_out(item_data'length+IICITEM.ItemAddrLen-1 downto IICITEM.ItemAddrLen) <= DataReg;
      end if;
    end process;
    --
  end generate;
  --
  cond_no_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth=0) generate
    item_data   <= (others =>'0');
    item_bit    <= '0';
    II_data_out <= (others =>'0');
  end generate;

end behaviour;

-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_WORD_REG is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_ADDR_WIDTH		:natural;
    constant II_DATA_WIDTH		:natural
  );
  port(
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
    II_data_in				:in  TSLV(II_DATA_WIDTH-1 downto 0);
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit   				:out TSL
  );
end CII_ITEM_WORD_REG;

architecture behaviour of CII_ITEM_WORD_REG is

  constant ZeroCon :TSLV(II_data_out'range) := (others =>'0');
  constant PosCnt  :TN := IICITEM.ItemRepeat*IICITEM.ItemNumber;
  signal   AddrCmp :TSLV(maximum(IICITEM.ItemAddrLen*PosCnt-1,0) downto 0);
  signal   DataReg :TSLV(item_data'range);

begin 

  cond_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth/=0) generate
    --
    cond1:
    if (PosCnt=1 and IICITEM.ItemAddrLen=1) generate
    --
      AddrCmp(0) <= '1' when (II_addr=IICITEM.ItemAddrPos) else '0';
      --
      process(II_resetN, II_strobeN)
      begin
        if(II_resetN='0') then
          DataReg <= (others => '0');
        elsif(II_strobeN'event and II_strobeN='1') then
          if(II_operN='0' and II_writeN='0') then
            if (AddrCmp(0)='1') then
              DataReg <= II_data_in(IICITEM.ItemWidth-1 downto 0);
            end if;
          end if;
        end if;
      end process;
      --
      II_data_out <= TSLVput(ZeroCon,IICITEM.ItemWidth-1,0,DataReg) when (AddrCmp(0)='1') else (others =>'0');
    --
    end generate;
    
    cond2:  
    if (PosCnt=1 and IICITEM.ItemAddrLen/=1) generate
    --
      addr_loop:
      for index in 0 to IICITEM.ItemAddrLen-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(II_resetN, II_strobeN)
        variable StepVar :TN;
      begin
        if(II_resetN='0') then
          DataReg <= (others => '0');
        elsif(II_strobeN'event and II_strobeN='1') then
          if(II_operN='0' and II_writeN='0') then
            for index in 0 to IICITEM.ItemAddrLen-2 loop
              if (AddrCmp(index)='1') then
                StepVar := II_DATA_WIDTH*index;
                DataReg(StepVar+II_DATA_WIDTH-1 downto StepVar) <= II_data_in;
              end if;
            end loop;
            if (AddrCmp(IICITEM.ItemAddrLen-1)='1') then
              StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
              DataReg(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar) <= II_data_in(StepVar-1 downto 0);
            end if;
          end if;
        end if;
      end process;
      --
      process(AddrCmp, DataReg) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
      begin
        DataVar := (others => '0');
        for index in 0 to IICITEM.ItemAddrLen-2 loop
          StepVar := II_DATA_WIDTH*index;
          DataVar := DataVar or sel(DataReg(StepVar+II_DATA_WIDTH-1 downto StepVar),'0',AddrCmp(index));
        end loop;
        StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
        DataVar(StepVar-1 downto 0) -->
        := DataVar(StepVar-1 downto 0) or sel(DataReg(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar),'0',AddrCmp(IICITEM.ItemAddrLen-1));
        II_data_out <= DataVar;
      end process;
    --
    end generate;
    
    cond3:
    if (PosCnt/=1 and IICITEM.ItemAddrLen=1) generate
    --
      addr_loop:
      for index in 0 to PosCnt-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(II_resetN, II_strobeN)
        variable StepVar :TN;
      begin
        if(II_resetN='0') then
          DataReg <= (others => '0');
        elsif(II_strobeN'event and II_strobeN='1') then
          if(II_operN='0' and II_writeN='0') then
            for count in 0 to PosCnt-1 loop
              if (AddrCmp(count)='1') then
                StepVar := IICITEM.ItemWidth*count;
                DataReg(StepVar+IICITEM.ItemWidth-1 downto StepVar) <= II_data_in(IICITEM.ItemWidth-1 downto 0);
              end if;
            end loop;
          end if;
        end if;
      end process;
      --
      process(AddrCmp, DataReg) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
      begin
        DataVar := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := IICITEM.ItemWidth*count;
          DataVar(IICITEM.ItemWidth-1 downto 0) := DataVar(IICITEM.ItemWidth-1 downto 0) -->
          or sel(DataReg(StepVar+IICITEM.ItemWidth-1 downto StepVar),'0',AddrCmp(count));
        end loop;
        II_data_out <= DataVar;
      end process;
    --
    end generate;
    
    cond4:
    if (PosCnt/=1 and IICITEM.ItemAddrLen/=1) generate
    --
      addr_loop:
      for index in 0 to PosCnt*IICITEM.ItemAddrLen-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(II_resetN, II_strobeN)
        variable StepVar :TN;
      begin
        if(II_resetN='0') then
          DataReg <= (others => '0');
        elsif(II_strobeN'event and II_strobeN='1') then
          if(II_operN='0' and II_writeN='0') then
            for count in 0 to PosCnt-1 loop
              for index in 0 to IICITEM.ItemAddrLen-2 loop
                if (AddrCmp(count*IICITEM.ItemAddrLen+index)='1') then
                  StepVar := count*IICITEM.ItemWidth+index*II_DATA_WIDTH;
                  DataReg(StepVar+II_DATA_WIDTH-1 downto StepVar) <= II_data_in;
                end if;
              end loop;
              if (AddrCmp((count+1)*IICITEM.ItemAddrLen-1)='1') then
                StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
                DataReg((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar) <= II_data_in(StepVar-1 downto 0);
              end if;
            end loop;
          end if;
        end if;
      end process;
      --
      process(AddrCmp, DataReg) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
      begin
        DataVar := (others => '0');
        for count in 0 to PosCnt-1 loop
          for index in 0 to IICITEM.ItemAddrLen-2 loop
            StepVar := count*IICITEM.ItemWidth+index*II_DATA_WIDTH;
            DataVar := DataVar or sel(DataReg(StepVar+II_DATA_WIDTH-1 downto StepVar),'0',AddrCmp(count*IICITEM.ItemAddrLen+index));
          end loop;
          StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
          DataVar(StepVar-1 downto 0) := DataVar(StepVar-1 downto 0) -->
          or sel(DataReg((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar),'0',AddrCmp((count+1)*IICITEM.ItemAddrLen-1));
        end loop;
        II_data_out <= DataVar;
      end process;
    --
    end generate;
    --
    item_data <= DataReg;
    item_bit  <= DataReg(0);
    --
  end generate;
  --
  cond_no_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth=0) generate
    item_data   <= (others =>'0');
    item_bit    <= '0';
    II_data_out <= (others =>'0');
  end generate;

end behaviour;

-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_BITS_EXT is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_ADDR_WIDTH		:natural;
    constant II_DATA_WIDTH		:natural;
    constant SINGLE_BIT			:boolean
  );
  port(
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
    II_data_in				:in  TSLV(II_DATA_WIDTH-1 downto 0);
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_in   			:in  TSL;
    item_ren       			:out TSL;
    item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_out   			:out TSL;
    item_wen   				:out TSL
  );
end CII_ITEM_BITS_EXT;

architecture behaviour of CII_ITEM_BITS_EXT is

  signal   AddrCmp :TSL;

begin 

  cond_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth/=0) generate
    --
    AddrCmp <= '1' when (II_addr=IICITEM.ItemAddrPos) else '0';
    --
    item_data_out <= II_data_in(item_data_out'length+IICITEM.ItemAddrLen-1 downto IICITEM.ItemAddrLen);
    item_bit_out  <= II_data_in(IICITEM.ItemAddrLen);
    item_ren      <= AddrCmp and not(II_operN) and II_writeN;
    item_wen      <= AddrCmp and not(II_operN) and not(II_writeN);
    --
    process(AddrCmp, item_data_in, item_bit_in) is
    begin
      II_data_out <= (others => '0');
      if (AddrCmp='1') then
        if (SINGLE_BIT=TRUE) then
          II_data_out(IICITEM.ItemAddrLen) <= item_bit_in;
        else
          II_data_out(item_data_in'length+IICITEM.ItemAddrLen-1 downto IICITEM.ItemAddrLen) <= item_data_in;
        end if;
      end if;
    end process;
    --
  end generate;
  --
  cond_no_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth=0) generate
    item_ren      <= '0';
    item_data_out <= (others =>'0');
    item_bit_out  <= '0';
    item_wen      <= '0';
    II_data_out   <= (others =>'0');
  end generate;

end behaviour;

-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_WORD_EXT is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_ADDR_WIDTH		:natural;
    constant II_DATA_WIDTH		:natural;
    constant SINGLE_BIT			:boolean
  );
  port(
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
    II_data_in				:in  TSLV(II_DATA_WIDTH-1 downto 0);
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_in   			:in  TSL;
    item_data_ren   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_ren   			:out TSL;
    item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_out   			:out TSL;
    item_data_wen   			:out TSLV(maximum(IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth-1,0) downto 0);
    item_bit_wen   			:out TSL
  );
end CII_ITEM_WORD_EXT;

architecture behaviour of CII_ITEM_WORD_EXT is

  constant PosCnt  :TN := IICITEM.ItemRepeat*IICITEM.ItemNumber;
  signal   AddrCmp :TSLV(maximum(IICITEM.ItemAddrLen*PosCnt-1,0) downto 0);

begin 

  cond_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth/=0) generate
    --
    cond1:
    if (PosCnt=1 and IICITEM.ItemAddrLen=1) generate
      --
      AddrCmp(0) <= '1' when (II_addr=IICITEM.ItemAddrPos) else '0';
      --
      item_data_out <= II_data_in(IICITEM.ItemWidth-1 downto 0);
      item_bit_out  <= II_data_in(0);
      item_data_ren <= (others => AddrCmp(0) and not(II_operN) and II_writeN);
      item_bit_ren  <= AddrCmp(0) and not(II_operN) and II_writeN;
      item_data_wen <= (others => AddrCmp(0) and not(II_operN) and not(II_writeN));
      item_bit_wen  <= AddrCmp(0) and not(II_operN) and not(II_writeN);
      --
      process(AddrCmp, item_bit_in, item_data_in) is
      begin
        II_data_out <= (others => '0');
        if (AddrCmp(0)='1') then
          if (SINGLE_BIT=TRUE) then
            II_data_out(0) <= item_bit_in;
          else
            II_data_out(IICITEM.ItemWidth-1 downto 0) <= item_data_in;
          end if;
        end if;
      end process;
    --
    end generate;
    
    cond2:  
    if (PosCnt=1 and IICITEM.ItemAddrLen/=1) generate
    --
      item_bit_ren <= '0';
      item_bit_out <= '0';
      item_bit_wen <= '0';
      addr_loop:
      for index in 0 to IICITEM.ItemAddrLen-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
        variable StepVar :TN;
        variable DataVar :TSLV(item_data_out'range);
        variable EnaVar :TSLV(item_data_out'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for index in 0 to IICITEM.ItemAddrLen-2 loop
          StepVar := II_DATA_WIDTH*index;
          DataVar(StepVar+II_DATA_WIDTH-1 downto StepVar) := II_data_in;
          EnaVar(StepVar+II_DATA_WIDTH-1 downto StepVar)  := (others => AddrCmp(index) and not(II_operN) and not(II_writeN));
        end loop;
        StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
        DataVar(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar) := II_data_in(StepVar-1 downto 0);
        EnaVar(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar)  := (others => AddrCmp(IICITEM.ItemAddrLen-1) and not(II_operN) and not(II_writeN));
        item_data_out <= DataVar;
        item_data_wen <= EnaVar;
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
        variable EnaVar :TSLV(item_data_in'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for index in 0 to IICITEM.ItemAddrLen-2 loop
          StepVar := II_DATA_WIDTH*index;
          DataVar := DataVar or sel(item_data_in(StepVar+II_DATA_WIDTH-1 downto StepVar),'0',AddrCmp(index));
          EnaVar(StepVar+II_DATA_WIDTH-1 downto StepVar) := (others => AddrCmp(index) and not(II_operN) and II_writeN);
        end loop;
        StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
        DataVar(StepVar-1 downto 0) -->
        := DataVar(StepVar-1 downto 0) or sel(item_data_in(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar),'0',AddrCmp(IICITEM.ItemAddrLen-1));
        EnaVar(IICITEM.ItemWidth-1 downto IICITEM.ItemWidth-StepVar) := (others => AddrCmp(IICITEM.ItemAddrLen-1) and not(II_operN) and II_writeN);
        --
        II_data_out   <= DataVar;
        item_data_ren <= EnaVar;
      end process;
    --
    end generate;
    
    cond3:
    if (PosCnt/=1 and IICITEM.ItemAddrLen=1) generate
    --
      item_bit_ren <= '0';
      item_bit_out <= '0';
      item_bit_wen <= '0';
      addr_loop:
      for index in 0 to PosCnt-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
        variable StepVar :TN;
        variable DataVar :TSLV(item_data_out'range);
        variable EnaVar :TSLV(item_data_out'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := IICITEM.ItemWidth*count;
          DataVar(StepVar+IICITEM.ItemWidth-1 downto StepVar) := II_data_in(IICITEM.ItemWidth-1 downto 0);
          EnaVar(StepVar+IICITEM.ItemWidth-1 downto StepVar)  := (others => AddrCmp(count) and not(II_operN) and not(II_writeN));
        end loop;
        item_data_out <= DataVar;
        item_data_wen <= EnaVar;
        item_bit_wen  <= OR_REDUCE(EnaVar);
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
        variable EnaVar :TSLV(item_data_in'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := IICITEM.ItemWidth*count;
          DataVar(IICITEM.ItemWidth-1 downto 0) := DataVar(IICITEM.ItemWidth-1 downto 0) -->
          or sel(item_data_in(StepVar+IICITEM.ItemWidth-1 downto StepVar),'0',AddrCmp(count));
          EnaVar(StepVar+IICITEM.ItemWidth-1 downto StepVar) := (others => AddrCmp(count) and not(II_operN) and II_writeN);
        end loop;
        II_data_out   <= DataVar;
        item_data_ren <= EnaVar;
      end process;
    --
    end generate;
    
    
    cond4:
    if (PosCnt/=1 and IICITEM.ItemAddrLen/=1) generate
    --
      item_bit_ren <= '0';
      item_bit_out <= '0';
      item_bit_wen <= '0';
      addr_loop:
      for index in 0 to PosCnt*IICITEM.ItemAddrLen-1 generate
        AddrCmp(index) <= '1' when (II_addr=(IICITEM.ItemAddrPos+index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
        variable StepVar :TN;
        variable DataVar :TSLV(item_data_out'range);
        variable EnaVar :TSLV(item_data_out'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          for index in 0 to IICITEM.ItemAddrLen-2 loop
            StepVar := count*IICITEM.ItemWidth+index*II_DATA_WIDTH;
            DataVar(StepVar+II_DATA_WIDTH-1 downto StepVar) := II_data_in;
            EnaVar(StepVar+II_DATA_WIDTH-1 downto StepVar) := (others => AddrCmp(count*IICITEM.ItemAddrLen+index) and not(II_operN) and not(II_writeN));
          end loop;
          StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
          DataVar((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar) := II_data_in(StepVar-1 downto 0);
          EnaVar((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar) -->
          := (others => AddrCmp((count+1)*IICITEM.ItemAddrLen-1) and not(II_operN) and not(II_writeN));
        end loop;
        item_data_out <= DataVar;
        item_data_wen <= EnaVar;
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
        variable EnaVar :TSLV(item_data_in'range);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          for index in 0 to IICITEM.ItemAddrLen-2 loop
            StepVar := count*IICITEM.ItemWidth+index*II_DATA_WIDTH;
            DataVar := DataVar or sel(item_data_in(StepVar+II_DATA_WIDTH-1 downto StepVar),'0',AddrCmp(count*IICITEM.ItemAddrLen+index));
            EnaVar(StepVar+II_DATA_WIDTH-1 downto StepVar) := (others => AddrCmp(count) and not(II_operN) and II_writeN);
          end loop;
          StepVar := IICITEM.ItemWidth-II_DATA_WIDTH*(IICITEM.ItemAddrLen-1);
          DataVar(StepVar-1 downto 0) := DataVar(StepVar-1 downto 0) -->
          or sel(item_data_in((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar),'0',AddrCmp((count+1)*IICITEM.ItemAddrLen-1));
          EnaVar((count+1)*IICITEM.ItemWidth-1 downto (count+1)*IICITEM.ItemWidth-StepVar) -->
          := (others => AddrCmp((count+1)*IICITEM.ItemAddrLen-1) and not(II_operN) and II_writeN);
        end loop;
        II_data_out   <= DataVar;
        item_data_ren <= EnaVar;
      end process;
    --
    end generate;
    --
  end generate;
  --
  cond_no_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth=0) generate
    item_data_ren <= (others =>'0');
    item_bit_ren  <= '0';
    item_data_out <= (others =>'0');
    item_bit_out  <= '0';
    item_data_wen <= (others =>'0');
    item_bit_wen  <= '0';
    II_data_out   <= (others =>'0');
  end generate;

end behaviour;

-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_AREA_EXT is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_ADDR_WIDTH		:natural;
    constant II_DATA_WIDTH		:natural;
    constant SINGLE_BIT			:boolean
  );
  port(
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(II_ADDR_WIDTH-1 downto 0);
    II_data_in				:in  TSLV(II_DATA_WIDTH-1 downto 0);
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0);
    item_bit_in   			:in  TSL;
    item_data_ren   			:out TSLV(maximum(IICITEM.ItemRepeat-1,0) downto 0);
    item_bit_ren   			:out TSL;
    item_data_out   			:out TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0);
    item_bit_out   			:out TSL;
    item_data_wen   			:out TSLV(maximum(IICITEM.ItemRepeat-1,0) downto 0);
    item_bit_wen   			:out TSL
  );
end CII_ITEM_AREA_EXT;

architecture behaviour of CII_ITEM_AREA_EXT is

  constant ADDR_MASK :TN := TVLcreate(maximum(IICITEM.ItemNumber-1,0));
  constant ADDR_STEP :TN := 2**ADDR_MASK;
  constant PosCnt    :TN := IICITEM.ItemRepeat;
  signal   AddrCmp   :TSLV(maximum(IICITEM.ItemAddrLen*PosCnt-1,0) downto 0);
  signal   AddrMask  :TSLV(II_ADDR_WIDTH-1 downto 0);

begin

  AddrMask <= II_addr(II_addr'length-1 downto ADDR_MASK) & TSLVnew(ADDR_MASK,'0'); 

  cond_exist:
  if (IICITEM.ItemRepeat/=0) generate
    --
    cond1:
    if (PosCnt=1 and IICITEM.ItemAddrLen=1) generate
    --
      AddrCmp(0) <= '1' when (AddrMask=IICITEM.ItemAddrPos) else '0';
      --
      item_data_out <= II_data_in;
      item_bit_out  <= II_data_in(0);
      item_data_wen <= (others => AddrCmp(0) and not(II_operN) and not(II_writeN));
      item_bit_wen  <= AddrCmp(0) and not(II_operN) and not(II_writeN);
      item_data_ren <= (others => AddrCmp(0) and not(II_operN) and II_writeN);
      item_bit_ren  <= AddrCmp(0) and not(II_operN) and II_writeN;
      --
      process(AddrCmp, item_data_in, item_bit_in) is
      begin
        II_data_out <= (others => '0');
        if (AddrCmp(0)='1') then
          if (SINGLE_BIT=TRUE) then
            II_data_out(0) <= item_bit_in;
          else
            II_data_out(IICITEM.ItemWidth-1 downto 0) <= item_data_in(IICITEM.ItemWidth-1 downto 0);
          end if;
        end if;
      end process;
    --
    end generate;
    
    cond2:  
    if (PosCnt=1 and IICITEM.ItemAddrLen/=1) generate
    --
      addr_loop:
      for index in 0 to IICITEM.ItemAddrLen-1 generate
        AddrCmp(index) <= '1' when (AddrMask=(IICITEM.ItemAddrPos+ADDR_STEP*index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
      begin
        item_data_out <= II_data_in;
        item_data_wen <= (others => OR_REDUCE(AddrCmp) and not(II_operN) and not(II_writeN));
        item_bit_wen  <= OR_REDUCE(AddrCmp) and not(II_operN) and not(II_writeN);
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
      begin
        II_data_out   <= sel(item_data_in,'0',OR_REDUCE(AddrCmp));
        item_data_ren <= (others => OR_REDUCE(AddrCmp) and not(II_operN) and II_writeN);
        item_bit_ren  <= OR_REDUCE(AddrCmp) and not(II_operN) and II_writeN;
      end process;
    --
    end generate;
    
    cond3:
    if (PosCnt/=1 and IICITEM.ItemAddrLen=1) generate
    --
      addr_loop:
      for index in 0 to PosCnt-1 generate
        AddrCmp(index) <= '1' when (AddrMask=(IICITEM.ItemAddrPos+ADDR_STEP*index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
        variable StepVar :TN;
        variable DataVar :TSLV(item_data_out'range);
        variable EnaVar :TSLV(PosCnt-1 downto 0);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := II_ADDR_WIDTH*count;
          DataVar(StepVar+IICITEM.ItemWidth-1 downto StepVar) := II_data_in;--(IICITEM.ItemWidth-1 downto 0);
          EnaVar(count) := AddrCmp(count) and not(II_operN) and not(II_writeN);
        end loop;
        item_data_out <= DataVar;
        item_data_wen <= EnaVar;
        item_bit_wen  <= OR_REDUCE(EnaVar);
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
        variable EnaVar :TSLV(PosCnt-1 downto 0);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := II_DATA_WIDTH*count;
          DataVar(IICITEM.ItemWidth-1 downto 0) := DataVar(IICITEM.ItemWidth-1 downto 0) -->
          or sel(item_data_in(StepVar+IICITEM.ItemWidth-1 downto StepVar),'0',AddrCmp(count));
          EnaVar(count) := AddrCmp(count) and not(II_operN) and II_writeN;
        end loop;
        II_data_out   <= DataVar;
        item_data_ren <= EnaVar;
        item_bit_ren  <= OR_REDUCE(EnaVar);
      end process;
    --
    end generate;
    
    
    cond4:
    if (PosCnt/=1 and IICITEM.ItemAddrLen/=1) generate
    --
      addr_loop:
      for index in 0 to PosCnt-1 generate
        AddrCmp(index) <= '1' when (AddrMask=(IICITEM.ItemAddrPos+ADDR_STEP*index)) else '0';
      end generate;
      --
      process(AddrCmp, II_operN, II_writeN, II_data_in)
        variable StepVar :TN;
        variable DataVar :TSLV(item_data_out'range);
        variable EnaVar :TSLV(PosCnt-1 downto 0);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
          StepVar := II_ADDR_WIDTH*count;
          DataVar(StepVar+IICITEM.ItemWidth-1 downto StepVar) := II_data_in;--(IICITEM.ItemWidth-1 downto 0);
          EnaVar(count) := AddrCmp(count) and not(II_operN) and not(II_writeN);
        end loop;
        item_data_out <= DataVar;
        item_data_wen <= EnaVar;
        item_bit_wen  <= OR_REDUCE(EnaVar);
      end process;
      --
      process(AddrCmp, II_operN, II_writeN, item_data_in) is
        variable StepVar :TN;
        variable DataVar :TSLV(II_data_out'range);
        variable EnaVar :TSLV(PosCnt-1 downto 0);
      begin
        DataVar := (others => '0');
        EnaVar  := (others => '0');
        for count in 0 to PosCnt-1 loop
            StepVar := II_DATA_WIDTH*count;
            DataVar := DataVar or sel(item_data_in(StepVar+II_DATA_WIDTH-1 downto StepVar),'0',AddrCmp(count));
            EnaVar(count) := AddrCmp(count) and not(II_operN) and II_writeN;
        end loop;
        II_data_out   <= DataVar;
        item_data_ren <= EnaVar;
        item_bit_ren  <= OR_REDUCE(EnaVar);
      end process;
    --
    end generate;
    --
  end generate;
  --
  cond_no_exist:
  if (IICITEM.ItemRepeat*IICITEM.ItemNumber*IICITEM.ItemWidth=0) generate
    item_data_ren <= (others =>'0');
    item_bit_ren  <= '0';
    item_data_out <= (others =>'0');
    item_bit_out  <= '0';
    item_data_wen <= (others =>'0');
    item_bit_wen  <= '0';
    II_data_out   <= (others =>'0');
  end generate;

end behaviour;

-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;

entity CII_ITEM_COMP is	  
  generic(
    constant IICITEM    		:TCIIItem;
    constant II_DATA_WIDTH		:natural
  );
  port(
    II_data_out				:out TSLV(II_DATA_WIDTH-1 downto 0);
    item_data_in   			:in  TSLV(maximum(IICITEM.ItemRepeat*II_DATA_WIDTH-1,0) downto 0)
  );
end CII_ITEM_COMP;

architecture behaviour of CII_ITEM_COMP is
begin

  process(item_data_in) is
    variable res : TSLV(II_DATA_WIDTH-1 downto 0);
    variable val : TSLV(II_DATA_WIDTH-1 downto 0);
  begin
    res := (others =>'0');
    if (IICITEM.ItemRepeat>0) then
      for index in 0 to IICITEM.ItemRepeat-1 loop
        val := (others =>'0');
        val(IICITEM.ItemWidth-1 downto 0) := SLVPartGet(item_data_in,IICITEM.ItemWidth,index);
        res := res or val;
      end loop;
    end if;
    II_data_out <= res;
  end process;
  
end behaviour;



-----------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.ComponentII.all;

entity II_PARALLEL_DRIVER is	  
  generic(
    II_ADDR_WIDTH	:in  TN := 16;
    II_DATA_WIDTH	:in  TN := 16;
    II_RESETN_SYNCH_ENA	:in  TL := FALSE;
    CLOCK_kHz		:in  TN := 62500;
    BUS_OPER_WAIT_ns    :in  TN := 20;
    OPER_STROBE_WAIT_ns :in  TN := 25;
    STROBE_WAIT_ns      :in  TN := 100;
    STROBE_OPER_WAIT_ns :in  TN := 25;
    OPER_BUS_WAIT_ns    :in  TN := 20;
    INPUT_REGISTERED    :in  TL := TRUE;
    RESETN_GLOBAL_ENA   :in  TL := FALSE;
    OPERN_GLOBAL_ENA    :in  TL := FALSE;
    WRITEN_GLOBAL_ENA   :in  TL := FALSE;
    STROBEN_GLOBAL_ENA  :in  TL := FALSE
  );
  port(
    resetN              :in  TSL;
    clk                 :in  TSL;
    addr                :in  TSLV(II_ADDR_WIDTH-1 downto 0);
    data_out            :out TSLV(II_DATA_WIDTH-1 downto 0);
    data_in             :in  TSLV(II_DATA_WIDTH-1 downto 0);
    enable              :in  TSL;
    write               :in  TSL;
    read                :in  TSL;
    ready               :out TSL;
    error               :out TSL;
    --
    II_resetN		:out   TSL;
    II_operN		:out   TSL;
    II_writeN		:out   TSL;
    II_strobeN		:out   TSL;
    II_addr		:out   TSLV(II_ADDR_WIDTH-1 downto 0);
    II_out_data		:out   TSLV(II_DATA_WIDTH-1 downto 0);
    II_in_data		:in    TSLV(II_DATA_WIDTH-1 downto 0)
  );
end II_PARALLEL_DRIVER;

architecture behaviour of II_PARALLEL_DRIVER is
  --
  constant BUS_OPER_COUNT       :TN := (BUS_OPER_WAIT_ns*CLOCK_kHz)/1000000;   
  constant OPER_STROBE_COUNT    :TN := (OPER_STROBE_WAIT_ns*CLOCK_kHz)/1000000;
  constant STROBE_COUNT         :TN := (STROBE_WAIT_ns*CLOCK_kHz)/1000000;     
  constant STROBE_OPER_COUNT    :TN := (STROBE_OPER_WAIT_ns*CLOCK_kHz)/1000000;
  constant OPER_BUS_COUNT       :TN := (OPER_BUS_WAIT_ns*CLOCK_kHz)/1000000;
  --
  type     T_II_STATE           is (II_IDLE,
                                    BUS_OPER_WAIT, OPER_STROBE_WAIT, STROBE_WAIT, STROBE_OPER_WAIT, OPER_BUS_WAIT,
                                    II_STOP,
                                    II_ERROR
                                   );
  --
  signal   AddrReg              :TSLV(II_ADDR_WIDTH-1 downto 0);
  signal   DataInReg            :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   EnableReg            :TSL;
  signal   WriteReg             :TSL;
  signal   ReadReg              :TSL;
  --
  signal   ii_state             :T_II_STATE;
  signal   IIReadyReg           :TSL;
  signal   IIErrorReg           :TSL;
  signal   IIwriteReg           :TSL;
  signal   IIoperReg            :TSL;
  signal   IIstrobeReg          :TSL;
  signal   IIaddrReg            :TSLV(II_ADDR_WIDTH-1 downto 0);
  signal   IIdataOutReg         :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   IIdataInReg          :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   BusOperCnt           :TSLV(TVLcreate(BUS_OPER_COUNT)-1 downto 0);
  signal   OperStrobeCnt        :TSLV(TVLcreate(OPER_STROBE_COUNT)-1 downto 0);
  signal   StrobeCnt            :TSLV(TVLcreate(STROBE_COUNT)-1 downto 0);
  signal   StrobeOperCnt        :TSLV(TVLcreate(STROBE_OPER_COUNT)-1 downto 0);
  signal   OperBusCnt           :TSLV(TVLcreate(OPER_BUS_COUNT)-1 downto 0);
  --
  signal   II_resetNsig		:TSL;
  signal   II_operNsig		:TSL;
  signal   II_writeNsig		:TSL;
  signal   II_strobeNsig	:TSL;

begin
  --
  ireg : process (clk, resetN) is
    variable clkv :TL;
  begin
    if (INPUT_REGISTERED=TRUE) then clkv := clk'event and clk='1'; else clkv := TRUE; end if; 
    if (resetN='0' and INPUT_REGISTERED=TRUE)then
      AddrReg    <= (others => '0');
      DataInReg  <= (others => '0');
      EnableReg  <= '0';
      WriteReg   <= '0';
      ReadReg    <= '0';
    elsif (clkv) then
      AddrReg    <= addr;
      DataInReg  <= data_in;
      EnableReg  <= enable;
      WriteReg   <= write;
      ReadReg    <= read;
    end if;
  end process ireg;
  --
  ii : process (clk, resetN) is
  begin
    if (resetN='0') then
      IIReadyReg    <= '0';
      IIErrorReg    <= '0';
      IIwriteReg    <= '0';
      IIoperReg     <= '0';
      IIstrobeReg   <= '0';
      IIaddrReg     <= (others => '0');
      IIdataOutReg  <= (others => '0');
      IIdataInReg   <= (others => '0');
      BusOperCnt    <= (others => '0');
      OperStrobeCnt <= (others => '0');
      StrobeCnt     <= (others => '0');
      StrobeOperCnt <= (others => '0');
      OperBusCnt    <= (others => '0');
      ii_state      <= II_IDLE;
    elsif clk'event and clk = '1' then
      if (EnableReg='0') then
        ii_state    <= II_IDLE;
        IIerrorReg  <= '0';
      else
        IIReadyReg <= '0';
        case ii_state is
          when II_IDLE =>
            IIoperReg     <= '0';
            IIstrobeReg   <= '0';
            IIwriteReg    <= '0';
            BusOperCnt    <= TSLVconv(BUS_OPER_COUNT,   BusOperCnt'length);
            OperStrobeCnt <= TSLVconv(OPER_STROBE_COUNT,OperStrobeCnt'length);
            StrobeCnt     <= TSLVconv(STROBE_COUNT,     StrobeCnt'length);
            StrobeOperCnt <= TSLVconv(STROBE_OPER_COUNT,StrobeOperCnt'length);
            OperBusCnt    <= TSLVconv(OPER_BUS_COUNT,   OperBusCnt'length);
            if ((WriteReg='1' and ReadReg='0') or (ReadReg='1' and WriteReg='0')) then
              IIwriteReg    <= WriteReg;
              IIaddrReg     <= AddrReg;
              IIdataOutReg  <= DataInReg;
              ii_state  <= BUS_OPER_WAIT;
            elsif (WriteReg='1' and ReadReg='1') then
              ii_state  <= II_ERROR;
            end if;
          when BUS_OPER_WAIT =>
            if (BusOperCnt/=0) then
              BusOperCnt <= BusOperCnt - 1;
            else
              IIoperReg <= '1';
              ii_state  <= OPER_STROBE_WAIT;
            end if;
          when OPER_STROBE_WAIT =>
            if (OperStrobeCnt/=0) then
              OperStrobeCnt <= OperStrobeCnt - 1;
            else
              IIstrobeReg <= '1';
              ii_state    <= STROBE_WAIT;
            end if;
          when STROBE_WAIT =>
            if (StrobeCnt/=0) then
              StrobeCnt <= StrobeCnt - 1;
            else
              IIdataInReg <= II_in_data;
              IIstrobeReg <= '0';
              ii_state    <= STROBE_OPER_WAIT;
            end if;
          when STROBE_OPER_WAIT =>
            if (StrobeOperCnt/=0) then
              StrobeOperCnt <= StrobeOperCnt - 1;
            else
              IIoperReg <= '0';
              ii_state  <= OPER_BUS_WAIT;
            end if;
          when OPER_BUS_WAIT =>
            if (OperBusCnt/=0) then
              OperBusCnt <= OperBusCnt - 1;
            else
              ii_state <= II_STOP;
            end if;
          when II_STOP =>
            IIReadyReg <= '1';
            ii_state <= II_IDLE;
          when others =>
            IIErrorReg <= '1';
        end case;
      end if;
    end if;
  end process ii;
  --
  data_out <= IIdataInReg;
  ready    <= IIReadyReg;
  error    <= IIErrorReg;
  --
  II_operNsig   <= not(IIoperReg);
  II_writeNsig  <= not(IIwriteReg);
  II_strobeNsig <= not(IIstrobeReg);
  II_addr       <= IIaddrReg;
  II_out_data   <= IIdataOutReg;
  --
  --
  rsynN: if (II_RESETN_SYNCH_ENA=FALSE) generate
    II_resetNsig <= resetN;
  end generate;
  --
  rsynT: if (II_RESETN_SYNCH_ENA=TRUE) generate
    res : process (clk, resetN) is
    begin
      if (resetN='0') then
        II_resetNsig <= '0';
      elsif clk'event and clk = '1' then
        II_resetNsig <= resetN;
      end if;
    end process res;
  end generate;
  --
  --
  resGN: if (RESETN_GLOBAL_ENA=FALSE) generate
    II_resetN <= II_resetNsig;
  end generate;
  --
  resGT: if (RESETN_GLOBAL_ENA=TRUE) generate
    resG :UT_GLOBAL port map(I=>II_resetNsig, O=>II_resetN);
  end generate;
  --
  --
  operGN: if (OPERN_GLOBAL_ENA=FALSE) generate
    II_operN <= II_operNsig;
  end generate;
  --
  operGT: if (OPERN_GLOBAL_ENA=TRUE) generate
    operG :UT_GLOBAL port map(I=>II_operNsig, O=>II_operN);
  end generate;
  --
  --
  writeGN: if (WRITEN_GLOBAL_ENA=FALSE) generate
    II_writeN <= II_writeNsig;
  end generate;
  --
  writeGT: if (WRITEN_GLOBAL_ENA=TRUE) generate
    writeG :UT_GLOBAL port map(I=>II_writeNsig, O=>II_writeN);
  end generate;
  --
  --
  strobeGN: if (STROBEN_GLOBAL_ENA=FALSE) generate
    II_strobeN <= II_strobeNsig;
  end generate;
  --
  strobeGT: if (STROBEN_GLOBAL_ENA=TRUE) generate
    strobeG :UT_GLOBAL port map(I=>II_strobeNsig, O=>II_strobeN);
  end generate;

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.componentII.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_inode_II is
  generic (
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5;
    II_ADDR_WIDTH                     :in    TN := 16;
    II_DATA_WIDTH                     :in    TN := 32;
    II_RESETN_SYNCH_ENA	              :in    TL := FALSE;
    II_BUS_OPER_WAIT_ns               :in    TN := 20;
    II_OPER_STROBE_WAIT_ns            :in    TN := 25;
    II_STROBE_WAIT_ns                 :in    TN := 100;
    II_STROBE_OPER_WAIT_ns            :in    TN := 25;
    II_OPER_BUS_WAIT_ns               :in    TN := 20;
    II_INPUT_REGISTERED               :in    TL := TRUE;
    II_RESETN_GLOBAL_ENA              :in    TL := FALSE;
    II_OPERN_GLOBAL_ENA               :in    TL := FALSE;
    II_WRITEN_GLOBAL_ENA              :in    TL := FALSE;
    II_STROBEN_GLOBAL_ENA             :in    TL := FALSE
  );
  port (
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSL;
    TX                                :out   TSL;
    --
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    initN                             :in    TSL;
    ready                             :out   TSL;
    -- internal interface bus
    II_resetN                         :out   TSL;
    II_operN                          :out   TSL;
    II_writeN                         :out   TSL;
    II_strobeN                        :out   TSL;
    II_addr                           :out   TSLV(II_ADDR_WIDTH-1 downto 0);
    II_out_data                       :out   TSLV(II_DATA_WIDTH-1 downto 0);
    II_in_data                        :in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0')
  );
end UART_inode_II;

architecture behaviour of UART_inode_II is

  signal AddrSig        :TSLV(II_ADDR_WIDTH-1 downto 0);
  signal DataOutSig     :TSLV(II_DATA_WIDTH-1 downto 0);
  signal DataInSig      :TSLV(II_DATA_WIDTH-1 downto 0); 
  signal WriteSig       :TSL;
  signal ReadSig        :TSL;
  signal AckSig         :TSL;

begin

  inode :UART_inode
    generic map (
      CLOCK_kHz	           => CLOCK_kHz,
      BAUD_kHz             => BAUD_kHz,
      ID_SIZE              => ID_SIZE,
      ADDR_SIZE            => II_ADDR_WIDTH,
      DATA_SIZE            => II_DATA_WIDTH,
      BUF_SIZE             => 0,
      SEND_BOUD_DELAY      => SEND_BOUD_DELAY
    )
    port map (
      resetN               => resetN,
      clk                  => clk,
      --
      RX                   => RX,
      TX                   => TX,
      --
      id                   => id,
      addr                 => AddrSig,
      data_out             => DataOutSig,
      data_in              => DataInSig,
      write                => WriteSig,
      read                 => ReadSig,
      ack                  => AckSig,
      --
      initN                => initN,
      ready                => ready
    );
  --
  iidrv: II_PARALLEL_DRIVER	  
    generic map(
      II_ADDR_WIDTH	  => II_ADDR_WIDTH,
      II_DATA_WIDTH	  => II_DATA_WIDTH,
      II_RESETN_SYNCH_ENA => II_RESETN_SYNCH_ENA,
      CLOCK_kHz		  => CLOCK_kHz,
      BUS_OPER_WAIT_ns    => II_BUS_OPER_WAIT_ns,
      OPER_STROBE_WAIT_ns => II_OPER_STROBE_WAIT_ns,
      STROBE_WAIT_ns      => II_STROBE_WAIT_ns,
      STROBE_OPER_WAIT_ns => II_STROBE_OPER_WAIT_ns,
      OPER_BUS_WAIT_ns    => II_OPER_BUS_WAIT_ns,
      INPUT_REGISTERED    => II_INPUT_REGISTERED,
      RESETN_GLOBAL_ENA   => II_RESETN_GLOBAL_ENA,
      OPERN_GLOBAL_ENA    => II_OPERN_GLOBAL_ENA,
      WRITEN_GLOBAL_ENA   => II_WRITEN_GLOBAL_ENA,
      STROBEN_GLOBAL_ENA  => II_STROBEN_GLOBAL_ENA
    )
    port map(
      resetN              => resetN,
      clk                 => clk,
      addr                => AddrSig,
      data_out            => DataInSig,
      data_in             => DataOutSig,
      enable              => '1',
      write               => WriteSig,
      read                => ReadSig,
      ready               => AckSig,
      error               => open,
      --
      II_resetN	          => II_resetN,
      II_operN	          => ii_operN,
      II_writeN	          => ii_writeN,
      II_strobeN          => II_strobeN,
      II_addr             => ii_addr,
      II_out_data         => ii_out_data,
      II_in_data          => ii_in_data
    );

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.componentII.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_mult_inode_II is
  generic (
    MULT_NUM	                      :in    TN := 4;
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5;
    II_ADDR_WIDTH                     :in    TN := 16;
    II_DATA_WIDTH                     :in    TN := 32;
    II_RESETN_SYNCH_ENA	              :in    TL := FALSE;
    II_BUS_OPER_WAIT_ns               :in    TN := 20;
    II_OPER_STROBE_WAIT_ns            :in    TN := 25;
    II_STROBE_WAIT_ns                 :in    TN := 100;
    II_STROBE_OPER_WAIT_ns            :in    TN := 25;
    II_OPER_BUS_WAIT_ns               :in    TN := 20;
    II_INPUT_REGISTERED               :in    TL := TRUE;
    II_RESETN_GLOBAL_ENA              :in    TL := FALSE;
    II_OPERN_GLOBAL_ENA               :in    TL := FALSE;
    II_WRITEN_GLOBAL_ENA              :in    TL := FALSE;
    II_STROBEN_GLOBAL_ENA             :in    TL := FALSE
  );
  port (
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSLV(MULT_NUM-1 downto 0);
    TX                                :out   TSLV(MULT_NUM-1 downto 0);
    --
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    initN                             :in    TSL;
    ready                             :out   TSL;
    -- internal interface bus
    II_resetN                         :out   TSL;
    II_operN                          :out   TSL;
    II_writeN                         :out   TSL;
    II_strobeN                        :out   TSL;
    II_addr                           :out   TSLV(II_ADDR_WIDTH-1 downto 0);
    II_out_data                       :out   TSLV(II_DATA_WIDTH-1 downto 0);
    II_in_data                        :in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0')
  );
end UART_mult_inode_II;

architecture behaviour of UART_mult_inode_II is

  signal AddrSig        :TSLV(II_ADDR_WIDTH-1 downto 0);
  signal DataOutSig     :TSLV(II_DATA_WIDTH-1 downto 0);
  signal DataInSig      :TSLV(II_DATA_WIDTH-1 downto 0); 
  signal WriteSig       :TSL;
  signal ReadSig        :TSL;
  signal AckSig         :TSL;

begin

  inode :UART_mult_inode
    generic map (
      MULT_NUM	           => MULT_NUM,
      CLOCK_kHz	           => CLOCK_kHz,
      BAUD_kHz             => BAUD_kHz,
      ID_SIZE              => ID_SIZE,
      ADDR_SIZE            => II_ADDR_WIDTH,
      DATA_SIZE            => II_DATA_WIDTH,
      BUF_SIZE             => 0,
      SEND_BOUD_DELAY      => SEND_BOUD_DELAY
    )
    port map (
      resetN               => resetN,
      clk                  => clk,
      --
      RX                   => RX,
      TX                   => TX,
      --
      id                   => id,
      addr                 => AddrSig,
      data_out             => DataOutSig,
      data_in              => DataInSig,
      write                => WriteSig,
      read                 => ReadSig,
      ack                  => AckSig,
      --
      initN                => initN,
      ready                => ready
    );
  --
  iidrv: II_PARALLEL_DRIVER	  
    generic map(
      II_ADDR_WIDTH	  => II_ADDR_WIDTH,
      II_DATA_WIDTH	  => II_DATA_WIDTH,
      II_RESETN_SYNCH_ENA => II_RESETN_SYNCH_ENA,
      CLOCK_kHz		  => CLOCK_kHz,
      BUS_OPER_WAIT_ns    => II_BUS_OPER_WAIT_ns,
      OPER_STROBE_WAIT_ns => II_OPER_STROBE_WAIT_ns,
      STROBE_WAIT_ns      => II_STROBE_WAIT_ns,
      STROBE_OPER_WAIT_ns => II_STROBE_OPER_WAIT_ns,
      OPER_BUS_WAIT_ns    => II_OPER_BUS_WAIT_ns,
      INPUT_REGISTERED    => II_INPUT_REGISTERED,
      RESETN_GLOBAL_ENA   => II_RESETN_GLOBAL_ENA,
      OPERN_GLOBAL_ENA    => II_OPERN_GLOBAL_ENA,
      WRITEN_GLOBAL_ENA   => II_WRITEN_GLOBAL_ENA,
      STROBEN_GLOBAL_ENA  => II_STROBEN_GLOBAL_ENA
    )
    port map(
      resetN              => resetN,
      clk                 => clk,
      addr                => AddrSig,
      data_out            => DataInSig,
      data_in             => DataOutSig,
      enable              => '1',
      write               => WriteSig,
      read                => ReadSig,
      ready               => AckSig,
      error               => open,
      --
      II_resetN	          => II_resetN,
      II_operN	          => ii_operN,
      II_writeN	          => ii_writeN,
      II_strobeN          => II_strobeN,
      II_addr             => ii_addr,
      II_out_data         => ii_out_data,
      II_in_data          => ii_in_data
    );

end behaviour;

