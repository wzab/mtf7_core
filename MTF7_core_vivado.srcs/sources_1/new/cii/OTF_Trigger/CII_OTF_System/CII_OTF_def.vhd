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

package CII_OTF_def is

  type TOTF is record
    LHC_CLK_FREQ                     :TN;
    TTC_BCN_EVT_WIDTH                :TN;
    TTC_BCN_WIDTH                    :TN;
    TTC_EVN_WIDTH                    :TN;
    TTC_BROADCAST1_WIDTH             :TN;
    TTC_BROADCAST2_WIDTH             :TN;
    TTC_BROADCAST_SIZE               :TN;
    TTC_DOUT_ID_WIDTH                :TN;
    TTC_SUBADDR_WIDTH                :TN;
    TTC_DQ_WIDTH                     :TN;
    TTC_ID_MODE_WIDTH                :TN;
    RPC_FEBSTD_DATA_WIDTH            :TN;
    RPC_FEBSTD_TEST_WIDTH            :TN;
    RPC_LB_DATA_PART_WIDTH           :TN;
    RPC_LB_TIME_MAX                  :TN;
    RPC_LB_CHAMBER_MAX               :TN;
    RPC_LB_CHAMBER_NUM               :TN;
    RPC_LB_FAST_DATA_WIDTH           :TN;
    RPC_LB_TEST_PART_WIDTH           :TN;
    GOL_DATA_SIZE                    :TN;
    RPC_LB_TEST_PART_NUM             :TN;
    RPC_LBSTD_DATA_POS_MAX           :TN;
    RPC_LBSTD_DATA_POS_WIDTH         :TN;
    RPC_LBSTD_TIME_WIDTH             :TN;
    RPC_LBSTD_CHAMBER_WIDTH          :TN;
    RPC_LBSTD_CODE_WIDTH             :TN;
    RPC_LBSTD_LMUX_WIDTH             :TN;
    RPC_LBSTD_BCN_WIDTH              :TN;
  end record;

  constant OTF :TOTF := (
    40000000,                        -- LHC_CLK_FREQ
    12,                              -- TTC_BCN_EVT_WIDTH
    12,                              -- TTC_BCN_WIDTH
    24,                              -- TTC_EVN_WIDTH
    4,                               -- TTC_BROADCAST1_WIDTH
    2,                               -- TTC_BROADCAST2_WIDTH
    6,                               -- TTC_BROADCAST_SIZE
    8,                               -- TTC_DOUT_ID_WIDTH
    8,                               -- TTC_SUBADDR_WIDTH
    4,                               -- TTC_DQ_WIDTH
    16,                              -- TTC_ID_MODE_WIDTH
    96,                              -- RPC_FEBSTD_DATA_WIDTH
    24,                              -- RPC_FEBSTD_TEST_WIDTH
    8,                               -- RPC_LB_DATA_PART_WIDTH
    7,                               -- RPC_LB_TIME_MAX
    2,                               -- RPC_LB_CHAMBER_MAX
    3,                               -- RPC_LB_CHAMBER_NUM
    5,                               -- RPC_LB_FAST_DATA_WIDTH
    8,                               -- RPC_LB_TEST_PART_WIDTH
    32,                              -- GOL_DATA_SIZE
    4,                               -- RPC_LB_TEST_PART_NUM
    11,                              -- RPC_LBSTD_DATA_POS_MAX
    4,                               -- RPC_LBSTD_DATA_POS_WIDTH
    3,                               -- RPC_LBSTD_TIME_WIDTH
    2,                               -- RPC_LBSTD_CHAMBER_WIDTH
    17,                              -- RPC_LBSTD_CODE_WIDTH
    19,                              -- RPC_LBSTD_LMUX_WIDTH
    7                                -- RPC_LBSTD_BCN_WIDTH
  );
end CII_OTF_def;
