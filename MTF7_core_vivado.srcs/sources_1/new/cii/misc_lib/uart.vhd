-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2011 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

package uart_interface is

  constant UART_BITS_NUM                :TN := 8;
  component UART_client is
    generic (
      CLOCK_KHz	                        :in    TN := 62500;
      MIN_BAUD_Hz                       :in    TN := 9600;
      SYNCH_COUNT                       :in    TN := 16;
      SEND_BOUD_DELAY                   :in    TN := 5
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      CTS                               :in    TSL;
      RTS                               :out   TSL;
      RX                                :in    TSL;
      TX                                :out   TSL;
      --
      RXdata                            :out   TSLV(UART_BITS_NUM-1 downto 0);
      RXrec                             :out   TSL;
      TXdata                            :in    TSLV(UART_BITS_NUM-1 downto 0);
      TXsend                            :in    TSL;
      TXempty                           :out   TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL;
      active                            :in    TSL
    );
  end component;

  constant UART_REQ_NUM                 :TN :=  4;
  constant UART_SVEC_NUM_MIN            :TN :=  1;
  constant UART_SVEC_NUM_MAX            :TN := 14;
  constant UART_EVEC_NUM_MIN            :TN :=  1;
  constant UART_EVEC_NUM_MAX            :TN := 12;
  constant UART_VEC_NUM_SIZE            :TN := TVLcreate(UART_SVEC_NUM_MAX);
  constant UART_VEC_DATA_SIZE           :TN := UART_SVEC_NUM_MAX*UART_BITS_NUM;
  constant UART_SHORT_NUM_BYTES         :TN := 1;
  constant UART_SHORT_NUM_SIZE          :TN := UART_SHORT_NUM_BYTES*UART_BITS_NUM;
  constant UART_SHORT_NUM_MIN           :TN := 0;
  constant UART_SHORT_NUM_MAX           :TN := (2**UART_SHORT_NUM_SIZE)-1;
  constant UART_LONG_NUM_BYTES          :TN := 2;
  constant UART_LONG_NUM_SIZE           :TN := UART_LONG_NUM_BYTES*UART_BITS_NUM;
  constant UART_LONG_NUM_MIN            :TN := 0;
  constant UART_LONG_NUM_MAX            :TN := (2**UART_LONG_NUM_SIZE)-1;

  component UART_prot_client is
    generic (
      CLOCK_KHz                         :in    TN := 62500;
      MIN_BAUD_Hz                       :in    TN := 9600;
      SYNCH_COUNT                       :in    TN := 16;
      SEND_BOUD_DELAY                   :in    TN := 5
    );                    
    port(                 
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      CTS_p                             :in    TSL;
      RTS_p                             :out   TSL;
      RX_p                              :in    TSL;
      TX_P                              :out   TSL;
      --
      CTS_c                             :out   TSL;
      RTS_c		                :in    TSL;
      RX_c                              :out   TSL;
      TX_c                              :in    TSL;
      --
      chain_id                          :in    TSLV(UART_BITS_NUM-1 downto 0);
      chain_first                       :in    TSL;
      chain_last                        :in    TSL;
      --
      int_rx_req                        :out   TSLV(UART_REQ_NUM-1 downto 0);
      int_rx_ack                        :in    TSLV(UART_REQ_NUM-1 downto 0)                   := (others => '0');
      --                                
      int_tx_req                        :in    TSLV(UART_REQ_NUM-1 downto 0)                   := (others => '0');
      int_tx_ack                        :out   TSLV(UART_REQ_NUM-1 downto 0);
      --
      vec_rx_data                       :out   TSLV(UART_VEC_DATA_SIZE-1 downto 0);
      vec_rx_num                        :out   TSLV(UART_VEC_NUM_SIZE-1 downto 0);
      vec_rx_valid                      :out   TSL;
      vec_rx_ack                        :in    TSL                                              := '0';
      --                                
      vec_tx_req                        :in    TSL                                              := '0';
      vec_tx_ext_ena                    :in    TSL                                              := '0';
      vec_tx_empty                      :out   TSL;
      vec_tx_data                       :in    TSLV(UART_VEC_DATA_SIZE-1 downto 0)              := (others => '0');
      vec_tx_num                        :in    TSLV(UART_VEC_NUM_SIZE-1 downto 0)               := (others => '0');
      --                                
      mem_rx_run                        :out   TSL;
      mem_rx_data                       :out   TSLV(UART_BITS_NUM-1 downto 0);
      mem_rx_valid                      :out   TSL;
      mem_rx_ack                        :in    TSL                                              := '0';
      --                                
      mem_tx_req                        :in    TSL                                              := '0';
      mem_tx_part_ena                   :in    TSL                                              := '0';
      mem_tx_long_ena                   :in    TSL                                              := '0';
      mem_tx_part                       :in    TSLV(UART_LONG_NUM_SIZE-1 downto 0)              := (others => '0');
      mem_tx_num                        :in    TSLV(UART_LONG_NUM_SIZE-1 downto 0)              := (others => '0');
      mem_tx_data                       :in    TSLV(UART_BITS_NUM-1 downto 0)                   := (others => '0');
      mem_tx_get                        :out   TSL                                              := '0';
      mem_tx_valid                      :in    TSL                                              := '0';
      mem_tx_empty                      :out   TSL;
      --                                
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  component UART_II is
    generic (
      CLOCK_kHz	                        :in    TN := 62500;
      MIN_BAUD_Hz                       :in    TN := 9600;
      SYNCH_COUNT                       :in    TN := 16;
      SEND_BOUD_DELAY                   :in    TN := 5;
      II_ADDR_WIDTH                     :in    TN := 16;
      II_DATA_WIDTH                     :in    TN := 32;
      BUS_OPER_WAIT_ns                  :in    TN := 10;
      OPER_STROBE_WAIT_ns               :in    TN := 25;
      STROBE_WAIT_ns                    :in    TN := 100;
      STROBE_OPER_WAIT_ns               :in    TN := 25;
      OPER_BUS_WAIT_ns                  :in    TN := 10
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      -- UART parent
      CTS_p                             :in    TSL;
      RTS_p                             :out   TSL;
      RX_p                              :in    TSL;
      TX_P                              :out   TSL;
      -- UART child 
      CTS_c                             :out   TSL;
      RTS_c		                :in    TSL;
      RX_c                              :out   TSL;
      TX_c                              :in    TSL;
      --
      chain_id                          :in    TSLV(UART_BITS_NUM-1 downto 0);
      chain_first                       :in    TSL;
      chain_last                        :in    TSL;
      -- internal interface bus
      II_resetN                         :out   TSL;
      II_operN                          :out   TSL;
      II_writeN                         :out   TSL;
      II_strobeN                        :out   TSL;
      II_addr                           :out   TSLV(II_ADDR_WIDTH-1 downto 0);
      II_out_data                       :out   TSLV(II_DATA_WIDTH-1 downto 0);
      II_in_data                        :in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0');
      --
      initN                             :in    TSL := '1';
      ready                             :out   TSL
    );
  end component;

  component UART_II5A8D is
    generic (
      CLOCK_kHz	                        :in    TN := 62500;
      MIN_BAUD_Hz                       :in    TN := 9600;
      SYNCH_COUNT                       :in    TN := 16;
      SEND_BOUD_DELAY                   :in    TN := 5;
      BUS_OPER_WAIT_ns                  :in    TN := 10;
      OPER_STROBE_WAIT_ns               :in    TN := 25;
      STROBE_WAIT_ns                    :in    TN := 100;
      STROBE_OPER_WAIT_ns               :in    TN := 25;
      OPER_BUS_WAIT_ns                  :in    TN := 10
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      -- UART
      CTS                               :in    TSL;
      RTS                               :out   TSL;
      RX                                :in    TSL;
      TX                                :out   TSL;
      -- internal interface bus
      II_resetN                         :out   TSL;
      II_operN                          :out   TSL;
      II_writeN                         :out   TSL;
      II_strobeN                        :out   TSL;
      II_addr                           :out   TSLV(4 downto 0);
      II_out_data                       :out   TSLV(7 downto 0);
      II_in_data                        :in    TSLV(7 downto 0) := (others =>'0');
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  constant UART_INODE_CHECK_SUM_SIZE :TN := 4;
  function UART_INODE_chksum(a, d :TSLV) return TSLV;

  component UART_iclient is
    generic (
      CLOCK_KHz	                        :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      DATA_SIZE                         :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSL := '1';
      TX                                :out   TSL;
      --
      RXdata                            :out   TSLV(DATA_SIZE-1 downto 0);
      RXlen                             :in    TSLV(TVLcreate(DATA_SIZE-1)-1 downto 0) := (others =>'1');
      RXrec                             :out   TSL;
      TXdata                            :in    TSLV(DATA_SIZE-1 downto 0) := (others =>'0');
      TXlen                             :in    TSLV(TVLcreate(DATA_SIZE-1)-1 downto 0) := (others =>'1');
      TXsend                            :in    TSL := '0';
      TXempty                           :out   TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  component UART_inode is
    generic (
      CLOCK_KHz	                        :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      ADDR_SIZE                         :in    TN := 0;
      DATA_SIZE                         :in    TN := 0;
      BUF_SIZE                          :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSL;
      TX                                :out   TSL;
      --
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0) := (others=>'0');
      addr                              :out   TSLV(ADDR_SIZE-1 downto 0);
      data_next                         :out   TSL;
      data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
      data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
      write                             :out   TSL;
      read                              :out   TSL;
      ack                               :in    TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  component UART_mult_inode is
    generic (
      MULT_NUM	                        :in    TN := 0;
      CLOCK_KHz	                        :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      ADDR_SIZE                         :in    TN := 0;
      DATA_SIZE                         :in    TN := 0;
      BUF_SIZE                          :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSLV(MULT_NUM-1 downto 0);
      TX                                :out   TSLV(MULT_NUM-1 downto 0);
      --
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0) := (others=>'0');
      addr                              :out   TSLV(ADDR_SIZE-1 downto 0);
      data_next                         :out   TSL;
      data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
      data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
      write                             :out   TSL;
      read                              :out   TSL;
      ack                               :in    TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  component UART_imaster is
    generic (
      CLOCK_KHz	                        :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      ADDR_SIZE                         :in    TN := 0;
      BUF_SIZE                          :in    TN := 0;
      DATA_SIZE                         :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0;
      INPUT_REGISTERED                  :in    TL := FALSE
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSL;
      TX                                :out   TSL;
      --
      enable                            :in    TSL;
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0) := (others=>'0');
      addr                              :in    TSLV(ADDR_SIZE-1 downto 0);
      buf                               :in    TSLV(maximum(BUF_SIZE,1)-1 downto 0) := (others=>'0');
      data_next                         :out   TSL;
      data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
      data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
      write                             :in    TSL;
      read                              :in    TSL;
      ack                               :out   TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

  component UART_mult_imaster is
    generic (
      MULT_NUM	                        :in    TN := 0;
      CLOCK_KHz	                        :in    TN := 0;
      BAUD_kHz                          :in    TN := 0;
      ID_SIZE                           :in    TN := 0;
      ADDR_SIZE                         :in    TN := 0;
      BUF_SIZE                          :in    TN := 0;
      DATA_SIZE                         :in    TN := 0;
      SEND_BOUD_DELAY                   :in    TN := 0;
      INPUT_REGISTERED                  :in    TL := FALSE
    );
    port(
      resetN                            :in    TSL;
      clk                               :in    TSL;
      --
      RX                                :in    TSLV(MULT_NUM-1 downto 0);
      TX                                :out   TSLV(MULT_NUM-1 downto 0);
      --
      enable                            :in    TSL;
      id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0) := (others=>'0');
      addr                              :in    TSLV(ADDR_SIZE-1 downto 0);
      buf                               :in    TSLV(maximum(BUF_SIZE,1)-1 downto 0) := (others=>'0');
      data_next                         :out   TSL;
      data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
      data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
      write                             :in    TSL;
      read                              :in    TSL;
      ack                               :out   TSL;
      --
      initN                             :in    TSL;
      ready                             :out   TSL
    );
  end component;

end package;
  
package body uart_interface is

  function UART_INODE_chksum(a, d :TSLV) return TSLV is
    constant AN :TN := SLVPartNum(a'length,UART_INODE_CHECK_SUM_SIZE);
    constant DN :TN := SLVPartNum(d'length,UART_INODE_CHECK_SUM_SIZE);
    variable av :TSLV(AN*UART_INODE_CHECK_SUM_SIZE-1 downto 0);
    variable dv :TSLV(DN*UART_INODE_CHECK_SUM_SIZE-1 downto 0);
    variable rv :TSLV(UART_INODE_CHECK_SUM_SIZE-1 downto 0);
  begin
    av := (others => '0'); av(a'length-1 downto 0) := a;
    dv := (others => '0'); dv(d'length-1 downto 0) := d;
    rv := (others =>'0');
    for index in 0 to AN-1 loop
      rv := (rv xor SLVPartGet(av,UART_INODE_CHECK_SUM_SIZE,index)) + rv;
    end loop;
    for index in 0 to DN-1 loop
      rv := (rv xor SLVPartGet(dv,UART_INODE_CHECK_SUM_SIZE,index)) + rv;
    end loop;
    return(rv);
  end function;

end package body;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.std_logic_1164_ktp.all;
use work.uart_interface.all;

entity UART_client is
  generic (
    CLOCK_KHz		:in    TN := 62500;
    MIN_BAUD_Hz         :in    TN := 9600;
    SYNCH_COUNT		:in    TN := 16;
    SEND_BOUD_DELAY	:in    TN := 5
  );
  port(
    resetN              :in    TSL;
    clk                 :in    TSL;
    --
    CTS                 :in    TSL;
    RTS                 :out   TSL;
    RX                  :in    TSL;
    TX                  :out   TSL;
    --
    RXdata              :out   TSLV(UART_BITS_NUM-1 downto 0);
    RXrec               :out   TSL;
    TXdata              :in    TSLV(UART_BITS_NUM-1 downto 0);
    TXsend              :in    TSL;
    TXempty             :out   TSL;
    --
    initN               :in    TSL;
    ready               :out   TSL;
    active              :in    TSL
  );
end UART_client;

architecture behaviour of UART_client is

  constant SYNCH_CNT_EST        :TN := ((CLOCK_KHz*SYNCH_COUNT*UART_BITS_NUM)/MIN_BAUD_Hz)*1000;
  constant SYNCH_CNT_LEN        :TN := TVLcreate((SYNCH_CNT_EST*105)/100);
  --
  signal   ReadyReg             :TSL;
  --
  signal   CTSreg               :TSL;
  signal   RXregD2              :TSL;
  signal   RXregD1              :TSL;
  signal   RXreg                :TSL;
  signal   StartReg             :TSL;
  --
  type     TUARTsynch           is (UART_IDLE, UART_INIT, UART_SYNCH);
  signal   UARTsynch            :TUARTsynch;
  signal   SynchCnt             :TSLV(SYNCH_CNT_LEN-1 downto 0);
  signal   SynchDataCnt         :TSLV(TVLcreate(SYNCH_COUNT)-1 downto 0);
  signal   BitLenCnt            :TSLV(SYNCH_CNT_LEN-1 downto 0);
  signal   RTSreg               :TSL;
  --
  type     TUARTrx              is (UART_RX_IDLE, UART_RX_REC, UART_RX_DATA, UART_RX_ERROR);
  signal   UARTrx               :TUARTrx;
  signal   RXfifo               :TSLV(UART_BITS_NUM-1 downto 0);
  signal   RXvalid              :TSL;
  signal   RXstart              :TSL;
  signal   RXbitLenCnt          :TSLV(SYNCH_CNT_LEN-1 downto 0);
  signal   RXbitNumCnt          :TSLV(TVLcreate(2+UART_BITS_NUM-1)-1 downto 0);
  --
  type     TUARTtx              is (UART_TX_IDLE, UART_TX_SEND, UART_TX_STOP, UART_TX_WAIT, UART_TX_INACT);
  signal   UARTtx               :TUARTtx;
  signal   TXreg                :TSL;
  signal   TXfifo               :TSLV(UART_BITS_NUM-1 downto 0);
  signal   TXbusy               :TSL;
  signal   TXbitLenCnt          :TSLV(SYNCH_CNT_LEN-1 downto 0);
  signal   TXbitNumCnt          :TSLV(TVLcreate(2+UART_BITS_NUM-1)-1 downto 0);
  signal   TXDelayCnt           :TSLV(TVLcreate(SEND_BOUD_DELAY)-1 downto 0);

begin

  reg_in: process (resetN, clk)
  begin
    if resetN = '0' then
      CTSreg   <= '0';
      RXregD2  <= '0';
      RXregD1  <= '0';
      RXreg    <= '0';
      StartReg <= '0';
    elsif clk'event and clk = '1' then
      CTSreg   <= CTS;
      RXregD2  <= TSLconv(RX/='0');
      RXregD1  <= RXregD2;
      RXreg    <= RXregD1;
      StartReg <= not(RXregD2) and RXregD1;
    end if;
  end process;

  uart_synchro: process (resetN, clk)
  begin
    if resetN = '0' then
      SynchCnt     <= (others =>'0');
      SynchDataCnt <= (others =>'0');
      RTSreg       <= '0';
      BitLenCnt    <= (others =>'0');
      ReadyReg     <= '0';
      UARTsynch    <= UART_IDLE;
    elsif clk'event and clk = '1' then
      if (CTSreg='0' or InitN='0' or UARTrx=UART_RX_ERROR) then
        ReadyReg     <= '0';
        RTSreg       <= '0';
        UARTsynch    <= UART_IDLE;
      else
        case UARTsynch is
          when UART_IDLE =>
            SynchCnt     <= (others =>'0');
            SynchDataCnt <= TSLVconv(SYNCH_COUNT,SynchDataCnt'length);
            BitLenCnt    <= (others =>'0');
            ReadyReg     <= '0';
            RTSreg       <= '0';
            UARTsynch    <= UART_INIT;
          when UART_INIT =>
            if (StartReg='1') then
              SynchDataCnt <= SynchDataCnt - 1;
            end if;
            if (SynchDataCnt=0 and RXreg='1') then
              BitLenCnt <= TSLVconv(TNconv(SynchCnt) / (UART_BITS_NUM*SYNCH_COUNT), BitLenCnt'length);
              UARTsynch <= UART_SYNCH;
            elsif (RXreg='0') then
              SynchCnt <= SynchCnt+1;
            end if;
          when UART_SYNCH =>
            UARTsynch <= UART_SYNCH;
            ReadyReg  <= '1';
            RTSreg    <= '1';
          when others =>
            UARTsynch <= UART_IDLE;
        end case;
      end if;
    end if;
  end process;
  --
  RTS   <= RTSreg and TSLconv(UARTtx /= UART_TX_INACT);
  Ready <= ReadyReg;


  uart_rx: process (resetN, clk)
  begin
    if resetN = '0' then
      RXfifo      <= (others =>'0');
      RXvalid     <='0';
      RXstart     <= '0';
      RXbitLenCnt <= (others =>'0');
      RXbitNumCnt <= (others =>'0');
      UARTrx      <= UART_RX_IDLE;
    elsif clk'event and clk = '1' then
      if (RTSreg='0') then
        UARTrx <= UART_RX_IDLE;
      else
        case UARTrx is
          when UART_RX_IDLE =>
            RXfifo      <= (others =>'0');
            RXvalid     <= '0';
            RXbitLenCnt <= BitLenCnt;
            RXbitNumCnt <= TSLVconv(1+UART_BITS_NUM,RXbitNumCnt'length);
            if (StartReg='1') then
              UARTrx <= UART_RX_REC;
            end if;
          when UART_RX_REC =>
            if (RXbitLenCnt/=0) then
              RXbitLenCnt <= RXbitLenCnt-1;
              if (RXbitLenCnt=(TNconv(BitLenCnt)/2)) then
                if (RXbitNumCnt/=0) then
                  RXfifo(RXfifo'length-2 downto 0) <= RXfifo(RXfifo'length-1 downto 1);
                  RXstart <= RXfifo(0);
                  RXfifo(RXfifo'length-1) <= RXreg;
                else
                  if (RXstart='0' and RXreg='1') then
                    UARTrx <= UART_RX_DATA;
                  else
                    UARTrx <= UART_RX_ERROR;
                  end if;
                end if;
              end if;
            else
              RXbitLenCnt <= BitLenCnt;
              RXbitNumCnt <= RXbitNumCnt-1;
            end if;
          when UART_RX_DATA =>
            RXvalid <= '1';
            UARTrx  <= UART_RX_IDLE;
          when UART_RX_ERROR =>
            UARTrx <= UART_RX_IDLE;
          when others =>
            UARTrx <= UART_RX_IDLE;
        end case;
      end if;
    end if;
  end process;
  
  RXdata <= RXfifo;
  RXrec  <= RXvalid;

  uart_tx: process (resetN, clk)
  begin
    if resetN = '0' then
      TXreg       <= '1';
      TXfifo      <= (others =>'0');
      TXbusy      <='0';
      TXbitLenCnt <= (others =>'0');
      TXbitNumCnt <= (others =>'0');
      TXDelayCnt  <= (others =>'0');
      UARTtx      <= UART_TX_IDLE;
    elsif clk'event and clk = '1' then
      if (RTSreg='0') then
        TXreg  <= RXreg;
        UARTtx <= UART_TX_IDLE;
      else
        case UARTtx is
          when UART_TX_IDLE =>
            TXreg       <= '1';
            TXfifo      <= (others =>'0');
            TXbitLenCnt <= BitLenCnt;
            TXbitNumCnt <= TSLVconv(1+UART_BITS_NUM,RXbitNumCnt'length);
            TXbusy      <= TXsend;
            if (TXsend='1') then
              TXfifo <= TXdata;
              UARTtx <= UART_TX_SEND;
              TXreg <= '0';
            end if;
          when UART_TX_SEND =>
            if (TXbitNumCnt/=0) then
              if (TXbitLenCnt/=0) then
                TXbitLenCnt <= TXbitLenCnt-1;
              else
                TXbitLenCnt <= BitLenCnt;
                TXbitNumCnt <= TXbitNumCnt-1;
                TXfifo(TXfifo'length-2 downto 0) <= TXfifo(TXfifo'length-1 downto 1);
                TXreg <= TXfifo(0);
              end if;
            else
              TXreg       <= '1';
              UARTtx      <= UART_TX_STOP;
            end if;
          when UART_TX_STOP =>
            if (TXbitLenCnt/=0) then
              TXbitLenCnt <= TXbitLenCnt-1;
            else
              TXbitLenCnt <= BitLenCnt;
              if (active='1') then
                TXDelayCnt  <= TSLVconv(SEND_BOUD_DELAY,TXDelayCnt'length);
                UARTtx      <= UART_TX_WAIT;
              else
                UARTtx <= UART_TX_INACT;
              end if;
            end if;
          when UART_TX_INACT =>
            if (TXbitLenCnt/=0) then
              TXbitLenCnt <= TXbitLenCnt-1;
            else
              UARTtx <= UART_TX_IDLE;
            end if;
          when UART_TX_WAIT =>
            if (TXDelayCnt/=0) then
              if (TXbitLenCnt/=0) then
                TXbitLenCnt <= TXbitLenCnt-1;
              else
                TXbitLenCnt <= BitLenCnt;
                TXDelayCnt  <= TXDelayCnt-1;
              end if;
            else
              UARTtx <= UART_TX_IDLE;
            end if;
          when others =>
            UARTtx <= UART_TX_IDLE;
        end case;
      end if;
    end if;
  end process;
  
  TX      <= TXreg and CTSreg;
  TXempty <= not(TXbusy);

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library unisim;
use unisim.vcomponents.all;
--
use work.std_logic_1164_ktp.all;
use work.uart_interface.all;

entity UART_prot_client is
  generic (
    CLOCK_kHz		:in    TN := 62500;
    MIN_BAUD_Hz         :in    TN := 9600;
    SYNCH_COUNT         :in    TN := 16;
    SEND_BOUD_DELAY	:in    TN := 5
  );
  port(
    resetN              :in    TSL;
    clk                 :in    TSL;
    --
    CTS_p               :in    TSL;
    RTS_p               :out   TSL;
    RX_p                :in    TSL;
    TX_P                :out   TSL;
    --
    CTS_c               :out   TSL;
    RTS_c               :in    TSL;
    RX_c                :out   TSL;
    TX_c                :in    TSL;
    --
    chain_id            :in    TSLV(UART_BITS_NUM-1 downto 0);
    chain_first         :in    TSL;
    chain_last          :in    TSL;
    --
    int_rx_req          :out   TSLV(UART_REQ_NUM-1 downto 0);
    int_rx_ack          :in    TSLV(UART_REQ_NUM-1 downto 0)                   := (others => '0');
    --
    int_tx_req          :in    TSLV(UART_REQ_NUM-1 downto 0)                   := (others => '0');
    int_tx_ack          :out   TSLV(UART_REQ_NUM-1 downto 0);
    --
    vec_rx_data         :out   TSLV(UART_VEC_DATA_SIZE-1 downto 0);
    vec_rx_num          :out   TSLV(UART_VEC_NUM_SIZE-1 downto 0);
    vec_rx_valid        :out   TSL;
    vec_rx_ack          :in    TSL                                              := '0';
    --
    vec_tx_req          :in    TSL                                              := '0';
    vec_tx_ext_ena      :in    TSL                                              := '0';
    vec_tx_empty        :out   TSL;
    vec_tx_data         :in    TSLV(UART_VEC_DATA_SIZE-1 downto 0)              := (others => '0');
    vec_tx_num          :in    TSLV(UART_VEC_NUM_SIZE-1 downto 0)               := (others => '0');
    --
    mem_rx_run          :out   TSL;
    mem_rx_data         :out   TSLV(UART_BITS_NUM-1 downto 0);
    mem_rx_valid        :out   TSL;
    mem_rx_ack          :in    TSL                                              := '0';
    --
    mem_tx_req          :in    TSL                                              := '0';
    mem_tx_part_ena     :in    TSL                                              := '0';
    mem_tx_long_ena     :in    TSL                                              := '0';
    mem_tx_part         :in    TSLV(UART_LONG_NUM_SIZE-1 downto 0)              := (others => '0');
    mem_tx_num          :in    TSLV(UART_LONG_NUM_SIZE-1 downto 0)              := (others => '0');
    mem_tx_data         :in    TSLV(UART_BITS_NUM-1 downto 0)                   := (others => '0');
    mem_tx_get          :out   TSL                                              := '0';
    mem_tx_valid        :in    TSL                                              := '0';
    mem_tx_empty        :out   TSL;
    --
    initN               :in    TSL;
    ready               :out   TSL
  );
end UART_prot_client;

architecture behaviour of UART_prot_client is

  --
  --
  constant HEAD_LEN             :TN := 4;
  constant HEAD_STATUS          :TSLV := "0000";
  constant HEAD_EXTEND          :TSLV := "1111";
  --
  function HeadGet(header :TSLV) return TSLV is
  begin
    return (header(HEAD_LEN-1 downto 0));
  end function;
  --
  constant HEXT_LEN :TN         := 4;
  constant HEXT_STATUS_NULL     :TSLV := "0000";
  constant HEXT_STATUS_SEND     :TSLV := "0001";
  constant HEXT_STATUS_REQ0     :TSLV := "0010";
  constant HEXT_STATUS_REQ1     :TSLV := "0011";
  constant HEXT_STATUS_REQ2     :TSLV := "0100";
  constant HEXT_STATUS_REQ3     :TSLV := "0101";
  constant HEXT_STATUS_RESET    :TSLV := "1101";
  constant HEXT_STATUS_ACT      :TSLV := "1110";
  constant HEXT_STATUS_INACT    :TSLV := "1111";
  constant HEXT_EXTEND_L1VEC    :TSLV := "1100";
  constant HEXT_EXTEND_L2VEC    :TSLV := "1101";
  constant HEXT_EXTEND_P1VEC    :TSLV := "1110";
  constant HEXT_EXTEND_P2VEC    :TSLV := "1111";
  --
  constant CTRL_STAT_ACK        :TSLV := "0110";
  constant CTRL_STAT_REJ        :TSLV := "1001";
  --
  function HExtGet(header :TSLV) return TSLV is
  begin
    return (header(HEXT_LEN+HEAD_LEN-1 downto HEAD_LEN));
  end function;
  --
  constant CLIENT_ACK           :TSLV(UART_BITS_NUM-1 downto 0) := TSLVconv(033,UART_BITS_NUM);  
  constant CLIENT_REQ           :TSLV(UART_BITS_NUM-1 downto 0) := TSLVconv(077,UART_BITS_NUM);  
  --
  signal   RXdata               :TSLV(UART_BITS_NUM-1 downto 0);
  signal   RXrec                :TSL;
  signal   TXdata               :TSLV(UART_BITS_NUM-1 downto 0);
  signal   TXsend               :TSL;
  signal   TXempty              :TSL;
  signal   ReadyReg             :TSL;
  signal   UARTinitNsig         :TSL;
  signal   RXHeadReg            :TSLV(UART_BITS_NUM-1 downto 0);
  signal   UARTreadySig         :TSL;
  signal   UARTactiveReg        :TSL;
  --
  type     TPROTOCOL            is (PROT_IDLE, PROT_TEST, PROT_TEST_END,
                                    PROT_HEADER,
                                      PROT_STAT_NULL,
                                      PROT_STAT_SEND,
                                      PROT_STAT_REC_REQ0,
                                      PROT_STAT_SEND_REQ0, PROT_STAT_SEND_ACK0,
                                      PROT_STAT_REC_REQ1,
                                      PROT_STAT_SEND_REQ1, PROT_STAT_SEND_ACK1,
                                      PROT_STAT_REC_REQ2,
                                      PROT_STAT_SEND_REQ2, PROT_STAT_SEND_ACK2,
                                      PROT_STAT_REC_REQ3,
                                      PROT_STAT_SEND_REQ3, PROT_STAT_SEND_ACK3,
                                      PROT_STAT_ACT_ID, PROT_STAT_ACT_CHK, PROT_STAT_ACT_ACK,
                                      PROT_STAT_INACT_ID, PROT_STAT_INACT_CHK, PROT_STAT_INACT_ACK,
                                      PROT_SVEC_REC, PROT_SVEC_REC_DATA, PROT_SVEC_REC_CHK, PROT_SVEC_REC_ACK,
                                      PROT_SVEC_SEND, PROT_SVEC_SEND_HEAD, PROT_SVEC_SEND_DATA, PROT_SVEC_SEND_ACK,
                                      PROT_EVEC_REC, PROT_EVEC_REC_DATA, PROT_EVEC_REC_CHK, PROT_EVEC_REC_ACK,
                                      PROT_EVEC_SEND, PROT_EVEC_SEND_HEAD, PROT_EVEC_SEND_DATA, PROT_EVEC_SEND_CHK, PROT_EVEC_SEND_ACK,
                                      PROT_L1VEC_REC_NUM, PROT_L1VEC_REC_DATA, PROT_L1VEC_REC_CHK, PROT_L1VEC_REC_ACK,
                                      PROT_L1VEC_SEND_HEAD, PROT_L1VEC_SEND_NUM, PROT_L1VEC_SEND_DATA, PROT_L1VEC_SEND_CHK, PROT_L1VEC_SEND_ACK,
                                      PROT_L2VEC_REC_NUM0, PROT_L2VEC_REC_NUM1, PROT_L2VEC_REC_DATA, PROT_L2VEC_REC_CHK0,
                                                           PROT_L2VEC_REC_CHK1, PROT_L2VEC_REC_ACK,
                                      PROT_L2VEC_SEND_HEAD, PROT_L2VEC_SEND_NUM0, PROT_L2VEC_SEND_NUM1, PROT_L2VEC_SEND_DATA,
                                                            PROT_L2VEC_SEND_CHK0, PROT_L2VEC_SEND_CHK1, PROT_L2VEC_SEND_ACK,
                                      PROT_P1VEC_REC_PART, PROT_P1VEC_REC_NUM, PROT_P1VEC_REC_DATA, PROT_P1VEC_REC_CHK, PROT_P1VEC_REC_ACK,
                                      PROT_P1VEC_SEND_HEAD, PROT_P1VEC_SEND_PART, PROT_P1VEC_SEND_NUM, PROT_P1VEC_SEND_DATA,
                                                            PROT_P1VEC_SEND_CHK, PROT_P1VEC_SEND_ACK,
                                      PROT_P2VEC_REC_PART0, PROT_P2VEC_REC_PART1, PROT_P2VEC_REC_NUM0, PROT_P2VEC_REC_NUM1,
                                                            PROT_P2VEC_REC_DATA, PROT_P2VEC_REC_CHK0,PROT_P2VEC_REC_CHK1, PROT_P2VEC_REC_ACK,
                                      PROT_P2VEC_SEND_HEAD, PROT_P2VEC_SEND_PART0, PROT_P2VEC_SEND_PART1, PROT_P2VEC_SEND_NUM0,
                                                            PROT_P2VEC_SEND_NUM1, PROT_P2VEC_SEND_DATA, PROT_P2VEC_SEND_CHK0,
                                                            PROT_P2VEC_SEND_CHK1, PROT_P2VEC_SEND_ACK,
                                    PROT_ERROR
                                );
  signal   PROTstate            :TPROTOCOL;
  signal   PROTerror            :TSL;
  signal   IntRxReqReg          :TSLV(int_rx_req'range);
  signal   IntRxAckReg          :TSLV(int_rx_ack'range);
  signal   IntTxReqReg          :TSLV(int_tx_req'range);
  signal   IntTxAckReg          :TSLV(int_tx_ack'range);
  signal   IntTxRejReg          :TSLV(int_tx_ack'range);
  
  --
  signal   VecRxDataReg         :TSLV(vec_rx_data'range);
  signal   VecRxNumReg          :TSLV(vec_rx_num'range);
  signal   VecRxValidReg        :TSL;
  signal   VecRxAckReg          :TSL;
  signal   VecRxCnt             :TSLV(vec_rx_num'range);
  signal   VecRxChkReg          :TSLV(UART_BITS_NUM-1 downto 0);
  signal   VecTxBusyReg         :TSL;
  signal   VecTxDataReg         :TSLV(vec_tx_data'range);
  signal   VecTxNumReg          :TSLV(vec_tx_num'range);
  signal   VecTxCnt             :TSLV(vec_tx_num'range);
  signal   VecTxChkReg          :TSLV(UART_BITS_NUM-1 downto 0);
  --
  signal   MemRxRunReg          :TSL;
  signal   MemRxDataReg         :TSLV(mem_rx_data'range);
  signal   MemRxPartReg         :TSLV(mem_tx_part'range);
  signal   MemRxValidReg        :TSL;
  signal   MemRxAckReg          :TSL;
  signal   MemRxCnt             :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   MemRxChkReg          :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   MemTxBusyReg         :TSL;
  signal   MemTxGetReg          :TSL;
  signal   MemTxCnt             :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   MemTxChkReg          :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   TXreqSig             :TSL;
  --
  type     TCHAIN               is (CHAIN_CHILD_INIT, CHAIN_SELECT, CHAIN_ACTIVE, CHAIN_BRIDGE, CHAIN_ERROR);
  signal   CHAINstate           :TCHAIN;
  signal   CHAINerror           :TSL;
  signal   RTSparReg            :TSL;
  signal   RXparReg             :TSL;
  signal   TXparReg             :TSL;
  signal   RTSchlReg            :TSL;
  signal   RXchlReg             :TSL;
  signal   TXchlReg             :TSL;
  signal   RTSsig               :TSL;
  signal   RXreg                :TSL;
  signal   TXsig                :TSL;

begin

  TXreqSig <= OR_REDUCE(IntTxReqReg and not(IntTxRejReg)) or VecTxBusyReg or MemTxBusyReg;
  --
  uart_prot: process (resetN, clk)
  begin
    if resetN = '0' then
      RXHeadReg     <= (others=>'0');
      TXdata        <= (others=>'0');
      TXsend        <= '0';
      UARTactiveReg <= '0';
      ReadyReg      <= '0';
      IntRxReqReg   <= (others=>'0');
      IntRxAckReg   <= (others=>'0');
      IntTxReqReg   <= (others=>'0');
      IntTxAckReg   <= (others=>'0');
      IntTxRejReg   <= (others=>'0');
      VecRxDataReg  <= (others=>'0');
      VecRxNumReg   <= (others=>'0');
      VecRxValidReg <= '0';
      VecRxAckReg   <= '0';
      VecRxCnt      <= (others=>'0');
      VecRxChkReg   <= (others=>'0');
      VecTxBusyReg  <= '0';
      VecTxDataReg  <= (others=>'0');
      VecTxNumReg   <= (others=>'0');
      VecTxCnt      <= (others=>'0');
      VecTxChkReg   <= (others=>'0');
      MemRxRunReg   <= '0';
      MemRxDataReg  <= (others=>'0');
      MemRxPartReg  <= (others=>'0');
      MemRxValidReg <= '0';
      MemRxAckReg   <= '0';
      MemRxCnt      <= (others=>'0');
      MemRxChkReg   <= (others=>'0');
      MemTxBusyReg  <= '0';
      MemTxGetReg   <= '0';
      MemTxCnt      <= (others=>'0');
      MemTxChkReg   <= (others=>'0');
      PROTstate     <= PROT_IDLE;
      PROTerror     <= '0';
    elsif clk'event and clk = '1' then
      if (UARTreadySig='0') then
        RXHeadReg     <= (others=>'0');
        TXdata        <= (others=>'0');
        TXsend        <= '0';
        ReadyReg      <= '0';
        UARTactiveReg <= '1';
        IntRxReqReg   <= (others=>'0');
        IntRxAckReg   <= (others=>'0');
        IntTxReqReg   <= (others=>'0');
        IntTxAckReg   <= (others=>'0');
        IntTxRejReg   <= (others=>'0');
        VecRxDataReg  <= (others=>'0');
        VecRxNumReg   <= (others=>'0');
        VecRxValidReg <= '0';
        VecRxAckReg   <= '0';
        VecRxCnt      <= (others=>'0');
        VecRxChkReg   <= (others=>'0');
        VecTxBusyReg  <= '0';
        VecTxDataReg  <= (others=>'0');
        VecTxNumReg   <= (others=>'0');
        VecTxCnt      <= (others=>'0');
        VecTxChkReg   <= (others=>'0');
        MemRxRunReg   <= '0';
        MemRxDataReg  <= (others=>'0');
        MemRxPartReg  <= (others=>'0');
        MemRxValidReg <= '0';
        MemRxAckReg   <= '0';
        MemRxCnt      <= (others=>'0');
        MemRxChkReg   <= (others=>'0');
        MemTxBusyReg  <= '0';
        MemTxGetReg   <= '0';
        MemTxCnt      <= (others=>'0');
        MemTxChkReg   <= (others=>'0');
        PROTstate     <= PROT_IDLE;
        PROTerror     <= '0';
      else
        PROTerror <= not(initN);
        --
        if (VecTxBusyReg='0' and vec_tx_ext_ena='0' and vec_tx_num>=UART_SVEC_NUM_MIN and vec_tx_num<=UART_SVEC_NUM_MAX) then
          VecTxBusyReg <= vec_tx_req;
        elsif (VecTxBusyReg='0' and vec_tx_ext_ena='1' and vec_tx_num>=UART_EVEC_NUM_MIN and vec_tx_num<=UART_EVEC_NUM_MAX) then
          VecTxBusyReg <= vec_tx_req;
        end if;
        --
        if (MemTxBusyReg='0' and (mem_tx_long_ena='1' -->
           or (mem_tx_num<=UART_SHORT_NUM_MAX and (mem_tx_part_ena='0' or mem_tx_part<=UART_SHORT_NUM_MAX)))) then
          MemTxBusyReg <= mem_tx_req;
        end if;
        IntRxAckReg <= IntRxReqReg and (IntRxAckReg or int_rx_ack);
        IntRxReqReg <= IntRxReqReg and not(IntRxAckReg);
        --
        IntTxReqReg <= (IntTxReqReg or int_tx_req) and not(IntTxAckReg);
        IntTxAckReg <= IntTxAckReg and int_tx_req;
        --
        case PROTstate is
          when PROT_IDLE =>
            if (UARTreadySig='1') then
              PROTstate <= PROT_TEST;
            end if;
          when PROT_TEST =>
            TXdata <= not(RXdata);
            TXsend <= RXrec;
            if(RXrec='1' and RXdata=0) then
              TXdata    <= RXdata;
              PROTstate <= PROT_TEST_END;
            else
              PROTstate <= PROT_TEST;
            end if;
          when PROT_TEST_END =>
            TXsend        <= '0';
            if(TXsend='0' and TXempty='1') then
              UARTactiveReg <= '0';
              ReadyReg      <= '1';
              PROTstate     <= PROT_HEADER;
            else
              PROTstate <= PROT_TEST_END;
            end if;
          when PROT_HEADER =>
            TXsend        <= '0';
            RXHeadReg     <= RXdata;
            VecRxDataReg  <= (others=>'0');
            VecRxNumReg   <= (others=>'0');
            VecRxValidReg <= '0';
            VecRxAckReg   <= '0';
            VecTxDataReg  <= (others=>'0');
            VecTxNumReg   <= (others=>'0');
            VecTxCnt      <= (others=>'0');
            VecTxChkReg   <= (others=>'0');
            MemRxDataReg  <= (others=>'0');
            MemRxValidReg <= '0';
            MemRxAckReg   <= '0';
            MemRxCnt      <= (others=>'0');
            MemRxChkReg   <= (others=>'0');
            MemTxGetReg   <= '0';
            MemTxCnt      <= (others=>'0');
            MemTxChkReg   <= (others=>'0');
            if (RXrec='1') then
              if (HeadGet(RXdata)=HEAD_STATUS and HExtGet(RXdata)=HEXT_STATUS_RESET) then
                PROTstate <= PROT_ERROR;
              elsif (UARTactiveReg='1') then
                if (HeadGet(RXdata)=HEAD_STATUS) then
                  if (HExtGet(RXdata)=HEXT_STATUS_NULL) then
                    PROTstate <= PROT_STAT_NULL;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_SEND) then
                    PROTstate <= PROT_STAT_SEND;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_REQ0) then
                    PROTstate <= PROT_STAT_REC_REQ0;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_REQ1) then
                    PROTstate <= PROT_STAT_REC_REQ1;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_REQ2) then
                    PROTstate <= PROT_STAT_REC_REQ2;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_REQ3) then
                    PROTstate <= PROT_STAT_REC_REQ3;
                  elsif (HExtGet(RXdata)=HEXT_STATUS_INACT) then
                    PROTstate <= PROT_STAT_INACT_ID;
                  else
                    PROTstate <= PROT_ERROR;
                  end if;
                elsif (HeadGet(RXdata)=HEAD_EXTEND) then
                  if (HExtGet(RXdata)=HEXT_EXTEND_L1VEC) then
                    PROTstate <= PROT_L1VEC_REC_NUM;
                  elsif (HExtGet(RXdata)=HEXT_EXTEND_L2VEC) then
                    PROTstate <= PROT_L2VEC_REC_NUM0;
                  elsif (HExtGet(RXdata)=HEXT_EXTEND_P1VEC) then
                    PROTstate <= PROT_P1VEC_REC_PART;
                  elsif (HExtGet(RXdata)=HEXT_EXTEND_P2VEC) then
                    PROTstate <= PROT_P2VEC_REC_PART0;
                  else
                    PROTstate <= PROT_EVEC_REC;
                  end if;
                else
                  PROTstate <= PROT_SVEC_REC;
                end if;
              elsif (HeadGet(RXdata)=HEAD_STATUS and HExtGet(RXdata)=HEXT_STATUS_ACT) then
                PROTstate <= PROT_STAT_ACT_ID;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
        --  
        -- STATUS NULL state
          when PROT_STAT_NULL =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              TXdata <= CLIENT_ACK;
              TXsend <= '1';
            end if;
        --  
        -- STATUS SEND state
          when PROT_STAT_SEND =>
            if    (IntTxReqReg(0)='1' and IntTxRejReg(0)='0') then
              PROTstate <= PROT_STAT_SEND_REQ0;
            elsif (IntTxReqReg(1)='1' and IntTxRejReg(1)='0') then
              PROTstate <= PROT_STAT_SEND_REQ1;
            elsif (IntTxReqReg(2)='1' and IntTxRejReg(2)='0') then
              PROTstate <= PROT_STAT_SEND_REQ2;
            elsif (IntTxReqReg(3)='1' and IntTxRejReg(3)='0') then
              PROTstate <= PROT_STAT_SEND_REQ3;
            elsif (VecTxBusyReg='1') then
              IntTxRejReg  <= (others => '0');
              VecTxDataReg <= vec_tx_data;
              VecTxCnt     <= vec_tx_num;
              if (vec_tx_ext_ena='0') then
                PROTstate <= PROT_SVEC_SEND;
              else
                PROTstate <= PROT_EVEC_SEND;
              end if;
            elsif (mem_tx_req='1') then
              IntTxRejReg  <= (others => '0');
              if (mem_tx_part_ena='0' and mem_tx_long_ena='0') then
                PROTstate <= PROT_L1VEC_SEND_HEAD;
              elsif (mem_tx_part_ena='0' and mem_tx_long_ena='1') then
                PROTstate <= PROT_L2VEC_SEND_HEAD;
              elsif (mem_tx_part_ena='1' and mem_tx_long_ena='0') then
                PROTstate <= PROT_P1VEC_SEND_HEAD;
              else
                PROTstate <= PROT_P2VEC_SEND_HEAD;
              end if;
            else
              if (IntTxReqReg=0) then
                PROTstate <= PROT_STAT_NULL;
              else
                IntTxRejReg <= (others => '0');
                PROTstate   <= PROT_STAT_SEND;
              end if;
            end if;
        --  
        -- STATUS REQ0 receive state
          when PROT_STAT_REC_REQ0 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              IntRxReqReg(0) <= '1';
              if (IntRxReqReg(0)='0') then
                TXdata <= not(HEXT_STATUS_REQ0) & CTRL_STAT_ACK;
              else
                TXdata <= not(HEXT_STATUS_REQ0) & CTRL_STAT_REJ;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- STATUS REQ0 send states
          when PROT_STAT_SEND_REQ0 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_STAT_SEND_ACK0;
            elsif (TXempty='1') then
              TXdata <= HEXT_STATUS_REQ0 & HEAD_STATUS;
              TXsend <= '1';
            end if;
          when PROT_STAT_SEND_ACK0 =>
            if (RXrec='1') then
              if (RXdata = (not(HEXT_STATUS_REQ0) & CTRL_STAT_ACK)) then
                IntTxAckReg(0) <= '1';
                IntTxRejReg(0) <= '0';
                PROTstate      <= PROT_HEADER;
              elsif(RXdata = (not(HEXT_STATUS_REQ0) & CTRL_STAT_REJ)) then
                IntTxRejReg(0) <= '1';
                IntTxAckReg(0) <= '0';
                PROTstate <= PROT_HEADER;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
        --  
        -- STATUS REQ1 receive state
          when PROT_STAT_REC_REQ1 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              IntRxReqReg(1) <= '1';
              if (IntRxReqReg(1)='0') then
                TXdata <= not(HEXT_STATUS_REQ1) & CTRL_STAT_ACK;
              else
                TXdata <= not(HEXT_STATUS_REQ1) & CTRL_STAT_REJ;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- STATUS REQ1 send states
          when PROT_STAT_SEND_REQ1 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_STAT_SEND_ACK1;
            elsif (TXempty='1') then
              TXdata <= HEXT_STATUS_REQ1 & HEAD_STATUS;
              TXsend <= '1';
            end if;
          when PROT_STAT_SEND_ACK1 =>
            if (RXrec='1') then
              if (RXdata = (not(HEXT_STATUS_REQ1) & CTRL_STAT_ACK)) then
                IntTxAckReg(1) <= '1';
                IntTxRejReg(1) <= '0';
                PROTstate      <= PROT_HEADER;
              elsif(RXdata = (not(HEXT_STATUS_REQ1) & CTRL_STAT_REJ)) then
                IntTxRejReg(1) <= '1';
                IntTxAckReg(1) <= '0';
                PROTstate <= PROT_HEADER;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
        --  
        -- STATUS REQ2 receive state
          when PROT_STAT_REC_REQ2 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              IntRxReqReg(2) <= '1';
              if (IntRxReqReg(2)='0') then
                TXdata <= not(HEXT_STATUS_REQ2) & CTRL_STAT_ACK;
              else
                TXdata <= not(HEXT_STATUS_REQ2) & CTRL_STAT_REJ;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- STATUS REQ2 send states
          when PROT_STAT_SEND_REQ2 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_STAT_SEND_ACK2;
            elsif (TXempty='1') then
              TXdata <= HEXT_STATUS_REQ2 & HEAD_STATUS;
              TXsend <= '1';
            end if;
          when PROT_STAT_SEND_ACK2 =>
            if (RXrec='1') then
              if (RXdata = (not(HEXT_STATUS_REQ2) & CTRL_STAT_ACK)) then
                IntTxAckReg(2) <= '1';
                IntTxRejReg(2) <= '0';
                PROTstate      <= PROT_HEADER;
              elsif(RXdata = (not(HEXT_STATUS_REQ2) & CTRL_STAT_REJ)) then
                IntTxRejReg(2) <= '1';
                IntTxAckReg(2) <= '0';
                PROTstate <= PROT_HEADER;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
        --  
        -- STATUS REQ3 receive state
          when PROT_STAT_REC_REQ3 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              IntRxReqReg(3) <= '1';
              if (IntRxReqReg(3)='0') then
                TXdata <= not(HEXT_STATUS_REQ3) & CTRL_STAT_ACK;
              else
                TXdata <= not(HEXT_STATUS_REQ3) & CTRL_STAT_REJ;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- STATUS REQ3 send states
          when PROT_STAT_SEND_REQ3 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_STAT_SEND_ACK3;
            elsif (TXempty='1') then
              TXdata <= HEXT_STATUS_REQ3 & HEAD_STATUS;
              TXsend <= '1';
            end if;
          when PROT_STAT_SEND_ACK3 =>
            if (RXrec='1') then
              if (RXdata = (not(HEXT_STATUS_REQ3) & CTRL_STAT_ACK)) then
                IntTxAckReg(3) <= '1';
                IntTxRejReg(3) <= '0';
                PROTstate      <= PROT_HEADER;
              elsif(RXdata = (not(HEXT_STATUS_REQ3) & CTRL_STAT_REJ)) then
                IntTxRejReg(3) <= '1';
                IntTxAckReg(3) <= '0';
                PROTstate <= PROT_HEADER;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
        --  
        -- STATUS ACTIVE receive state
          when PROT_STAT_ACT_ID =>
            if (RXrec='1') then
              TXdata <= RXdata;
              PROTstate <= PROT_STAT_ACT_CHK;
            end if;
          when PROT_STAT_ACT_CHK =>
            if (RXrec='1') then
              if (RXdata=TXdata+CLIENT_REQ) then
                if (TXdata=chain_id) then
                  UARTactiveReg <= '1';
                  PROTstate     <= PROT_STAT_ACT_ACK;
                else
                  PROTstate <= PROT_HEADER;
                end if;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_STAT_ACT_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              TXdata <= not(HEXT_STATUS_ACT) & CTRL_STAT_ACK;
              TXsend <= '1';
            end if;
        --  
        -- STATUS INACTIVE receive state
          when PROT_STAT_INACT_ID =>
            if (RXrec='1') then
              TXdata <= RXdata;
              PROTstate <= PROT_STAT_INACT_CHK;
            end if;
          when PROT_STAT_INACT_CHK =>
            if (RXrec='1') then
              if (RXdata=TXdata+CLIENT_REQ) then
                if (TXdata=chain_id) then
                  UARTactiveReg <= '0';
                  PROTstate     <= PROT_STAT_INACT_ACK;
                else
                  PROTstate <= PROT_HEADER;
                end if;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_STAT_INACT_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              TXdata <= not(HEXT_STATUS_INACT) & CTRL_STAT_REJ;
              TXsend <= '1';
            end if;
        --  
        -- SVEC receive states
          when PROT_SVEC_REC =>
            VecRxNumReg <= TSLVresize(HeadGet(RXHeadReg),VecRxNumReg'length);
            VecRxCnt    <= TSLVresize(HeadGet(RXHeadReg),VecRxNumReg'length);
            VecRxChkReg <= (others=>'0');
            PROTstate      <= PROT_SVEC_REC_DATA;
          when PROT_SVEC_REC_DATA =>
            if (VecRxCnt/=0) then
              if (RXrec='1') then
                VecRxDataReg(UART_BITS_NUM-1 downto 0) <= RXdata;
                VecRxDataReg(VecRxDataReg'length-1 downto UART_BITS_NUM) <= VecRxDataReg(VecRxDataReg'length-UART_BITS_NUM-1 downto 0);
                VecRxChkReg <= VecRxChkReg+RXdata;
                VecRxCnt    <= VecRxCnt - 1;
              end if;
            else
              PROTstate <= PROT_SVEC_REC_CHK;
            end if;
          when PROT_SVEC_REC_CHK =>
            if (HeadGet(VecRxChkReg)+HExtGet(VecRxChkReg)+HeadGet(RXHeadReg)=HExtGet(RXHeadReg)) then
              VecRxValidReg <='1';
              VecRxAckReg   <='0';
              PROTstate     <= PROT_SVEC_REC_ACK;
            else
              PROTstate <= PROT_ERROR;
            end if;
          when PROT_SVEC_REC_ACK =>
            VecRxAckReg <= VecRxAckReg or vec_rx_ack;
            VecRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (VecRxAckReg='1') then
                if (TXreqSig='1') then
                  TXdata <= CLIENT_REQ;
                else
                  TXdata <= CLIENT_ACK;
                end if;
                TXsend <= '1';
              end if;
            end if;
        --  
        -- SVEC send states
          when PROT_SVEC_SEND => 
            if (VecTxCnt/=0) then
              VecTxChkReg <= VecTxChkReg+VecTxDataReg(UART_BITS_NUM-1 downto 0);
              VecTxDataReg(VecTxDataReg'length-UART_BITS_NUM-1 downto 0) <= VecTxDataReg(VecTxDataReg'length-1 downto UART_BITS_NUM);
              VecTxCnt    <= VecTxCnt - 1;
            else
              VecTxChkReg <=   (HeadGet(VecTxChkReg)+HExtGet(VecTxChkReg)+TSLVresize(vec_tx_num,HEAD_LEN)) -->
                                 & TSLVresize(vec_tx_num,HEAD_LEN);
              PROTstate       <= PROT_SVEC_SEND_HEAD;
            end if;
          when PROT_SVEC_SEND_HEAD =>
            if (TXsend='1') then
              VecTxDataReg     <= vec_tx_data;
              VecTxCnt     <= vec_tx_num;
              TXsend           <= '0';
              PROTstate        <= PROT_SVEC_SEND_DATA;
            elsif (TXempty='1') then
              TXdata <= VecTxChkReg;
              TXsend <= '1';
            end if;
          when PROT_SVEC_SEND_DATA =>
            if (VecTxCnt/=0) then
              if (TXsend='1') then
                TXsend <= '0';
                VecTxDataReg(VecTxDataReg'length-UART_BITS_NUM-1 downto 0) <= VecTxDataReg(VecTxDataReg'length-1 downto UART_BITS_NUM);
                VecTxCnt <= VecTxCnt - 1;
              elsif (TXempty='1') then
                TXdata <= VecTxDataReg(UART_BITS_NUM-1 downto 0);
                TXsend <= '1';
              end if;
            else
              VecTxBusyReg <= '0';
              PROTstate    <= PROT_SVEC_SEND_ACK;
            end if;
          when PROT_SVEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- EVEC receive states
          when PROT_EVEC_REC =>
            VecRxNumReg <= TSLVresize(HExtGet(RXHeadReg)+1,VecRxNumReg'length);
            VecRxCnt    <= TSLVresize(HExtGet(RXHeadReg)+1,VecRxNumReg'length);
            VecRxChkReg <= (others=>'0');
            PROTstate      <= PROT_EVEC_REC_DATA;
          when PROT_EVEC_REC_DATA =>
            if (VecRxCnt/=0) then
              if (RXrec='1') then
                VecRxDataReg(UART_BITS_NUM-1 downto 0) <= RXdata;
                VecRxDataReg(VecRxDataReg'length-1 downto UART_BITS_NUM) <= VecRxDataReg(VecRxDataReg'length-UART_BITS_NUM-1 downto 0);
                VecRxChkReg <= VecRxChkReg+RXdata;
                VecRxCnt    <= VecRxCnt - 1;
              end if;
            else
              PROTstate <= PROT_EVEC_REC_CHK;
            end if;
          when PROT_EVEC_REC_CHK =>
            if (RXrec='1') then
              if (VecRxChkReg+VecRxNumReg=RXdata) then
                VecRxValidReg <='1';
                VecRxAckReg   <='0';
                PROTstate        <= PROT_EVEC_REC_ACK;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_EVEC_REC_ACK =>
            VecRxAckReg <= VecRxAckReg or vec_rx_ack;
            VecRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (VecRxAckReg='1') then
                if (TXreqSig='1') then
                  TXdata <= CLIENT_REQ;
                else
                  TXdata <= CLIENT_ACK;
                end if;
                TXsend <= '1';
              end if;
            end if;
        --  
        -- EVEC send states
          when PROT_EVEC_SEND =>
            VecTxCnt  <= vec_tx_num-1;
            PROTstate <= PROT_EVEC_SEND_HEAD;
          when PROT_EVEC_SEND_HEAD =>
            if (TXempty='1') then
              TXdata <= TSLVresize(VecTxCnt,HEAD_LEN) & HEAD_EXTEND;
              TXsend <= '1';
            elsif (TXsend='1') then
              VecTxDataReg <= vec_tx_data;
              TXsend       <= '0';
              PROTstate    <= PROT_EVEC_SEND_DATA;
              VecTxChkReg  <= TSLVresize(VecTxCnt,VecTxChkReg'length);
            end if;
          when PROT_EVEC_SEND_DATA =>
            if (VecTxCnt/=0) then
              if (TXsend='1') then
                TXsend <= '0';
                VecTxDataReg(VecTxDataReg'length-UART_BITS_NUM-1 downto 0) <= VecTxDataReg(VecTxDataReg'length-1 downto UART_BITS_NUM);
                VecTxCnt    <= VecTxCnt - 1;
                VecTxChkReg <= VecTxChkReg + VecTxDataReg(UART_BITS_NUM-1 downto 0);
              elsif (TXempty='1') then
                TXdata <= VecTxDataReg(UART_BITS_NUM-1 downto 0);
                TXsend <= '1';
              end if;
            else
              VecTxBusyReg <= '0';
              PROTstate    <= PROT_EVEC_SEND_CHK;
            end if;
          when PROT_EVEC_SEND_CHK =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_EVEC_SEND_ACK;
            elsif (TXempty='1') then
              TXdata <= VecTxChkReg;
              TXsend <= '1';
            end if;
          when PROT_EVEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- L1VEC receive states
          when PROT_L1VEC_REC_NUM =>
            if(MemRxRunReg='0') then
              if (RXrec='1') then
                MemRxCnt    <= TSLVresize(RXdata,MemRxCnt'length);
                MemRxChkReg <= TSLVresize(RXdata,MemRxChkReg'length);
                MemRxRunReg <= '1';
                PROTstate   <= PROT_L1VEC_REC_DATA;
              end if;
            else
              PROTstate <= PROT_ERROR;
            end if;
          when PROT_L1VEC_REC_DATA =>
            MemRxValidReg <= RXrec;
            if (RXrec='1') then
              MemRxDataReg <= RXdata;
              MemRxChkReg  <= MemRxChkReg+TSLVresize(RXdata,MemRxChkReg'length);
              MemRxCnt     <= MemRxCnt - 1;
              if (MemRxCnt=0) then
                PROTstate <= PROT_L1VEC_REC_CHK;
              end if;
            end if;
          when PROT_L1VEC_REC_CHK =>
            MemRxValidReg <= '0';
            if (RXrec='1') then
              if (MemRxChkReg(UART_BITS_NUM-1 downto 0)=RXdata) then
                MemRxRunReg <= '0';
                MemRxAckReg <= '0';
                PROTstate   <= PROT_L1VEC_REC_ACK;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_L1VEC_REC_ACK =>
            MemRxAckReg   <= MemRxAckReg or mem_rx_ack;
            MemRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (MemRxAckReg='1') then
                if (TXreqSig='1') then
                  TXdata <= CLIENT_REQ;
                else
                  TXdata <= CLIENT_ACK;
                end if;
                TXsend <= '1';
              end if;
            end if;
        --  
        -- L1VEC send states
          when PROT_L1VEC_SEND_HEAD =>
            if (TXsend='1') then
              TXsend       <= '0';
              PROTstate    <= PROT_L1VEC_SEND_NUM;
            elsif (TXempty='1') then
              TXdata <= HEXT_EXTEND_L1VEC & HEAD_EXTEND;
              TXsend <= '1';
            end if;
          when PROT_L1VEC_SEND_NUM =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_L1VEC_SEND_DATA;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(UART_BITS_NUM-1 downto 0);
              MemTxCnt     <= mem_tx_num;
              MemTxChkReg  <= mem_tx_num;
              TXsend <= '1';
            end if;
          when PROT_L1VEC_SEND_DATA =>
            if (TXsend='1') then
              TXsend      <= '0';
              MemTxGetReg <= '0';
              MemTxChkReg <= MemTxChkReg + mem_tx_data(UART_BITS_NUM-1 downto 0);
              MemTxCnt    <= MemTxCnt - 1;
              if (MemTxCnt=0) then
                MemTxBusyReg <= '0';
                PROTstate    <= PROT_L1VEC_SEND_CHK;
              end if;
            elsif (TXempty='1' and mem_tx_valid='1') then
              TXdata      <= mem_tx_data;
              TXsend      <= '1';
              MemTxGetReg <= '1';
            end if;
          when PROT_L1VEC_SEND_CHK =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_L1VEC_SEND_ACK;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(TXdata'range);
              TXsend <= '1';
            end if;
          when PROT_L1VEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- L2VEC receive states
          when PROT_L2VEC_REC_NUM0 =>
            if(MemRxRunReg='0') then
              if (RXrec='1') then
                MemRxCnt    <= TSLVresize(RXdata,MemRxCnt);
                MemRxChkReg <= TSLVresize(RXdata,MemRxChkReg'length);
                PROTstate   <= PROT_L2VEC_REC_NUM1;
              end if;
            else
              PROTstate <= PROT_ERROR;
            end if;
          when PROT_L2VEC_REC_NUM1 =>
            if (RXrec='1') then
              MemRxCnt(2*UART_BITS_NUM-1 downto UART_BITS_NUM)    <= RXdata;
              MemRxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM) <= RXdata;
              MemRxRunReg <= '1';
              PROTstate   <= PROT_L2VEC_REC_DATA;
            end if;
          when PROT_L2VEC_REC_DATA =>
            MemRxValidReg <= RXrec;
            if (RXrec='1') then
              MemRxDataReg <= RXdata;
              MemRxChkReg  <= MemRxChkReg+TSLVresize(RXdata,MemRxChkReg'length);
              MemRxCnt     <= MemRxCnt - 1;
              if (MemRxCnt=0) then
                PROTstate <= PROT_L2VEC_REC_CHK0;
              end if;
            end if;
          when PROT_L2VEC_REC_CHK0 =>
            MemRxValidReg <= '0';
            if (RXrec='1') then
              if (MemRxChkReg(UART_BITS_NUM-1 downto 0)=RXdata) then
                PROTstate <= PROT_L2VEC_REC_CHK1;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_L2VEC_REC_CHK1 =>
            MemRxValidReg <= '0';
            if (RXrec='1') then
              if (MemRxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM)=RXdata) then
                MemRxRunReg <= '0';
                MemRxAckReg <= '0';
                PROTstate   <= PROT_L2VEC_REC_ACK;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_L2VEC_REC_ACK =>
            MemRxAckReg <= MemRxAckReg or mem_rx_ack;
            MemRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (MemRxAckReg='1') then
                if (TXreqSig='1') then
                  TXdata <= CLIENT_REQ;
                else
                  TXdata <= CLIENT_ACK;
                end if;
                TXsend <= '1';
              end if;
            end if;
        --  
        -- L2VEC send states
          when PROT_L2VEC_SEND_HEAD =>
            if (TXsend='1') then
              TXsend       <= '0';
              PROTstate    <= PROT_L2VEC_SEND_NUM0;
            elsif (TXempty='1') then
              TXdata <= HEXT_EXTEND_L2VEC & HEAD_EXTEND;
              TXsend <= '1';
            end if;
          when PROT_L2VEC_SEND_NUM0 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_L2VEC_SEND_NUM1;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(UART_BITS_NUM-1 downto 0);
              TXsend <= '1';
            end if;
          when PROT_L2VEC_SEND_NUM1 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_L2VEC_SEND_DATA;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(2*UART_BITS_NUM-1 downto UART_BITS_NUM);
              MemTxCnt     <= mem_tx_num;
              MemTxChkReg  <= mem_tx_num;
              TXsend <= '1';
            end if;
          when PROT_L2VEC_SEND_DATA =>
            if (TXsend='1') then
              TXsend      <= '0';
              MemTxGetReg <= '0';
              MemTxChkReg <= MemTxChkReg + mem_tx_data(UART_BITS_NUM-1 downto 0);
              MemTxCnt    <= MemTxCnt - 1;
              if (MemTxCnt=0) then
                MemTxBusyReg <= '0';
                PROTstate    <= PROT_L2VEC_SEND_CHK0;
              end if;
            elsif (TXempty='1' and mem_tx_valid='1') then
              TXdata      <= mem_tx_data;
              TXsend      <= '1';
              MemTxGetReg <= '1';
            end if;
          when PROT_L2VEC_SEND_CHK0 =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_L2VEC_SEND_CHK1;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(UART_BITS_NUM-1 downto 0);
              TXsend <= '1';
            end if;
          when PROT_L2VEC_SEND_CHK1 =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_L2VEC_SEND_ACK;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM);
              TXsend <= '1';
            end if;
          when PROT_L2VEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- P1VEC receive states
          when PROT_P1VEC_REC_PART =>
            if (RXrec='1') then
              MemRxChkReg <= TSLVresize(RXdata,MemRxChkReg'length);
              if(MemRxRunReg='0') then
                MemRxPartReg <= TSLVresize(RXdata,MemRxPartReg'length);
                PROTstate    <= PROT_P1VEC_REC_NUM;
              elsif (MemRxPartReg(RXdata'range)=RXdata) then
                PROTstate <= PROT_P1VEC_REC_NUM;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P1VEC_REC_NUM =>
            if (RXrec='1') then
              MemRxCnt    <= TSLVresize(RXdata,MemRxCnt'length);
              MemRxChkReg <= MemRxChkReg + TSLVresize(RXdata,MemRxChkReg'length);
              MemRxRunReg <= '1';
              PROTstate   <= PROT_P1VEC_REC_DATA;
            end if;
          when PROT_P1VEC_REC_DATA =>
            MemRxValidReg <= RXrec;
            if (RXrec='1') then
              MemRxDataReg <= RXdata;
              MemRxChkReg  <= MemRxChkReg+TSLVresize(RXdata,MemRxChkReg'length);
              MemRxCnt     <= MemRxCnt - 1;
              if (MemRxCnt=0) then
                PROTstate <= PROT_P1VEC_REC_CHK;
              end if;
            end if;
          when PROT_P1VEC_REC_CHK =>
            MemRxValidReg <= '0';
            if (RXrec='1') then
              if (MemRxChkReg(UART_BITS_NUM-1 downto 0)=RXdata) then
                if (MemRxPartReg=0) then
                  MemRxRunReg <= '0';
                end if;
                MemRxAckReg <= '0';
                PROTstate   <= PROT_P1VEC_REC_ACK;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P1VEC_REC_ACK =>
            MemRxAckReg   <= MemRxAckReg or mem_rx_ack;
            MemRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (MemRxPartReg=0) then
                if (MemRxAckReg='1') then
                  if (TXreqSig='1') then
                    TXdata <= CLIENT_REQ;
                  else
                    TXdata <= CLIENT_ACK;
                  end if;
                  TXsend <= '1';
                end if;
              else
                MemRxPartReg <= MemRxPartReg-1;
                TXdata       <= CLIENT_ACK;
                TXsend       <= '1';
              end if;
            end if;
        --  
        -- P1VEC send states
          when PROT_P1VEC_SEND_HEAD =>
            if (TXsend='1') then
              TXsend       <= '0';
              PROTstate    <= PROT_P1VEC_SEND_PART;
            elsif (TXempty='1') then
              TXdata <= HEXT_EXTEND_P1VEC & HEAD_EXTEND;
              TXsend <= '1';
            end if;
          when PROT_P1VEC_SEND_PART =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P1VEC_SEND_NUM;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_part(UART_BITS_NUM-1 downto 0);
              MemTxChkReg  <= mem_tx_part;
              TXsend <= '1';
            end if;
          when PROT_P1VEC_SEND_NUM =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P1VEC_SEND_DATA;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(UART_BITS_NUM-1 downto 0);
              MemTxCnt     <= mem_tx_num;
              MemTxChkReg  <= MemTxChkReg + mem_tx_num;
              TXsend <= '1';
            end if;
          when PROT_P1VEC_SEND_DATA =>
            if (TXsend='1') then
              TXsend      <= '0';
              MemTxGetReg <= '0';
              MemTxChkReg <= MemTxChkReg + mem_tx_data(UART_BITS_NUM-1 downto 0);
              MemTxCnt    <= MemTxCnt - 1;
              if (MemTxCnt=0) then
                MemTxBusyReg <= '0';
                PROTstate    <= PROT_P1VEC_SEND_CHK;
              end if;
            elsif (TXempty='1' and mem_tx_valid='1') then
              TXdata      <= mem_tx_data;
              TXsend      <= '1';
              MemTxGetReg <= '1';
            end if;
          when PROT_P1VEC_SEND_CHK =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_P1VEC_SEND_ACK;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(TXdata'range);
              TXsend <= '1';
            end if;
          when PROT_P1VEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- P2VEC receive states
          when PROT_P2VEC_REC_PART0 =>
            if (RXrec='1') then
              MemRxChkReg  <= TSLVresize(RXdata,MemRxChkReg'length);
              if(MemRxRunReg='0') then
                MemRxPartReg <= TSLVresize(RXdata,MemRxPartReg'length);
                PROTstate    <= PROT_P2VEC_REC_PART1;
              elsif (MemRxPartReg(RXdata'range)=RXdata) then
                PROTstate <= PROT_P2VEC_REC_PART1;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P2VEC_REC_PART1 =>
            if (RXrec='1') then
              MemRxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM)  <= RXdata;
              if(MemRxRunReg='0') then
                MemRxPartReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM) <= RXdata;
                PROTstate <= PROT_P2VEC_REC_NUM0;
              elsif (MemRxPartReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM)=RXdata) then
                PROTstate <= PROT_P2VEC_REC_NUM0;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P2VEC_REC_NUM0 =>
            if (RXrec='1') then
              MemRxCnt    <= TSLVresize(RXdata,MemRxCnt'length);
              PROTstate   <= PROT_P2VEC_REC_NUM1;
            end if;
          when PROT_P2VEC_REC_NUM1 =>
            if (RXrec='1') then
              MemRxCnt(2*UART_BITS_NUM-1 downto UART_BITS_NUM) <= RXdata;
              MemRxChkReg <= MemRxChkReg + TSLVresize(SLVnorm(RXdata & MemRxCnt(UART_BITS_NUM downto 0)),MemRxChkReg'length);
              MemRxRunReg <= '1';
              PROTstate   <= PROT_P2VEC_REC_DATA;
            end if;
          when PROT_P2VEC_REC_DATA =>
            MemRxValidReg <= RXrec;
            if (RXrec='1') then
              MemRxDataReg <= RXdata;
              MemRxChkReg <= MemRxChkReg+TSLVresize(RXdata,MemRxChkReg'length);
              MemRxCnt    <= MemRxCnt - 1;
              if (MemRxCnt=0) then
                PROTstate <= PROT_P2VEC_REC_CHK0;
              end if;
            end if;
          when PROT_P2VEC_REC_CHK0 =>
            MemRxValidReg <= '0';
            if (RXrec='1') then
              if (MemRxChkReg(UART_BITS_NUM-1 downto 0)=RXdata) then
                PROTstate <= PROT_P2VEC_REC_CHK1;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P2VEC_REC_CHK1 =>
            if (RXrec='1') then
              if (MemRxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM)=RXdata) then
                if (MemRxPartReg=0) then
                  MemRxRunReg <= '0';
                end if;
                MemRxAckReg <= '0';
                PROTstate   <= PROT_P2VEC_REC_ACK;
              else
                PROTstate <= PROT_ERROR;
              end if;
            end if;
          when PROT_P2VEC_REC_ACK =>
            MemRxAckReg <= MemRxAckReg or mem_rx_ack;
            MemRxValidReg <= '0';
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (MemRxPartReg=0) then
                if (MemRxAckReg='1') then
                  if (TXreqSig='1') then
                    TXdata <= CLIENT_REQ;
                  else
                    TXdata <= CLIENT_ACK;
                  end if;
                  TXsend <= '1';
                end if;
              else
                MemRxPartReg <= MemRxPartReg-1;
                TXdata       <= CLIENT_ACK;
                TXsend       <= '1';
              end if;
            end if;
        --  
        -- P2VEC send states
          when PROT_P2VEC_SEND_HEAD =>
            if (TXsend='1') then
              TXsend       <= '0';
              PROTstate    <= PROT_P2VEC_SEND_PART0;
            elsif (TXempty='1') then
              TXdata <= HEXT_EXTEND_P2VEC & HEAD_EXTEND;
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_PART0 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P2VEC_SEND_PART1;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(UART_BITS_NUM-1 downto 0);
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_PART1 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P2VEC_SEND_NUM0;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(2*UART_BITS_NUM-1 downto UART_BITS_NUM);
              MemTxChkReg  <= mem_tx_num;
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_NUM0 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P2VEC_SEND_NUM1;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(UART_BITS_NUM-1 downto 0);
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_NUM1 =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_P2VEC_SEND_DATA;
            elsif (TXempty='1') then
              TXdata       <= mem_tx_num(2*UART_BITS_NUM-1 downto UART_BITS_NUM);
              MemTxCnt     <= mem_tx_num;
              MemTxChkReg  <= MemTxChkReg + mem_tx_num;
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_DATA =>
            if (TXsend='1') then
              TXsend      <= '0';
              MemTxGetReg <= '0';
              MemTxChkReg <= MemTxChkReg + mem_tx_data(UART_BITS_NUM-1 downto 0);
              MemTxCnt    <= MemTxCnt - 1;
              if (MemTxCnt=0) then
                MemTxBusyReg <= '0';
                PROTstate    <= PROT_P2VEC_SEND_CHK0;
              end if;
            elsif (TXempty='1' and mem_tx_valid='1') then
              TXdata      <= mem_tx_data;
              TXsend      <= '1';
              MemTxGetReg <= '1';
            end if;
          when PROT_P2VEC_SEND_CHK0 =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_P2VEC_SEND_CHK1;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(UART_BITS_NUM-1 downto 0);
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_CHK1 =>
            if (TXsend='1') then
              TXsend <= '0';
              PROTstate <= PROT_P2VEC_SEND_ACK;
            elsif (TXempty='1') then
              TXdata <= MemTxChkReg(2*UART_BITS_NUM-1 downto UART_BITS_NUM);
              TXsend <= '1';
            end if;
          when PROT_P2VEC_SEND_ACK =>
            if (TXsend='1') then
              TXsend    <= '0';
              PROTstate <= PROT_HEADER;
            elsif (TXempty='1') then
              if (TXreqSig='1') then
                TXdata <= CLIENT_REQ;
              else
                TXdata <= CLIENT_ACK;
              end if;
              TXsend <= '1';
            end if;
        --  
        -- error states 
          when PROT_ERROR =>
            PROTerror <= '1';
            PROTstate <= PROT_ERROR;
          when others =>
            PROTerror <= '1';
            PROTstate <= PROT_ERROR;
        end case;
      end if;
    end if;
  end process;
  
  int_rx_req   <= IntRxReqReg;
  int_tx_ack   <= IntTxAckReg;
  --
  vec_rx_data  <= VecRxDataReg;
  vec_rx_num   <= VecRxNumReg;
  vec_rx_valid <= VecRxValidReg;
  vec_tx_empty <= not(VecTxBusyReg);
  --
  mem_rx_run   <= MemRxRunReg;
  mem_rx_data  <= MemRxDataReg;
  mem_rx_valid <= MemRxValidReg;
  mem_tx_get   <= MemTxGetReg;
  mem_tx_empty <= not(MemTxBusyReg); 
  --
  ready        <= ReadyReg;
  --
  --
  uart_chain: process (resetN, clk)
  begin
    if resetN = '0' then
      RTSparReg  <= '0';
      RXparReg   <= '0';
      TXparReg   <= '0';
      RTSchlReg  <= '0';
      RXchlReg   <= '0';
      TXchlReg   <= '0';
      RXreg      <= '0';
      CHAINstate <= CHAIN_ERROR;
      CHAINerror <= '0';
    elsif clk'event and clk = '1' then
      RXparReg  <= RX_p;
      RTSchlReg <= sel('1',RTS_c,chain_last);
      TXchlReg  <= sel('1',TX_c,chain_last);
      if (ReadyReg='0') then
        RTSparReg  <= '0';
        RXreg      <= RXparReg;
        TXparReg   <= TXsig;
        RXchlReg   <= '1';
        CHAINerror <= '0';
        if (chain_last='1') then
          CHAINstate <= CHAIN_SELECT;
        else
          CHAINstate <= CHAIN_CHILD_INIT;
        end if;
      else
        case CHAINstate is
          when CHAIN_CHILD_INIT =>
            RTSparReg <= '0';
            RXreg     <= '1';
            TXparReg  <= TXchlReg;
            RXchlReg  <= RXparReg;
            if (RTSchlReg='1') then
              CHAINstate <= CHAIN_SELECT;
            end if;
          when CHAIN_SELECT =>
            RTSparReg <= sel('1',RTSchlReg and RTSsig,chain_first);
            RXreg     <= RXparReg;
            TXparReg  <= TXchlReg and TXsig;
            RXchlReg  <= RXparReg;
            if ((TXsig='0' and RTSsig='0') or (TXchlReg='0' and RTSchlReg='0')) then
              CHAINstate <= CHAIN_ERROR;
            elsif (UARTactiveReg='1') then
              CHAINstate <= CHAIN_ACTIVE;
            elsif (TXchlReg='0') then
              CHAINstate <= CHAIN_BRIDGE;
            end if;
          when CHAIN_ACTIVE =>
            RTSparReg <= sel('1',RTSchlReg and RTSsig,chain_first);
            RXchlReg  <= '1';
            RXreg     <= RXparReg;
            TXparReg  <= TXsig;
            if (TXchlReg='0' or RTSchlReg = '0') then
              CHAINstate <= CHAIN_ERROR;
            elsif (UARTactiveReg='0') then
              CHAINstate <= CHAIN_SELECT;
            end if;
          when CHAIN_BRIDGE =>
            RTSparReg <= sel('1',RTSchlReg and RTSsig,chain_first);
            RXchlReg  <= RXparReg;
            TXparReg  <= TXchlReg;
            RXreg     <= '1';
            if (TXsig='0' or RTSsig='0' or (TXchlReg='0' and RTSchlReg='0')) then
              CHAINstate <= CHAIN_ERROR;
            elsif (TXchlReg='1' and RTSchlReg = '0') then
              CHAINstate <= CHAIN_SELECT;
            end if;
          when CHAIN_ERROR =>
            CHAINerror <= '1';
            TXparReg   <= '1';
            CHAINstate <= CHAIN_ERROR;
          when others =>
            CHAINerror <= '1';
            CHAINstate <= CHAIN_ERROR;
        end case;
      end if;
    end if;
  end process;
  --
  RTS_p <= RTSparReg;
  TX_p  <= TXparReg;
  CTS_c <= CTS_p and UARTreadySig;
  RX_c  <= RXchlReg;
  --
  UARTinitNsig <= not(PROTerror or CHAINerror);
  --
  uart :UART_client
    generic map(
      CLOCK_KHz		=> CLOCK_KHz,
      MIN_BAUD_Hz       => MIN_BAUD_Hz,
      SYNCH_COUNT	=> SYNCH_COUNT,
      SEND_BOUD_DELAY	=> SEND_BOUD_DELAY
    )
    port map (
      resetN            => resetN,
      clk               => clk,
      --
      CTS               => CTS_p,
      RTS		=> RTSsig,
      RX                => RXreg,
      TX                => TXsig,
      --
      RXdata            => RXdata,
      RXrec             => RXrec,
      TXdata            => TXdata,
      TXsend            => TXsend,
      TXempty           => TXempty,
      --
      initN             => UARTinitNsig,
      ready             => UARTreadySig,
      active            => UARTactiveReg
    );

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_II is
  generic (
    CLOCK_kHz		:in    TN := 62500;
    MIN_BAUD_Hz         :in    TN := 9600;
    SYNCH_COUNT         :in    TN := 16;
    SEND_BOUD_DELAY	:in    TN := 5;
    II_ADDR_WIDTH	:in    TN := 16;
    II_DATA_WIDTH	:in    TN := 32;
    BUS_OPER_WAIT_ns    :in    TN := 10;
    OPER_STROBE_WAIT_ns :in    TN := 25;
    STROBE_WAIT_ns      :in    TN := 100;
    STROBE_OPER_WAIT_ns :in    TN := 25;
    OPER_BUS_WAIT_ns    :in    TN := 10
  );
  port(
    resetN              :in    TSL;
    clk                 :in    TSL;
    -- UART parent
    CTS_p               :in    TSL;
    RTS_p		:out   TSL;
    RX_p                :in    TSL;
    TX_P                :out   TSL;
    -- UART child 
    CTS_c               :out   TSL;
    RTS_c		:in    TSL;
    RX_c                :out   TSL;
    TX_c                :in    TSL;
    --
    chain_id            :in    TSLV(UART_BITS_NUM-1 downto 0);
    chain_first         :in    TSL;
    chain_last          :in    TSL;
    -- internal interface bus 
    II_resetN		:out   TSL;
    II_operN		:out   TSL;
    II_writeN		:out   TSL;
    II_strobeN		:out   TSL;
    II_addr		:out   TSLV(II_ADDR_WIDTH-1 downto 0);
    II_out_data		:out   TSLV(II_DATA_WIDTH-1 downto 0);
    II_in_data		:in    TSLV(II_DATA_WIDTH-1 downto 0) := (others =>'0');
    --
    initN               :in    TSL := '1';
    ready               :out   TSL
  );
end UART_II;

architecture behaviour of UART_II is

  constant II_ADDR_NUM          :TN := SLVPartNum(II_ADDR_WIDTH,UART_BITS_NUM);
  constant II_DATA_NUM          :TN := SLVPartNum(II_DATA_WIDTH,UART_BITS_NUM);
  constant RX_DATA_NUM          :TN := SLVPartNum(II_ADDR_WIDTH+II_DATA_WIDTH,UART_BITS_NUM);
  constant BUS_OPER_COUNT       :TN := (BUS_OPER_WAIT_ns*CLOCK_kHz)/1000000;   
  constant OPER_STROBE_COUNT    :TN := (OPER_STROBE_WAIT_ns*CLOCK_kHz)/1000000;
  constant STROBE_COUNT         :TN := (STROBE_WAIT_ns*CLOCK_kHz)/1000000;     
  constant STROBE_OPER_COUNT    :TN := (STROBE_OPER_WAIT_ns*CLOCK_kHz)/1000000;
  constant OPER_BUS_COUNT       :TN := (OPER_BUS_WAIT_ns*CLOCK_kHz)/1000000;   
  --
  constant II_MEM_WRITE         :TN := 0;
  constant II_L1MEM_READ        :TN := 1;
  constant II_L2MEM_READ        :TN := 2;
  constant II_P1MEM_READ        :TN := 3;
  constant II_P2MEM_READ        :TN := 4;
  constant II_CHN_WRITE         :TN := 5;
  constant II_L1CHN_READ        :TN := 6;
  constant II_L2CHN_READ        :TN := 7;
  constant II_P1CHN_READ        :TN := 8;
  constant II_P2CHN_READ        :TN := 9;
  --
  signal   VecRxSig             :TSLV(UART_VEC_DATA_SIZE-1 downto 0);
  signal   VecRxNumSig          :TSLV(UART_VEC_NUM_SIZE-1 downto 0);
  signal   VecRxValSig          :TSL;
  signal   VecRxAckReg          :TSL;
  signal   VecTxEmptySig        :TSL;
  signal   VecTxReqReg          :TSL;
  signal   VecTxDataReg         :TSLV(UART_VEC_DATA_SIZE-1 downto 0);
  signal   VecTxNumReg          :TSLV(UART_VEC_NUM_SIZE-1 downto 0);
  signal   MemRxRunSig          :TSL;
  signal   MemRxDataSig         :TSLV(UART_BITS_NUM-1 downto 0);
  signal   MemRxValidSig        :TSL;
  signal   MemRxAckReg          :TSL;
  signal   MemTxReqReg          :TSL;
  signal   MemTxPartEnaReg      :TSL;
  signal   MemTxLongEnaReg      :TSL;
  signal   MemTxPartReg         :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   MemTxNumReg          :TSLV(UART_LONG_NUM_SIZE-1 downto 0);
  signal   MemTxDataReg         :TSLV(UART_BITS_NUM-1 downto 0);
  signal   MemTxGetSig          :TSL;
  signal   MemTxValidReg        :TSL;
  signal   MemTxEmptySig        :TSL;
  signal   MemAddrCnt           :TSLV(TVLcreate(II_ADDR_NUM-1)-1 downto 0);
  signal   MemDataCnt           :TSLV(TVLcreate(II_DATA_NUM-1)-1 downto 0);
  signal   MemPartCnt           :TSLV(TVLcreate(UART_LONG_NUM_BYTES-1)-1 downto 0);
  signal   MemNumCnt            :TSLV(TVLcreate(UART_LONG_NUM_BYTES-1)-1 downto 0);
  signal   InitNsig             :TSL;
  signal   ReadySig             :TSL;
  --
  type     T_PROT_STATE         is (PROT_IDLE, 
                                    PROT_VEC_WRITE,
                                    PROT_VEC_READ, PROT_VEC_SEND,
                                    PROT_MEM_WRITE_ADDR, PROT_MEM_WRITE_DATA,
                                    PROT_MEM_READ_PART, PROT_MEM_READ_NUM, PROT_MEM_READ_ADDR, PROT_MEM_READ_REQ, PROT_MEM_READ_DATA
                                   );
  signal   prot_state           :T_PROT_STATE;
  signal   ProtErrorReg         :TSL;
  type     T_II_STATE           is (II_IDLE,
                                    BUS_OPER_WAIT, OPER_STROBE_WAIT, STROBE_WAIT, STROBE_OPER_WAIT, OPER_BUS_WAIT,
                                    II_STOP
                                   );
  signal   ii_state             :T_II_STATE;
  signal   IIErrorReg           :TSL;
  signal   IIExecReg            :TSL;
  signal   IIwriteReg           :TSL;
  signal   IIoperReg            :TSL;
  signal   IIstrobeReg          :TSL;
  signal   IIstrobeGsig         :TSL;
  signal   IIaddrReg            :TSLV(II_ADDR_WIDTH-1 downto 0);
  signal   IIdataOutReg         :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   IIdataInReg          :TSLV(II_DATA_WIDTH-1 downto 0);
  signal   BusOperCnt           :TSLV(TVLcreate(BUS_OPER_COUNT)-1 downto 0);
  signal   OperStrobeCnt        :TSLV(TVLcreate(OPER_STROBE_COUNT)-1 downto 0);
  signal   StrobeCnt            :TSLV(TVLcreate(STROBE_COUNT)-1 downto 0);
  signal   StrobeOperCnt        :TSLV(TVLcreate(STROBE_OPER_COUNT)-1 downto 0);
  signal   OperBusCnt           :TSLV(TVLcreate(OPER_BUS_COUNT)-1 downto 0);
  signal   AddrIncReg           :TSLV(II_ADDR_WIDTH-1 downto 0);

begin

  ii_resetN <= resetN;
  --
  prot : process (clk, resetN)
  begin
    if (resetN='0')then
      ProtErrorReg    <= '0';
      VecRxAckReg     <= '0';
      VecTxReqReg     <= '0';
      VecTxDataReg    <= (others => '0');
      VecTxNumReg     <= (others => '0');
      MemRxAckReg     <= '0';
      MemTxReqReg     <= '0';
      MemTxPartEnaReg <= '0';
      MemTxLongEnaReg <= '0';
      MemTxPartReg    <= (others => '0');
      MemTxNumReg     <= (others => '0');
      MemTxDataReg    <= (others => '0');
      MemTxValidReg   <= '0';
      MemAddrCnt      <= (others => '0');
      MemDataCnt      <= (others => '0');
      MemPartCnt      <= (others => '0');
      MemNumCnt       <= (others => '0');
      IIExecReg       <= '0';
      IIwriteReg      <= '0';
      IIaddrReg       <= (others => '0');
      IIdataOutReg    <= (others => '0');
      AddrIncReg      <= (others => '0');
      prot_state      <= PROT_IDLE;
    elsif clk'event and clk = '1' then
      if (ReadySig='0') then
        prot_state  <= PROT_IDLE;
      else
        case prot_state is
          when PROT_IDLE =>
            VecRxAckReg     <= '0';
            VecTxNumReg     <= (others => '0');
            MemRxAckReg     <= '0';
            MemTxReqReg     <= '0';
            MemTxPartEnaReg <= '0';
            MemTxLongEnaReg <= '0';
            MemTxPartReg    <= (others => '0');
            MemTxNumReg     <= (others => '0');
            MemTxDataReg    <= (others => '0');
            MemTxValidReg   <= '0';
            MemAddrCnt      <= (others => '0');
            MemDataCnt      <= (others => '0');
            MemPartCnt      <= (others => '0');
            MemNumCnt       <= (others => '0');
            IIwriteReg      <= '0';
            IIaddrReg       <= (others => '0');
            IIdataOutReg    <= (others => '0');
            IIExecReg       <= '0';
            AddrIncReg      <= (others => '0');
            if (IIExecReg='0') then
              if (VecRxValSig='1') then
                IIaddrReg    <= VecRxSig(II_ADDR_WIDTH-1 downto 0);
                IIdataOutReg <= VecRxSig(II_ADDR_WIDTH+II_DATA_WIDTH-1 downto II_ADDR_WIDTH);
                if (VecRxNumSig=II_ADDR_NUM) then
                  IIwriteReg <= '0';
                  prot_state <= PROT_VEC_READ;
                elsif (VecRxNumSig=RX_DATA_NUM) then
                  IIwriteReg <= '1';
                  prot_state <= PROT_VEC_WRITE;
                else
                  ProtErrorReg <= '1';
                end if;
              elsif (MemRxRunSig='1' and MemRxValidSig='1') then
                if (MemRxDataSig=II_MEM_WRITE) then
                  AddrIncReg <= TSLVconv(1,AddrIncReg'length);
                  prot_state <= PROT_MEM_WRITE_ADDR;
                elsif (MemRxDataSig=II_L1MEM_READ) then
                  MemTxPartEnaReg <= '0';
                  MemTxLongEnaReg <= '0';
                  MemNumCnt       <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= (others=>'0');
                  AddrIncReg      <= TSLVconv(1,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_NUM;
                elsif (MemRxDataSig=II_L2MEM_READ) then
                  MemTxPartEnaReg <= '0';
                  MemTxLongEnaReg <= '1';
                  MemNumCnt       <= TSLVconv(UART_LONG_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= (others=>'0');
                  AddrIncReg      <= TSLVconv(1,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_NUM;
                elsif (MemRxDataSig=II_P1MEM_READ) then
                  MemTxPartEnaReg <= '1';
                  MemTxLongEnaReg <= '0';
                  MemNumCnt       <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemPartCnt'length);
                  AddrIncReg      <= TSLVconv(1,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_PART;
                elsif (MemRxDataSig=II_P2MEM_READ) then
                  MemTxPartEnaReg <= '1';
                  MemTxLongEnaReg <= '1';
                  MemNumCnt       <= TSLVconv(UART_LONG_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= TSLVconv(UART_LONG_NUM_BYTES-1,MemPartCnt'length);
                  AddrIncReg      <= TSLVconv(1,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_PART;
                elsif (MemRxDataSig=II_CHN_WRITE) then
                  AddrIncReg <= TSLVconv(0,AddrIncReg'length);
                  prot_state <= PROT_MEM_WRITE_ADDR;
                elsif (MemRxDataSig=II_L1CHN_READ) then
                  MemTxPartEnaReg <= '0';
                  MemTxLongEnaReg <= '0';
                  MemNumCnt       <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= (others=>'0');
                  AddrIncReg      <= TSLVconv(0,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_NUM;
                elsif (MemRxDataSig=II_L2CHN_READ) then
                  MemTxPartEnaReg <= '0';
                  MemTxLongEnaReg <= '1';
                  MemNumCnt       <= TSLVconv(UART_LONG_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= (others=>'0');
                  AddrIncReg      <= TSLVconv(0,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_NUM;
                elsif (MemRxDataSig=II_P1CHN_READ) then
                  MemTxPartEnaReg <= '1';
                  MemTxLongEnaReg <= '0';
                  MemNumCnt       <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= TSLVconv(UART_SHORT_NUM_BYTES-1,MemPartCnt'length);
                  AddrIncReg      <= TSLVconv(0,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_PART;
                elsif (MemRxDataSig=II_P2CHN_READ) then
                  MemTxPartEnaReg <= '1';
                  MemTxLongEnaReg <= '1';
                  MemNumCnt       <= TSLVconv(UART_LONG_NUM_BYTES-1,MemAddrCnt'length);
                  MemPartCnt      <= TSLVconv(UART_LONG_NUM_BYTES-1,MemPartCnt'length);
                  AddrIncReg      <= TSLVconv(0,AddrIncReg'length);
                  prot_state      <= PROT_MEM_READ_PART;
                else
                  ProtErrorReg <= '1';
                end if;
              end if;
            end if;
          --
          --
          when PROT_VEC_WRITE => 
            IIExecReg <= '1';
            if (ii_state=II_STOP) then
              IIExecReg   <= '0';
              VecRxAckReg <= '1';
              prot_state  <= PROT_IDLE;
            end if;
          --
          --
          when PROT_VEC_READ => 
            IIExecReg <= '1';
            if (ii_state=II_STOP) then
              IIExecReg   <= '0';
              VecRxAckReg <= '1';
              VecTxReqReg <= '1';
              VecTxNumReg <= TSLVconv(II_DATA_NUM,VecTxNumReg'length);
              VecTxDataReg(IIdataInReg'length-1 downto 0) <= IIdataInReg;
              prot_state  <= PROT_VEC_SEND;
            end if;
          when PROT_VEC_SEND => 
            if (VecTxReqReg='1' and VecTxEmptySig='0') then
              VecTxReqReg <= '0';
            elsif (VecTxReqReg='0' and VecTxEmptySig='1') then
              prot_state <= PROT_IDLE;
            end if;
          --
          --
          when PROT_MEM_WRITE_ADDR => 
            if (MemRxRunSig='1') then
              if (MemRxValidSig='1') then
                MemAddrCnt <= MemAddrCnt + 1;
                IIaddrReg  <= TSLVsh2h(IIaddrReg,MemRxDataSig);
                if(MemAddrCnt=II_ADDR_NUM-1) then
                  IIwriteReg <= '1';
                  prot_state <= PROT_MEM_WRITE_DATA;
                end if;
              end if;
            else
              ProtErrorReg <= '1';
            end if;
          when PROT_MEM_WRITE_DATA => 
            if (IIExecReg='1' and ii_state=II_STOP) then
              IIExecReg   <= '0';
              MemRxAckReg <= '1';
              IIaddrReg   <= IIaddrReg + AddrIncReg;
            end if;
            if (MemRxRunSig='1') then
              if (MemRxValidSig='1') then
                MemRxAckReg  <= '0';
                MemDataCnt   <= MemDataCnt + 1;
                IIdataOutReg <= TSLVsh2h(IIdataOutReg,MemRxDataSig);
                if (MemDataCnt=II_DATA_NUM-1) then
                  MemDataCnt  <= (others => '0');
                  if (ii_state=II_IDLE) then
                    IIExecReg <= '1';
                  else
                    ProtErrorReg <= '1';
                  end if;
                end if;
              end if;
            elsif (MemRxAckReg='1') then
              prot_state  <= PROT_IDLE;
            else
              ProtErrorReg <= '1';
            end if;
          --
          --
          when PROT_MEM_READ_PART => 
            if (MemRxRunSig='1') then
              if (MemRxValidSig='1') then
                MemPartCnt   <= MemPartCnt - 1;
                MemTxPartReg <= TSLVsh2h(MemTxPartReg,MemRxDataSig);
                if(MemPartCnt=0) then
                  prot_state <= PROT_MEM_READ_NUM;
                end if;
              end if;
            else
              ProtErrorReg <= '1';
            end if;
          when PROT_MEM_READ_NUM => 
            if (MemRxRunSig='1') then
              if (MemRxValidSig='1') then
                MemNumCnt   <= MemNumCnt - 1;
                MemTxNumReg <= TSLVsh2h(MemTxNumReg,MemRxDataSig);
                if(MemNumCnt=0) then
                  prot_state <= PROT_MEM_READ_ADDR;
                end if;
              end if;
            else
              ProtErrorReg <= '1';
            end if;
          when PROT_MEM_READ_ADDR => 
            if (MemRxRunSig='1') then
              if (MemRxValidSig='1') then
                MemAddrCnt <= MemAddrCnt + 1;
                IIaddrReg  <= TSLVsh2h(IIaddrReg,MemRxDataSig);
                if(MemAddrCnt=II_ADDR_NUM-1) then
                  MemAddrCnt <= (others => '0');
                  prot_state <= PROT_MEM_READ_REQ;
                end if;
              end if;
            else
              ProtErrorReg <= '1';
            end if;
          when PROT_MEM_READ_REQ => 
            MemRxAckReg     <= '1';
            MemTxReqReg     <= '1';
            if (MemRxRunSig='0') then
              MemRxAckReg <= '0';
              prot_state  <= PROT_MEM_READ_DATA;
            end if;
          when PROT_MEM_READ_DATA =>
            if (MemTxEmptySig='1' and MemTxReqReg='0') then
              if (MemTxValidReg='0') then
                if (MemTxPartReg/=0) then
                  MemTxPartReg <= MemTxPartReg - 1;
                  MemTxReqReg  <= '1';
                else
                  prot_state <= PROT_IDLE;
                end if;
              else
                ProtErrorReg <= '1';
              end if;                    
            elsif (IIExecReg='0' and ii_state=II_IDLE and MemTxValidReg='0') then
              IIExecReg <= '1';
            end if;
            if (IIExecReg='1' and ii_state=II_STOP) then
              VecTxDataReg(IIdataInReg'length-1 downto 0) <= IIdataInReg;
              IIaddrReg  <= IIaddrReg + AddrIncReg;
              IIExecReg  <= '0';
              MemDataCnt <= (others => '0');
              MemTxValidReg <= '1';
            elsif (MemTxValidReg='1') then
              MemTxDataReg  <= VecTxDataReg(UART_BITS_NUM-1 downto 0);
              if (MemTxGetSig='1') then
                MemTxReqReg <= '0';
                MemDataCnt  <= MemDataCnt + 1;
                VecTxDataReg(UART_VEC_DATA_SIZE-UART_BITS_NUM-1 downto 0) <= VecTxDataReg(UART_VEC_DATA_SIZE-1 downto UART_BITS_NUM);
                if (MemDataCnt=II_DATA_NUM-1) then
                  MemTxValidReg <= '0';
                end if;
              end if;
            end if;
          --
          --
          when others =>
            ProtErrorReg <= '1';
        end case;
      end if;
    end if;
  end process prot;
  --
  ii : process (clk, resetN)
  begin
    if (resetN='0')then
      IIErrorReg    <= '0';
      IIoperReg     <= '0';
      IIstrobeReg   <= '0';
      IIdataInReg   <= (others => '0');
      BusOperCnt    <= (others => '0');
      OperStrobeCnt <= (others => '0');
      StrobeCnt     <= (others => '0');
      StrobeOperCnt <= (others => '0');
      OperBusCnt    <= (others => '0');
      ii_state      <= II_IDLE;
    elsif clk'event and clk = '1' then
      if (ReadySig='0') then
        ii_state  <= II_IDLE;
      else
        case ii_state is
          when II_IDLE =>
            IIoperReg     <= '0';
            IIstrobeReg   <= '0';
            BusOperCnt    <= TSLVconv(BUS_OPER_COUNT,   BusOperCnt'length);
            OperStrobeCnt <= TSLVconv(OPER_STROBE_COUNT,OperStrobeCnt'length);
            StrobeCnt     <= TSLVconv(STROBE_COUNT,     StrobeCnt'length);
            StrobeOperCnt <= TSLVconv(STROBE_OPER_COUNT,StrobeOperCnt'length);
            OperBusCnt    <= TSLVconv(OPER_BUS_COUNT,   OperBusCnt'length);
            if (IIExecReg='1') then
              ii_state  <= BUS_OPER_WAIT;
            end if;
          when BUS_OPER_WAIT =>
            if (BusOperCnt/=0) then
              BusOperCnt <= BusOperCnt - 1;
            else
              IIoperReg <= '1';
              ii_state  <= OPER_STROBE_WAIT;
            end if;
          when OPER_STROBE_WAIT =>
            if (OperStrobeCnt/=0) then
              OperStrobeCnt <= OperStrobeCnt - 1;
            else
              IIstrobeReg <= '1';
              ii_state    <= STROBE_WAIT;
            end if;
          when STROBE_WAIT =>
            if (StrobeCnt/=0) then
              StrobeCnt <= StrobeCnt - 1;
            else
              IIdataInReg <= II_in_data;
              IIstrobeReg <= '0';
              ii_state    <= STROBE_OPER_WAIT;
            end if;
          when STROBE_OPER_WAIT =>
            if (StrobeOperCnt/=0) then
              StrobeOperCnt <= StrobeOperCnt - 1;
            else
              IIoperReg <= '0';
              ii_state  <= OPER_BUS_WAIT;
            end if;
          when OPER_BUS_WAIT =>
            if (OperBusCnt/=0) then
              OperBusCnt <= OperBusCnt - 1;
            else
              ii_state <= II_STOP;
            end if;
          when II_STOP =>
            if (IIExecReg='0') then
              ii_state <= II_IDLE;
            end if;
          when others =>
            IIErrorReg <= '1';
        end case;
      end if;
    end if;
  end process ii;
  --
  bufG_ii_strobeNG: UT_GLOBAL port map (i => IIstrobeReg, o => IIstrobeGSig);
  II_operN    <= not(IIoperReg);
  II_writeN   <= not(IIwriteReg);
  II_strobeN  <= not(IIstrobeReg);
  II_addr     <= IIaddrReg;
  II_out_data <= IIdataOutReg;
  --
  InitNsig <= not(IIErrorReg or ProtErrorReg);
  uart :UART_prot_client
    generic map (
      CLOCK_kHz		  => CLOCK_kHz,
      MIN_BAUD_Hz         => MIN_BAUD_Hz,
      SYNCH_COUNT         => SYNCH_COUNT,
      SEND_BOUD_DELAY	  => SEND_BOUD_DELAY
    )
    port map (
      resetN              => resetN,
      clk                 => clk,
      --
      CTS_P               => CTS_P,
      RTS_p               => RTS_p,    
      RX_p                => RX_p,
      TX_p                => TX_p,
      --
      CTS_c               => CTS_c,
      RTS_c               => RTS_c,    
      RX_c                => RX_c,
      TX_c                => TX_c,
      --
      chain_id            => chain_id,
      chain_first         => chain_first,
      chain_last          => chain_last,
      --
      vec_rx_data         => VecRxSig,
      vec_rx_num          => VecRxNumSig,
      vec_rx_valid        => VecRxValSig,
      vec_rx_ack          => VecRxAckReg,
      --
      vec_tx_req          => VecTxReqReg,
      vec_tx_ext_ena      => '0',
      vec_tx_empty        => VecTxEmptySig,
      vec_tx_data         => VecTxDataReg,
      vec_tx_num          => VecTxNumReg,
      --
      mem_rx_run          => MemRxRunSig,
      mem_rx_data         => MemRxDataSig,
      mem_rx_valid        => MemRxValidSig,
      mem_rx_ack          => MemRxAckReg,
      --
      mem_tx_req          => MemTxReqReg,
      mem_tx_part_ena     => MemTxPartEnaReg,
      mem_tx_long_ena     => MemTxLongEnaReg,
      mem_tx_part         => MemTxPartReg,
      mem_tx_num          => MemTxNumReg,
      mem_tx_data         => MemTxDataReg,
      mem_tx_get          => MemTxGetSig,
      mem_tx_valid        => MemTxValidReg,
      mem_tx_empty        => MemTxEmptySig,
      --
      initN               => InitNsig,
      ready               => ReadySig
    );
  --  
  ready <= ReadySig;

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_II5A8D is
  generic (
    CLOCK_kHz                         :in    TN := 62500;
    MIN_BAUD_Hz                       :in    TN := 9600;
    SYNCH_COUNT                       :in    TN := 16;
    SEND_BOUD_DELAY                   :in    TN := 5;
    BUS_OPER_WAIT_ns                  :in    TN := 10;
    OPER_STROBE_WAIT_ns               :in    TN := 25;
    STROBE_WAIT_ns                    :in    TN := 100;
    STROBE_OPER_WAIT_ns               :in    TN := 25;
    OPER_BUS_WAIT_ns                  :in    TN := 10
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    -- UART
    CTS                               :in    TSL;
    RTS                               :out   TSL;
    RX                                :in    TSL;
    TX                                :out   TSL;
    -- internal interface bus
    II_resetN                         :out   TSL;
    II_operN                          :out   TSL;
    II_writeN                         :out   TSL;
    II_strobeN                        :out   TSL;
    II_addr                           :out   TSLV(4 downto 0);
    II_out_data                       :out   TSLV(7 downto 0);
    II_in_data                        :in    TSLV(7 downto 0) := (others =>'0');
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_II5A8D;

architecture behaviour of UART_II5A8D is
  --
  signal   RXdataSig            :TSLV(UART_BITS_NUM-1 downto 0);
  signal   RXrecSig             :TSL;
  signal   TXdataReg            :TSLV(UART_BITS_NUM-1 downto 0);
  signal   TXsendReg            :TSL;
  signal   TXemptySig           :TSL;
  signal   UARTreadySig         :TSL;
  signal   initNSig             :TSL;
  signal   ReadyReg             :TSL;
  --
  constant PROT_OK              :TSLV(UART_BITS_NUM/2-1 downto 0) := "0101";
  constant PROT_DATA            :TSLV(UART_BITS_NUM/2-1 downto 0) := "1010";
  constant PROT_ERR             :TSLV(UART_BITS_NUM/2-1 downto 0) := "1111";
  --
  function CheckSum(c,a,d: TSLV) return TSLV is
    variable cL                 :TSLV(UART_BITS_NUM/2-1 downto 0) := c;
    variable aL                 :TSLV(UART_BITS_NUM/2-1 downto 0) := a(a'length-2 downto 0);
    variable aH                 :TSLV(UART_BITS_NUM/2-1 downto 0) := "000" & a(a'length-1);
    variable dL                 :TSLV(UART_BITS_NUM/2-1 downto 0) := d(d'length/2-1 downto 0);
    variable dH                 :TSLV(UART_BITS_NUM/2-1 downto 0) := d(d'length-1 downto d'length/2);
    variable xorVar             :TSLV(UART_BITS_NUM/2-1 downto 0);
    variable sumVar             :TSLV(UART_BITS_NUM/2-1 downto 0);
  begin
    cL     := c;
    aL     := a(a'length-2 downto 0);
    aH     := "000" & a(a'length-1);
    dL     := d(d'length/2-1 downto 0);
    dH     := d(d'length-1 downto d'length/2);
    xorVar := cL xor((aL xor aH) xor (dL xor dH));
    sumVar := cL + aL + aH + dL + dH;
    return(xorVar xor sumVar);
  end function;
  --
  type     T_II_STATE           is (RS_IDLE, RS_TEST, RX_ADDR, RX_DATA,
                                    BUS_OPER_WAIT, OPER_STROBE_WAIT, STROBE_WAIT, STROBE_OPER_WAIT, OPER_BUS_WAIT,
                                    TX_ACK, TX_DATA1, TX_DATA2, RS_ERROR
                                   );
  signal   ii_state             :T_II_STATE;
  signal   IIwriteReg           :TSL;
  signal   IIoperReg            :TSL;
  signal   IIstrobeReg          :TSL;
  signal   IIstrobeGsig         :TSL;
  signal   IIaddrReg            :TSLV(II_addr'range);
  signal   IIdataOutReg         :TSLV(II_out_data'range);
  signal   IIdataInReg          :TSLV(II_in_data'range);
  constant BUS_OPER_COUNT       :TN := (BUS_OPER_WAIT_ns*CLOCK_kHz)/1000000;   
  constant OPER_STROBE_COUNT    :TN := (OPER_STROBE_WAIT_ns*CLOCK_kHz)/1000000;
  constant STROBE_COUNT         :TN := (STROBE_WAIT_ns*CLOCK_kHz)/1000000;     
  constant STROBE_OPER_COUNT    :TN := (STROBE_OPER_WAIT_ns*CLOCK_kHz)/1000000;
  constant OPER_BUS_COUNT       :TN := (OPER_BUS_WAIT_ns*CLOCK_kHz)/1000000;   
  signal   BusOperCnt           :TSLV(TVLcreate(BUS_OPER_COUNT)-1 downto 0);
  signal   OperStrobeCnt        :TSLV(TVLcreate(OPER_STROBE_COUNT)-1 downto 0);
  signal   StrobeCnt            :TSLV(TVLcreate(STROBE_COUNT)-1 downto 0);
  signal   StrobeOperCnt        :TSLV(TVLcreate(STROBE_OPER_COUNT)-1 downto 0);
  signal   OperBusCnt           :TSLV(TVLcreate(OPER_BUS_COUNT)-1 downto 0);
  signal   AddrIncReg           :TSLV(II_addr'range);

begin

  ii : process (clk, resetN)
  begin
    if (resetN='0')then
      ReadyReg      <= '0';
      IIwriteReg    <= '0';
      IIaddrReg     <= (others => '0');
      IIdataOutReg  <= (others => '0');
      IIoperReg     <= '0';
      IIstrobeReg   <= '0';
      IIdataInReg   <= (others => '0');
      BusOperCnt    <= (others => '0');
      OperStrobeCnt <= (others => '0');
      StrobeCnt     <= (others => '0');
      StrobeOperCnt <= (others => '0');
      OperBusCnt    <= (others => '0');
      ii_state      <= RS_IDLE;
    elsif clk'event and clk = '1' then
      if (UARTreadySig='0') then
        ReadyReg      <= '0';
        IIwriteReg    <= '0';
        IIaddrReg     <= (others => '0');
        IIdataOutReg  <= (others => '0');
        IIoperReg     <= '0';
        IIstrobeReg   <= '0';
        IIdataInReg   <= (others => '0');
        BusOperCnt    <= (others => '0');
        OperStrobeCnt <= (others => '0');
        StrobeCnt     <= (others => '0');
        StrobeOperCnt <= (others => '0');
        OperBusCnt    <= (others => '0');
        ii_state      <= RS_IDLE;
      else
        TXsendReg <= '0';
        case ii_state is
          when RS_IDLE =>
            if (UARTreadySig='1') then
              ii_state <= RS_TEST;
            end if;
          when RS_TEST =>
            TXdataReg <= not(RXdataSig);
            TXsendReg <= RXrecSig;
            if(RXrecSig='1' and RXdataSig=0) then
              TXdataReg <= RXdataSig;
              ReadyReg <= '1';
              ii_state <= RX_ADDR;
            end if;
          when RX_ADDR =>
            IIoperReg     <= '0';
            IIstrobeReg   <= '0';
            IIwriteReg    <= '0';
            IIdataOutReg  <= (others => '0');
            IIaddrReg     <= (others => '0');
            BusOperCnt    <= TSLVconv(BUS_OPER_COUNT,   BusOperCnt'length);
            OperStrobeCnt <= TSLVconv(OPER_STROBE_COUNT,OperStrobeCnt'length);
            StrobeCnt     <= TSLVconv(STROBE_COUNT,     StrobeCnt'length);
            StrobeOperCnt <= TSLVconv(STROBE_OPER_COUNT,StrobeOperCnt'length);
            OperBusCnt    <= TSLVconv(OPER_BUS_COUNT,   OperBusCnt'length);
            if (RXrecSig='1') then
              if (RXdataSig(7) = '0') then
                IIwriteReg      <= RXdataSig(6);
                IIaddrReg       <= RXdataSig(5 downto 1);
                IIdataOutReg(7) <= RXdataSig(0);
                if (RXdataSig(6)='1') then
                  ii_state  <= RX_DATA;
                else
                  ii_state  <= BUS_OPER_WAIT;
                end if;
              else
                ii_state <= RS_ERROR;
              end if;
            end if;
          when RX_DATA =>
            if (RXrecSig='1') then
              if (RXdataSig(7) = '1') then
                IIdataOutReg(6 downto 0) <= RXdataSig(6 downto 0);
                ii_state  <= BUS_OPER_WAIT;
              else
                ii_state <= RS_ERROR;
              end if;
            end if;
          when BUS_OPER_WAIT =>
            if (BusOperCnt/=0) then
              BusOperCnt <= BusOperCnt - 1;
            else
              IIoperReg <= '1';
              ii_state  <= OPER_STROBE_WAIT;
            end if;
          when OPER_STROBE_WAIT =>
            if (OperStrobeCnt/=0) then
              OperStrobeCnt <= OperStrobeCnt - 1;
            else
              IIstrobeReg <= '1';
              ii_state    <= STROBE_WAIT;
            end if;
          when STROBE_WAIT =>
            if (StrobeCnt/=0) then
              StrobeCnt <= StrobeCnt - 1;
            else
              IIdataInReg <= II_in_data;
              IIstrobeReg <= '0';
              ii_state    <= STROBE_OPER_WAIT;
            end if;
          when STROBE_OPER_WAIT =>
            if (StrobeOperCnt/=0) then
              StrobeOperCnt <= StrobeOperCnt - 1;
            else
              IIoperReg <= '0';
              ii_state  <= OPER_BUS_WAIT;
            end if;
          when OPER_BUS_WAIT =>
            if (OperBusCnt/=0) then
              OperBusCnt <= OperBusCnt - 1;
            else
              if (IIwriteReg='0') then
                ii_state <= TX_DATA1;
              else
                ii_state <= TX_ACK;
              end if;
            end if;
          when TX_ACK =>
            if (TXsendReg='1') then
              TXsendReg  <= '0';
              IIwriteReg <= '0';
              ii_state <= RX_ADDR;
            elsif (TXemptySig='1') then
              TXdataReg <= PROT_OK & CheckSum(PROT_OK,IIaddrReg,IIdataOutReg);
              TXsendReg <= '1';
            end if;
          when TX_DATA1 =>
            if (TXsendReg='1') then
              TXsendReg <= '0';
              ii_state <= TX_DATA2;
            elsif (TXemptySig='1') then
              TXdataReg <= PROT_DATA & IIdataInReg(3 downto 0);
              TXsendReg <= '1';
            end if;
          when TX_DATA2 =>
            if (TXsendReg='1') then
              TXsendReg <= '0';
              ii_state <= RX_ADDR;
            elsif (TXemptySig='1') then
              TXdataReg <= CheckSum(PROT_DATA,IIaddrReg,IIdataInReg) & IIdataInReg(7 downto 4);
              TXsendReg <= '1';
            end if;
          when RS_ERROR =>
            if (TXsendReg='1') then
              TXsendReg <= '0';
              ii_state  <= RS_IDLE;
            elsif (TXemptySig='1') then
              TXdataReg <= PROT_ERR & TSLVconv(0,TXdataReg'length/2);
              TXsendReg <= '1';
            end if;
          when others =>
              ii_state <= RS_ERROR;
        end case;
      end if;
    end if;
  end process ii;
  --
  ready <= ReadyReg;
  --
  II_resetN   <= resetN;
  bufG_ii_strobeNG: UT_GLOBAL port map (i => IIstrobeReg, o => IIstrobeGSig);
  II_operN    <= not(IIoperReg);
  II_writeN   <= not(IIwriteReg);
  II_strobeN  <= not(IIstrobeReg);
  II_addr     <= IIaddrReg;
  II_out_data <= IIdataOutReg;
  --
  initNSig <= initN and TSLconv(ii_state/=RS_ERROR);
  uart :UART_client
    generic map(
      CLOCK_KHz		=> CLOCK_KHz,
      MIN_BAUD_Hz       => MIN_BAUD_Hz,
      SYNCH_COUNT	=> SYNCH_COUNT,
      SEND_BOUD_DELAY	=> SEND_BOUD_DELAY
    )
    port map (
      resetN            => resetN,
      clk               => clk,
      --
      CTS               => CTS,
      RTS		=> RTS,
      RX                => RX,
      TX                => TX,
      --
      RXdata            => RXdataSig,
      RXrec             => RXrecSig,
      TXdata            => TXdataReg,
      TXsend            => TXsendReg,
      TXempty           => TXemptySig,
      --
      initN             => initNSig,
      ready             => UARTreadySig,
      active            => '1'
    );

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_iclient is
  generic (
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    DATA_SIZE                         :in    TN := 16;
    SEND_BOUD_DELAY                   :in    TN := 5
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSL;
    TX                                :out   TSL;
    --
    RXdata                            :out   TSLV(DATA_SIZE-1 downto 0);
    RXlen                             :in    TSLV(TVLcreate(DATA_SIZE-1)-1 downto 0);
    RXrec                             :out   TSL;
    TXdata                            :in    TSLV(DATA_SIZE-1 downto 0);
    TXlen                             :in    TSLV(TVLcreate(DATA_SIZE-1)-1 downto 0);
    TXsend                            :in    TSL;
    TXempty                           :out   TSL;
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_iclient;

architecture behaviour of UART_iclient is

  constant BAUD_SIZE            :TN := CLOCK_kHz/BAUD_kHz;
  signal   ReadyReg             :TSL;
  --
  signal   RXregD2              :TSL;
  signal   RXregD1              :TSL;
  signal   RXreg                :TSL;
  signal   StartReg             :TSL;
  --
  type     TUARTrx              is (UART_RX_IDLE, UART_RX_REC, UART_RX_DATA, UART_RX_ERROR);
  signal   UARTrx               :TUARTrx;
  signal   RXlenReg             :TSLV(TVLcreate(DATA_SIZE-1)-1 downto 0);
  signal   RXfifo               :TSLV(DATA_SIZE-1 downto 0);
  signal   RXvalid              :TSL;
  signal   RXstart              :TSL;
  signal   RXbitLenCnt          :TSLV(TVLcreate(BAUD_SIZE-1)-1 downto 0);
  signal   RXbitNumCnt          :TSLV(TVLcreate(2+DATA_SIZE-1)-1 downto 0);
  signal   RxResetCnt           :TSLV(TVLcreate(2*BAUD_SIZE*DATA_SIZE)-1 downto 0);
  --
  type     TUARTtx              is (UART_TX_IDLE, UART_TX_SEND, UART_TX_STOP, UART_TX_WAIT);
  signal   UARTtx               :TUARTtx;
  signal   TXreg                :TSL;
  signal   TXfifo               :TSLV(DATA_SIZE-1 downto 0);
  signal   TXbusy               :TSL;
  signal   TXbitLenCnt          :TSLV(TVLcreate(BAUD_SIZE-1)-1 downto 0);
  signal   TXbitNumCnt          :TSLV(TVLcreate(DATA_SIZE)-1 downto 0);
  signal   TXDelayCnt           :TSLV(TVLcreate(SEND_BOUD_DELAY)-1 downto 0);
  signal   TxResetCnt           :TSLV(TVLcreate(3*BAUD_SIZE*DATA_SIZE)-1 downto 0);

begin

  reg_in: process (resetN, clk)
  begin
    if resetN = '0' then
      RXregD2  <= '0';
      RXregD1  <= '0';
      RXreg    <= '0';
      StartReg <= '0';
    elsif clk'event and clk = '1' then
      RXregD2  <= TSLconv(RX/='0');
      RXregD1  <= RXregD2;
      RXreg    <= RXregD1;
      StartReg <= not(RXregD2) and RXregD1;
    end if;
  end process;
  --
  uart_rx: process (resetN, clk)
  begin
    if resetN = '0' then
      ReadyReg    <= '0';
      RXlenReg    <= (others =>'0');
      RXfifo      <= (others =>'0');
      RXvalid     <='0';
      RXstart     <= '0';
      RXbitLenCnt <= (others =>'0');
      RXbitNumCnt <= (others =>'0');
      RxResetCnt  <= (others =>'0');
      UARTrx      <= UART_RX_IDLE;
    elsif clk'event and clk = '1' then
      if (RXreg='1') then
        RxResetCnt <= (others =>'0');
      else
        RxResetCnt <= RxResetCnt + 1;
      end if;
      if (InitN='0' or UARTrx=UART_RX_ERROR or RxResetCnt=2*BAUD_SIZE*DATA_SIZE) then
        UARTrx   <= UART_RX_ERROR;
        ReadyReg <= '0';
        if (RXreg='1') then
          UARTrx   <= UART_RX_IDLE;
        end if;
      else
        ReadyReg <= '1';
        case UARTrx is
          when UART_RX_IDLE =>
            RXfifo      <= (others =>'0');
            RXvalid     <= '0';
            RXbitLenCnt <= TSLVconv(BAUD_SIZE-1,RXbitLenCnt'length);
            RXbitNumCnt <= TSLVconv(2+TNconv(RXlen),RXbitNumCnt'length);
            RXlenReg    <= RXlen;
            if (StartReg='1') then
              UARTrx <= UART_RX_REC;
            end if;
          when UART_RX_REC =>
            if (RXbitLenCnt/=0 or BAUD_SIZE=1) then
              RXbitLenCnt <= sel(RXbitLenCnt-1,RXbitLenCnt,BAUD_SIZE>1);
              if (RXbitLenCnt=BAUD_SIZE/2) then
                if (RXbitNumCnt/=0) then
                  RXfifo(RXfifo'length-2 downto 0) <= RXfifo(RXfifo'length-1 downto 1);
                  RXstart <= RXfifo(0);
                  RXfifo(TNconv(RXlenReg)) <= RXreg;
                  RXbitNumCnt <= RXbitNumCnt-1;
                else
                  if (RXstart='0' and RXreg='1') then
                    UARTrx <= UART_RX_DATA;
                  else
                    UARTrx <= UART_RX_ERROR;
                  end if;
                end if;
              end if;
            else
              RXbitLenCnt <= TSLVconv(BAUD_SIZE-1,RXbitLenCnt'length);
            end if;
          when UART_RX_DATA =>
            if (TXbusy='0') then
              RXvalid <= '1';
              UARTrx  <= UART_RX_IDLE;
            end if;
          when UART_RX_ERROR =>
            UARTrx   <= UART_RX_ERROR;
            ReadyReg <= '0';
          when others =>
            UARTrx   <= UART_RX_ERROR;
            ReadyReg <= '0';
        end case;
      end if;
    end if;
  end process;
  
  Ready  <= ReadyReg;
  RXdata <= RXfifo;
  RXrec  <= RXvalid;

  uart_tx: process (resetN, clk)
  begin
    if resetN = '0' then
      TXreg       <= '0';
      TXfifo      <= (others =>'0');
      TXbusy      <='0';
      TXbitLenCnt <= (others =>'0');
      TXbitNumCnt <= (others =>'0');
      TXDelayCnt  <= (others =>'0');
      TxResetCnt  <= (others =>'0');
      UARTtx      <= UART_TX_IDLE;
    elsif clk'event and clk = '1' then
      if (InitN='0') then
        TXreg      <= '0';
        TxResetCnt <= TSLVconv(3*BAUD_SIZE*DATA_SIZE,TxResetCnt'length);
      elsif (TxResetCnt/=0) then
        TXreg      <= '0';
        TxResetCnt <= TxResetCnt - 1;
      elsif (ReadyReg='0') then
        TXreg  <= '1';
        UARTtx <= UART_TX_IDLE;
      else
        case UARTtx is
          when UART_TX_IDLE =>
            TXreg       <= '1';
            TXfifo      <= (others =>'0');
            TXbitLenCnt <= TSLVconv(BAUD_SIZE-1,TXbitLenCnt'length);
            TXbitNumCnt <= TSLVconv(minimum(1+TNconv(TXlen),DATA_SIZE),TXbitNumCnt'length);
            TXbusy      <= TXsend;
            if (TXsend='1') then
              TXfifo <= TXdata;
              UARTtx <= UART_TX_SEND;
              TXreg <= '0';
            end if;
          when UART_TX_SEND =>
            if (TXbitLenCnt/=0) then
              TXbitLenCnt <= TXbitLenCnt-1;
            else
              TXbitLenCnt <= TSLVconv(BAUD_SIZE-1,TXbitLenCnt'length);
              TXbitNumCnt <= TXbitNumCnt-1;
              TXfifo(TXfifo'length-2 downto 0) <= TXfifo(TXfifo'length-1 downto 1);
              if (TXbitNumCnt=0) then
                TXreg  <= '1';
                UARTtx <= UART_TX_STOP;
              else
                TXreg <= TXfifo(0);
              end if;
            end if;
          when UART_TX_STOP =>
            if (TXbitLenCnt/=0) then
              TXbitLenCnt <= TXbitLenCnt-1;
            else
              TXbitLenCnt <= TSLVconv(BAUD_SIZE-1,TXbitLenCnt'length);
              TXDelayCnt  <= TSLVconv(SEND_BOUD_DELAY,TXDelayCnt'length);
              UARTtx      <= UART_TX_WAIT;
            end if;
          when UART_TX_WAIT =>
            if (TXDelayCnt/=0) then
              if (TXbitLenCnt/=0) then
                TXbitLenCnt <= TXbitLenCnt-1;
              else
                TXbitLenCnt <= TSLVconv(BAUD_SIZE-1,TXbitLenCnt'length);
                TXDelayCnt  <= TXDelayCnt-1;
              end if;
            else
              UARTtx <= UART_TX_IDLE;
            end if;
          when others =>
            UARTtx <= UART_TX_IDLE;
        end case;
      end if;
    end if;
  end process;
  
  TX      <= TXreg;
  TXempty <= not(TXbusy);

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_inode is
  generic (
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    ADDR_SIZE                         :in    TN := 16;
    DATA_SIZE                         :in    TN := 16;
    BUF_SIZE                          :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSL;
    TX                                :out   TSL;
    --
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    addr                              :out   TSLV(ADDR_SIZE-1 downto 0);
    data_next                         :out   TSL;
    data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
    data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
    write                             :out   TSL;
    read                              :out   TSL;
    ack                               :in    TSL;
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_inode;

architecture behaviour of UART_inode is

  constant UART_DATA_SIZE :TN := maximum(ID_SIZE+BUF_SIZE+ADDR_SIZE+1,DATA_SIZE+UART_INODE_CHECK_SUM_SIZE)+1;
  --
  type     T_DRV_STATE    is (DRV_ADDR, DRV_DATA_WRITE, DRV_ACK_WRITE, DRV_DATA_READ, DRV_ACK_READ, DRV_ERROR);
  signal   drv_state      :T_DRV_STATE;
  --
  signal   RXdataSig      :TSLV(UART_DATA_SIZE-1 downto 0);
  signal   RXdataReg      :TSLV(ID_SIZE+BUF_SIZE+ADDR_SIZE+1 downto 0);
  signal   RXlenReg       :TSLV(TVLcreate(UART_DATA_SIZE-1)-1 downto 0);
  signal   RXrecSig       :TSL;
  signal   TXdataReg      :TSLV(UART_DATA_SIZE-1 downto 0);
  signal   TXlenReg       :TSLV(TVLcreate(UART_DATA_SIZE-1)-1 downto 0);
  signal   TXsendReg      :TSL;
  signal   TXemptySig     :TSL;
  signal   ReadySig       :TSL;
  signal   ReadyReg       :TSL;
  signal   IdReg          :TSLV(maximum(ID_SIZE,1)-1 downto 0);
  signal   BufReg         :TSLV(maximum(BUF_SIZE,1)-1 downto 0);
  signal   AddrReg        :TSLV(ADDR_SIZE-1 downto 0);
  signal   TotalSumReg    :TSLV(UART_INODE_CHECK_SUM_SIZE-1 downto 0);
  signal   DataNextReg    :TSL;
  signal   DataOutReg     :TSLV(DATA_SIZE-1 downto 0);
  signal   DataInReg      :TSLV(DATA_SIZE-1 downto 0);
  signal   WriteReg       :TSL;
  signal   ReadReg        :TSL;
  signal   AckReg         :TSL;

begin

  drv : process (clk, resetN)
  begin
    if (resetN='0')then
      RXdataReg     <= (others => '0');
      RXlenReg      <= (others => '0');
      TXdataReg     <= (others => '0');
      TXlenReg      <= (others => '0');
      TXsendReg     <= '0';
      ReadyReg      <= '0';
      IdReg         <= (others => '0');
      BufReg        <= (others => '0');
      AddrReg       <= (others => '0');
      TotalSumReg   <= (others => '0');
      DataOutReg    <= (others => '0');
      DataInReg     <= (others => '0');
      WriteReg      <= '0';
      ReadReg       <= '0';
      AckReg        <= '0';
      drv_state     <= DRV_ADDR;
    elsif clk'event and clk = '1' then
      WriteReg    <= '0';
      ReadReg     <= '0';
      DataNextReg <= '0';
      if (ReadySig='0') then
        ReadyReg  <= '0';
        AckReg    <= '0';
        drv_state <= DRV_ADDR;
      else
        ReadyReg  <= '1';
        DataInReg <= data_in;
        AckReg    <= ack;
        TXsendReg <= '0';
        case drv_state is
          when DRV_ADDR =>
            RXlenReg    <= TSLVconv(1+ID_SIZE+BUF_SIZE+1+ADDR_SIZE-1,RXlenReg'length);
            TotalSumReg <= (others => '0');
            if (RXrecSig='1') then
              RXdataReg <= RXdataSig(ID_SIZE+BUF_SIZE+ADDR_SIZE+1 downto 0);
              IdReg     <= (others => '0');
              BufReg    <= (others => '0');
              if (ID_SIZE>0) then
                IdReg <= RXdataSig(ID_SIZE+BUF_SIZE+ADDR_SIZE downto 1+ADDR_SIZE+BUF_SIZE);
              end if;
              if (BUF_SIZE>0) then
                BufReg <= RXdataSig(BUF_SIZE+ADDR_SIZE downto 1+ADDR_SIZE);
              end if;
              AddrReg   <= RXdataSig(ADDR_SIZE-1 downto 0);
              if (RXdataSig(ID_SIZE+BUF_SIZE+1+ADDR_SIZE)='1') then
                if (RXdataSig(ADDR_SIZE)='1') then
                  RXlenReg  <= TSLVconv(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE,RXlenReg'length);
                  drv_state <= DRV_DATA_WRITE;
                elsif (RXdataSig(ID_SIZE+BUF_SIZE+1+ADDR_SIZE-1 downto 1+ADDR_SIZE+BUF_SIZE)/=id) then
                  drv_state <= DRV_ADDR;
                else
                  drv_state <= DRV_DATA_READ;
                end if;
              else
               drv_state <= DRV_ERROR;
              end if;
            end if;
          when DRV_DATA_WRITE =>
            if (RXrecSig='1') then
              if (RXdataSig(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE)='0') then
                DataOutReg <= RXdataSig(DATA_SIZE-1 downto 0);
                if (IdReg/=id and ID_SIZE>0) then
                  drv_state <= DRV_ADDR;
                elsif (RXdataSig(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE-1 downto DATA_SIZE) = UART_INODE_chksum(IdReg & BufReg & AddrReg,RXdataSig(DATA_SIZE-1 downto 0))) then
                  WriteReg    <= '1';
                  TotalSumReg <= TotalSumReg xor UART_INODE_chksum(IdReg & BufReg & AddrReg,RXdataSig(DATA_SIZE-1 downto 0));
                  if (BufReg=0) then
                    TXlenReg  <= TSLVconv(UART_INODE_CHECK_SUM_SIZE-1,TXlenReg'length);
                    drv_state <= DRV_ACK_WRITE;
                  else
                    DataNextReg <= '1';
                    BufReg      <= BufReg - 1;
                  end if;
                else
                  drv_state <= DRV_ERROR;
                end if;
              else
               drv_state <= DRV_ERROR;
              end if;
            end if;
          when DRV_ACK_WRITE =>
            TXdataReg <= TSLVresize(TotalSumReg,TXdataReg'length);
            if (AckReg='1') then
              if (TXemptySig='1') then
                TXsendReg <= '1';
                drv_state <= DRV_ADDR;
              else
                drv_state <= DRV_ERROR;
              end if;
            end if;
          when DRV_DATA_READ =>
            if (TXemptySig='1' and TXsendReg='1') then
              TXsendReg <= '1';
            elsif (TXemptySig='0' and TXsendReg='1') then
              TXsendReg <= '0';
            elsif (TXemptySig='1' and TXsendReg='0') then
              if (BufReg/=0) then DataNextReg <= '1'; end if;
              ReadReg   <= '1';
              drv_state <= DRV_ACK_READ;
            end if;
          when DRV_ACK_READ =>
            TXlenReg  <= TSLVconv(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE,TXlenReg'length);
            TXdataReg(DATA_SIZE-1 downto 0) <= DataInReg;
            TXdataReg(UART_INODE_CHECK_SUM_SIZE+DATA_SIZE-1 downto DATA_SIZE) <= UART_INODE_chksum(IdReg & BufReg & AddrReg,DataInReg);
            TXdataReg(UART_INODE_CHECK_SUM_SIZE+DATA_SIZE) <= '0';
            if (AckReg='1') then
              TXsendReg <= '1';
              if (BufReg=0) then
                drv_state <= DRV_ADDR;
              else
                BufReg    <= BufReg - 1;
                drv_state <= DRV_DATA_READ;
              end if;
            end if;
          when others =>
            ReadyReg  <= '0';
            drv_state <= DRV_ADDR;
        end case;
      end if;
    end if;
  end process drv;
  --
  addr      <= AddrReg;
  data_next <= DataNextReg;
  data_out  <= DataOutReg;
  write     <= WriteReg;
  read      <= ReadReg;
  ready     <= ReadyReg;
  --
  uart :UART_iclient
    generic map(
      CLOCK_kHz	                        => CLOCK_kHz,
      BAUD_kHz                          => BAUD_kHz,
      DATA_SIZE                         => UART_DATA_SIZE,
      SEND_BOUD_DELAY                   => SEND_BOUD_DELAY
    )
    port map(
      resetN                            => resetN,
      clk                               => clk,
      --
      RX                                => RX,
      TX                                => TX,
      --
      RXdata                            => RXdataSig,
      RXlen                             => RXlenReg,
      RXrec                             => RXrecSig,
      TXdata                            => TXdataReg,
      TXlen                             => TXlenReg,
      TXsend                            => TXsendReg,
      TXempty                           => TXemptySig,
      --
      initN                             => initN,
      ready                             => ReadySig
    );

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_mult_inode is
  generic (
    MULT_NUM	                      :in    TN := 4;
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    ADDR_SIZE                         :in    TN := 16;
    DATA_SIZE                         :in    TN := 16;
    BUF_SIZE                          :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSLV(MULT_NUM-1 downto 0);
    TX                                :out   TSLV(MULT_NUM-1 downto 0);
    --
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    addr                              :out   TSLV(ADDR_SIZE-1 downto 0);
    data_next                         :out   TSL;
    data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
    data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
    write                             :out   TSL;
    read                              :out   TSL;
    ack                               :in    TSL;
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_mult_inode;

architecture behaviour of UART_mult_inode is

  constant PART_ID_SIZE         :TN := sel(0,SLVPartNum(ID_SIZE,  MULT_NUM),ID_SIZE=0);
  constant PART_ADDR_SIZE       :TN := SLVPartNum(ADDR_SIZE,MULT_NUM);
  constant PART_DATA_SIZE       :TN := SLVPartNum(DATA_SIZE,MULT_NUM); 
  --
  signal   PartIDsig            :TSLV(maximum(MULT_NUM*PART_ID_SIZE-1,0) downto 0) := (others =>'0');
  signal   PartAddrSig          :TSLV(MULT_NUM*PART_ADDR_SIZE-1 downto 0) := (others =>'0');
  signal   PartDataNextSig      :TSLV(MULT_NUM-1 downto 0) := (others =>'0');
  signal   PartDataInSig        :TSLV(MULT_NUM*PART_DATA_SIZE-1 downto 0) := (others =>'0');
  signal   PartDataOutSig       :TSLV(MULT_NUM*PART_DATA_SIZE-1 downto 0);
  signal   PartWriteSig         :TSLV(MULT_NUM-1 downto 0);
  signal   PartReadSig          :TSLV(MULT_NUM-1 downto 0);
  signal   PartReadySig         :TSLV(MULT_NUM-1 downto 0);

begin

  PartIDsig(id'range)          <= id;
  PartDataInSig(data_in'range) <= data_in;
  --
  iloop:
  for index in 0 to MULT_NUM-1 generate
    inode: UART_inode
      generic map (
        CLOCK_KHz       => CLOCK_KHz,
        BAUD_kHz        => BAUD_kHz,
        ID_SIZE         => PART_ID_SIZE,
        ADDR_SIZE       => PART_ADDR_SIZE,
        DATA_SIZE       => PART_DATA_SIZE,
        BUF_SIZE        => BUF_SIZE,
        SEND_BOUD_DELAY => SEND_BOUD_DELAY
      )
      port map (
        resetN          => resetN,
        clk             => clk,
        RX              => RX(index),
        TX              => TX(index),
        id              => PartIDsig(maximum((index+1)*PART_ID_SIZE-1,0) downto index*PART_ID_SIZE),
        addr            => PartAddrSig((index+1)*PART_ADDR_SIZE-1 downto index*PART_ADDR_SIZE),
        data_next       => PartDataNextSig(index),
        data_out        => PartDataOutSig((index+1)*PART_DATA_SIZE-1 downto index*PART_DATA_SIZE),
        data_in         => PartDataInSig((index+1)*PART_DATA_SIZE-1 downto index*PART_DATA_SIZE),
        write           => PartWriteSig(index),
        read            => PartReadSig(index),
        ack             => ack,
        initN           => initN,
        ready           => PartReadySig(index)
      );
  end generate;
  --
  addr      <= PartAddrSig(addr'range);
  data_next <= AND_REDUCE(PartDataNextSig);
  data_out  <= PartDataOutSig(data_out'range);
  write     <= AND_REDUCE(PartWriteSig);
  read      <= AND_REDUCE(PartReadSig);
  ready     <= AND_REDUCE(PartReadySig);

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_imaster is
  generic (
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    ADDR_SIZE                         :in    TN := 16;
    DATA_SIZE                         :in    TN := 16;
    BUF_SIZE                          :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5;
    INPUT_REGISTERED                  :in    TL := TRUE
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSL;
    TX                                :out   TSL;
    --
    enable                            :in    TSL;
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    addr                              :in    TSLV(ADDR_SIZE-1 downto 0);
    buf                               :in    TSLV(maximum(BUF_SIZE,1)-1 downto 0);
    data_next                         :out   TSL;
    data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
    data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
    write                             :in    TSL;
    read                              :in    TSL;
    ack                               :out   TSL;
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_imaster;

architecture behaviour of UART_imaster is

  constant UART_DATA_SIZE :TN := maximum(ID_SIZE+BUF_SIZE+ADDR_SIZE+1,DATA_SIZE+UART_INODE_CHECK_SUM_SIZE)+1;
  --
  type     T_DRV_STATE    is (DRV_IDLE, DRV_ADDR, DRV_DATA_WRITE, DRV_ACK_WRITE, DRV_DATA_READ, DRV_ERROR);
  signal   drv_state      :T_DRV_STATE;
  --
  signal   RXdataSig      :TSLV(UART_DATA_SIZE-1 downto 0);
  signal   RXlenReg       :TSLV(TVLcreate(UART_DATA_SIZE-1)-1 downto 0);
  signal   RXrecSig       :TSL;
  signal   TXdataReg      :TSLV(UART_DATA_SIZE-1 downto 0);
  signal   TXlenReg       :TSLV(TVLcreate(UART_DATA_SIZE-1)-1 downto 0);
  signal   TXsendReg      :TSL;
  signal   TXemptySig     :TSL;
  signal   ReadySig       :TSL;
  signal   ReadyReg       :TSL;
  signal   IdReg          :TSLV(maximum(ID_SIZE,1)-1 downto 0);
  signal   AddrReg        :TSLV(ADDR_SIZE-1 downto 0);
  signal   BufReg         :TSLV(maximum(BUF_SIZE,1)-1 downto 0);
  signal   BufCnt         :TSLV(maximum(BUF_SIZE,1)-1 downto 0);
  signal   DataNextReg    :TSL;
  signal   DataOutReg     :TSLV(DATA_SIZE-1 downto 0);
  signal   DataInReg      :TSLV(DATA_SIZE-1 downto 0);
  signal   EnableReg      :TSL;
  signal   WriteReg       :TSL;
  signal   ReadReg        :TSL;
  signal   WriteFlag      :TSL;
  signal   CheckSumReg    :TSLV(UART_INODE_CHECK_SUM_SIZE-1 downto 0);
  signal   TotalSumReg    :TSLV(UART_INODE_CHECK_SUM_SIZE-1 downto 0);
  signal   AckReg         :TSL;

begin

  ireg : process (clk, resetN) is
    variable clkv :TL;
  begin
    if (INPUT_REGISTERED=TRUE) then clkv := clk'event and clk='1'; else clkv := TRUE; end if;
    if (resetN='0' and INPUT_REGISTERED=TRUE)then
      IdReg         <= (others => '0');
      AddrReg       <= (others => '0');
      BufReg        <= (others => '0');
      DataInReg     <= (others => '0');
      EnableReg     <= '0';
      WriteReg      <= '0';
      ReadReg       <= '0';
    elsif (clkv) then
      AddrReg       <= addr;
      DataInReg     <= data_in;
      EnableReg     <= enable;
      WriteReg      <= write;
      ReadReg       <= read;
      if (ID_SIZE>0)  then IdReg  <= id;  else IdReg  <= (others =>'0'); end if;
      if (BUF_SIZE>0) then BufReg <= buf; else BufReg <= (others =>'0'); end if;
    end if;
  end process;
  --
  drv : process (clk, resetN) is
  begin
    if (resetN='0')then
      RXlenReg      <= (others => '0');
      TXdataReg     <= (others => '0');
      TXlenReg      <= (others => '0');
      TXsendReg     <= '0';
      ReadyReg      <= '0';
      BufCnt        <= (others => '0');
      DataNextReg   <= '0';
      DataOutReg    <= (others => '0');
      WriteFlag     <= '0';
      CheckSumReg   <= (others => '0');
      TotalSumReg   <= (others => '0');
      AckReg        <= '0';
      drv_state     <= DRV_ADDR;
    elsif clk'event and clk = '1' then
      AckReg      <= '0';
      DataNextReg <= '0';
      if (ReadySig='0') then
        ReadyReg  <= '0';
        drv_state <= DRV_IDLE;
      else
        ReadyReg <= '1';
        case drv_state is
          when DRV_IDLE =>
            if (EnableReg='1') then
              TXsendReg <= '0';
              if (WriteReg='1' and ReadReg='0') then
                WriteFlag <= '1';
                drv_state <= DRV_ADDR;
              elsif (ReadReg='1' and WriteReg='0') then
                WriteFlag <= '0';
                drv_state <= DRV_ADDR;
              elsif (ReadReg='1' and WriteReg='1') then
                drv_state <= DRV_ERROR;
              end if;
            end if;
          when DRV_ADDR =>
            TXlenReg    <= TSLVconv(1+ID_SIZE+BUF_SIZE+1+ADDR_SIZE-1,TXlenReg'length);
            TXdataReg   <= (others => '0');
            CheckSumReg <= (others => '0');
            TXdataReg(ID_SIZE+BUF_SIZE+ADDR_SIZE+1) <= '1';
            if (ID_SIZE>0) then
              TXdataReg(ID_SIZE+BUF_SIZE+ADDR_SIZE downto 1+ADDR_SIZE+BUF_SIZE) <= IdReg;
            end if;
            if (BUF_SIZE>0) then
              TXdataReg(BUF_SIZE+ADDR_SIZE downto 1+ADDR_SIZE) <= BufReg;
            end if;
            TotalSumReg <= (others =>'0');
            BufCnt      <= BufReg;
            TXdataReg(ADDR_SIZE) <= WriteFlag;
            TXdataReg(ADDR_SIZE-1 downto 0) <= AddrReg;
            if (TXemptySig='1') then
              TXsendReg <= '1';
              if (WriteFlag='1') then
                drv_state <= DRV_DATA_WRITE;
              else
                RXlenReg  <= TSLVconv(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE,TXlenReg'length);
                drv_state <= DRV_DATA_READ;
              end if;
            else
              drv_state <= DRV_ERROR;
            end if;
          when DRV_DATA_WRITE =>
            if (TXemptySig='0' and TXsendReg='1') then
              CheckSumReg <= UART_INODE_chksum(IdReg & BufCnt & AddrReg,DataInReg);
              TXsendReg   <= '0';
            elsif (TXemptySig='1' and TXsendReg='0') then
              TXlenReg  <= TSLVconv(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE,TXlenReg'length);
              TXdataReg <= (others => '0');
              TXdataReg(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE) <= '0';
              TXdataReg(DATA_SIZE+UART_INODE_CHECK_SUM_SIZE-1 downto DATA_SIZE) <= CheckSumReg;
              TXdataReg(DATA_SIZE-1 downto 0) <= DataInReg;
              TXsendReg   <= '1';
              RXlenReg    <= TSLVconv(UART_INODE_CHECK_SUM_SIZE-1,TXlenReg'length);
              TotalSumReg <= TotalSumReg xor CheckSumReg;
              if (BufCnt=0) then
                drv_state <= DRV_ACK_WRITE;
              else
                BufCnt      <= BufCnt - 1;
                DataNextReg <= '1';
              end if;
            end if;
          when DRV_ACK_WRITE =>
            TXsendReg <= '0';
            if (RXrecSig='1') then
              if (RXdataSig(UART_INODE_CHECK_SUM_SIZE-1 downto 0)=TotalSumReg) then
                AckReg <= '1';
                drv_state <= DRV_IDLE;
              else
                drv_state <= DRV_ERROR;
              end if;
            end if;
          when DRV_DATA_READ =>
            TXsendReg <= '0';
            if (RXrecSig='1') then
              if(    RXdataSig(UART_INODE_CHECK_SUM_SIZE+DATA_SIZE)='0' -->
                 and RXdataSig(UART_INODE_CHECK_SUM_SIZE+DATA_SIZE-1 downto DATA_SIZE) = UART_INODE_chksum(IdReg & BufCnt & AddrReg,RXdataSig(DATA_SIZE-1 downto 0))) then
                DataOutReg <= RXdataSig(DATA_SIZE-1 downto 0);
                AckReg <= '1';
                if (BufCnt=0) then
                  drv_state <= DRV_IDLE;
                else
                  BufCnt      <= BufCnt - 1;
                  DataNextReg <= '1';
                end if;
              else
                drv_state <= DRV_ERROR;
              end if;
            end if;
          when others =>
            ReadyReg  <= '0';
            drv_state <= DRV_ADDR;
        end case;
      end if;
    end if;
  end process drv;
  --
  data_next <= DataNextReg;
  data_out  <= DataOutReg;
  ack       <= AckReg;
  ready     <= ReadyReg;
  --
  uart :UART_iclient
    generic map(
      CLOCK_kHz	                        => CLOCK_kHz,
      BAUD_kHz                          => BAUD_kHz,
      DATA_SIZE                         => UART_DATA_SIZE,
      SEND_BOUD_DELAY                   => SEND_BOUD_DELAY
    )
    port map(
      resetN                            => resetN,
      clk                               => clk,
      --
      RX                                => RX,
      TX                                => TX,
      --
      RXdata                            => RXdataSig,
      RXlen                             => RXlenReg,
      RXrec                             => RXrecSig,
      TXdata                            => TXdataReg,
      TXlen                             => TXlenReg,
      TXsend                            => TXsendReg,
      TXempty                           => TXemptySig,
      --
      initN                             => initN,
      ready                             => ReadySig
    );

end behaviour;

-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
--
use work.std_logic_1164_ktp.all;
use work.LPMComp_UniTech.all;
use work.uart_interface.all;

entity UART_mult_imaster is
  generic (
    MULT_NUM	                      :in    TN := 4;
    CLOCK_kHz	                      :in    TN := 62500;
    BAUD_kHz                          :in    TN := 12500;
    ID_SIZE                           :in    TN := 5;
    ADDR_SIZE                         :in    TN := 16;
    DATA_SIZE                         :in    TN := 16;
    BUF_SIZE                          :in    TN := 5;
    SEND_BOUD_DELAY                   :in    TN := 5;
    INPUT_REGISTERED                  :in    TL := TRUE
  );
  port(
    resetN                            :in    TSL;
    clk                               :in    TSL;
    --
    RX                                :in    TSLV(MULT_NUM-1 downto 0);
    TX                                :out   TSLV(MULT_NUM-1 downto 0);
    --
    enable                            :in    TSL;
    id                                :in    TSLV(maximum(ID_SIZE,1)-1 downto 0);
    addr                              :in    TSLV(ADDR_SIZE-1 downto 0);
    buf                               :in    TSLV(maximum(BUF_SIZE,1)-1 downto 0);
    data_next                         :out   TSL;
    data_out                          :out   TSLV(DATA_SIZE-1 downto 0);
    data_in                           :in    TSLV(DATA_SIZE-1 downto 0);
    write                             :in    TSL;
    read                              :in    TSL;
    ack                               :out   TSL;
    --
    initN                             :in    TSL;
    ready                             :out   TSL
  );
end UART_mult_imaster;

architecture behaviour of UART_mult_imaster is

  constant PART_ID_SIZE         :TN := sel(0,SLVPartNum(ID_SIZE,  MULT_NUM),ID_SIZE=0);
  constant PART_ADDR_SIZE       :TN := SLVPartNum(ADDR_SIZE,MULT_NUM);
  constant PART_DATA_SIZE       :TN := SLVPartNum(DATA_SIZE,MULT_NUM); 
  --
  signal   PartIDsig            :TSLV(maximum(MULT_NUM*PART_ID_SIZE-1,0) downto 0) := (others =>'0');
  signal   PartAddrSig          :TSLV(MULT_NUM*PART_ADDR_SIZE-1 downto 0) := (others =>'0');
  signal   PartDataNextSig      :TSLV(MULT_NUM-1 downto 0);
  signal   PartDataInSig        :TSLV(MULT_NUM*PART_DATA_SIZE-1 downto 0) := (others =>'0');
  signal   PartDataOutSig       :TSLV(MULT_NUM*PART_DATA_SIZE-1 downto 0);
  signal   PartAckSig           :TSLV(MULT_NUM-1 downto 0);
  signal   PartReadySig         :TSLV(MULT_NUM-1 downto 0);

begin

  PartIDsig(id'range)          <= id;
  PartAddrSig(addr'range)      <= addr;
  PartDataInSig(data_in'range) <= data_in;
  --
  iloop:
  for index in 0 to MULT_NUM-1 generate
    imaster: UART_imaster
      generic map (
        CLOCK_KHz        => CLOCK_KHz,
        BAUD_kHz         => BAUD_kHz,
        ID_SIZE          => PART_ID_SIZE,
        ADDR_SIZE        => PART_ADDR_SIZE,
        DATA_SIZE        => PART_DATA_SIZE,
        BUF_SIZE         => BUF_SIZE,
        SEND_BOUD_DELAY  => SEND_BOUD_DELAY,
        INPUT_REGISTERED => INPUT_REGISTERED
      )
      port map (
        resetN           => resetN,
        clk              => clk,
        RX               => RX(index),
        TX               => TX(index),
        enable           => enable,
        id               => PartIDsig(maximum((index+1)*PART_ID_SIZE-1,0) downto index*PART_ID_SIZE),
        addr             => PartAddrSig((index+1)*PART_ADDR_SIZE-1 downto index*PART_ADDR_SIZE),
        buf              => buf,
        data_next        => PartDataNextSig(index),
        data_out         => PartDataOutSig((index+1)*PART_DATA_SIZE-1 downto index*PART_DATA_SIZE),
        data_in          => PartDataInSig((index+1)*PART_DATA_SIZE-1 downto index*PART_DATA_SIZE),
        write            => write,
        read             => read,
        ack              => PartAckSig(index),
        initN            => initN,
        ready            => PartReadySig(index)
      );
  end generate;
  --
  data_next <= AND_REDUCE(PartDataNextSig);
  data_out  <= PartDataOutSig(data_out'range);
  ack       <= AND_REDUCE(PartAckSig);
  ready     <= AND_REDUCE(PartReadySig);
end behaviour;

