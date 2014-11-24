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
use work.CII_MTF7_def.all;

package CII_MTF7_prv is

  type TMTF7_prv is record
    MTF7_DUMMY0                      :TN;
    MTF7_DUMMY1                      :TN;
  end record;

  constant MTF7_prv :TMTF7_prv := (
    0,                               -- dummy item
    0                                -- dummy item
  );
end CII_MTF7_prv;
