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

package CII_SYS_def is

  type \_TCIISYS_1_\ is record
    CIISIG                           :TN; -- 0 
    CIIREG                           :TN; -- 1 
    LOWVAL                           :TN; -- 2 
    HIGHVAL                          :TN; -- 3 
    CIIVAL                           :TN; -- 4 
    EXTSIG                           :TN; -- 5 
    EXTREG                           :TN; -- 6 
    CIIEXTSIG                        :TN; -- 7 
    CIIEXTREG                        :TN; -- 8 
  end record;

  type \_TCIISYS_2_\ is record
    CIISIG                           :TN; -- 0 
    CIIREG                           :TN; -- 1 
    LOWVAL                           :TN; -- 2 
    HIGHVAL                          :TN; -- 3 
    CIIVAL                           :TN; -- 4 
  end record;

  type TCIISYS is record
    HEX_SIZE                         :TN;
    CHAR_SIZE                        :TN;
    INT_SIZE                         :TN;
    LIST_INTERF_CTRL                 :\_TCIISYS_1_\;
    LIST_INTERF_STAT                 :\_TCIISYS_2_\;
  end record;

  constant CIISYS :TCIISYS := (
    4,                               -- HEX_SIZE
    8,                               -- CHAR_SIZE
    32,                              -- INT_SIZE
    ( 0,                             -- LIST_INTERF_CTRL.CIISIG
      1,                             -- LIST_INTERF_CTRL.CIIREG
      2,                             -- LIST_INTERF_CTRL.LOWVAL
      3,                             -- LIST_INTERF_CTRL.HIGHVAL
      4,                             -- LIST_INTERF_CTRL.CIIVAL
      5,                             -- LIST_INTERF_CTRL.EXTSIG
      6,                             -- LIST_INTERF_CTRL.EXTREG
      7,                             -- LIST_INTERF_CTRL.CIIEXTSIG
      8),                            -- LIST_INTERF_CTRL.CIIEXTREG
    ( 0,                             -- LIST_INTERF_STAT.CIISIG
      1,                             -- LIST_INTERF_STAT.CIIREG
      2,                             -- LIST_INTERF_STAT.LOWVAL
      3,                             -- LIST_INTERF_STAT.HIGHVAL
      4)                             -- LIST_INTERF_STAT.CIIVAL
  );

  type TCII_IDENTIFICATOR is record
    CONS_CREATOR_ELHEP               :TS(4 downto 1);
    IPAR_USER_REG_WIDTH              :TN;
    IPAR_IDENTYFIER                  :TN;
    SPAR_CREATOR                     :TN;
    SPAR_NAME                        :TN;
    HPAR_VERSION                     :TN;
    LPAR_IDENTYFIER_CII              :TN;
    LPAR_CREATOR_CII                 :TN;
    LPAR_NAME_CII                    :TN;
    LPAR_VERSION_CII                 :TN;
    IPAR_USER_REG_NUM                :TN;
    WORD_IDENTYFIER                  :TN;
    WORD_CREATOR                     :TN;
    WORD_NAME                        :TN;
    WORD_VERSION                     :TN;
    WORD_USER                        :TN;
  end record;

  constant CII_IDENTIFICATOR :TCII_IDENTIFICATOR := (
    "ELWA",                          -- CONS_CREATOR_ELHEP
    0,                               -- IPAR_USER_REG_WIDTH
    1,                               -- IPAR_IDENTYFIER
    2,                               -- SPAR_CREATOR
    3,                               -- SPAR_NAME
    4,                               -- HPAR_VERSION
    5,                               -- LPAR_IDENTYFIER_CII
    6,                               -- LPAR_CREATOR_CII
    7,                               -- LPAR_NAME_CII
    8,                               -- LPAR_VERSION_CII
    9,                               -- IPAR_USER_REG_NUM
    10,                              -- WORD_IDENTYFIER
    11,                              -- WORD_CREATOR
    12,                              -- WORD_NAME
    13,                              -- WORD_VERSION
    14                               -- WORD_USER
  );
end CII_SYS_def;
