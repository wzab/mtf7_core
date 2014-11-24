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
use work.CII_OTF_def.all;

package CII_OTF_prv is

  type TOTF_prv is record
    OTF_DUMMY0                       :TN;
    OTF_DUMMY1                       :TN;
  end record;

  constant OTF_prv :TOTF_prv := (
    0,                               -- dummy item
    0                                -- dummy item
  );
end CII_OTF_prv;
