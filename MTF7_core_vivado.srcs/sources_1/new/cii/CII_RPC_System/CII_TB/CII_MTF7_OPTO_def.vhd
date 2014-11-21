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

package CII_MTF7_OPTO_def is

  type TMTF7_OPTO is record
    CREATOR                          :TS(4 downto 1);
    NAME                             :TS(8 downto 1);
    VERSION                          :THV(3 downto 0);
    CHECK_SUM                        :TN;
    COMP_ID                          :TN;
  end record;

  constant MTF7_OPTO :TMTF7_OPTO := (
    "PERG",                          -- CREATOR
    "MTF7OPTO",                      -- NAME
    "0001",                          -- VERSION
    0,                               -- CHECK_SUM
    1                                -- COMP_ID
  );
end CII_MTF7_OPTO_def;
