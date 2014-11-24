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

package CII_MTF7_def is

  type TMTF7 is record
    II_ADDR_WIDTH                    :TN;
    II_DATA_WIDTH                    :TN;
    RPC_LINK_NUM                     :TN;
    RPC_LINK_DATA                    :TN;
  end record;

  constant MTF7 :TMTF7 := (
    16,                              -- II_ADDR_WIDTH
    32,                              -- II_DATA_WIDTH
    1,                               -- RPC_LINK_NUM
    32                               -- RPC_LINK_DATA
  );
end CII_MTF7_def;
