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

package LPMComp_spartan6 is

  component XLPM_URAM
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_ADDR_WIDTH		:in natural := 0
    );
    port(
      clkA			:in  TSL := '1';
      enableA			:in  TSL := '0';
      weA			:in  TSL := '0';
      rstA			:in  TSL := '1';
      addrA			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_inA			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_outA			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      clkB			:in  TSL := '1';
      enableB			:in  TSL := '0';
      weB			:in  TSL := '0';
      rstB			:in  TSL := '1';
      addrB			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_inB			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_outB			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component XLPM_UDPM
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      LPM_ADDR_WIDTH		:in natural := 0
    );
    port(
      clkA			:in  TSL := '1';
      enableA			:in  TSL := '0';
      weA			:in  TSL := '0';
      rstA			:in  TSL := '1';
      addrA			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_inA			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_outA			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      clkB			:in  TSL := '1';
      enableB			:in  TSL := '0';
      weB			:in  TSL := '0';
      rstB			:in  TSL := '1';
      addrB			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
      data_inB			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      data_outB			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component dcm_spartan6_mult
    generic (
      LPM_MULTIP_CLOCK		:in natural := 0;
      LPM_DIVIDE_CLOCK		:in natural := 0;
      CLOCK_IN_FREQ_MHZ		:in real    := 0.0
    );
    port(
      CLKIN_IN			:in  TSL;
      RST_IN			:in  TSL;          
      CLKFX_OUT			:out TSL;
      CLKIN_IBUFG_OUT		:out TSL;
      CLK0_OUT			:out TSL;
      CLK90_OUT			:out TSL;
      LOCKED_OUT		:out TSL
      );
  end component;

  component dcm_spartan6_div is
    generic (
      LPM_DIVIDE_CLOCK		:in natural := 0;
      CLOCK_IN_FREQ_MHZ		:in real    := 0.0
    );
    port(
      CLKIN_IN			:in  TSL; 
      RST_IN			:in  TSL; 
      CLKDV_OUT			:out TSL; 
      CLKIN_IBUFG_OUT		:out TSL; 
      CLK0_OUT			:out TSL; 
      CLK90_OUT			:out TSL; 
      LOCKED_OUT		:out TSL
    );
  end component;

end LPMComp_spartan6;

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

package LPMComp_UniTechType is

  function GetUniTechLibraryType return TS;

end LPMComp_UniTechType;

package body LPMComp_UniTechType is

  function GetUniTechLibraryType return TS is
  begin
    return("KTP_SPARTAN6_LIB");
  end;

end LPMComp_UniTechType;

-------------------------------------------------------------------
-- LPMComp_spartan6
-------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
library unisim;
use unisim.vcomponents.all;

entity XLPM_URAM is
  generic (
    LPM_DATA_WIDTH		:in natural := 8;
    LPM_ADDR_WIDTH		:in natural := 8
  );
  port(
    clkA			:in  TSL := '1';
    enableA			:in  TSL := '0';
    weA				:in  TSL := '0';
    rstA			:in  TSL := '1';
    addrA			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inA			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outA			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    clkB			:in  TSL := '1';
    enableB			:in  TSL := '0';
    weB				:in  TSL := '0';
    rstB			:in  TSL := '1';
    addrB			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inB			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outB			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
 );
end XLPM_URAM;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

architecture behaviour of XLPM_URAM is

  constant AMIN  :TN := 5;
  constant AMAX  :TN := 7;
  constant APART :TN := 2**maximum(LPM_ADDR_WIDTH-AMAX,0);
  constant ASIZE :TN := maximum(minimum(LPM_ADDR_WIDTH,AMAX),AMIN);
  signal   ADA   :TSLV(ASIZE-1 downto 0) := (others => '0');
  signal   DPOA  :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   SPOA  :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   DA    :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   WENA  :TSLV(APART-1 downto 0);
  signal   ADB   :TSLV(ASIZE-1 downto 0) := (others => '0');
  signal   DPOB  :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   SPOB  :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   DB    :TSLV(APART*LPM_DATA_WIDTH-1 downto 0);
  signal   WENB  :TSLV(APART-1 downto 0);

begin

  process (enableA, weA, addrA) is begin
    WENA <= (others => '0');
    if (APART=1) then
      WENA(0) <= enableA and weA;
    else
      for i in 0 to APART-1 loop
        if (addrA(LPM_ADDR_WIDTH-1 downto AMAX) = i) then
          WENA(i) <= enableA and weA;
          exit;
        end if;
      end loop;
    end if;
  end process;
  --
  process (enableB, weB, addrB) is begin
    WENB <= (others => '0');
    if (APART=1) then
      WENB(0) <= enableB and weB;
    else
      for i in 0 to APART-1 loop
        if (addrB(LPM_ADDR_WIDTH-1 downto AMAX) = i) then
          WENB(i) <= enableB and weB;
          exit;
        end if;
      end loop;
    end if;
  end process;
  --
  ADA(minimum(ASIZE,LPM_ADDR_WIDTH)-1 downto 0) <= addrA(minimum(ASIZE,LPM_ADDR_WIDTH)-1 downto 0);
  ADB(minimum(ASIZE,LPM_ADDR_WIDTH)-1 downto 0) <= addrB(minimum(ASIZE,LPM_ADDR_WIDTH)-1 downto 0);
  --
  ploop:
  for p in 0 to APART-1 generate
    dloop:
    for i in 0 to LPM_DATA_WIDTH-1 generate
      ifr32:
      if (ASIZE<=AMIN) generate
        rA : RAM32X1D
          port map (
            DPO   => DPOA(p*LPM_DATA_WIDTH+i),
            SPO   => SPOA(p*LPM_DATA_WIDTH+i),
            A0    => ADA(0),
            A1    => ADA(1),
            A2    => ADA(2),
            A3    => ADA(3),
            A4    => ADA(4),
            D     => DA(p*LPM_DATA_WIDTH+i),
            DPRA0 => ADB(0),
            DPRA1 => ADB(1),
            DPRA2 => ADB(2),
            DPRA3 => ADB(3),
            DPRA4 => ADB(4),
            WCLK  => clkA,
            WE    => WENA(p)
          );
        --  
        rB : RAM32X1D
          port map (
            DPO   => DPOB(p*LPM_DATA_WIDTH+i),
            SPO   => SPOB(p*LPM_DATA_WIDTH+i),
            A0    => ADB(0),
            A1    => ADB(1),
            A2    => ADB(2),
            A3    => ADB(3),
            A4    => ADB(4),
            D     => DB(p*LPM_DATA_WIDTH+i),
            DPRA0 => ADA(0),
            DPRA1 => ADA(1),
            DPRA2 => ADA(2),
            DPRA3 => ADA(3),
            DPRA4 => ADA(4),
            WCLK  => clkA,
            WE    => WENB(p)
          );
      end generate;
      --
      ifr64:
      if (ASIZE=AMIN+1) generate
        rA : RAM64X1D
          port map (
            DPO   => DPOA(p*LPM_DATA_WIDTH+i),
            SPO   => SPOA(p*LPM_DATA_WIDTH+i),
            A0    => ADA(0),
            A1    => ADA(1),
            A2    => ADA(2),
            A3    => ADA(3),
            A4    => ADA(4),
            A5    => ADA(5),
            D     => DA(p*LPM_DATA_WIDTH+i),
            DPRA0 => ADB(0),
            DPRA1 => ADB(1),
            DPRA2 => ADB(2),
            DPRA3 => ADB(3),
            DPRA4 => ADB(4),
            DPRA5 => ADB(5),
            WCLK  => clkA,
            WE    => WENA(p)
          );
        --  
        rB : RAM64X1D
          port map (
            DPO   => DPOB(p*LPM_DATA_WIDTH+i),
            SPO   => SPOB(p*LPM_DATA_WIDTH+i),
            A0    => ADB(0),
            A1    => ADB(1),
            A2    => ADB(2),
            A3    => ADB(3),
            A4    => ADB(4),
            A5    => ADB(5),
            D     => DB(p*LPM_DATA_WIDTH+i),
            DPRA0 => ADA(0),
            DPRA1 => ADA(1),
            DPRA2 => ADA(2),
            DPRA3 => ADA(3),
            DPRA4 => ADA(4),
            DPRA5 => ADA(5),
            WCLK  => clkA,
            WE    => WENB(p)
          );
      end generate;
      --
      ifr128:
      if (ASIZE=AMIN+2) generate
        rA : RAM128X1D
          port map (
            DPO   => DPOA(p*LPM_DATA_WIDTH+i),
            SPO   => SPOA(p*LPM_DATA_WIDTH+i),
            A     => ADA(6 downto 0),
            D     => DA(p*LPM_DATA_WIDTH+i),
            DPRA  => ADB(6 downto 0),
            WCLK  => clkA,
            WE    => WENA(p)
          );
        --  
        rB : RAM128X1D
          port map (
            DPO   => DPOB(p*LPM_DATA_WIDTH+i),
            SPO   => SPOB(p*LPM_DATA_WIDTH+i),
            A     => ADB(6 downto 0),
            D     => DB(p*LPM_DATA_WIDTH+i),
            DPRA  => ADA(6 downto 0),
            WCLK  => clkA,
            WE    => WENB(p)
          );
      end generate;
    end generate;
  end generate;
  --  
  process (data_inA, DPOB) is begin
    for i in 0 to APART-1 loop
      DA((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH) <= data_inA xor DPOB((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH);
    end loop;
  end process;
  --  
  process (data_inB, DPOA) is begin
    for i in 0 to APART-1 loop
      DB((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH) <= data_inB xor DPOA((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH);
    end loop;
  end process;
  --
  process (rstA, clkA) is begin
    if (rstA='1') then
      data_outA <= (others => '0');
    elsif (clkA'event and clkA='1') then
      data_outA <= (others => '0');
      if (APART=1) then
        data_outA <= SPOA xor DPOB;
      else
        for i in 0 to APART-1 loop
          if (addrA(LPM_ADDR_WIDTH-1 downto AMAX) = i) then
            data_outA <= SPOA((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH) xor DPOB((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH);
            exit;
          end if;
        end loop;
      end if;
    end if;
  end process;
  --
  process (rstB, clkB) is begin
    if (rstB='1') then
      data_outB <= (others => '0');
    elsif (clkB'event and clkB='1') then
      data_outB <= (others => '0');
      if (APART=1) then
        data_outB <= SPOB xor DPOA;
      else
        for i in 0 to APART-1 loop
          if (addrB(LPM_ADDR_WIDTH-1 downto AMAX) = i) then
            data_outB <= SPOB((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH) xor DPOA((i+1)*LPM_DATA_WIDTH-1 downto i*LPM_DATA_WIDTH);
            exit;
          end if;
        end loop;
      end if;
    end if;
  end process;

end behaviour;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_Config.all;
use work.LPMComp_spartan6.all;

entity XLPM_UDPM is
  generic (
    LPM_DATA_WIDTH		:in natural := 4;
    LPM_ADDR_WIDTH		:in natural := 4
  );
  port(
    clkA			:in  TSL := '1';
    enableA			:in  TSL := '0';
    weA				:in  TSL := '0';
    rstA			:in  TSL := '1';
    addrA			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inA			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outA			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    clkB			:in  TSL := '1';
    enableB			:in  TSL := '0';
    weB				:in  TSL := '0';
    rstB			:in  TSL := '1';
    addrB			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inB			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outB			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
 );
end XLPM_UDPM;

architecture behaviour of XLPM_UDPM is

  constant ASIZE        :TNV := (14, 13);
  constant DSIZE        :TNV := (32, 16);
  constant AMAX         :TN := maximum(ASIZE);
  constant AMIN         :TN := 8;
  constant APART        :TN := 2**maximum(LPM_ADDR_WIDTH-AMAX,0);
  constant ANUM         :TN := minimum(LPM_ADDR_WIDTH,AMAX);
  --
  type     TMBLK        is record
                          mtype :TI range -1 to ASIZE'length;
                          dpos  :TN;
                          dnum  :TN;
                          dsize :TN;
                          apos  :TN;
                        end record;
  type     TMTAB        is array (TN range<>, TN range<>) of TMBLK;
  --
  function TMTABget return TMTAB is
    constant DPART :TN := LPM_DATA_WIDTH;
    --
    procedure \get\(tab :inout TMTAB; dp :out TI) is
      constant RAM   :TL := T3LisTrue(LPMComp_MEMORY_RAM_TYPE_ENA);
      variable dn    :TN;
      variable val   :TN;
      variable flag  :TL;
      variable dpmax :TN;
    begin
      dp    := -1; 
      tab   := (tab'range(1) => (tab'range(2) => (-1, 0 ,0, 0, 0)));
      dpmax := 0;
      for ap in 0 to tab'length(1)-1 loop
        dn := LPM_DATA_WIDTH;
        for dp in 0 to tab'length(2)-1 loop
          if (dn=0) then exit; end if;
          dpmax := maximum(dp,dpmax);
          flag := FALSE;
          for mt in 0 to ASIZE'length-1 loop
            val := 2**(ASIZE(mt)-ANUM);
            if ((val<=DSIZE(mt) and val<=dn) or (mt=ASIZE'length-1 and (RAM=FALSE or ANUM>=AMIN))) then
              val := minimum(minimum(val,DSIZE(mt)),dn);
              tab(ap,dp).mtype := mt;
              tab(ap,dp).dpos  := LPM_DATA_WIDTH-dn;
              tab(ap,dp).dnum  := val;
              tab(ap,dp).dsize := val+val/8;
              tab(ap,dp).apos  := ASIZE(mt)-ANUM;
              dn               := dn-val;
              flag             := TRUE;
              exit;
            end if;
          end loop;
          if (flag=TRUE) then next; end if;
          tab(ap,dp).mtype := ASIZE'length;
          tab(ap,dp).dpos  := LPM_DATA_WIDTH-dn;
          tab(ap,dp).dnum  := dn;
          tab(ap,dp).dsize := dn;
          tab(ap,dp).apos  := 0;
          dn               := 0;
          exit;
        end loop;
        if (dn/=0) then return; end if; 
      end loop;
      dp := dpmax;
    end procedure;
    --
    function \dnum\ return TN is
      variable tmp   :TMTAB(0 to APART-1, 0 to DPART-1);
      variable dp    :TN;
    begin
      \get\(tmp,dp);
      return(dp);
    end function;
    --
    variable res :TMTAB(0 to APART-1, 0 to \dnum\);
    variable tmp :TN;
  begin
    \get\(res,tmp);
    res(0,tmp) := res(0,tmp); --!!! dummy operation only for test error when tmp=-1
    return(res);
  end function;
  --
  constant MTAB         :TMTAB := TMTABget;
  --constant MTAB         :TMTAB(0 to APART-1, 0 to 31-1) := (others => (others => (-1, 0 ,0, 0, 0)));
  signal   ENAsig       :TSLV(MTAB'range(1));
  signal   ENBsig       :TSLV(MTAB'range(1));
  --
  type     TADDR        is array(MTAB'range(1),MTAB'range(2)) of TSLV(maximum(ASIZE)-1 downto 0);
  signal   ADDRAsig     :TADDR;
  signal   ADDRBsig     :TADDR;
  --
  signal   WEAsig       :TSLV(maximum(DSIZE)/8-1 downto 0);
  signal   WEBsig       :TSLV(maximum(DSIZE)/8-1 downto 0);
  --
  type     TDATA        is array(MTAB'range(1),MTAB'range(2)) of TSLV(maximum(DSIZE)-1 downto 0);
  signal   DIAsig       :TDATA;
  signal   DIBsig       :TDATA;
  signal   DOAsig       :TDATA := (others => (others => (others => '0')));
  signal   DOBsig       :TDATA := (others => (others => (others => '0')));

begin

--  process is
--    variable tab         :TMTAB(0 to APART-1, 0 to 32-1);
--  begin
--    tab := TMTABget;
--    wait;
--  end process;
  
  process (enableA, addrA) is begin
    ENAsig <= (others=> '0');
    if (APART=1) then
      ENAsig <= (others=> enableA);
    else
      for a in 0 to APART-1 loop
        if (addrA(LPM_ADDR_WIDTH-1 downto AMAX) = a) then
          ENAsig(a) <= enableA;
          exit;
        end if;
      end loop;
    end if;
  end process;
  --
  process (enableB, addrB) is begin
    ENBsig <= (others=> '0');
    if (APART=1) then
      ENBsig <= (others=> enableA);
    else
      for a in 0 to APART-1 loop
        if (addrB(LPM_ADDR_WIDTH-1 downto AMAX) = a) then
          ENBsig(a) <= enableB;
          exit;
        end if;
      end loop;
    end if;
  end process;
  --
  process (addrA) is begin
    ADDRAsig <= (others=> (others=> (others=> '0')));
    for a in 0 to APART-1 loop
      for d in MTAB'range(2) loop
        ADDRAsig(a,d)(minimum(ANUM,LPM_ADDR_WIDTH)+MTAB(a,d).apos-1 downto MTAB(a,d).apos) <= addrA(minimum(ANUM,LPM_ADDR_WIDTH)-1 downto 0);
      end loop;
    end loop;
  end process;
  --
  process (addrB) is begin
    ADDRBsig <= (others=> (others=> (others=> '0')));
    for a in 0 to APART-1 loop
      for d in MTAB'range(2) loop
        ADDRBsig(a,d)(minimum(ANUM,LPM_ADDR_WIDTH)+MTAB(a,d).apos-1 downto MTAB(a,d).apos) <= addrB(minimum(ANUM,LPM_ADDR_WIDTH)-1 downto 0);
      end loop;
    end loop;
  end process;
  --
  WEAsig  <= (others => weA);
  WEBsig  <= (others => weB);
  --
  process (data_inA) is begin
    DIAsig <= (others=> (others=> (others=> '0')));
    for a in 0 to APART-1 loop
      for d in MTAB'range(2) loop
        DIAsig(a,d)(MTAB(a,d).dnum-1 downto 0) <= data_inA(MTAB(a,d).dnum+MTAB(a,d).dpos-1 downto MTAB(a,d).dpos);
      end loop;
    end loop;
  end process;
  --
  process (data_inB) is begin
    DIBsig <= (others=> (others=> (others=> '0')));
    for a in 0 to APART-1 loop
      for d in MTAB'range(2) loop
        DIBsig(a,d)(MTAB(a,d).dnum-1 downto 0) <= data_inB(MTAB(a,d).dnum+MTAB(a,d).dpos-1 downto MTAB(a,d).dpos);
      end loop;
    end loop;
  end process;
  --
  aloop:
  for aindex in MTAB'range(1) generate
    dloop:
    for dindex in MTAB'range(2) generate
      mif16:
      if (MTAB(aindex,dindex).mtype=0) generate 
        m16: RAMB16BWER
          generic map (
            DATA_WIDTH_A        => MTAB(aindex,dindex).dsize,
            DATA_WIDTH_B        => MTAB(aindex,dindex).dsize,
            DOA_REG             => 0,
            DOB_REG             => 0,
            EN_RSTRAM_A         => TRUE,
            EN_RSTRAM_B         => TRUE,
            RSTTYPE             => "SYNC",
            RST_PRIORITY_A      => "CE",
            RST_PRIORITY_B      => "CE",
            SIM_COLLISION_CHECK => "ALL",
            SIM_DEVICE          => "SPARTAN6",
            WRITE_MODE_A        => "READ_FIRST",
            WRITE_MODE_B        => "READ_FIRST"
            )
          port map (
            RSTA                => rstA,
            CLKA                => clkA,
            ENA                 => ENAsig(aindex),
            ADDRA               => ADDRAsig(aindex,dindex)(13 downto 0),
            WEA                 => WEAsig(3 downto 0),
            DIA                 => DIAsig(aindex,dindex)(31 downto 0),
            DIPA                => (others => '0'),
            DOA                 => DOAsig(aindex,dindex)(31 downto 0),
            DOPA                => open,
            REGCEA              => '1',
            
            RSTB                => rstB,
            CLKB                => clkB,
            ENB                 => ENBsig(aindex),
            ADDRB               => ADDRBsig(aindex,dindex)(13 downto 0),
            WEB                 => WEBsig(3 downto 0),
            DIB                 => DIBsig(aindex,dindex)(31 downto 0),
            DIPB                => (others => '0'),
            DOB                 => DOBsig(aindex,dindex)(31 downto 0),
            DOPB                => open,
            REGCEB              => '1'
          ); 
      end generate;
      --
      mif8:
      if (MTAB(aindex,dindex).mtype=1) generate 
        m8: RAMB8BWER
          generic map (
            DATA_WIDTH_A        => MTAB(aindex,dindex).dsize,
            DATA_WIDTH_B        => MTAB(aindex,dindex).dsize,
            DOA_REG             => 0,
            DOB_REG             => 0,
            EN_RSTRAM_A         => TRUE,
            EN_RSTRAM_B         => TRUE,
            RAM_MODE            => "TDP",
            RSTTYPE             => "SYNC",
            RST_PRIORITY_A      => "CE",
            RST_PRIORITY_B      => "CE",
            SIM_COLLISION_CHECK => "ALL",
            WRITE_MODE_A        => "READ_FIRST",
            WRITE_MODE_B        => "READ_FIRST"
            )
          port map (
            RSTA                => rstA,
            CLKAWRCLK           => clkA,
            ENAWREN             => ENAsig(aindex),
            ADDRAWRADDR         => ADDRAsig(aindex,dindex)(12 downto 0),
            WEAWEL              => WEAsig(1 downto 0),
            DIADI               => DIAsig(aindex,dindex)(15 downto 0),
            DIPADIP             => (others => '0'),
            DOADO               => DOAsig(aindex,dindex)(15 downto 0),
            DOPADOP             => open,
            REGCEA              => '1',
            
            RSTBRST             => rstB,
            CLKBRDCLK           => clkB,
            ENBRDEN             => ENBsig(aindex),
            ADDRBRDADDR         => ADDRBsig(aindex,dindex)(12 downto 0),
            WEBWEU              => WEBsig(1 downto 0),
            DIBDI               => DIBsig(aindex,dindex)(15 downto 0),
            DIPBDIP             => (others => '0'),
            DOBDO               => DOBsig(aindex,dindex)(15 downto 0),
            DOPBDOP             => open,
            REGCEBREGCE         => '1'
          ); 
      end generate;
      --
      mifr:
      if (MTAB(aindex,dindex).mtype=ASIZE'length) generate 
        mram: XLPM_URAM
          generic map (
            LPM_DATA_WIDTH      => MTAB(aindex,dindex).dsize,
            LPM_ADDR_WIDTH      => ANUM
          )
          port map(
            clkA                => clkA,
            enableA             => ENAsig(aindex),
            weA                 => WEAsig(0),
            rstA                => rstA,
            addrA               => ADDRAsig(aindex,dindex)(ANUM-1 downto 0),
            data_inA            => DIAsig(aindex,dindex)(MTAB(aindex,dindex).dnum-1 downto 0),
            data_outA           => DOAsig(aindex,dindex)(MTAB(aindex,dindex).dnum-1 downto 0),
            clkB                => clkB,
            enableB             => ENBsig(aindex),
            weB                 => WEBsig(0),
            rstB                => rstB,
            addrB               => ADDRBsig(aindex,dindex)(ANUM-1 downto 0),
            data_inB            => DIBsig(aindex,dindex)(MTAB(aindex,dindex).dnum-1 downto 0),
            data_outB           => DOBsig(aindex,dindex)(MTAB(aindex,dindex).dnum-1 downto 0)
          );
      end generate;
    end generate;
  end generate;
  --
  process (DOAsig, addrA) is begin
    data_outA <= (others=> '0');
    if (APART=1) then
      for d in MTAB'range(2) loop
        data_outA(MTAB(0,d).dnum+MTAB(0,d).dpos-1 downto MTAB(0,d).dpos) <= DOAsig(0,d)(MTAB(0,d).dnum-1 downto 0);
      end loop;
    else
      for a in 0 to APART-1 loop
        if (addrA(LPM_ADDR_WIDTH-1 downto AMAX) = a) then
          for d in MTAB'range(2) loop
            data_outA(MTAB(a,d).dnum+MTAB(a,d).dpos-1 downto MTAB(a,d).dpos) <= DOAsig(a,d)(MTAB(a,d).dnum-1 downto 0);
          end loop;
          exit;
        end if;
      end loop;
    end if;
  end process;
  --
  process (DOBsig, addrB) is begin
    data_outB <= (others=> '0');
    if (APART=1) then
      for d in MTAB'range(2) loop
        data_outB(MTAB(0,d).dnum+MTAB(0,d).dpos-1 downto MTAB(0,d).dpos) <= DOBsig(0,d)(MTAB(0,d).dnum-1 downto 0);
      end loop;
    else
      for a in 0 to APART-1 loop
        if (addrB(LPM_ADDR_WIDTH-1 downto AMAX) = a) then
          for d in MTAB'range(2) loop
            data_outB(MTAB(a,d).dnum+MTAB(a,d).dpos-1 downto MTAB(a,d).dpos) <= DOBsig(a,d)(MTAB(a,d).dnum-1 downto 0);
          end loop;
          exit;
        end if;
      end loop;
    end if;
  end process;

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

entity XLPM_UDPMold is
  generic (
    LPM_DATA_WIDTH		:in natural := 4;
    LPM_ADDR_WIDTH		:in natural := 4
  );
  port(
    clkA			:in  TSL := '1';
    enableA			:in  TSL := '0';
    weA				:in  TSL := '0';
    rstA			:in  TSL := '1';
    addrA			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inA			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outA			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    clkB			:in  TSL := '1';
    enableB			:in  TSL := '0';
    weB				:in  TSL := '0';
    rstB			:in  TSL := '1';
    addrB			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_inB			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_outB			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
 );
end XLPM_UDPMold;

architecture behaviour of XLPM_UDPMold is

  type TXDPM_type is record
    anum :TP;
    dnum :TP;
  end record;
  type TXDPM_tab is array (TN range<>) of TXDPM_type;
  constant XDPM_tab :TXDPM_tab := (
    (14,  1), -- index 0
    (13,  2), -- index 1
    (12,  4), -- index 2
    (11,  8), -- index 3
    (10, 16), -- index 4
    ( 9, 32)  -- index 5
  );

  function XDPM_AdrrBlockIndexGet(anum :TN) return TN is
    variable AddrBlockIndex :TN;
  begin
    AddrBlockIndex:=0;
    for index in XDPM_tab'length-1 downto 0 loop
      AddrBlockIndex:=index;
      if (anum<=XDPM_tab(index).anum) then
        exit;
      end if;
    end loop;
    return(AddrBlockIndex);
  end function;
  
  function XDPM_BlockEnaGet(line :TN; addr :TSLV; ena :TSL) return TSLV is
    variable VecVar :TSLV(pow2(line)-1 downto 0);
    variable AddrVar :TN range VecVar'left downto 0;
  begin
    if(line=0) then
      VecVar:=(others => ena);
    else
      VecVar:=(others => '0');
      AddrVar:=TNconv(addr(addr'left downto addr'left-line+1));
      VecVar(AddrVar):=ena;
    end if;
    return(VecVar);
  end function;
  
  constant XDPM_AddrBlockIndex : TN := XDPM_AdrrBlockIndexGet(LPM_ADDR_WIDTH);
  constant XDPM_AddrNum        : TN := XDPM_tab(XDPM_AddrBlockIndex).anum;
  constant XDPM_DataNum        : TN := XDPM_tab(XDPM_AddrBlockIndex).dnum;
  constant XDPM_AddrBlockLine  : TN := maximum(0,LPM_ADDR_WIDTH-XDPM_AddrNum);
  constant XDPM_AddrBlockNum   : TN := pow2(XDPM_AddrBlockLine);
  constant XDPM_DataBlockNum   : TN := SLVPartNum(LPM_DATA_WIDTH,XDPM_DataNum);
  constant VecLow              : TSLV(3 downto 0) := (others =>'0');
  
  subtype XDPM_DataPage is TSLV(XDPM_DataBlockNum*XDPM_DataNum-1 downto 0);
  type    XDPM_DataTab is array (XDPM_AddrBlockNum-1 downto 0) of XDPM_DataPage;
  
  function DataRdGet(dline :TN; tab :XDPM_DataTab) return TSLV is
    variable BlockDataVar :TSLV(XDPM_DataPage'length-1 downto 0);
  begin
    BlockDataVar := (others => '0');
    for index in XDPM_DataTab'range loop
      BlockDataVar := BlockDataVar or tab(index);
    end loop;
    return(BlockDataVar(dline-1 downto 0));
  end function;
  
  signal  BlockENA :TSLV(XDPM_AddrBlockNum-1 downto 0);
  signal  BlockADA :TSLV(XDPM_AddrNum-1 downto 0);
  signal  BlockDIA :XDPM_DataPage;
  signal  BlockDOA :XDPM_DataTab;
  signal  BlockENB :TSLV(XDPM_AddrBlockNum-1 downto 0);
  signal  BlockADB :TSLV(XDPM_AddrNum-1 downto 0);
  signal  BlockDIB :XDPM_DataPage;
  signal  BlockDOB :XDPM_DataTab;

begin

  BlockENA <= XDPM_BlockEnaGet(XDPM_AddrBlockLine,addrA,enableA);
  BlockADA <= TSLVResize(addrA,BlockADA'length);
  BlockDIA <= TSLVResize(data_inA,BlockDIA'length);

  BlockENB <= XDPM_BlockEnaGet(XDPM_AddrBlockLine,addrB,enableB);
  BlockADB <= TSLVResize(addrB,BlockADA'length);
  BlockDIB <= TSLVResize(data_inB,BlockDIB'length);

  aloop:
  for aindex in 0 to XDPM_AddrBlockNum-1 generate
    dloop:
    for dindex in 0 to XDPM_DataBlockNum-1 generate
      cif0:
      if (XDPM_AddrBlockIndex=0) generate
        mem: RAMB16_S1_S1
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum)
	  );
      end generate;
      cif1:
      if (XDPM_AddrBlockIndex=1) generate
        mem: RAMB16_S2_S2
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum)
	  );
      end generate;
      cif2:
      if (XDPM_AddrBlockIndex=2) generate
        mem: RAMB16_S4_S4
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum)
	  );
      end generate;
      cif3:
      if (XDPM_AddrBlockIndex=3) generate
        mem: RAMB16_S9_S9
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPA  => VecLow(0 downto 0),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPA  => open,
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPB  => VecLow(0 downto 0),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPB  => open
	  );
      end generate;
      cif4:
      if (XDPM_AddrBlockIndex=4) generate
        mem: RAMB16_S18_S18
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPA  => VecLow(1 downto 0),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPA  => open,
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPB  => VecLow(1 downto 0),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPB  => open
	  );
      end generate;
      cif5:
      if (XDPM_AddrBlockIndex=5) generate
        mem: RAMB16_S36_S36
          port map (
            CLKA  => clkA,
            ENA   => BlockENA(aindex),
            WEA   => weA,
            SSRA  => rstA,
            ADDRA => BlockADA(XDPM_AddrNum-1 downto 0),
            DIA   => BlockDIA((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPA  => VecLow(3 downto 0),
	    DOA   => BlockDOA(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPA  => open,
	    --
            CLKB  => clkB,
            ENB   => BlockENB(aindex),
            WEB   => weB,
            SSRB  => rstB,
            ADDRB => BlockADB(XDPM_AddrNum-1 downto 0),
            DIB   => BlockDIB((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
            DIPB  => VecLow(3 downto 0),
	    DOB   => BlockDOB(aindex)((dindex+1)*XDPM_DataNum-1 downto dindex*XDPM_DataNum),
	    DOPB  => open
	  );
      end generate;
    end generate;
  end generate;

  data_outA <= DataRdGet(LPM_DATA_WIDTH,BlockDOA);
  data_outB <= DataRdGet(LPM_DATA_WIDTH,BlockDOB);

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

entity dcm_spartan6_mult is
  generic (
    LPM_MULTIP_CLOCK		:in natural := 0;
    LPM_DIVIDE_CLOCK		:in natural := 0;
    CLOCK_IN_FREQ_MHZ		:in real    := 0.0
  );
  port (
    CLKIN_IN			: in    std_logic; 
    RST_IN			: in    std_logic; 
    CLKFX_OUT			: out   std_logic; 
    CLKIN_IBUFG_OUT		: out   std_logic; 
    CLK0_OUT 			: out   std_logic; 
    CLK90_OUT 			: out   std_logic; 
    LOCKED_OUT			: out   std_logic);
end dcm_spartan6_mult;

architecture BEHAVIORAL of dcm_spartan6_mult is
   signal CLKFB_IN        : std_logic;
   signal CLKFX_BUF       : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal CLK90_BUF       : std_logic;
   signal GND             : std_logic;
   component BUFG
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   
   component IBUFG
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   
begin
   GND <= '0';
   CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
   CLK0_OUT <= CLKFB_IN;
   CLKFX_BUFG_INST : BUFG
      port map (I=>CLKFX_BUF,
                O=>CLKFX_OUT);
   
--   CLKIN_IBUFG_INST : IBUFG
--      port map (I=>CLKIN_IN,
--                O=>CLKIN_IBUFG);
   CLKIN_IBUFG <= CLKIN_IN;
   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>CLKFB_IN);
   CLK90_BUFG_INST : BUFG
      port map (I=>CLK90_BUF,
                O=>CLK90_OUT);
   
   DCM_INST : DCM
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => 2.000000,
            CLKFX_DIVIDE => LPM_DIVIDE_CLOCK,
            CLKFX_MULTIPLY => LPM_MULTIP_CLOCK,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 1000.0/CLOCK_IN_FREQ_MHZ,
            CLKOUT_PHASE_SHIFT => "NONE",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"C080",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE,
            DSS_MODE => "NONE")
      port map (CLKFB=>CLKFB_IN,
                CLKIN=>CLKIN_IBUFG,
                DSSEN=>GND,
                PSCLK=>GND,
                PSEN=>GND,
                PSINCDEC=>GND,
                RST=>RST_IN,
                CLKDV=>open,
                CLKFX=>CLKFX_BUF,
                CLKFX180=>open,
                CLK0=>CLK0_BUF,
                CLK2X=>open,
                CLK2X180=>open,
                CLK90=>CLK90_BUF,
                CLK180=>open,
                CLK270=>open,
                LOCKED=>LOCKED_OUT,
                PSDONE=>open,
                STATUS=>open);
   
end BEHAVIORAL;

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

entity dcm_spartan6_div is
  generic (
    LPM_DIVIDE_CLOCK		:in  natural := 0;
    CLOCK_IN_FREQ_MHZ		:in  real    := 0.0
  );
  port (
    CLKIN_IN			:in  std_logic; 
    RST_IN			:in  std_logic; 
    CLKDV_OUT			:out std_logic; 
    CLKIN_IBUFG_OUT		:out std_logic; 
    CLK0_OUT			:out std_logic; 
    CLK90_OUT			:out std_logic; 
    LOCKED_OUT			:out std_logic);
end dcm_spartan6_div;

architecture BEHAVIORAL of dcm_spartan6_div is
   signal CLKDV_BUF       : std_logic;
   signal CLKFB_IN        : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal CLK90_BUF       : std_logic;
   signal GND             : std_logic;

begin
   GND <= '0';
   CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
   CLK0_OUT <= CLKFB_IN;
   CLKDV_BUFG_INST : BUFG
      port map (I=>CLKDV_BUF,
                O=>CLKDV_OUT);
   
--   CLKIN_IBUFG_INST : IBUFG
--      port map (I=>CLKIN_IN,
--                O=>CLKIN_IBUFG);
   CLKIN_IBUFG <= CLKIN_IN;
   
   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>CLKFB_IN);
   
   CLK90_BUFG_INST : BUFG
      port map (I=>CLK90_BUF,
                O=>CLK90_OUT);
   
   DCM_INST : DCM
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => real(LPM_DIVIDE_CLOCK),
            CLKFX_DIVIDE => 1,
            CLKFX_MULTIPLY => 4,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 1000.0/CLOCK_IN_FREQ_MHZ,
            CLKOUT_PHASE_SHIFT => "NONE",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"C080",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE,
            DSS_MODE => "NONE")
      port map (CLKFB=>CLKFB_IN,
                CLKIN=>CLKIN_IBUFG,
                DSSEN=>GND,
                PSCLK=>GND,
                PSEN=>GND,
                PSINCDEC=>GND,
                RST=>RST_IN,
                CLKDV=>CLKDV_BUF,
                CLKFX=>open,
                CLKFX180=>open,
                CLK0=>CLK0_BUF,
                CLK2X=>open,
                CLK2X180=>open,
                CLK90=>CLK90_BUF,
                CLK180=>open,
                CLK270=>open,
                LOCKED=>LOCKED_OUT,
                PSDONE=>open,
                STATUS=>open);
   
end BEHAVIORAL;


-------------------------------------------------------------------
-- LPMComp_UniTech
-------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UT_TRI_MODE is
  generic (
    UT_IOMODE			:TUT_IOMODE
  );
  port(
    p_p				:inout TSL;
    p_n				:inout TSL;
    o_p               		:out   TSL;
    o_n               		:out   TSL;
    o                 		:out   TSL;
    i_p               		:in    TSL;
    i_n				:in    TSL;
    i		        	:in    TSL;
    e_p               		:in    TSL;
    e_n               		:in    TSL;
    e                 		:in    TSL
  );
end UT_TRI_MODE;

architecture behaviour of UT_TRI_MODE is

  signal EpN, EnN :TSL;

begin

  EpN <= not(e_p); EnN <= not(e_n);

  IN_WIRE_sel: if (UT_IOMODE=IN_WIRE) generate
    o_p <= p_p;
    o_n <= p_n;
    o <= '0';
  end generate;
  
  OUT_WIRE_sel: if (UT_IOMODE=OUT_WIRE) generate
    p_p <= i_p;
    p_n <= i_n;
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  IN_LVDS_25_sel: if (UT_IOMODE=IN_LVDS_25) generate
    buf : IBUFDS generic map (DIFF_TERM => TRUE, IOSTANDARD => "LVDS_25") port map (I  => p_p, IB => p_n, O  => o);
    o_p <= '0';
    o_n <= '0';
  end generate;
  
  OUT_LVDS_25_sel: if (UT_IOMODE=OUT_LVDS_25) generate
    buf : OBUFDS generic map (IOSTANDARD => "LVDS_25") port map (I => i, O => p_p, OB => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  IN_LVDS_33_sel: if (UT_IOMODE=IN_LVDS_33) generate
    buf : IBUFDS generic map (DIFF_TERM => TRUE, IOSTANDARD => "LVDS_33") port map (I  => p_p, IB => p_n, O  => o);
    o_p <= '0';
    o_n <= '0';
  end generate;
  
  OUT_LVDS_33_sel: if (UT_IOMODE=OUT_LVDS_33) generate
    buf : OBUFDS generic map (IOSTANDARD => "LVDS_33") port map (I => i, O => p_p, OB => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  IN_LVCMOS25_sel: if (UT_IOMODE=IN_LVCMOS25) generate
    bufp : IBUF generic map (IOSTANDARD => "LVCMOS25") port map (I  => p_p, O  => o_p);
    bufn : IBUF generic map (IOSTANDARD => "LVCMOS25") port map (I  => p_n, O  => o_n);
    o <= '0';
  end generate;
  
  OUT_LVCMOS25_sel: if (UT_IOMODE=OUT_LVCMOS25) generate
    bufp : OBUF generic map (IOSTANDARD => "LVCMOS25") port map (I  => i_p, O  => p_p);
    bufn : OBUF generic map (IOSTANDARD => "LVCMOS25") port map (I  => i_n, O  => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  INOUT_LVCMOS25_sel: if (UT_IOMODE=TRI_LVCMOS25) generate
    bufp : IOBUF generic map (IOSTANDARD => "LVCMOS25") port map (IO  => p_p, I  => i_p, O  => o_p, T  => EpN);
    bufn : IOBUF generic map (IOSTANDARD => "LVCMOS25") port map (IO  => p_n, I  => i_n, O  => o_n, T  => EnN);
    o   <= '0';
  end generate;
  
  IN_LVCMOS33_sel: if (UT_IOMODE=IN_LVCMOS33) generate
    bufp : IBUF generic map (IOSTANDARD => "LVCMOS33") port map (I  => p_p, O  => o_p);
    bufn : IBUF generic map (IOSTANDARD => "LVCMOS33") port map (I  => p_n, O  => o_n);
    o <= '0';
  end generate;
  
  OUT_LVCMOS33_sel: if (UT_IOMODE=OUT_LVCMOS33) generate
    bufp : OBUF generic map (IOSTANDARD => "LVCMOS33") port map (I  => i_p, O  => p_p);
    bufn : OBUF generic map (IOSTANDARD => "LVCMOS33") port map (I  => i_n, O  => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  INOUT_LVCMOS33_sel: if (UT_IOMODE=TRI_LVCMOS33) generate
    bufp : IOBUF generic map (IOSTANDARD => "LVCMOS33") port map (IO  => p_p, I  => i_p, O  => o_p, T  => EpN);
    bufn : IOBUF generic map (IOSTANDARD => "LVCMOS33") port map (IO  => p_n, I  => i_n, O  => o_n, T  => EnN);
    o   <= '0';
  end generate;

  IN_BLVDS_25_sel: if (UT_IOMODE=IN_BLVDS_25) generate
    buf : IBUFDS generic map (IOSTANDARD => "BLVDS_25") port map (I  => p_p, IB => p_n, O  => o);
    o_p <= '0';
    o_n <= '0';
  end generate;
  
  OUT_BLVDS_25_sel: if (UT_IOMODE=OUT_BLVDS_25) generate
    buf : OBUFDS generic map (IOSTANDARD => "BLVDS_25") port map (I => i, O => p_p, OB => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  INOUT_BLVDS_25_sel: if (UT_IOMODE=TRI_BLVDS_25) generate
    buf : IOBUFDS generic map (IOSTANDARD => "BLVDS_25") port map (IO  => p_p, IOB => p_n, I  => i_p, O  => o_p, T  => EpN);
    o   <= '0';
  end generate;
  
  IN_UNDEF_SIMM_sel: if (UT_IOMODE=IN_UNDEF_SIM) generate
    buf : IBUFDS generic map (IOSTANDARD => "DEFAULT") port map (I  => p_p, IB => p_n, O  => o);
    o_p <= '0';
    o_n <= '0';
  end generate;
  
  OUT_UNDEF_SIMM_sel: if (UT_IOMODE=OUT_UNDEF_SIM) generate
    buf : OBUFDS generic map (IOSTANDARD => "DEFAULT") port map (I => i, O => p_p, OB => p_n);
    o_p <= '0';
    o_n <= '0';
    o   <= '0';
  end generate;
  
  INOUT_UNDEF_SIMM_sel: if (UT_IOMODE=TRI_UNDEF_SIM) generate
    buf : IOBUFDS generic map (IOSTANDARD => "DEFAULT") port map (IO  => p_p, IOB => p_n, I  => i_p, O  => o_p, T  => EpN);
    o   <= '0';
  end generate;
  
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_GLOBAL is
  port(
    i				:in  TSL;
    o				:out TSL
  );
end entity UT_GLOBAL;

architecture behaviour of UT_GLOBAL is
begin
  gbuf : BUFG
    port map (
      I => i,
      O => o
    );
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_IN_SIMM is
  port(
    p_p				:in  TSL;
    p_n				:in  TSL;
    o				:out TSL
  );
end UT_IN_SIMM;

architecture behaviour of UT_IN_SIMM is
begin
  ibuf: IBUFDS
    port map (
      I  => p_p,
      IB => p_n,
      O  => o
    );
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_GIN_SIMM is
  port(
    p_p				:in  TSL;
    p_n				:in  TSL;
    o				:out TSL
  );
end UT_GIN_SIMM;

architecture behaviour of UT_GIN_SIMM is
begin
  ibuf: IBUFGDS
    port map (
      I  => p_p,
      IB => p_n,
      O  => o
    );
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_OUT_SIMM is
  port(
    i				:in  TSL;
    p_p				:out TSL;
    p_n			:out TSL
  );
end UT_OUT_SIMM;

architecture behaviour of UT_OUT_SIMM is
begin
  buf: OBUFDS
    port map (
      O  => p_p,
      OB => p_n,
      I  => i
    ) ;
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_TRI_SIMM is
  port(
    i				:in    TSL;
    o				:out   TSL;
    p_p				:inout TSL;
    p_n				:inout TSL;
    e				:in    TSL
  );
end UT_TRI_SIMM;

architecture behaviour of UT_TRI_SIMM is
  signal t :TSL;
begin
  t <= not(e);
  buf: IOBUFDS
    port map (
      I   => i,
      O   => o,
      IO  => p_p,
      IOB => p_n,
      T   => t
    );
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity UT_TRI is
  port(
    i				:in    TSL;
    o				:out   TSL;
    p				:inout TSL;
    e				:in    TSL
  );
end UT_TRI;

architecture behaviour of UT_TRI is
begin
  o <= p;
  p <= i when e='1' else 'Z';
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity UT_OC is
  port(
    i				:in    TSL;
    o				:out   TSL;
    p				:inout TSL;
    e				:in    TSL
  );
end UT_OC;

architecture behaviour of UT_OC is
begin
  o <= p;
  p <= '0' when (e='1' and i='0') else 'Z';
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

entity UTLPM_DPM_SYNCH is
  generic (
    LPM_DATA_WIDTH		:in natural := 0;
    LPM_ADDR_WIDTH		:in natural := 0
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    wr_ena1			:in  TSL;
    addr1			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_in1			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out1			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    wr_ena2			:in  TSL;
    addr2			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    data_in2			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    data_out2			:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );  
end UTLPM_DPM_SYNCH;

architecture behaviour of UTLPM_DPM_SYNCH is

  signal L, H			:TSL;

begin

  L <= '0'; H <= '1';
	
  mem :XLPM_UDPM
    generic map(
      LPM_DATA_WIDTH => LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH =>	LPM_ADDR_WIDTH
    )
    port map(
      clkA           => clk,
      enableA        => H,
      weA            => wr_ena1,
      rstA           => L,
      addrA          => addr1,
      data_inA       => data_in1,
      data_outA      => data_out1,
      clkB           => clk,   
      enableB        => H,         
      weB            => wr_ena2,    
      rstB           => L,         
      addrB          => addr2,  
      data_inB       => data_in2,
      data_outB      => data_out2
    );

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_Config.all;
use work.LPMComp_spartan6.all;

entity UTLPM_DPM_PROG is
  generic (
    LPM_DATA_WIDTH		:in natural := 8;
    LPM_ADDR_WIDTH		:in natural := 4;
    LPM_MDATA_WIDTH		:in natural := 4;
    ADDRESS_SEPARATE		:in boolean := TRUE;
    INIT_CLEAR_ENA		:in boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    wr_ena			:in  TSL;
    wr_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    wr_data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    rd_ena			:in  TSL;
    rd_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    rd_data			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    mem_str			:in  TSL;
    mem_wr			:in  TSL;
    mem_addr			:in  TSLV(LPM_ADDR_WIDTH-1 downto 0);
    mem_data_in			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    mem_data_out		:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    mem_ena			:in  TSL;
    mem_ena_ack			:out TSL
  );
end UTLPM_DPM_PROG;

architecture behaviour of UTLPM_DPM_PROG is

  signal L, H			:TSL;
  signal RdDataReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ClksigN		:TSL;
  signal ClkBsig		:TSL;
  signal WEAsig			:TSL;
  signal WEBsig			:TSL;
  signal AddrBsig		:TSLV(LPM_ADDR_WIDTH-1 downto 0);
  signal DataOutBsig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal MemStrReg              :TSL;

begin

  L <= '0'; H <= '1';
  ClksigN <= not(clk);
	
  process(clk, resetN)
  begin
    if(resetN='0') then
      RdDataReg <= (others =>'0');
      MemStrReg <= '0';
    elsif(clk'event and clk='1') then
      MemStrReg <= mem_str and mem_wr;
      if(rd_ena='1' and mem_ena='0') then
        if (ADDRESS_SEPARATE=TRUE and wr_addr=rd_addr and wr_ena='1') then
          RdDataReg <= wr_data;
	else
          RdDataReg <= DataOutBsig;
	end if;
      end if;
    end if;
  end process;
  
  WEAsig      <= wr_ena   when mem_ena='0' else L;
  ClkBsig     <= not(clk) when (mem_ena='0' or LPMComp_MEMORY_CLOCK_STROBE_ENA=TRUE) else mem_str;
  WEBsig      <= L        when mem_ena='0' else MemStrReg when LPMComp_MEMORY_CLOCK_STROBE_ENA=TRUE else mem_wr;
  AddrBsig    <= rd_addr  when mem_ena='0' else mem_addr;

  mem :XLPM_UDPM
    generic map(
      LPM_DATA_WIDTH => LPM_DATA_WIDTH,
      LPM_ADDR_WIDTH =>	LPM_ADDR_WIDTH
    )
    port map(
      clkA           => clk,
      enableA        => H,
      weA            => WEAsig,
      rstA           => L,
      addrA          => wr_addr,
      data_inA       => wr_data,
      data_outA      => open,
      clkB           => ClkBsig,   
      enableB        => H,         
      weB            => WEBsig,    
      rstB           => L,         
      addrB          => AddrBsig,  
      data_inB       => mem_data_in,
      data_outB      => DataOutBsig
    );

  mem_ena_ack  <= mem_ena;
  rd_data      <= RdDataReg;
  mem_data_out <= DataOutBsig when mem_ena='1' else (others => '0');
  
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_spartan6.all;

entity UTLPM_MODIFY_CLOCK is
  generic (
    LPM_MULTIP_CLOCK		:in natural := 0;
    LPM_DIVIDE_CLOCK		:in natural := 0;
    CLOCK_IN_FREQ_MHZ		:in natural := 0
  );
  port(
    resetN			:in  TSL;
    clk_in			:in  TSL;
    clk_out			:out TSL;
    clk90_out			:out TSL;
    mclk_out			:out TSL;
    mclk90_out			:out TSL;
    locked			:out TSL
  );
end UTLPM_MODIFY_CLOCK;

architecture behaviour of UTLPM_MODIFY_CLOCK is

  signal ResetSig    :TSL;

begin

  ResetSig <= not(resetN);
  mult:
  if (LPM_MULTIP_CLOCK>1) generate
    mclk: dcm_spartan6_mult
      generic map (
        LPM_MULTIP_CLOCK  => LPM_MULTIP_CLOCK,
        LPM_DIVIDE_CLOCK  => LPM_DIVIDE_CLOCK,
        CLOCK_IN_FREQ_MHZ => real(CLOCK_IN_FREQ_MHZ)
      )
      port map(
        CLKIN_IN          => clk_in,
        RST_IN            => ResetSig,
        CLKFX_OUT         => mclk_out,
        CLKIN_IBUFG_OUT   => open,
        CLK0_OUT          => clk_out,
        CLK90_OUT         => clk90_out,
        LOCKED_OUT        => locked
    );
    mclk90_out <= '0';
  end generate;
  --
  div:
  if (LPM_MULTIP_CLOCK=1) generate
    mclk: dcm_spartan6_div
      generic map (
        LPM_DIVIDE_CLOCK  => LPM_DIVIDE_CLOCK,
        CLOCK_IN_FREQ_MHZ => real(CLOCK_IN_FREQ_MHZ)
      )
      port map(
        CLKIN_IN          => clk_in,
        RST_IN            => ResetSig,
        CLKDV_OUT         => mclk_out, 
        CLKIN_IBUFG_OUT   => open,
        CLK0_OUT          => clk_out,
        CLK90_OUT         => clk90_out,
        LOCKED_OUT        => locked
    );
    mclk90_out <= '0';
  end generate;

end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_IN_SER2 is
  generic (
    CLK180_ADD                  :TL := TRUE
  );
  port (
    rN                          :in  TSL;
    c0                          :in  TSL;
    c180                        :in  TSL := '0';
    i                           :in  TSL;
    o0                          :out TSL;
    o180                        :out TSL
  );
end UT_IN_SER2;

architecture behaviour of UT_IN_SER2 is

  signal reset                  :TSL;
  signal clk180sig              :TSL;

begin
 
  reset       <= not(rN);
  clk180sig   <= not(c0)   when CLK180_ADD=TRUE  else c180;
  --
  rx : IDDR2
    generic map(
      DDR_ALIGNMENT             => "C0", -- Sets output alignment to "NONE", "C0", "C1"
      INIT_Q0                   => '0', -- Sets initial state of the Q0 output to ’0’ or ’1’
      INIT_Q1                   => '0', -- Sets initial state of the Q1 output to ’0’ or ’1’
      SRTYPE                    => "ASYNC") -- Specifies "SYNC" or "ASYNC" set/reset
    port map (
      D                         => i, 
      C0                        => c0,
      C1                        => clk180sig,
      CE                        => '1',
      Q0                        => o0,
      Q1                        => o180,
      R                         => reset, 
      S                         => '0'
    );
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_OUT_SER2 is
  generic (
    CLK180_ADD                  :TL := TRUE
  );
  port (
    rN                          :in  TSL;
    c0                          :in  TSL;
    c180                        :in  TSL := '0';
    i0                          :in  TSL;
    i180                        :in  TSL;
    o                           :out TSL
  );
end UT_OUT_SER2;

architecture behaviour of UT_OUT_SER2 is

  signal reset                  :TSL;
  signal clk180sig              :TSL;

begin
 
  reset  <= not(rN);
  clk180sig   <= not(c0)   when CLK180_ADD=TRUE  else c180;
  --
  tx : ODDR2
    generic map(
      DDR_ALIGNMENT             => "C0", -- Sets output alignment to "NONE", "C0", "C1"
      INIT                      => '0', -- Sets initial state of the Q output to ’0’ or ’1’
      SRTYPE                    => "ASYNC") -- Specifies "SYNC" or "ASYNC" set/reset
    port map (
      Q                         => o, 
      C0                        => c0,
      C1                        => clk180sig,
      CE                        => '1',
      D0                        => i0,
      D1                        => i180,
      R                         => reset, 
      S                         => '0'
    );
end behaviour;


-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;
use work.std_logic_1164_ktp.all;

entity UT_TRI_SER2_SIMM is
  generic (
    CLK180_ADD                  :TL := TRUE
  );
  port (
    rN                          :in    TSL;
    c0                          :in    TSL;
    c180                        :in    TSL;
    i0                          :in    TSL;
    i180                        :in    TSL;
    o0                          :out   TSL;
    o180                        :out   TSL;
    p_p                         :inout TSL;
    p_n                         :inout TSL;
    e0                          :in    TSL;
    e180                        :in    TSL
  );
end UT_TRI_SER2_SIMM;

architecture behaviour of UT_TRI_SER2_SIMM is

  signal tri, tro, trt          :TSL;
  signal reset               :TSL;
  signal c180sig                :TSL;
  signal t0sig                  :TSL;
  signal t180sig                :TSL;

begin
 
  reset    <= not(rN);
  c180sig <= not(c0) when CLK180_ADD=TRUE  else c180;
  --
  tbuf: IOBUFDS
    port map (
      I   => tri,
      O   => tro,
      IO  => p_p,
      IOB => p_n,
      T   => trt
    );
  --
  rx : IDDR2
    generic map(
      DDR_ALIGNMENT             => "C0", -- Sets output alignment to "NONE", "C0", "C1"
      INIT_Q0                   => '0', -- Sets initial state of the Q0 output to ’0’ or ’1’
      INIT_Q1                   => '0', -- Sets initial state of the Q1 output to ’0’ or ’1’
      SRTYPE                    => "ASYNC") -- Specifies "SYNC" or "ASYNC" set/reset
    port map (
      D                         => tro, 
      C0                        => c0,
      C1                        => c180sig,
      CE                        => '1',
      Q0                        => o0,
      Q1                        => o180,
      R                         => reset, 
      S                         => '0'
    );
  --
  tx : ODDR2
    generic map(
      DDR_ALIGNMENT             => "C0", -- Sets output alignment to "NONE", "C0", "C1"
      INIT                      => '0', -- Sets initial state of the Q output to ’0’ or ’1’
      SRTYPE                    => "ASYNC") -- Specifies "SYNC" or "ASYNC" set/reset
    port map (
      Q                         => tri, 
      C0                        => c0,
      C1                        => c180sig,
      CE                        => '1',
      D0                        => i0,
      D1                        => i180,
      R                         => reset, 
      S                         => '0'
    );
  --
  t0sig   <= not(e0);
  t180sig <= not(e180);
  --
  txe : ODDR2
    generic map(
      DDR_ALIGNMENT             => "C0", -- Sets output alignment to "NONE", "C0", "C1"
      INIT                      => '1', -- Sets initial state of the Q output to ’0’ or ’1’
      SRTYPE                    => "ASYNC") -- Specifies "SYNC" or "ASYNC" set/reset
    port map (
      Q                         => trt, 
      C0                        => c0,
      C1                        => c180sig,
      CE                        => '1',
      D0                        => t0sig,
      D1                        => t180sig,
      R                         => '0', 
      S                         => reset
    );
    
end behaviour;
