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
    CREATOR                          :TS(8 downto 1);
    NAME                             :TS(8 downto 1);
    VERSION                          :THV(3 downto 0);
    RECEIVER_ERROR_COUNT_SIZE        :TN;
    CLOCK_TEST_SIZE                  :TN;
    TB_OPTO_DELAY_SIZE               :TN;
    CHECK_SUM                        :TN;
    BITS_TEST_CNT_CLK40              :TN;
    BITS_TEST_CNT_BCN0               :TN;
    WORD_REC_CHECK_ENA               :TN;
    WORD_REC_CHECK_DATA_ENA          :TN;
    WORD_REC_TEST_ENA                :TN;
    WORD_REC_TEST_RND_ENA            :TN;
    WORD_REC_TEST_DATA               :TN;
    WORD_REC_TEST_OR_DATA            :TN;
    WORD_REC_ERROR_COUNT             :TN;
    WORD_BCN0_DELAY                  :TN;
    COMP_ID                          :TN;
  end record;

  constant MTF7_OPTO :TMTF7_OPTO := (
    "ELHEPWUT",                      -- CREATOR
    "MTF7OPTO",                      -- NAME
    "0001",                          -- VERSION
    16,                              -- RECEIVER_ERROR_COUNT_SIZE
    4,                               -- CLOCK_TEST_SIZE
    8,                               -- TB_OPTO_DELAY_SIZE
    0,                               -- CHECK_SUM
    1,                               -- BITS_TEST_CNT_CLK40
    2,                               -- BITS_TEST_CNT_BCN0
    3,                               -- WORD_REC_CHECK_ENA
    4,                               -- WORD_REC_CHECK_DATA_ENA
    5,                               -- WORD_REC_TEST_ENA
    6,                               -- WORD_REC_TEST_RND_ENA
    7,                               -- WORD_REC_TEST_DATA
    8,                               -- WORD_REC_TEST_OR_DATA
    9,                               -- WORD_REC_ERROR_COUNT
    10,                              -- WORD_BCN0_DELAY
    11                               -- COMP_ID
  );
end CII_MTF7_OPTO_def;
