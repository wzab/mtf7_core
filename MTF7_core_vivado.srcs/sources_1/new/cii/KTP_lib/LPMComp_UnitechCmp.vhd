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
use work.LPMComp_UniTech.all;

entity UTLPM_BUSTRI_MODE is
  generic (
    LPM_IOMODE			:TUTV_IOMODE;
    LPM_WIDTH			:TN := 0
  );
  port(
    p_p				:inout TSLV(LPM_WIDTH-1 downto 0);
    p_n				:inout TSLV(LPM_WIDTH-1 downto 0);
    o_p               		:out   TSLV(LPM_WIDTH-1 downto 0);
    o_n               		:out   TSLV(LPM_WIDTH-1 downto 0);
    o                 		:out   TSLV(LPM_WIDTH-1 downto 0);
    i_p               		:in    TSLV(LPM_WIDTH-1 downto 0);
    i_n				:in    TSLV(LPM_WIDTH-1 downto 0);
    i		        	:in    TSLV(LPM_WIDTH-1 downto 0);
    e_p               		:in    TSLV(LPM_WIDTH-1 downto 0);
    e_n               		:in    TSLV(LPM_WIDTH-1 downto 0);
    e                 		:in    TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUSTRI_MODE;

architecture behaviour of UTLPM_BUSTRI_MODE is begin
  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_TRI_MODE
      generic map (
        UT_IOMODE		=> LPM_IOMODE(index)
      )
      port map (
        p_p			=> p_p(index),
        p_n			=> p_n(index),
        o_p               	=> o_p(index),
        o_n               	=> o_n(index),
        o                 	=> o(index),
        i_p               	=> i_p(index),
        i_n			=> i_n(index),
        i		        => i(index),
        e_p               	=> e_p(index),
        e_n               	=> e_n(index),
        e                 	=> e(index)  
      );
  end generate;
end behaviour;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUS_GLOBAL is
  generic (
    LPM_WIDTH			:TN := 0
  );
  port(
    i				:in  TSLV(LPM_WIDTH-1 downto 0);
    o				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUS_GLOBAL;

architecture behaviour of UTLPM_BUS_GLOBAL is

begin

  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_GLOBAL
      port map (
        i  => i(index),
        o  => o(index)
    );
  end generate;

end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSIN_SIMM is
  generic (
    LPM_WIDTH			:TN := 0
  );
  port(
    p_p				:in  TSLV(LPM_WIDTH-1 downto 0);
    p_n				:in  TSLV(LPM_WIDTH-1 downto 0);
    o				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUSIN_SIMM;

architecture behaviour of UTLPM_BUSIN_SIMM is

begin

  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_IN_SIMM
      port map (
        p_p => p_p(index),
        p_n => p_n(index),
        o   => o(index)
    );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSOUT_SIMM is
  generic (
    LPM_WIDTH			:TN := 0
  );
  port(
    i				:in  TSLV(LPM_WIDTH-1 downto 0);
    p_p				:out TSLV(LPM_WIDTH-1 downto 0);
    p_n				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUSOUT_SIMM;

architecture behaviour of UTLPM_BUSOUT_SIMM is

begin

  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_OUT_SIMM
      port map (
        i   => i(index),
        p_p => p_p(index),
        p_n => p_n(index)
    );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSTRI_SIMM is
  generic (
    LPM_WIDTH			:TN := 0
  );
  port(
    i				:in    TSLV(LPM_WIDTH-1 downto 0);
    o				:out   TSLV(LPM_WIDTH-1 downto 0);
    p_p				:inout TSLV(LPM_WIDTH-1 downto 0);
    p_n				:inout TSLV(LPM_WIDTH-1 downto 0);
    o_e				:in    TSLV(LPM_WIDTH-1 downto 0);
    e				:in    TSL
  );
end UTLPM_BUSTRI_SIMM;

architecture behaviour of UTLPM_BUSTRI_SIMM is
  signal   EnaSig		:TSLV(LPM_WIDTH-1 downto 0);
begin

  EnaSig <= (others =>'1') when e='1' else o_e;
  --
  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_TRI_SIMM
      port map (
        i   => i(index),
        o   => o(index),
        p_p => p_p(index),
        p_n => p_n(index),
        e   => EnaSig(index)
    );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSTRI is
  generic (
    LPM_WIDTH			:TN := 0
  );
  port(
    i				:in    TSLV(LPM_WIDTH-1 downto 0);
    o				:out   TSLV(LPM_WIDTH-1 downto 0);
    p				:inout TSLV(LPM_WIDTH-1 downto 0);
    o_e				:in    TSLV(LPM_WIDTH-1 downto 0);
    e				:in    TSL
  );
end UTLPM_BUSTRI;

architecture behaviour of UTLPM_BUSTRI is
  signal   EnaSig		:TSLV(LPM_WIDTH-1 downto 0);
begin

  EnaSig <= (others =>'1') when e='1' else o_e;
  --
  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_TRI
      port map (
        i => i(index),
        o => o(index),
        p => p(index),
        e => EnaSig(index)
    );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSIN_SER2 is
  generic (
    LPM_WIDTH			:TN := 0;
    CLK180_ADD                  :TL := TRUE
  );
  port(
    rN                          :in  TSL;
    c0                          :in  TSL;
    c180                        :in  TSL := '0';
    i                           :in  TSLV(LPM_WIDTH-1 downto 0);
    o0                          :out TSLV(LPM_WIDTH-1 downto 0);
    o180                        :out TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUSIN_SER2;

architecture behaviour of UTLPM_BUSIN_SER2 is

begin

  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_IN_SER2
      generic map (
        CLK180_ADD => CLK180_ADD
      )
      port map (
        rN         => rN,
        c0         => c0,
        c180       => c180,
        i          => i(index),
        o0         => o0(index),
        o180       => o180(index)
      );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSOUT_SER2 is
  generic (
    LPM_WIDTH			:TN := 0;
    CLK180_ADD                  :TL := TRUE
  );
  port(
    rN                          :in  TSL;
    c0                          :in  TSL;
    c180                        :in  TSL := '0';
    i0                          :in  TSLV(LPM_WIDTH-1 downto 0);
    i180                        :in  TSLV(LPM_WIDTH-1 downto 0);
    o                           :out TSLV(LPM_WIDTH-1 downto 0)
  );
end UTLPM_BUSOUT_SER2;

architecture behaviour of UTLPM_BUSOUT_SER2 is

begin

  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_OUT_SER2
      generic map (
        CLK180_ADD       => CLK180_ADD
      )
      port map (
        rN               => rN,
        c0               => c0,
        c180             => c180,
        i0               => i0(index),
        i180             => i180(index),
        o                => o(index)
      );
  end generate;
  
end behaviour;			   

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;

entity UTLPM_BUSTRI_SER2_SIMM is
  generic (
    LPM_WIDTH                   :TN := 0;
    CLK180_ADD                  :TL := TRUE
  );
  port (
    rN                          :in    TSL;
    c0                          :in    TSL;
    c180                        :in    TSL;
    i0                          :in    TSLV(LPM_WIDTH-1 downto 0);
    i180                        :in    TSLV(LPM_WIDTH-1 downto 0);
    o0                          :out   TSLV(LPM_WIDTH-1 downto 0);
    o180                        :out   TSLV(LPM_WIDTH-1 downto 0);
    p_p                         :inout TSLV(LPM_WIDTH-1 downto 0);
    p_n                         :inout TSLV(LPM_WIDTH-1 downto 0);
    e0                          :in    TSLV(LPM_WIDTH-1 downto 0);
    e180                        :in    TSLV(LPM_WIDTH-1 downto 0);
    e                           :in    TSL
  );
end entity UTLPM_BUSTRI_SER2_SIMM;


architecture behaviour of UTLPM_BUSTRI_SER2_SIMM is
  signal   e0Sig		:TSLV(LPM_WIDTH-1 downto 0);
  signal   e180Sig		:TSLV(LPM_WIDTH-1 downto 0);
begin

  e0Sig   <= (others =>'1') when e='1' else e0;
  e180Sig <= (others =>'1') when e='1' else e180;
  --
  iloop:
  for index in 0 to LPM_WIDTH-1 generate
    buf: UT_TRI_SER2_SIMM
      generic map (
        CLK180_ADD => CLK180_ADD
      )
      port map (
        rN        => rN,
        c0        => c0,
        c180      => c180,
        i0        => i0(index),
        i180      => i180(index),
        o0        => o0(index),
        o180      => o180(index),
        p_p       => p_p(index),
        p_n       => p_n(index),
        e0        => e0Sig(index),
        e180      => e180Sig(index)
      );
  end generate;
  
end behaviour;			   







