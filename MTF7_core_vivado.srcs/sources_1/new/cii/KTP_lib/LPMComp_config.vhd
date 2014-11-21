-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2008 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

package LPMComp_Config is

  constant LPMComp_MEMORY_CLOCK_STROBE_ENA		:TL  := FALSE;
  constant LPMComp_MEMORY_RAM_TYPE_ENA			:T3L := FALSE;

end LPMComp_Config;

