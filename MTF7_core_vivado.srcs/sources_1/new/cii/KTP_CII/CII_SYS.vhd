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
use work.ComponentII.all;
use work.CII_SYS_def.all;
use work.CII_SYS_prv.all;

package CII_SYS_dec is

  function CII_SYS_CTRL_IsReg(constant mode: TN) return TL;
  function CII_SYS_CTRL_IsCII(constant mode: TN) return TL;
  procedure CII_SYS_CTRL_GetFlag(constant mode :in TN; constant val :in TL; csig, esig, risig: in TSL; signal rosig, osig :out TSL);
  procedure CII_SYS_CTRL_GetVect(constant mode :in TN; constant val :in TSLV; csig, esig, risig: in TSLV; signal rosig, osig :out TSLV);
  procedure CII_SYS_STAT_GetFlag(constant mode :in TN; constant val :in TL; csig, risig: in TSL; signal rosig, osig :out TSL);
  procedure CII_SYS_STAT_GetVect(constant mode :in TN; constant val :in TSLV; csig, risig: in TSLV; signal rosig, osig :out TSLV);

  component CII_SYS_CTRL_IR_FLAG is
    generic(
      constant MODE			:TN;
      constant CIIVAL			:TL := FALSE
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL := '0';
      cii_flag				:in  TSL := '0';
      ext_flag				:in  TSL := '0';
      flag				:out TSL
    );
  end component;

  component CII_SYS_CTRL_IR_VECT is
    generic(
      constant MODE			:in  TN;
      constant CIIVAL			:in  TSLV;
      constant LEN			:in  TN   := 0
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL := '0';
      cii_vect				:in  TSLV(sel(LEN-1,0,CII_SYS_CTRL_IsCII(MODE)) downto 0) := (others => '0');
      ext_vect				:in  TSLV(LEN-1 downto 0) := (others => '0');
      vect				:out TSLV(LEN-1 downto 0)
    );
  end component;

  component CII_SYS_STAT_FLAG is
    generic(
      constant MODE			:TN;
      constant CIIVAL			:TL := FALSE
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL := '0';
      cii_flag				:in  TSL := '0';
      flag				:out TSL
    );
  end component;

  component CII_SYS_STAT_VECT is
    generic(
      constant MODE			:in  TN;
      constant CIIVAL			:in  TSLV;
      constant LEN			:in  TN   := 0
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL := '0';
      cii_vect				:in  TSLV(sel(LEN-1,0,CII_SYS_CTRL_IsCII(MODE)) downto 0) := (others => '0');
      vect				:out TSLV(LEN-1 downto 0)
    );
  end component;

  component CII_SYS_STROBE_REG is
    generic(
      constant SINGLE_ENA		:in  TL := TRUE
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL;
      enable				:in  TSL := '1';
      strobeN				:in  TSL;
      flag				:out TSL
    );
  end component;
  
  component CII_SYS_FLAG_HOLD is
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL;
      clk_flag				:in  TSL;
      operN				:in  TSL;
      cii_flag				:out TSL
    );
  end component;

  component CII_SYS_VECT_HOLD is
    generic(
      constant LEN			:in  TN   := 0
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL;
      clk_vect				:in  TSLV(LEN-1 downto 0);
      operN				:in  TSL;
      cii_vect				:out TSLV(LEN-1 downto 0)
    );
  end component;

  component CCII_IDENTIFICATOR is
    generic(
      constant IICPAR			:TCII;
      constant IICPOS			:TVI
    );
    port(
      -- internal bus interface
      II_resetN				:in  TSL;
      II_operN				:in  TSL := '1';
      II_writeN				:in  TSL := '1';
      II_strobeN			:in  TSL := '1';
      II_addr				:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0) := (others =>'0');
      II_in_data			:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0) := (others =>'0');
      II_out_data			:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
    );  
  end component;

  component CII_SYS_VECT_REG is
    generic(
      constant VLEN			:TN := 0;
      constant DLEN			:TN := 0
    );
    port(
      resetN				:in  TSL := '1';
      clk				:in  TSL;
      ena				:in  TSLV(VLEN-1 downto 0);
      vin				:in  TSLV(VLEN-1 downto 0);
      vout				:out TSLV(VLEN-1 downto 0)
    );
  end component;

end CII_SYS_dec;


package body CII_SYS_dec is

  function CII_SYS_CTRL_IsReg(constant mode: TN) return TL is
  begin
    if    (mode=CIISYS.LIST_INTERF_CTRL.CIISIG)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIREG)    then return(TRUE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.LOWVAL)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.HIGHVAL)   then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIVAL)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTSIG)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTREG)    then return(TRUE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTSIG) then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTREG) then return(TRUE);
    end if;
    return(TLconv(-mode)); -- error
  end function;
--
  function CII_SYS_CTRL_IsCII(constant mode: TN) return TL is
    variable res:TL;
  begin
    if    (mode=CIISYS.LIST_INTERF_CTRL.CIISIG)    then return(TRUE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIREG)    then return(TRUE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.LOWVAL)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.HIGHVAL)   then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIVAL)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTSIG)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTREG)    then return(FALSE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTSIG) then return(TRUE);
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTREG) then return(TRUE);
    end if;
    return(FALSE); 
  end function;
  
  procedure CII_SYS_CTRL_GetFlag(constant mode :in TN; constant val :in TL; csig, esig, risig: in TSL; signal rosig, osig :out TSL) is
  begin
    if    (mode=CIISYS.LIST_INTERF_CTRL.CIISIG)    then rosig <= '0';  osig <= csig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIREG)    then rosig <= csig; osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_CTRL.LOWVAL)    then rosig <= '0';  osig <= '0';             
    elsif (mode=CIISYS.LIST_INTERF_CTRL.HIGHVAL)   then rosig <= '0';  osig <= '1';             
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIVAL)    then rosig <= '0';  osig <= TSLconv(val);    
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTSIG)    then rosig <= '0';  osig <= esig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTREG)    then rosig <= esig; osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTSIG) then rosig <= '0';  osig <= esig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTREG) then rosig <= esig; osig <= risig;           
                                                        rosig <= '0';  osig <= TSLconv(-mode); -- error
    end if;
  end procedure;

  procedure CII_SYS_CTRL_GetVect(constant mode :in TN; constant val :in TSLV; csig, esig, risig: in TSLV; signal rosig, osig :out TSLV) is
    constant VECT0 :TSLV(osig'range) := (others =>'0');
  begin
    if    (mode=CIISYS.LIST_INTERF_CTRL.CIISIG)    then rosig <= VECT0; osig <= csig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIREG)    then rosig <= csig;  osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_CTRL.LOWVAL)    then rosig <= VECT0; osig <= VECT0;           
    elsif (mode=CIISYS.LIST_INTERF_CTRL.HIGHVAL)   then rosig <= VECT0; osig <= not(VECT0);      
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIVAL)    then rosig <= VECT0; osig <= val;             
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTSIG)    then rosig <= VECT0; osig <= esig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.EXTREG)    then rosig <= esig;  osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTSIG) then rosig <= VECT0; osig <= esig;            
    elsif (mode=CIISYS.LIST_INTERF_CTRL.CIIEXTREG) then rosig <= esig;  osig <= risig;           
                                                        rosig <= VECT0; osig <= TSLVconv(-mode); -- error
    end if;
  end procedure;

  procedure CII_SYS_STAT_GetFlag(constant mode :in TN; constant val :in TL; csig, risig: in TSL; signal rosig, osig :out TSL) is
  begin
    if    (mode=CIISYS.LIST_INTERF_STAT.CIISIG)    then rosig <= '0';  osig <= csig;            
    elsif (mode=CIISYS.LIST_INTERF_STAT.CIIREG)    then rosig <= csig; osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_STAT.LOWVAL)    then rosig <= '0';  osig <= '0';             
    elsif (mode=CIISYS.LIST_INTERF_STAT.HIGHVAL)   then rosig <= '0';  osig <= '1';             
    elsif (mode=CIISYS.LIST_INTERF_STAT.CIIVAL)    then rosig <= '0';  osig <= TSLconv(val);    
                                                        rosig <= '0';  osig <= TSLconv(-mode); -- error
    end if;
  end procedure;

  procedure CII_SYS_STAT_GetVect(constant mode :in TN; constant val :in TSLV; csig, risig: in TSLV; signal rosig, osig :out TSLV) is
    constant VECT0 :TSLV(osig'range) := (others =>'0');
  begin
    if    (mode=CIISYS.LIST_INTERF_STAT.CIISIG)    then rosig <= VECT0; osig <= csig;            
    elsif (mode=CIISYS.LIST_INTERF_STAT.CIIREG)    then rosig <= csig;  osig <= risig;           
    elsif (mode=CIISYS.LIST_INTERF_STAT.LOWVAL)    then rosig <= VECT0; osig <= VECT0;           
    elsif (mode=CIISYS.LIST_INTERF_STAT.HIGHVAL)   then rosig <= VECT0; osig <= not(VECT0);      
    elsif (mode=CIISYS.LIST_INTERF_STAT.CIIVAL)    then rosig <= VECT0; osig <= val;             
                                                        rosig <= VECT0; osig <= TSLVconv(-mode); -- error
    end if;
  end procedure;

end CII_SYS_dec;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all; use work.CII_SYS_prv.all; use work.CII_SYS_dec.all;

entity CII_SYS_CTRL_IR_FLAG is
  generic(
    constant MODE			:TN;
    constant CIIVAL			:TL
  );
  port(
    resetN				:in  TSL;
    clk					:in  TSL;
    cii_flag				:in  TSL;
    ext_flag				:in  TSL;
    flag				:out TSL
  );
end CII_SYS_CTRL_IR_FLAG;

architecture behaviour of CII_SYS_CTRL_IR_FLAG is

  signal   FlagSig :TSL;
  signal   FlagReg :TSL;

begin

  CII_SYS_CTRL_GetFlag(MODE, CIIVAL, cii_flag, ext_flag, FlagReg, FlagSig, flag);

  process (clk, resetN) begin 
    if (resetN='0') then
      FlagReg  <= '0';
    elsif (clk'event and clk='1') then
      FlagReg  <= FlagSig;
    end if;
  end process;
  
end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all; use work.CII_SYS_prv.all; use work.CII_SYS_dec.all;

entity CII_SYS_CTRL_IR_VECT is
  generic(
    constant MODE			:TN;
    constant CIIVAL			:TSLV;
    constant LEN			:TN := 0
  );
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL := '0';
    cii_vect				:in  TSLV(TNconv(CII_SYS_CTRL_IsCII(MODE))*(LEN-1) downto 0) := (others => '0');
    ext_vect				:in  TSLV(LEN-1 downto 0) := (others => '0');
    vect				:out TSLV(LEN-1 downto 0)
  );
end CII_SYS_CTRL_IR_VECT;

architecture behaviour of CII_SYS_CTRL_IR_VECT is

  signal   VectSig :TSLV(LEN-1 downto 0);
  signal   VectReg :TSLV(LEN-1 downto 0);

begin

  CII_SYS_CTRL_GetVect(MODE, TSLVresize(CIIVAL,LEN), cii_vect, ext_vect, VectReg, VectSig, vect);

  process (clk, resetN) begin 
    if (resetN='0') then
      VectReg  <= (others => '0');
    elsif (clk'event and clk='1') then
      VectReg  <= VectSig;
    end if;
  end process;
  
end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all; use work.CII_SYS_prv.all; use work.CII_SYS_dec.all;

entity CII_SYS_STAT_FLAG is
  generic(
    constant MODE			:TN;
    constant CIIVAL			:TL
  );
  port(
    resetN				:in  TSL;
    clk					:in  TSL;
    cii_flag				:in  TSL;
    flag				:out TSL
  );
end CII_SYS_STAT_FLAG;

architecture behaviour of CII_SYS_STAT_FLAG is

  signal   FlagSig :TSL;
  signal   FlagReg :TSL;

begin

  CII_SYS_STAT_GetFlag(MODE, CIIVAL, cii_flag, FlagReg, FlagSig, flag);

  process (clk, resetN) begin 
    if (resetN='0') then
      FlagReg  <= '0';
    elsif (clk'event and clk='1') then
      FlagReg  <= FlagSig;
    end if;
  end process;
  
end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all; use work.CII_SYS_prv.all; use work.CII_SYS_dec.all;

entity CII_SYS_STAT_VECT is
  generic(
    constant MODE			:TN;
    constant CIIVAL			:TSLV;
    constant LEN			:TN := 0
  );
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL := '0';
    cii_vect				:in  TSLV(TNconv(CII_SYS_CTRL_IsCII(MODE))*(LEN-1) downto 0) := (others => '0');
    vect				:out TSLV(LEN-1 downto 0)
  );
end CII_SYS_STAT_VECT;

architecture behaviour of CII_SYS_STAT_VECT is

  signal   VectSig :TSLV(LEN-1 downto 0);
  signal   VectReg :TSLV(LEN-1 downto 0);

begin

  CII_SYS_STAT_GetVect(MODE, TSLVresize(CIIVAL,LEN), cii_vect, VectReg, VectSig, vect);

  process (clk, resetN) begin 
    if (resetN='0') then
      VectReg  <= (others => '0');
    elsif (clk'event and clk='1') then
      VectReg  <= VectSig;
    end if;
  end process;
  
end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity CII_SYS_STROBE_REG is
  generic(
    constant SINGLE_ENA			:in  TL := FALSE
  );
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL;
    enable				:in  TSL := '1';
    strobeN				:in  TSL;
    flag				:out TSL
  );
end CII_SYS_STROBE_REG;

architecture behaviour of CII_SYS_STROBE_REG is

  signal FlagReg1 : TSL;
  signal FlagReg2 : TSL;

begin

  process (clk, resetN) begin 
    if (resetN='0') then
      FlagReg1  <= '0';
      FlagReg2  <= '0';
    elsif (clk'event and clk='1') then
      FlagReg1  <= not(strobeN) and enable;
      FlagReg2  <= FlagReg1 and strobeN and enable;
    end if;
  end process;
  
  flag <= FlagReg1 when SINGLE_ENA=FALSE else FlagReg2;

end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity CII_SYS_FLAG_HOLD is
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL;
    clk_flag				:in  TSL;
    operN				:in  TSL;
    cii_flag				:out TSL
  );
end CII_SYS_FLAG_HOLD;

architecture behaviour of CII_SYS_FLAG_HOLD is

  signal HoldRegN : TSL;
  signal FlagReg  : TSL;

begin

  process (clk, resetN) begin 
    if (resetN='0') then
      HoldRegN <= '0';
    elsif (clk'event and clk='0') then
      HoldRegN <= not(operN);
    end if;
  end process;
  
  process (clk, resetN) begin 
    if (resetN='0') then
      FlagReg  <= '0';
    elsif (clk'event and clk='1') then
      if (HoldRegN = '0') then
        FlagReg <= clk_flag;
      end if;
    end if;
  end process;
  
  cii_flag <= FlagReg;

end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity CII_SYS_VECT_HOLD is
  generic(
    constant LEN			:TN := 0
  );
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL;
    clk_vect				:in  TSLV(LEN-1 downto 0);
    operN				:in  TSL;
    cii_vect				:out TSLV(LEN-1 downto 0)
  );
end CII_SYS_VECT_HOLD;

architecture behaviour of CII_SYS_VECT_HOLD is

  signal HoldRegN : TSL;
  signal VectReg  : TSLV(LEN-1 downto 0);

begin

  process (clk, resetN) begin 
    if (resetN='0') then
      HoldRegN <= '0';
    elsif (clk'event and clk='0') then
      HoldRegN <= not(operN);
    end if;
  end process;
  
  process (clk, resetN) begin 
    if (resetN='0') then
      VectReg  <= (others => '0');
    elsif (clk'event and clk='1') then
      if (HoldRegN = '0') then
        VectReg <= clk_vect;
      end if;
    end if;
  end process;
  
  cii_vect <= VectReg;

end behaviour;

--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity CII_SYS_VECT_REG is
  generic(
    constant VLEN			:TN := 0;
    constant DLEN			:TN := 0
  );
  port(
    resetN				:in  TSL := '1';
    clk					:in  TSL;
    ena					:in  TSLV(VLEN-1 downto 0);
    vin				        :in  TSLV(VLEN-1 downto 0);
    vout				:out TSLV(VLEN-1 downto 0)
  );
end CII_SYS_VECT_REG;

architecture behaviour of CII_SYS_VECT_REG is

  constant REGLEN :TN := ((VLEN-1)/maximum(DLEN,1))*DLEN;
  signal   VecReg :TSLV(maximum(REGLEN,1)-1 downto 0);

begin
  --
  process(resetN,clk) is
  begin
    if (resetN='0')then
      VecReg <= (others => '0');
    elsif clk'event and clk='1' then
      for index in 0 to REGLEN-1 loop
        if (ena(index)='1') then
          VecReg(index) <= vin(index);
        end if;
      end loop;
    end if;
  end process;
  --
  process (vin, VecReg) is
  begin
    if (DLEN>=VLEN) then
      vout <= vin;
    elsif(DLEN>0) then
      vout <= vin(VLEN-1 downto REGLEN) & VecReg(REGLEN-1 downto 0);
    else
      vout <= VecReg;
    end if;
  end process;

end behaviour;


--------------------------------------------------------------------------------------------------------
--                                                                                                    --
--                                        CII_IDENTIFICATOR componet                                  --
--                                                                                                    --
--------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.ComponentII.all;
use work.CII_SYS_def.all, work.CII_SYS_prv.all, work.CII_SYS_dec.all;


entity CCII_IDENTIFICATOR is
  generic(
    constant IICPAR			:TCII;
    constant IICPOS			:TVI
  );
  port(
    -- internal bus interface
    II_resetN				:in  TSL;
    II_operN				:in  TSL;
    II_writeN				:in  TSL;
    II_strobeN				:in  TSL;
    II_addr				:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0) := (others =>'0');
    II_in_data				:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0) := (others =>'0');
    II_out_data				:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
  );
end CCII_IDENTIFICATOR;

architecture behaviour of CCII_IDENTIFICATOR is

  --#CII# declaration insert start for 'CII_IDENTIFICATOR' - don't edit below !
  type TCIIpar                                            is record
    IPAR_USER_REG_WIDTH                                   :TI;
    IPAR_IDENTYFIER                                       :TI;
    SPAR_CREATOR                                          :TS(1 to IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_CREATOR)))).ItemWidth);
    SPAR_NAME                                             :TS(1 to IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_NAME)))).ItemWidth);
    HPAR_VERSION                                          :THV(IICPAR(CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.HPAR_VERSION)))).ItemWidth-1 downto 0);
    LPAR_IDENTYFIER_CII                                   :TL;
    LPAR_CREATOR_CII                                      :TL;
    LPAR_NAME_CII                                         :TL;
    LPAR_VERSION_CII                                      :TL;
    IPAR_USER_REG_NUM                                     :TI;
    WORD_IDENTYFIER                                       :TCIIItem;
    WORD_CREATOR                                          :TCIIItem;
    WORD_NAME                                             :TCIIItem;
    WORD_VERSION                                          :TCIIItem;
    WORD_USER                                             :TCIIItem;
  end record;

  function CIIpar_get return TCIIpar is
    variable res: TCIIpar;
    variable pos, idx, len: TN;
  begin
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_USER_REG_WIDTH);
    res.IPAR_USER_REG_WIDTH := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_IDENTYFIER);
    res.IPAR_IDENTYFIER := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_CREATOR)));
    res.SPAR_CREATOR := (others => nul);
    for cnt in 0 to (res.SPAR_CREATOR'length-1)/4 loop
      idx := res.SPAR_CREATOR'length-4*cnt;
      len := minimum(2,idx);
      res.SPAR_CREATOR(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrLen,len);
      len := minimum(2,maximum(idx-2,0));
      if (len>0) then
        idx := idx-2;
        res.SPAR_CREATOR(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrPos,len);
      end if;
    end loop;
    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.SPAR_NAME)));
    res.SPAR_NAME := (others => nul);
    for cnt in 0 to (res.SPAR_NAME'length-1)/4 loop
      idx := res.SPAR_NAME'length-4*cnt;
      len := minimum(2,idx);
      res.SPAR_NAME(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrLen,len);
      len := minimum(2,maximum(idx-2,0));
      if (len>0) then
        idx := idx-2;
        res.SPAR_NAME(idx-len+1 to idx) := TSconv(IICPAR(pos+cnt).ItemAddrPos,len);
      end if;
    end loop;
    pos := CIIParamPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.HPAR_VERSION)));
    res.HPAR_VERSION := (others => '0');
    for cnt in 0 to (res.HPAR_VERSION'length-1)/8 loop
      idx := 8*cnt;
      len := minimum(4,res.HPAR_VERSION'length-8*cnt);
      res.HPAR_VERSION(idx+len-1 downto idx) := THVconv(IICPAR(pos+cnt).ItemAddrLen,len);
      len := minimum(4,maximum(res.HPAR_VERSION'length-8*cnt-4,0));
      if (len>0) then
        idx := idx+4;
        res.HPAR_VERSION(idx+len-1 downto idx) := THVconv(IICPAR(pos+cnt).ItemAddrPos,len);
      end if;
    end loop;
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_IDENTYFIER_CII);
    res.LPAR_IDENTYFIER_CII := TLconv(IICPAR(pos).ItemAddrLen);
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_CREATOR_CII);
    res.LPAR_CREATOR_CII := TLconv(IICPAR(pos).ItemAddrLen);
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_NAME_CII);
    res.LPAR_NAME_CII := TLconv(IICPAR(pos).ItemAddrLen);
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.LPAR_VERSION_CII);
    res.LPAR_VERSION_CII := TLconv(IICPAR(pos).ItemAddrLen);
    pos := CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.IPAR_USER_REG_NUM);
    res.IPAR_USER_REG_NUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
    res.WORD_IDENTYFIER := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_IDENTYFIER));
    res.WORD_CREATOR := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_CREATOR));
    res.WORD_NAME := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_NAME));
    res.WORD_VERSION := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_VERSION));
    res.WORD_USER := IICPAR(CIIItemPosGet(IICPAR(IICPOS),CII_IDENTIFICATOR.WORD_USER));
    return(res);
  end function;

  constant CIIPar                                         :TCIIpar := CIIpar_get;

  signal   CIIput_WORD_IDENTYFIER                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
  signal   CIIren_WORD_IDENTYFIER                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_IDENTYFIER).ItemWidth-1,0) downto 0);
  signal   CIIput_WORD_CREATOR                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
  signal   CIIren_WORD_CREATOR                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_CREATOR).ItemWidth-1,0) downto 0);
  signal   CIIput_WORD_NAME                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
  signal   CIIren_WORD_NAME                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_NAME).ItemWidth-1,0) downto 0);
  signal   CIIput_WORD_VERSION                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
  signal   CIIren_WORD_VERSION                            :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_VERSION).ItemWidth-1,0) downto 0);
  signal   CIIget_WORD_USER                               :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+CII_IDENTIFICATOR.WORD_USER).ItemNumber-1,0) downto 0);
  --#CII# declaration insert end for 'CII_IDENTIFICATOR' - don't edit above !

begin

  CIIput_WORD_IDENTYFIER <= TSLVconv(CIIpar.IPAR_IDENTYFIER,CIISYS.INT_SIZE);
  CIIput_WORD_CREATOR    <= TSLVconv(CIIpar.SPAR_CREATOR,CIIput_WORD_CREATOR'length);
  CIIput_WORD_NAME       <= TSLVconv(CIIpar.SPAR_NAME,CIIput_WORD_NAME'length);
  CIIput_WORD_VERSION    <= TSLVconv(CIIpar.HPAR_VERSION,CIIput_WORD_VERSION'length);
  --
  --#CII# instantation insert start for 'CII_IDENTIFICATOR' - don't edit below !
  CIIinterf :CII_IDENTIFICATOR_cii_interface
    generic map (
      IICPAR                                    => IICPAR,
      IICPOS                                    => IICPOS
    )
    port map (
      put_WORD_IDENTYFIER                       => CIIput_WORD_IDENTYFIER,
      ren_WORD_IDENTYFIER                       => CIIren_WORD_IDENTYFIER,
      put_WORD_CREATOR                          => CIIput_WORD_CREATOR,
      ren_WORD_CREATOR                          => CIIren_WORD_CREATOR,
      put_WORD_NAME                             => CIIput_WORD_NAME,
      ren_WORD_NAME                             => CIIren_WORD_NAME,
      put_WORD_VERSION                          => CIIput_WORD_VERSION,
      ren_WORD_VERSION                          => CIIren_WORD_VERSION,
      get_WORD_USER                             => CIIget_WORD_USER,
      II_resetN                                 => II_resetN,
      II_operN                                  => ii_operN,
      II_writeN                                 => II_writeN,
      II_strobeN                                => II_strobeN,
      II_addr                                   => II_addr,
      II_data_in                                => ii_in_data,
      II_data_out                               => ii_out_data
  );
  --#CII# instantation insert end for 'CII_IDENTIFICATOR' - don't edit above !

end behaviour;

