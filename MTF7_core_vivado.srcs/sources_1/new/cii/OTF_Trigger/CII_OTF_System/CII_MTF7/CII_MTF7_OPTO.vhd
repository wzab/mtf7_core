library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.std_logic_1164_ktp.all;
use work.KTPcomponent.all;
use work.LPMComp_UniTech.all;
use work.LPMcomponent.all;
use work.LPMsynchro.all;
use work.LPMdiagnostics.all;

use work.ComponentII.all;
use work.CII_SYS_def.all,   work.CII_SYS_prv.all,   work.CII_SYS_dec.all;

use work.CII_OTF_def.all;
use work.CII_OTF_lib.all;
use work.CII_MTF7_def.all;
use work.CII_MTF7_OPTO_def.all;
use work.CII_MTF7_opto_prv.all;

entity CCII_MTF7_opto is
  generic (
    constant IICPAR				:TCII := MTF7_OPTO_tab;
    constant IICPOS				:TVI := 0
  );
  port(
    -- TTC signals
    clk40					:in    TSL;
    bcn0					:in    TSL;
    evn0					:in    TSL;
    l1a					        :in    TSL;
    pretrg0					:in    TSL;
    pretrg1					:in    TSL;
    pretrg2					:in    TSL;
    --
    -- links interface
    link_data					:in    TSLV(MTF7.RPC_LINK_DATA-1 downto 0);
    --
    -- internal bus interface
    II_resetN					:in    TSL;
    II_operN					:in    TSL;
    II_writeN					:in    TSL;
    II_strobeN					:in    TSL;
    II_addr					:in    TSLV(MTF7.II_ADDR_WIDTH-1 downto 0);
    II_in_data					:in    TSLV(MTF7.II_DATA_WIDTH-1 downto 0);
    II_out_data					:out   TSLV(MTF7.II_DATA_WIDTH-1 downto 0)
);
end CCII_MTF7_opto;    

architecture behaviour of CCII_MTF7_opto is

  --#CII# declaration insert start for 'MTF7_OPTO' - don't edit below !
  type TCIIpar                                            is record
    CHECK_SUM                                             :TI;
    BITS_TEST_CNT_CLK40                                   :TCIIItem;
    BITS_TEST_CNT_BCN0                                    :TCIIItem;
    WORD_REC_CHECK_ENA                                    :TCIIItem;
    WORD_REC_CHECK_DATA_ENA                               :TCIIItem;
    WORD_REC_TEST_ENA                                     :TCIIItem;
    WORD_REC_TEST_RND_ENA                                 :TCIIItem;
    WORD_REC_TEST_DATA                                    :TCIIItem;
    WORD_REC_TEST_OR_DATA                                 :TCIIItem;
    WORD_REC_ERROR_COUNT                                  :TCIIItem;
    WORD_BCN0_DELAY                                       :TCIIItem;
    COMP_ID                                               :TCII(0 to maximum(CIICompRepeatGet(IICPAR(CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)))))-1,0));
  end record;

  function CIIpar_get return TCIIpar is
    variable res: TCIIpar;
    variable pos, idx, len: TN;
  begin
    pos := CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.CHECK_SUM);
    res.CHECK_SUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
    res.BITS_TEST_CNT_CLK40 := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.BITS_TEST_CNT_CLK40));
    res.BITS_TEST_CNT_BCN0 := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.BITS_TEST_CNT_BCN0));
    res.WORD_REC_CHECK_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_CHECK_ENA));
    res.WORD_REC_CHECK_DATA_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_CHECK_DATA_ENA));
    res.WORD_REC_TEST_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_ENA));
    res.WORD_REC_TEST_RND_ENA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_RND_ENA));
    res.WORD_REC_TEST_DATA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_DATA));
    res.WORD_REC_TEST_OR_DATA := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_TEST_OR_DATA));
    res.WORD_REC_ERROR_COUNT := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_REC_ERROR_COUNT));
    res.WORD_BCN0_DELAY := IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.WORD_BCN0_DELAY));
    pos := CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)));
    for num in res.COMP_ID'range loop
      res.COMP_ID(num) := IICPAR(pos+num);
    end loop;
    return(res);
  end function;

  constant CIIPar                                         :TCIIpar := CIIpar_get;

  signal   CIIput_BITS_TEST_CNT_CLK40                     :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_CLK40).ItemNumber-1,0) downto 0);
  signal   CIIren_BITS_TEST_CNT_CLK40                     :TSL;
  signal   CIIput_BITS_TEST_CNT_BCN0                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.BITS_TEST_CNT_BCN0).ItemNumber-1,0) downto 0);
  signal   CIIren_BITS_TEST_CNT_BCN0                      :TSL;
  signal   CIIget_WORD_REC_CHECK_ENA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_ENA).ItemNumber-1,0) downto 0);
  signal   CIIget_WORD_REC_CHECK_DATA_ENA                 :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_CHECK_DATA_ENA).ItemNumber-1,0) downto 0);
  signal   CIIget_WORD_REC_TEST_ENA                       :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_ENA).ItemNumber-1,0) downto 0);
  signal   CIIget_WORD_REC_TEST_RND_ENA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_RND_ENA).ItemNumber-1,0) downto 0);
  signal   CIIput_WORD_REC_TEST_DATA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
  signal   CIIren_WORD_REC_TEST_DATA                      :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_DATA).ItemNumber-1,0) downto 0);
  signal   CIIput_WORD_REC_TEST_OR_DATA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
  signal   CIIren_WORD_REC_TEST_OR_DATA                   :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_TEST_OR_DATA).ItemNumber-1,0) downto 0);
  signal   CIIput_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
  signal   CIIren_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
  signal   CIIget_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
  signal   CIIwen_WORD_REC_ERROR_COUNT                    :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_REC_ERROR_COUNT).ItemNumber-1,0) downto 0);
  signal   CIIget_WORD_BCN0_DELAY                         :TSLV(maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemWidth*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.WORD_BCN0_DELAY).ItemNumber-1,0) downto 0);
  type     TCIIcpd_COMP_ID                                is array(0 to maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat,1)-1) of TSLV(maximum(IICPAR(CIICompPtrGet(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID))).ItemWidth,1)-1 downto 0);
  signal   CIIcpd_COMP_ID                                 :TCIIcpd_COMP_ID := (TCIIcpd_COMP_ID'range => (others =>'0'));
  signal   CIIcpdv_COMP_ID                                :TSLV(maximum(CIICompDataWidthGet(IICPAR(IICPOS))*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat-1,0) downto 0);
  function CIIcpdv_COMP_ID_get(d :TCIIcpd_COMP_ID) return TSLV is constant L :TN := d(0)'length; variable r :TSLV(TCIIcpd_COMP_ID'length*L-1 downto 0); begin for i in TCIIcpd_COMP_ID'range loop r(L*(i+1)-1 downto L*i) := d(i); end loop; return(r); end function;
  --#CII# declaration insert end for 'MTF7_OPTO' - don't edit above !

  -- Link receiver
  type     TLinkData			        is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.GOL_DATA_SIZE-1 downto 0);
  type     TReceiverData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.GOL_DATA_SIZE-OTF.RPC_LBSTD_BCN_WIDTH-2 downto 0);
  type     TReceiverTestORData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.RPC_LB_TEST_PART_NUM-1 downto 0);
  --
  signal   LinkDataSig				:TLinkData;
  signal   ReceiverDataSig			:TReceiverData;
  signal   ReceiverTestDataSig			:TLinkData;
  signal   ReceiverTestORDataSig		:TReceiverTestORData;
  signal   ReceiverTestORReadSig		:TReceiverTestORData;
  signal   ReceiverCheckSig			:TSLV(OTF.RPC_LBSTD_BCN_WIDTH downto 0);
  signal   ReceiverValid			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);

  -- TTC engine
  signal   BCN0DelSig				:TSL;
  signal   EVN0Sig				:TSL;
  signal   BCN0Cnt				:TSLV(MTF7_OPTO.CLOCK_TEST_SIZE-1 downto 0);
  signal   BCNCnt				:TSLV(OTF.TTC_BCN_EVT_WIDTH-1 downto 0);
  signal   EVNCnt				:TSLV(2*OTF.TTC_BCN_EVT_WIDTH-1 downto 0);

  signal   TrigDataDelSig			:TSL;
  signal   TrigDataDelEvtSig			:TSL;

begin
    
  --
  -- Link receiver
  --
  ReceiverCheckSig     <= BCNcnt(OTF.RPC_LBSTD_BCN_WIDTH-1 downto 0) & BCN0DelSig;
  loop_receiver:
  for index in 0 to MTF7.RPC_LINK_NUM-1 generate
    --
    LinkDataSig(index)           <= SLVpartGet(link_data,OTF.GOL_DATA_SIZE,index);
    ReceiverTestORreadSig(index) <= SLVpartGet(CIIren_WORD_REC_TEST_OR_DATA,OTF.RPC_LB_TEST_PART_NUM,index);
    --
    receiver :LPM_PART_DATA_RECEIVER_V1
      generic map (
        LPM_PART_WIDTH		=> OTF.RPC_LB_TEST_PART_WIDTH,
        LPM_PART_NUM		=> OTF.RPC_LB_TEST_PART_NUM,
        LPM_CHECK_WIDTH		=> OTF.RPC_LBSTD_BCN_WIDTH+1,
        LPM_DELAY_WIDTH		=> 0,
        INPUT_REGISTERED	=> TRUE,
        CHECK_REGISTERED	=> TRUE,
        OUTPUT_DELAY_REGISTERED	=> FALSE,
        OUTPUT_REGISTERED	=> TRUE
      )
      port map (
        resetN			=> II_resetN,
        clock			=> clk40,
        clock_inv		=> '0',
        data_delay		=> (others =>'0'),
        part_ena		=> '0',
        check_ena		=> CIIget_WORD_REC_CHECK_ENA(index),
        check_data		=> ReceiverCheckSig,
        in_data			=> LinkDataSig(index),
        out_data		=> ReceiverDataSig(index),
        check_data_ena		=> CIIget_WORD_REC_CHECK_DATA_ENA(index),
        test_ena		=> CIIget_WORD_REC_TEST_ENA(index),	
        test_rand_ena		=> CIIget_WORD_REC_TEST_RND_ENA(index),
        test_data		=> ReceiverTestDataSig(index),
        data_valid		=> ReceiverValid(index),
        test_or_read		=> ReceiverTestORreadSig(index),
        test_or_data		=> ReceiverTestORdataSig(index)
      );
  end generate;

  --
  -- TTC engine
  --
  ttc_cnt :CII_OTF_TTC_cnt
    generic map (
      BCN0_DELAY_WIDTH => OTF.TTC_BCN_WIDTH,
      EVN0_DELAY_WIDTH => 0,
      BCN0_WIDTH       => MTF7_OPTO.CLOCK_TEST_SIZE,
      BCN_WIDTH        => OTF.TTC_BCN_WIDTH,
      EVN_WIDTH        => OTF.TTC_EVN_WIDTH
    )
    port map (
      resetN           => ii_resetN,
      clock            => clk40,
      bcn0             => bcn0,
      evn0             => evn0,
      bcn0_del         => BCN0DelSig,
      evn0_del         => EVN0Sig,
      bcn0_cnt         => BCN0cnt,
      bcn              => BCNcnt,
      evn              => EVNcnt,
      --
      event_in         => TrigDataDelSig,
      event_out        => TrigDataDelEvtSig,
      bcn0_delay       => CIIget_WORD_BCN0_DELAY,
      evn0_delay       => open
    );

  --
  -- CII implementation
  --
  COMP_ID_inst : CCII_IDENTIFICATOR
    generic map (
      IICPAR                                    => IICPAR,
      IICPOS                                    => CIICompPosGet(CIIPar.COMP_ID(0))
    )
    port map (
    -- internal bus interface
      II_resetN                                 => II_resetN,
      II_operN                                  => ii_operN,
      II_writeN                                 => II_writeN,
      II_strobeN                                => II_strobeN,
      II_addr                                   => II_addr,
      II_in_data				=> ii_in_data,
      II_out_data				=> CIIcpd_COMP_ID(0)
    );
  --
  --#CII# instantation insert start for 'MTF7_OPTO' - don't edit below !
  CIIinterf :MTF7_OPTO_cii_interface
    generic map (
      IICPAR                                    => IICPAR,
      IICPOS                                    => IICPOS
    )
    port map (
      put_BITS_TEST_CNT_CLK40                   => CIIput_BITS_TEST_CNT_CLK40,
      ren_BITS_TEST_CNT_CLK40                   => CIIren_BITS_TEST_CNT_CLK40,
      put_BITS_TEST_CNT_BCN0                    => CIIput_BITS_TEST_CNT_BCN0,
      ren_BITS_TEST_CNT_BCN0                    => CIIren_BITS_TEST_CNT_BCN0,
      get_WORD_REC_CHECK_ENA                    => CIIget_WORD_REC_CHECK_ENA,
      get_WORD_REC_CHECK_DATA_ENA               => CIIget_WORD_REC_CHECK_DATA_ENA,
      get_WORD_REC_TEST_ENA                     => CIIget_WORD_REC_TEST_ENA,
      get_WORD_REC_TEST_RND_ENA                 => CIIget_WORD_REC_TEST_RND_ENA,
      put_WORD_REC_TEST_DATA                    => CIIput_WORD_REC_TEST_DATA,
      ren_WORD_REC_TEST_DATA                    => CIIren_WORD_REC_TEST_DATA,
      put_WORD_REC_TEST_OR_DATA                 => CIIput_WORD_REC_TEST_OR_DATA,
      ren_WORD_REC_TEST_OR_DATA                 => CIIren_WORD_REC_TEST_OR_DATA,
      put_WORD_REC_ERROR_COUNT                  => CIIput_WORD_REC_ERROR_COUNT,
      ren_WORD_REC_ERROR_COUNT                  => CIIren_WORD_REC_ERROR_COUNT,
      get_WORD_REC_ERROR_COUNT                  => CIIget_WORD_REC_ERROR_COUNT,
      wen_WORD_REC_ERROR_COUNT                  => CIIwen_WORD_REC_ERROR_COUNT,
      get_WORD_BCN0_DELAY                       => CIIget_WORD_BCN0_DELAY,
      cpd_COMP_ID                               => CIIcpdv_COMP_ID,
      II_resetN                                 => II_resetN,
      II_operN                                  => ii_operN,
      II_writeN                                 => II_writeN,
      II_strobeN                                => II_strobeN,
      II_addr                                   => II_addr,
      II_data_in                                => ii_in_data,
      II_data_out                               => ii_out_data
  );
  CIIcpdv_COMP_ID                               <= CIIcpdv_COMP_ID_get(CIIcpd_COMP_ID);
  --#CII# instantation insert end for 'MTF7_OPTO' - don't edit above !

end behaviour;

--  signal   L, H					:TSL;
--  signal   clock				:TSL;
--  signal   clock80				:TSL;
--  signal   clock8				:TSL;
--  signal   ClK8StrobeSig			:TSL;
--
--  signal   PllLockSig				:TSL;
--  signal   PllUnlockHoldSig			:TSL;
--  signal   Clk8StrobeUnlockHoldSig		:TSL;
--  signal   PllUnlockReadSig			:TSL;
--  signal   Clk8StrobeUnlockReadSig		:TSL;
--  signal   Clk40Cnt				:TSLV(MTF7_OPTO.CLOCK_TEST_SIZE-1 downto 0);
--  signal   Clk80Cnt				:TSLV(MTF7_OPTO.CLOCK_TEST_SIZE-1 downto 0);
--  
--  signal   TLKRxEnableSig			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKRxLckRefNSig			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKErrorReadEnaSig			:TSL;
--  signal   TLKErrorReg				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKNoDataReg				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKNoDataReadEnaSig			:TSL;
--
--  type     TRecState				is (
--						     TRecState_Idle,
--						     TRecState_Start,
--						     TRecState_WaitRepeat,
--						     TRecState_CheckRepeat,
--						     TRecState_SetPosition,
--						     TRecState_DelayPosLoop,
--						     TRecState_FastDelayPosLoop,
--						     TRecState_Calculate,
--						     TRecState_Finish
--  						   );
--  type     TRecStateVec				is array (0 to MTF7.RPC_LINK_NUM-1) of TRecState;
--  signal   RecStateReg				:TRecStateVec;
--  signal   RecSynchReqReg			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
----  type     TReceiverData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.GOL_DATA_SIZE-OTF.RPC_LBSTD_BCN_WIDTH-2 downto 0);
----  type     TReceiverTestData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.GOL_DATA_SIZE-1 downto 0);
----  type     TReceiverTestORData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(OTF.RPC_LB_TEST_PART_NUM-1 downto 0);
--  type     TReceiverDelay			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(MTF7_OPTO.RECEIVER_DELAY_WIDTH-1 downto 0);
--  signal   ReceiverDelayCIIreg			:TReceiverDelay;
--  signal   ReceiverDelayReg			:TReceiverDelay;
--  type     TReceiverFastDelay			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH-1 downto 0);
--  signal   ReceiverFastDelayCIIreg			:TReceiverFastDelay;
--  signal   ReceiverFastDelayReg			:TReceiverFastDelay;
--  type     TStateRepeterCnt			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(7 downto 0);
--  signal   StateRepeterCnt			:TStateRepeterCnt;
--  signal   StateErrorFlag			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   StateFirstPosFlag			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   StateDelayFirstReg			:TReceiverDelay;
--  signal   StateDelayLastReg			:TReceiverDelay;
--  signal   StateFastDelayFirstReg		:TReceiverFastDelay;
--  signal   StateFastDelayLastReg		:TReceiverFastDelay;
--  signal   StateSynchroFlag			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  function ReceiverFastDelay_get (arg :TReceiverFastDelay) return TSLV is
--    variable res :TSLV(arg'length*arg(0)'length-1 downto 0);
--  begin
--    res := (others => '0');
--    for index in 0 to arg'length-1 loop
--      res := SLVPartPut(res, index, arg(index));
--    end loop;
--    return(res);
--  end function;
--  function ReceiverDelay_get (arg :TReceiverDelay) return TSLV is
--    variable res :TSLV(arg'length*arg(0)'length-1 downto 0);
--  begin
--    res := (others => '0');
--    for index in 0 to arg'length-1 loop
--      res := SLVPartPut(res, index, arg(index));
--    end loop;
--    return(res);
--  end function;
--  --
--  signal   ReceiverCheckEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);  
--  signal   ReceiverCheckDataEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);  
--  signal   ReceiverTestEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);   
--  signal   ReceiverTestRndEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
----  signal   ReceiverData				:TReceiverData;
----  signal   ReceiverTestData			:TReceiverTestData;
----  signal   ReceiverTestORData			:TReceiverTestORData;
----  signal   ReceiverTestORRead			:TReceiverTestORData;
----  signal   ReceiverCheckSig			:TSLV(OTF.RPC_LBSTD_BCN_WIDTH downto 0);
----  signal   ReceiverValid			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   RecErrorSig				:TSL;
--  signal   RecErrorCountLoadSig			:TSL;
--  signal   RecErrorCountDataSig			:TSLV(MTF7_OPTO.RECEIVER_ERROR_COUNT_SIZE-1 downto 0);
--  signal   RecErrorCountOutSig			:TSLV(MTF7_OPTO.RECEIVER_ERROR_COUNT_SIZE-1 downto 0);
--  function ReceiverTestData_get (arg :TReceiverTestData) return TSLV is--TReceiverTestData) return TSLV is
--    variable res :TSLV(arg'length*arg(0)'length-1 downto 0);
--  begin
--    res := (others => '0');
--    for index in 0 to arg'length-1 loop
--      res := SLVPartPut(res, index, arg(index));
--    end loop;
--    return(res);
--  end function;
--  function ReceiverTestORData_get (arg :TReceiverTestORData) return TSLV is
--    variable res :TSLV(arg'length*arg(0)'length-1 downto 0);
--  begin
--    res := (others => '0');
--    for index in 0 to arg'length-1 loop
--      res := SLVPartPut(res, index, arg(index));
--    end loop;
--    return(res);
--  end function;
--
--  constant H0_DATA_SIZE				:TN := 24;
--  type     TReceiverDataH0			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(H0_DATA_SIZE-1 downto 0);
--  signal   ReceiverDataH0RND			:TReceiverDataH0;
--  signal   ReceiverValidH0			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   H0ChanEnaSig				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   H0RndEnaSig				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  
--  signal   DataSig				:TReceiverData;
--
--  type     TSenderTestData			is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(MTF7.TB_OPTO_DATA_WIDTH-1 downto 0);
--  signal   SenderCheckEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);  
--  signal   SenderCheckDataEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);  
--  signal   SenderTestEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);   
--  signal   SenderTestRndEna			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   SenderTestData			:TSenderTestData;
--  signal   SenderCheckSig			:TSLV(MTF7.TB_OPTO_BCN_WIDTH downto 0);
--  --
--  signal   TTCDataDalay				:TSLV(MTF7.TB_MUX_MULTIPL_WIDTH-1 downto 0);
--  signal   BCN0DelayValSig			:TSLV(OTF.TTC_BCN_WIDTH-1 downto 0);
--  signal   TTCBCN0Sig				:TSL;
--  signal   TTCEVN0Sig				:TSL;
--  signal   L1ASig				:TSL;
--  signal   Pretrg0Sig				:TSL;
--  signal   Pretrg1Sig				:TSL;
--  signal   Pretrg2Sig				:TSL;
--  signal   BCN0DelSig				:TSL;
----  signal   EVN0Sig				:TSL;
----  signal   BCN0Cnt				:TSLV(MTF7_OPTO.CLOCK_TEST_SIZE-1 downto 0);
----  signal   BCNCnt				:TSLV(OTF.TTC_BCN_EVT_WIDTH-1 downto 0);
----  signal   EVNCnt				:TSLV(2*OTF.TTC_BCN_EVT_WIDTH-1 downto 0);
--  signal   TTCTestDataSig			:TSLV(2*MTF7.TB_FAST_BUS_WIDTH-1 downto 0);
--  signal   TimerHresetCnt			:TSLV(MTF7_OPTO.TB_OPTO_HREST_TIMER_SIZE-1 downto 0);
--  signal   TimerHresetReg			:TSL;
--  signal   TimerHresetEnaReg			:TSL;
--  --
--  signal   TimerDaqLimitSig			:TSLV(MTF7.TB_TIMER_SIZE-1 downto 0);
--  signal   TimerDaqCountSig			:TSLV(MTF7.TB_TIMER_SIZE-1 downto 0);
--  signal   TimerDaqStartSig			:TSL;
--  signal   TimerDaqStopSig			:TSL;
--  signal   TimerDaqClkEnaSig			:TSL;
--  signal   TimerDaqTrgSel			:TN;
--  signal   TimerDaqTrgSig			:TSL;
--  signal   TimerDaqTrigDelayValSig		:TSLV(MTF7_OPTO.TB_OPTO_DELAY_SIZE-1 downto 0);
--  signal   TimerDaqTrigDelSig			:TSL;
--  signal   TimerDaqEngineClkEnaSig		:TSL;
--  signal   TimerDaqProcReqSig			:TSL;
--  signal   TimerDaqProcAckSig			:TSL;
--  --
--  signal   TrigDataSel				:TN;
--  signal   TrigDataSig				:TSL;
--  signal   TrigDataDelayValSig			:TSLV(MTF7_OPTO.TB_OPTO_DELAY_SIZE-1 downto 0);
----  signal   TrigDataDelSig			:TSL;
----  signal   TrigDataDelEvtSig			:TSL;
--  --
--  signal   DAQDiagDataSig			:TSLV(MTF7_OPTO.DAQ_DIAG_DATA_SIZE-1 downto 0);
--  signal   DAQDiagDataDelaySig			:TSLV(MTF7_OPTO.DAQ_DIAG_DATA_SIZE-1 downto 0);
--  signal   DAQDiagDataDelayValSig		:TSLV(MTF7_OPTO.DAQ_DIAG_DATA_DELAY_SIZE-1 downto 0);
--  signal   DAQDiagTrigReg			:TSLV(MTF7_OPTO.DAQ_DIAG_TRIG_NUM-1 downto 0);
--  signal   DAQDiagMaskSig			:TSLV(MTF7_OPTO.DAQ_DIAG_MASK_WIDTH*MTF7_OPTO.DAQ_DIAG_TRIG_NUM-1 downto 0);
--  signal   DAQDiagTimeSig			:TSLV(3*OTF.TTC_BCN_EVT_WIDTH-1 downto 0);
--  signal   DAQDiagEmptyStrSig			:TSL;
--  signal   DAQDiagEmptySig			:TSL;
--  signal   DAQDiagEmptyAckSig			:TSL;
--  signal   DAQDiagLostStrSig			:TSL;
--  signal   DAQDiagLostSig			:TSL;
--  signal   DAQDiagLostAckSig			:TSL;
--  signal   DAQDiagWrAddrStrSig			:TSL;
--  signal   DAQDiagWrAddrSig			:TSLV(MTF7_OPTO.DAQ_DIAG_ADDR_WIDTH-1 downto 0);
--  signal   DAQDiagWrAddrAckSig			:TSL;
--  signal   DAQDiagRdAddrStrSig			:TSL;
--  signal   DAQDiagRdAddrEnaSig			:TSL;
--  signal   DAQDiagRdAddrSig			:TSLV(MTF7_OPTO.DAQ_DIAG_ADDR_WIDTH-1 downto 0);
--  signal   DAQDiagRdAddrTestStrSig		:TSL;
--  signal   DAQDiagRdAddrTestSig			:TSLV(MTF7_OPTO.DAQ_DIAG_ADDR_WIDTH-1 downto 0);
--  signal   DAQDiagRdAddrTestAckSig		:TSL;
--  signal   DAQDiagMemWrSig			:TSL;
--  signal   DAQDiagMemStrSig			:TSL;
--  signal   DAQDiagMemDataOutSig			:TSLV(MTF7.TB_II_DATA_WIDTH-1 downto 0);
--  signal   ProcDAQDiagAckSig			:TSL;
--  --
--  signal   TimerPulserLimitSig			:TSLV(MTF7.TB_TIMER_SIZE-1 downto 0);
--  signal   TimerPulserCountSig			:TSLV(MTF7.TB_TIMER_SIZE-1 downto 0);
--  signal   TimerPulserStartSig			:TSL;
--  signal   TimerPulserStopSig			:TSL;
--  signal   TimerPulserClkEnaSig			:TSL;
--  signal   TimerPulserTrgSel			:TN;
--  signal   TimerPulserTrgSig			:TSL;
--  signal   TimerPulserTrigDelayValSig		:TSLV(MTF7_OPTO.TB_OPTO_DELAY_SIZE-1 downto 0);
--  signal   TimerPulserTrigDelSig		:TSL;
--  signal   TimerPulserEngineClkEnaSig		:TSL;
--  signal   TimerPulseRepeatEnaSig		:TSL;
--  signal   TimerPulserProcReqSig		:TSL;
--  signal   TimerPulserProcAckSig		:TSL;
--  signal   OutputPulserEna			:TL;
--  --
--  signal   PulseDelaySig			:TSLV(MTF7_OPTO.PULSE_POS_SIZE-1 downto 0);
--  signal   PulseDataInSig			:TSLV(MTF7_OPTO.PULSE_DATA_SIZE-1 downto 0);
--  signal   PulseDataOutSig			:TSLV(MTF7_OPTO.PULSE_DATA_SIZE-1 downto 0);
--  signal   PulseProcAckSig			:TSL;
--  signal   PulseMemStrSig			:TSL;
--  signal   PulseMemWrSig			:TSL;
--  signal   PulseMemDataOutSig			:TSLV(MTF7.TB_II_DATA_WIDTH-1 downto 0);
--  --
--  signal   IIVecInt, IIVecAll, IIVecEna		:TSLV(TSLVhigh(CII(MTF7_OPTO_tab,0)) downto VEC_INDEX_MIN);
--  signal   IIEnableSig				:TSL;
--  signal   IIEnableNSig				:TSL;
--  signal   IIDataSig				:TSLV(MTF7.TB_II_DATA_WIDTH-1 downto 0);
--  signal   IIDataExport				:TSLV(MTF7.TB_II_DATA_WIDTH-1 downto 0);
--  signal   IIDataExportEnable			:TSL;
--
--  signal   LedLinkSig				:TSLV(led_link'range);
--  signal   LedMainSig				:TSLV(led_main'range);
--
--  signal   dummy				:TSL;
--  signal   TLKrxErrLed				:TSL;
--  signal   SynchErrLed				:TSL;
--  signal   DataErrLed				:TSL;
--  signal   DataLed				:TSL;
--  
--  type     TTLKRxPipe				is array (0 to MTF7.RPC_LINK_NUM-1) of TSLV(6 downto 0);
--  signal   TLKRxDvPipe				:TTLKRxPipe;
--  signal   TLKRxErPipe				:TTLKRxPipe;
--  signal   TLKRxDvReg				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKRxErReg				:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKDataValidPipe			:TTLKRxPipe;
--  signal   TLKSynchroPipe			:TTLKRxPipe;
--  signal   TLKDataValidReg			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--  signal   TLKSynchroReg			:TSLV(MTF7.RPC_LINK_NUM-1 downto 0);
--
--begin
--
--  L <= '0'; H <= '1';
--
--  --
--  -- clocks interface
--  --
--  clock80       <= clk80;
--  --
--  PllUnlockReadSig        <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_PLL_UNLOCK);
--  Clk8StrobeUnlockReadSig <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_STROBE_UNLOCK);
--  mclk_inst :LPM_MODIFY_CLOCK
--    generic map (
--      LPM_MULTIP_CLOCK        => MTF7.TB_MUX_MULTIPL,
--      LPM_DIVIDE_CLOCK        => 1,
--      CLOCK_IN_FREQ_MHZ       => OTF.LHC_CLK_FREQ/1000000,
--      LPM_MCLOCK_POS          => -1
--    )
--    port map (
--      resetN                  => ii_resetN,
--      in_clock                => clk,
--      out_clock               => clock,
--      out_mclock              => clock8,
--      out_mclock90            => open,
--      out_strobe              => ClK8StrobeSig,
--      --
--      pll_lock                => PllLockSig,
--      strobe_lock             => open,
--      pll_unlock_hold         => PllUnlockHoldSig,
--      pll_unlock_read         => PllUnlockReadSig,
--      strobe_unlock_hold      => Clk8StrobeUnlockHoldSig,
--      strobe_unlock_read      => Clk8StrobeUnlockReadSig
--    );
--  --
--  process(ii_resetN, clock)
--  begin
--    if(ii_resetN='0') then
--      Clk40Cnt <= (others => '0');
--    elsif(clock'event and clock='1') then
--      Clk40Cnt <= Clk40Cnt + 1;
--    end if;
--  end process;
--  --
--  process(ii_resetN, clk80)
--  begin
--    if(ii_resetN='0') then
--      Clk80Cnt <= (others => '0');
--    elsif(clk80'event and clk80='1') then
--      Clk80Cnt <= Clk80Cnt + 1;
--    end if;
--  end process;
--  --
--  -------------------------------------------------------
--  --                  DATA RECEIVER PART               --
--  -------------------------------------------------------
--
--  --
--  -- TLK interface
--  --
--  TLKRxEnableSig  <= CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_ENABLE,0,0);
--  tlk_enable      <= TLKRxEnableSig;
--  TLKRxLckRefNSig <= CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_LCK_REFN,0,0);
--  tlk_lck_refN    <= TLKRxLckRefNSig;
--  tlk_gtx_clk     <= (others => clock80);
--  --
--  TLKErrorReadEnaSig <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_RX_ERROR);
--  process (ii_resetN, tlk_rx_er, TLKErrorReadEnaSig) begin
--    for index in 0 to MTF7.RPC_LINK_NUM-1 loop
--      if (ii_resetN='0') then
--         TLKErrorReg(index) <= '0';
--      elsif (tlk_rx_er(index)='1') then
--         TLKErrorReg(index) <= '1';
--      elsif(TLKErrorReadEnaSig'event and TLKErrorReadEnaSig='0') then
--         TLKErrorReg(index) <= '0';
--      end if;
--    end loop;
--  end process;
--  --
--  TLKNoDataReadEnaSig <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_RX_NO_DATA);
--  process (ii_resetN, tlk_rx_dv, TLKNoDataReadEnaSig) begin
--    for index in 0 to MTF7.RPC_LINK_NUM-1 loop
--      if (ii_resetN='0') then
--         TLKNoDataReg(index) <= '0';
--      elsif (tlk_rx_dv(index)='0') then
--         TLKNoDataReg(index) <= '1';
--      elsif(TLKErrorReadEnaSig'event and TLKErrorReadEnaSig='0') then
--         TLKNoDataReg(index) <= '0';
--      end if;
--    end loop;
--  end process;
--  --
--  process(ii_resetN, clock8)
--  begin
--    if(ii_resetN='0') then
--      TLKRxDvPipe <= (TLKRxDvPipe'range => (others => '0'));
--      TLKRxErPipe <= (TLKRxErPipe'range => (others => '0'));
--      TLKRxDvReg  <= (others => '0');
--      TLKRxErReg  <= (others => '0');
--    elsif(clock8'event and clock8='1') then
--      for index in TLKDataValidPipe'range loop
--        TLKRxDvPipe(index)(0) <= tlk_rx_dv(index);
--        TLKRxDvPipe(index)(TLKRxDvPipe(0)'length-1 downto 1) <= TLKRxDvPipe(index)(TLKRxDvPipe(0)'length-2 downto 0);
--        TLKRxDvReg(index) <= AND_REDUCE(TLKRxDvPipe(index));
--        --
--        TLKRxErPipe(index)(0) <= tlk_rx_er(index);
--        TLKRxErPipe(index)(TLKRxErPipe(0)'length-1 downto 1) <= TLKRxErPipe(index)(TLKRxErPipe(0)'length-2 downto 0);
--        TLKRxDvReg(index) <= OR_REDUCE(TLKRxDvPipe(index));
--      end loop;
--    end if;
--  end process;
--  --
--  process(ii_resetN, clock)
--  begin
--    if(ii_resetN='0') then
--      TLKSynchroPipe   <= (TLKSynchroPipe'range => (others => '0'));
--    elsif(clock'event and clock='0') then
--      for index in TLKDataValidPipe'range loop
--        TLKSynchroPipe(index)(0) <= not(TLKRxDvReg(index)) and not(TLKRxErReg(index));
--        TLKSynchroPipe(index)(TLKSynchroPipe(0)'length-1 downto 1) <= TLKSynchroPipe(index)(TLKSynchroPipe(0)'length-2 downto 0);
--        TLKSynchroReg(index) <= OR_REDUCE(TLKSynchroPipe(index));
--      end loop;
--    end if;
--  end process;
--  --
--  process(ii_resetN, clock)
--    variable DelaySum     :TSLV(MTF7_OPTO.RECEIVER_DELAY_WIDTH+MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH downto 0);
--  begin
--    if(ii_resetN='0') then
--      RecStateReg               <= (others => TRecState_Idle);
--      RecSynchReqReg            <= (others => '0');
--      ReceiverFastDelayReg      <= (TReceiverFastDelay'range => (others => '0'));
--      ReceiverDelayReg          <= (TReceiverDelay'range => (others => '0'));
--      StateRepeterCnt		<= (TStateRepeterCnt'range => (others => '0'));
--      StateErrorFlag            <= (others => '0');
--      StateFirstPosFlag         <= (others => '0');
--      StateDelayFirstReg        <= (TReceiverDelay'range => (others => '0'));
--      StateDelayLastReg         <= (TReceiverDelay'range => (others => '0'));
--      StateFastDelayFirstReg    <= (TReceiverFastDelay'range => (others => '0'));
--      StateFastDelayLastReg     <= (TReceiverFastDelay'range => (others => '0'));
--      StateSynchroFlag          <= (others => '0');
--    elsif(clock'event and clock='1') then
--      RecSynchReqReg            <= CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_REC_SYNCH_REQ,0,0);
--      for chan in 0 to MTF7.RPC_LINK_NUM-1 loop
--        if (TimerHresetEnaReg='1' and TimerHresetReg='1') then
--          StateSynchroFlag(chan) <= '0';
--          RecStateReg(chan)      <= TRecState_Start;
--        elsif (RecSynchReqReg(chan)='0') then
--          StateSynchroFlag(chan)     <= '0';
--          RecStateReg(chan)          <= TRecState_Start;
--          ReceiverFastDelayReg(chan) <= ReceiverFastDelayCIIreg(chan);
--          ReceiverDelayReg(chan)     <= ReceiverDelayCIIreg(chan);
--        elsif (TLKSynchroReg(chan)='1') then
--          StateSynchroFlag(chan) <= '0';
--          RecStateReg(chan)      <= TRecState_Start;
--        else
--          case RecStateReg(chan) is
--            when TRecState_Idle =>
--              if (RecSynchReqReg(chan)='1') then
--                RecStateReg(chan) <= TRecState_Start;
--              end if;
--            when TRecState_Start =>
--              ReceiverFastDelayReg(chan)   <= (others => '0');
--              ReceiverDelayReg(chan)       <= (others => '0');
--              StateRepeterCnt(chan)        <= (others => '0');
--              StateErrorFlag(chan)         <= '0';
--              StateFirstPosFlag(chan)      <= '0';
--              StateDelayFirstReg(chan)     <= (others => '0');
--              StateDelayLastReg(chan)      <= (others => '0');
--              StateFastDelayFirstReg(chan) <= (others => '0');
--              StateFastDelayLastReg(chan)  <= (others => '0');
--              StateSynchroFlag(chan)       <= '0';
--              RecStateReg(chan)            <= TRecState_WaitRepeat;
--            when TRecState_WaitRepeat =>
--              if (StateRepeterCnt(chan)=7) then
--                RecStateReg(chan)     <= TRecState_CheckRepeat;
--                StateRepeterCnt(chan) <= (others => '0');
--              else
--                StateRepeterCnt(chan) <= StateRepeterCnt(chan)+1;
--              end if;
--            when TRecState_CheckRepeat =>
--              if (AND_REDUCE(StateRepeterCnt(chan))='1') then
--                RecStateReg(chan) <= TRecState_SetPosition;
--              else
--                StateRepeterCnt(chan) <= StateRepeterCnt(chan)+1;
--                StateErrorFlag(chan)  <= StateErrorFlag(chan) or not(ReceiverValid(chan));
--              end if;
--            when TRecState_SetPosition =>
--              if (StateFirstPosFlag(chan)='0' and StateErrorFlag(chan)='0') then
--                StateFirstPosFlag(chan)      <= '1';
--                StateFastDelayFirstReg(chan) <= ReceiverFastDelayReg(chan);
--                StateDelayFirstReg(chan)     <= ReceiverDelayReg(chan);
--                StateFastDelayLastReg(chan)  <= ReceiverFastDelayReg(chan);
--                StateDelayLastReg(chan)      <= ReceiverDelayReg(chan);
--              end if;
--              if (StateFirstPosFlag(chan)='1' and StateErrorFlag(chan)='0') then
--                StateFastDelayLastReg(chan) <= ReceiverFastDelayReg(chan);
--                StateDelayLastReg(chan)     <= ReceiverDelayReg(chan);
--              end if;
--              if (StateFirstPosFlag(chan)='1' and StateErrorFlag(chan)='1') then
--                RecStateReg(chan) <= TRecState_Calculate;
--              else
--                RecStateReg(chan) <= TRecState_FastDelayPosLoop;
--              end if;
--            when TRecState_FastDelayPosLoop =>
--              if (ReceiverFastDelayReg(chan)=MTF7_OPTO.RECEIVER_FAST_DELAY_POS-1) then
--                RecStateReg(chan) <= TRecState_DelayPosLoop;
--              else
--                ReceiverFastDelayReg(chan) <= ReceiverFastDelayReg(chan)+1;
--                StateRepeterCnt(chan)      <= (others => '0');
--                StateErrorFlag(chan)       <= '0';
--                RecStateReg(chan)          <= TRecState_WaitRepeat;
--              end if;
--            when TRecState_DelayPosLoop =>
--              if (ReceiverDelayReg(chan)=MTF7_OPTO.RECEIVER_DELAY_POS-1) then
--                RecStateReg(chan) <= TRecState_Calculate;
--              else
--                ReceiverDelayReg(chan)     <= ReceiverDelayReg(chan)+1;
--                ReceiverFastDelayReg(chan) <= (others => '0');
--                StateRepeterCnt(chan)      <= (others => '0');
--                StateErrorFlag(chan)       <= '0';
--                RecStateReg(chan)          <= TRecState_WaitRepeat;
--              end if;
--            when TRecState_Calculate =>
--              if (StateFirstPosFlag(chan) = '1') then
--                StateSynchroFlag(chan) <= '1';
--                DelaySum     := (("0"&StateDelayFirstReg(chan)&StateFastDelayFirstReg(chan))+("0"&StateDelayLastReg(chan)&StateFastDelayLastReg(chan))+1);
--                ReceiverDelayReg(chan)     <= DelaySum(MTF7_OPTO.RECEIVER_DELAY_WIDTH+MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH downto MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH+1);
--                ReceiverFastDelayReg(chan) <= DelaySum(MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH downto 1);
--                RecStateReg(chan) <= TRecState_Finish;
--              else
--                RecStateReg(chan) <= TRecState_Start;
--              end if;
--            when TRecState_Finish =>
--              RecStateReg(chan) <= TRecState_Finish;
--            when others =>
--              RecStateReg(chan) <= TRecState_Finish;
--          end case;
--        end if;
--      end loop;
--    end if;
--  end process;
--  --
--  process(ii_resetN, clock)
--    variable SynchroVar :TSL;
--  begin
--    if(ii_resetN='0') then
--      TLKDataValidPipe <= (TLKDataValidPipe'range => (others => '0'));
--    elsif(clock'event and clock='0') then
--      for index in TLKDataValidPipe'range loop
--        TLKDataValidPipe(index)(0) <= TLKRxDvReg(index) and not(TLKRxErReg(index));
--        TLKDataValidPipe(index)(TLKDataValidPipe(0)'length-1 downto 1) <= TLKDataValidPipe(index)(TLKDataValidPipe(0)'length-2 downto 0);
--        TLKDataValidReg(index) <= AND_REDUCE(TLKDataValidPipe(index)) and (not(RecSynchReqReg(index)) or StateSynchroFlag(index));
--      end loop;
--    end if;
--  end process;
----  --
----  ReceiverCheckEna     <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_CHECK_ENA,0,0);
----  ReceiverCheckDataEna <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_CHECK_DATA_ENA,0,0);
----  ReceiverTestEna      <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_TEST_ENA,0,0);
----  ReceiverTestRndEna   <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_TEST_RND_ENA,0,0);
----  ReceiverCheckSig     <= BCNcnt(OTF.RPC_LBSTD_BCN_WIDTH-1 downto 0) & BCN0DelSig;
----  loop_receiver:
----  for index in 0 to MTF7.RPC_LINK_NUM-1 generate
----    --
----    ReceiverTestORread(index) <= CIIConnGetWordReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_TEST_OR_DATA,index,0);
----    --
----    receiver :LPM_MUX_DATA_RECEIVER_V1
----      generic map (
----        LPM_MUX_WIDTH		=> MTF7_OPTO.RECEIVER_MUX_DATA_WIDTH, 
----        LPM_MUX_MULTIPL		=> MTF7_OPTO.RECEIVER_MUX_MULTIPL,
----        LPM_CLOCK_MULTIPL	=> MTF7_OPTO.RECEIVER_CLOCK_MULTIPL,
----        LPM_PART_NUM		=> OTF.RPC_LB_TEST_PART_NUM,
----        LPM_DELAY_WIDTH		=> MTF7_OPTO.RECEIVER_DELAY_WIDTH,
----        LPM_CHECK_WIDTH		=> OTF.RPC_LBSTD_BCN_WIDTH+1,
----        MUX_SYMMETRIZATION_ENA	=> FALSE,
----        MUX_PART_MODE_ENA	=> TRUE,
----        MUX_DECREASE_ENA        => FALSE,
----        DEMUX_CLOCK_PIPE_ENA	=> TRUE,
----        DEMUX_STROBE_ENABLE	=> FALSE,
----        DEMUX_STROBE_REGISTERED	=> FALSE,
----        DEMUX_OUTPUT_REGISTERED	=> TRUE,
----        INPUT_PART_REGISTERED	=> FALSE ,--@T@ TRUE,
----        INPUT_DELAY_REGISTERED	=> FALSE,
----        OUTPUT_DELAY_REGISTERED	=> FALSE ,--@T@ FALSE,
----        OUTPUT_PART_REGISTERED	=> TRUE--FALSE
----      )
----      port map (
----        resetN			=> ii_resetN,
----        clock			=> clock,
----        clock_inv		=> '0',
----        mux_clock		=> clock8,
----        mux_clock90		=> L,
----        strobe			=> L,
----        mux_data_clk90		=> (others => '0'),
----        mux_data_clk_inv	=> (others => '0'),
----        mux_data_reg_add	=> (others => '0'),
----        mux_data_delay		=> ReceiverFastDelayReg(index),
----        data_delay		=> ReceiverDelayReg(index),
----        part_ena		=> L,
----        check_ena		=> ReceiverCheckEna(index),
----        check_data		=> ReceiverCheckSig,
----        check_data_ena		=> ReceiverCheckDataEna(index),
----        mux_data		=> tlk_rxd(index),
----        data			=> ReceiverData(index),
----        test_data		=> ReceiverTestData(index),
----        test_ena		=> ReceiverTestEna(index),	
----        test_rand_ena		=> ReceiverTestRndEna(index),
----        data_valid		=> ReceiverValid(index),
----        test_or_read		=> ReceiverTestORread(index),
----        test_or_data		=> ReceiverTestORdata(index)
----      );
----  end generate;
----  --
----  RecErrorSig            <= not(AND_REDUCE((ReceiverValid and TLKDataValidReg) or (ReceiverTestEna and not(ReceiverTestRndEna))));
----  RecErrorCountDataSig   <= CIIConnGetWordData(IIVecAll,IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_ERROR_COUNT,0,0,RecErrorCountOutSig);
----  RecErrorCountLoadSig   <= not(OR_REDUCE(CIIConnGetWordWriteStr(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_ERROR_COUNT,0,0,ii_strobeN)));
----  --
----  bx_hist_count :KTP_LPM_COUNT
----    generic map(
----      LPM_DATA_WIDTH		=> MTF7_OPTO.RECEIVER_ERROR_COUNT_SIZE,
----      COUNT_STOP		=> TRUE,
----      COUNT_RELOAD		=> FALSE
----    )
----    port map(
----      resetN			=> ii_resetN,
----      clk			=> clock,
----      clk_ena			=> RecErrorSig,
----      initN			=> H,
----      loadN			=> RecErrorCountLoadSig,
----      downN			=> H,
----      setN			=> H,
----      reloadN			=> H,
----      data			=> RecErrorCountDataSig,
----      count			=> RecErrorCountOutSig,
----      finishN			=> open,
----      overN			=> open
----    );
--
--  --
--  -- sender
--  --
--  H0ChanEnaSig    <=  CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_H0_CHAN_ENA,0,0);
--  H0RndEnaSig     <=  CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_H0_RND_ENA,0,0);
--  OutputPulserEna <= (CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_OUT_ENA,0,0)(0)='1');
--  process (ReceiverData, ReceiverValid, TLKDataValidReg, H0ChanEnaSig, PulseDataOutSig, OutputPulserEna) is
--  begin
--    for index in ReceiverData'range loop
--      if (OutputPulserEna=FALSE) then
----        if (H0ChanEnaSig(index)='0') then
--          DataSig(index)         <= sel(ReceiverData(index),'0',TLKDataValidReg(index) and ReceiverValid(index) and not(TimerHresetReg));
--          ReceiverValidH0(index) <= ReceiverValid(index) and TLKDataValidReg(index);
----        else
----          if (H0RndEnaSig(index)='0') then
----            DataSig(index)         <= ReceiverTestData(index);
----            ReceiverValidH0(index) <= ReceiverValid(index);
----	  else
----            DataSig(index)(H0_DATA_SIZE-1 downto 0)             <= ReceiverTestData(index)(H0_DATA_SIZE-1 downto 0) xor ReceiverDataH0RND(index);
----            DataSig(index)(OTF.GOL_DATA_SIZE-1 downto H0_DATA_SIZE) <= ReceiverTestData(index)(OTF.GOL_DATA_SIZE-1 downto H0_DATA_SIZE);
----            ReceiverValidH0(index)                              <= not(OR_REDUCE(ReceiverTestData(index)(H0_DATA_SIZE-1 downto 0) xor ReceiverDataH0RND(index))) and ReceiverValid(index);
----	  end if;
----	end if;
--      else
--        DataSig(index)(OTF.RPC_LBSTD_LMUX_WIDTH-1 downto 0) <= SLVPartGet(PulseDataOutSig,OTF.RPC_LBSTD_LMUX_WIDTH,index);
--      end if;
--    end loop;
--  end process;
--  
--  SenderCheckEna     <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_SEND_CHECK_ENA,0,0);
--  SenderCheckDataEna <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_SEND_CHECK_DATA_ENA,0,0);
--  SenderTestEna      <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_SEND_TEST_ENA,0,0);
--  SenderTestRndEna   <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_SEND_TEST_RND_ENA,0,0);
--  SenderCheckSig     <= BCNcnt(MTF7.TB_OPTO_BCN_WIDTH+2 downto 2) xor TSLVnew(MTF7.TB_OPTO_BCN_WIDTH+1,BCN0DelSig xor BCNcnt(0) xor BCNcnt(2));
--  --
--  loop_sender:
--  for index in 0 to MTF7.RPC_LINK_NUM-1 generate
--    --
--    SenderTestData(index) <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_SEND_TEST_DATA,index,0);
--    --
--    tx :LPM_MUX_DATA_SENDER_V1
--      generic map (
--        LPM_MUX_WIDTH		=> MTF7.TB_OPTO_MUX_DATA_WIDTH,
--        LPM_MUX_MULTIPL		=> MTF7.TB_OPTO_MUX_MULTIPL,
--        LPM_CLOCK_MULTIPL	=> 1,
--        LPM_PART_NUM		=> MTF7.TB_OPTO_MUX_DATA_WIDTH,
--        LPM_CHECK_WIDTH		=> MTF7.TB_OPTO_BCN_WIDTH+1,
--        MUX_SYMMETRIZATION_ENA	=> FALSE,
--        MUX_PART_MODE_ENA	=> FALSE,
--        MUX_DECREASE_ENA        => FALSE,
--        PART_INPUT_REGISTERED	=> FALSE,-- @T@ TRUE,
--        PART_OUTPUT_REGISTERED	=> TRUE,
--        MUX_INPUT_REGISTERED	=> TRUE,--FALSE,
--        MUX_STROBE_ASET_ENA	=> FALSE,
--        MUX_OUTPUT_REGISTERED	=> TRUE
--      )
--      port map (
--        resetN			=> ii_resetN,
--        clock			=> clock,
--        mux_clock		=> Clock8,
--        clock_inv		=> L,
--        strobe			=> ClK8StrobeSig,
--        part_ena		=> H,--L,
--        check_ena		=> SenderCheckEna(index),
--        check_data		=> SenderCheckSig,
--        check_data_ena		=> SenderCheckDataEna(index),
--        data			=> DataSig(index)(OTF.RPC_LBSTD_LMUX_WIDTH-1 downto 0),
--        mux_data		=> mux_data(index),
--        test_data		=> SenderTestData(index),
--        test_ena		=> SenderTestEna(index),
--        test_rand_ena		=> SenderTestRndEna(index)
--      );
--    --
--  end generate;
--
--  --
--  -- TTC engine
--  --
--  TTCDataDalay <= CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_TTC_DATA_DELAY,0,0);
--  ttc_tc :CII_RPC_TB3_lib_TTC_timing_rx
--    generic map (
--      LPM_CLOCK_MULTIPL    => MTF7.TB_MUX_MULTIPL
--    )
--    port map(
--      resetN               => ii_resetN,
--      fclock               => clock8,
--      clock                => clock,
--      data                 => fast_bus,
--      fdelay               => TTCDataDalay,
--      bcn0                 => TTCBCN0Sig,
--      evn0                 => TTCEVN0Sig,
--      l1a                  => L1ASig,
--      pretrg0              => PreTrg0Sig,
--      pretrg1              => PreTrg1Sig,
--      pretrg2              => PreTrg2Sig,
--      test_data            => TTCTestDataSig
--    );
--  --
----  BCN0DelayValSig <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_BCN0_DELAY,0,0);
----  ttc_cnt :CII_RPC_system_lib_TTC_cnt
----    generic map (
----      BCN0_DELAY_WIDTH => OTF.TTC_BCN_WIDTH,
----      EVN0_DELAY_WIDTH => 0,
----      BCN0_WIDTH       => MTF7_OPTO.CLOCK_TEST_SIZE,
----      BCN_WIDTH        => OTF.TTC_BCN_WIDTH,
----      EVN_WIDTH        => OTF.TTC_EVN_WIDTH
----    )
----    port map (
----      resetN           => ii_resetN,
----      clock            => clock,
----      bcn0             => TTCBCN0Sig,
----      evn0             => TTCEVN0Sig,
----      bcn0_del         => BCN0DelSig,
----      evn0_del         => EVN0Sig,
----      bcn0_cnt         => BCN0cnt,
----      bcn              => BCNcnt,
----      evn              => EVNcnt,
----      --
----      event_in         => TrigDataDelSig,
----      event_out        => TrigDataDelEvtSig,
----      bcn0_delay       => BCN0DelayValSig,
----      evn0_delay       => open
----    );
--  --
--  process(ii_resetN, clock)
--  begin
--    if(ii_resetN='0') then
--      TimerHresetCnt    <= (others =>'0');
--      TimerHresetReg    <= '0';
--      TimerHresetEnaReg <= '0';
--    elsif(clock'event and clock='1') then
--      TimerHresetReg    <= '0';
--      TimerHresetEnaReg <= CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_REC_HRESET_ENA,0,0)(0);
--      if (PreTrg2Sig='1' and TimerHresetEnaReg='1') then
--        TimerHresetCnt <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_HRESET_TIMER,0,0);
--        TimerHresetReg <= '1';
--      elsif (TimerHresetCnt /= 0) then
--        TimerHresetCnt <= TimerHresetCnt - 1;
--        TimerHresetReg <= '1';
--      end if;
--    end if;
--  end process;
--
--  --
--  -- DAQ timer engine
--  --
--  TimerDaqTrgSel <= TNconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_TIMER_TRIG_SEL,0,0));
--  TimerDaqTrgSig <= L1ASig        when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_L1A)     else
--                    Pretrg0Sig    when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG0) else
--                    Pretrg1Sig    when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG1) else
--                    Pretrg2Sig    when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG2) else
--                    BCN0DelSig    when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_BCN0)    else
--                    RecErrorSig   when (TimerDaqTrgSel=MTF7_OPTO.TRG_COND_SEL_LOCAL)   else
--	            '1';
--  --
--  TimerDaqTrigDelayValSig <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DAQ_TIMER_TRG_DELAY,0,0);
--  TimerDaqDelay: LPM_PULSE_DELAY
--    generic map (
--      LPM_DELAY_SIZE	=> MTF7_OPTO.TB_OPTO_DELAY_SIZE
--    )
--    port map(
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena		=> H,
--      pulse_in		=> TimerDaqTrgSig,
--      pulse_out		=> TimerDaqTrigDelSig,
--      limit		=> TimerDaqTrigDelayValSig
--    );
--  --
--  TimerDaqProcReqSig <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_PROC_REQ,0,0));
--  TimerDaqProcAckSig <= ProcDAQDiagAckSig;  
--  --
--  TimerDaqClkEnaSig <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_TIMER_LOC_ENA,0,0));
--  TimerDaqStartSig  <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_TIMER_START,0,0));
--  TimerDaqLimitSig  <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DAQ_TIMER_LIMIT,0,0);
--  --
--  TimerDaq: LPM_TIMER_ENGINE 
--    generic map (
--      LPM_TIMER_SIZE	=> MTF7.TB_TIMER_SIZE
--    )
--    port map (
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena_in	=> TimerDaqClkEnaSig,
--      clk_ena_out	=> TimerDaqEngineClkEnaSig,
--      start		=> TimerDaqStartSig,
--      trigger		=> TimerDaqTrigDelSig,
--      repeat		=> L,
--      stop		=> TimerDaqStopSig,
--      limit		=> TimerDaqLimitSig,
--      count		=> TimerDaqCountSig
--    );
--
--  --
--  -- trigger signals delays
--  --
--  TrigDataSel <= TNconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_TRG_DATA_SEL,0,0));
--  TrigDataSig <= L1ASig        when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_L1A)     else
--                 Pretrg0Sig    when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_PRETRG0) else
--                 Pretrg1Sig    when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_PRETRG1) else
--                 Pretrg2Sig    when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_PRETRG2) else
--                 BCN0DelSig    when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_BCN0)    else
--                 RecErrorSig   when (TrigDataSel=MTF7_OPTO.TRG_COND_SEL_LOCAL)   else
--	         '1';
--  --
--  TrigDataDelayValSig <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DATA_TRG_DELAY,0,0);
--  L1A_delay: LPM_PULSE_DELAY
--    generic map (
--      LPM_DELAY_SIZE	=> MTF7_OPTO.TB_OPTO_DELAY_SIZE
--    )
--    port map(
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena		=> H,
--      pulse_in		=> TrigDataSig,
--      pulse_out		=> TrigDataDelSig,
--      limit		=> TrigDataDelayValSig
--    );
--
--  --
--  -- Diagnostics Data Acquisition
--  --
--  DAQDiagMemWrSig  <= CIIConnGetAreaWriteEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_DAQ_DIAG,0);
--  DAQDiagMemStrSig <= CIIConnGetAreaStrobe(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_DAQ_DIAG,0,ii_strobeN);
--  DAQDiagTimeSig   <= EVNcnt & BCNcnt;
--  --
--  for_diag_data:
--  for index in 0 to MTF7.RPC_LINK_NUM-1 generate
--    DAQDiagDataSig(OTF.GOL_DATA_SIZE*(index+1)-1 downto OTF.GOL_DATA_SIZE*index) <= ReceiverTestData(index);
--  end generate;
--  DAQDiagDataSig(MTF7_OPTO.DAQ_DIAG_DATA_SIZE-1 downto MTF7.RPC_LINK_NUM*OTF.GOL_DATA_SIZE) <= BCNcnt(OTF.RPC_LBSTD_BCN_WIDTH-1 downto 0) & BCN0DelSig & ReceiverValidH0;
--  
--  --
--  DAQDiagDataDelayValSig  <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DAQ_DATA_DELAY,0,0);
--  RMBDelay: DPM_PIPE
--    generic map (
--      LPM_DATA_WIDTH	=> MTF7_OPTO.DAQ_DIAG_DATA_SIZE,
--      LPM_DELAY_WIDTH	=> MTF7_OPTO.DAQ_DIAG_DATA_DELAY_SIZE
--  
--    )
--    port map(
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena		=> H,
--      delay		=> DAQDiagDataDelayValSig,
--      data_in		=> DAQDiagDataSig,
--      data_out		=> DAQDiagDataDelaySig
--    ); 
--  --
----  for_diag_mask:
----  for index in 0 to MTF7_OPTO.DAQ_DIAG_TRIG_NUM-1 generate
----    DAQDiagMaskSig(MTF7_OPTO.DAQ_DIAG_MASK_WIDTH*(index+1)-1 downto MTF7_OPTO.DAQ_DIAG_MASK_WIDTH*index) -->
----    <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DAQ_MASK,index,0);
----  end generate;
----  DAQDiagTrigReg(0)       <= TrigDataDelEvtSig;
----  DAQDiagEmptyStrSig      <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_EMPTY);
----  DAQDiagLostStrSig       <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_LOST);
----  DAQDiagWrAddrStrSig     <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_WR_ADDR);
----  DAQDiagRdAddrEnaSig     <= CIIConnGetBitsWriteEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ADDR);
----  DAQDiagRdAddrStrSig     <= CIIConnGetBitsWriteStr(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ADDR,ii_strobeN);
----  DAQDiagRdAddrSig        <= CIIConnGetBitsData(IIVecAll,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ADDR,0,0);
----  DAQDiagRdAddrTestStrSig <= CIIConnGetBitsReadEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ADDR);
----  DAQDiagMem :LPM_DIAG_DAQ
----    generic map(
----      LPM_DATA_WIDTH	=> MTF7_OPTO.DAQ_DIAG_DATA_SIZE,
----      LPM_TRIG_NUM	=> MTF7_OPTO.DAQ_DIAG_TRIG_NUM,
----      LPM_TIME_WIDTH	=> MTF7_OPTO.DAQ_DIAG_TIMER_SIZE,
----      LPM_MASK_WIDTH	=> MTF7_OPTO.DAQ_DIAG_MASK_WIDTH,
----      LPM_ADDR_WIDTH	=> MTF7_OPTO.DAQ_DIAG_ADDR_WIDTH,
----      LPM_MDATA_WIDTH	=> MTF7.TB_II_DATA_WIDTH,
----      DATA_REGISTERED	=> FALSE,
----      TIME_REGISTERED	=> FALSE,
----      TRIG_REGISTERED	=> TRUE
----  )
----    port map(
----      resetN		=> ii_resetN,
----      clock		=> clock,
----      data_ena		=> H,
----      data		=> DAQDiagDataDelaySig,
----      trig_ena		=> TimerDaqEngineClkEnaSig,
----      trig		=> DAQDiagTrigReg,
----      time		=> DAQDiagTimeSig,
----      mask		=> (others => '1'), -- @T@ DAQDiagMaskSig,
----      empty_str		=> DAQDiagEmptyStrSig,
----      empty		=> DAQDiagEmptySig,
----      empty_ack		=> DAQDiagEmptyAckSig,
----      lost_data_str	=> DAQDiagLostStrSig,
----      lost_data		=> DAQDiagLostSig,
----      lost_data_ack	=> DAQDiagLostAckSig,
----      wr_addr_str	=> DAQDiagWrAddrStrSig,
----      wr_addr		=> DAQDiagWrAddrSig,
----      wr_addr_ack	=> DAQDiagWrAddrAckSig,
----      rd_addr_str	=> DAQDiagRdAddrStrSig,
----      rd_addr_ena	=> DAQDiagRdAddrEnaSig,
----      rd_addr		=> DAQDiagRdAddrSig,
----      rd_addr_test_str	=> DAQDiagRdAddrTestStrSig,
----      rd_addr_test	=> DAQDiagRdAddrTestSig,
----      rd_addr_test_ack	=> DAQDiagRdAddrTestAckSig,
----      sim_loop		=> L,
----      proc_req		=> TimerDaqProcReqSig,
----      proc_ack		=> ProcDAQDiagAckSig,
----      memory_addr	=> ii_addr(MTF7_OPTO.DAQ_MEM_ADDR_SIZE-1 downto 0),
----      memory_data_in	=> ii_data,
----      memory_data_out	=> DAQDiagMemDataOutSig,
----      memory_wr		=> DAQDiagMemWrSig,
----      memory_str	=> DAQDiagMemStrSig
----    ); 
--
--  --
--  -- pulser timer engine
--  --
--  TimerPulserTrgSel <= TNconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_TIMER_TRIG_SEL,0,0));
--  TimerPulserTrgSig <= L1ASig        when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_L1A)     else
--                       Pretrg0Sig    when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG0) else
--                       Pretrg1Sig    when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG1) else
--                       Pretrg2Sig    when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_PRETRG2) else
--                       BCN0DelSig    when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_BCN0)    else
--                       RecErrorSig   when (TimerPulserTrgSel=MTF7_OPTO.TRG_COND_SEL_LOCAL)      else
--	               '1';
--  --
--  TimerPulserTrigDelayValSig <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_PULSER_TIMER_TRG_DELAY,0,0);
--  TimerPulserDelay: LPM_PULSE_DELAY
--    generic map (
--      LPM_DELAY_SIZE	=> MTF7_OPTO.TB_OPTO_DELAY_SIZE
--    )
--    port map(
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena		=> H,
--      pulse_in		=> TimerPulserTrgSig,
--      pulse_out		=> TimerPulserTrigDelSig,
--      limit		=> TimerPulserTrigDelayValSig
--    );
--  --
--  TimerPulseRepeatEnaSig <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_REPEAT_ENA,0,0));
--  TimerPulserProcReqSig  <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_PROC_REQ,0,0));
--  TimerPulserProcAckSig  <= PulseProcAckSig;  
--  --
--  TimerPulserClkEnaSig   <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_TIMER_LOC_ENA,0,0));
--  TimerPulserStartSig    <= TSLconv(CIIConnGetBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_TIMER_START,0,0));
--  TimerPulserLimitSig    <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_PULSER_TIMER_LIMIT,0,0);
--  --
--  TimerPulser: LPM_TIMER_ENGINE 
--    generic map (
--      LPM_TIMER_SIZE	=>MTF7.TB_TIMER_SIZE
--    )
--    port map (
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      clk_ena_in	=> TimerPulserClkEnaSig,
--      clk_ena_out	=> TimerPulserEngineClkEnaSig,
--      start		=> TimerPulserStartSig,
--      trigger		=> TimerPulserTrigDelSig,
--      repeat		=> TimerPulseRepeatEnaSig,
--      stop		=> TimerPulserStopSig,
--      limit		=> TimerPulserLimitSig,
--      count		=> TimerPulserCountSig
--    );
--
--  --
--  -- pulse engine
--  --
--  PulseDelaySig  <= CIIConnGetWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_PULSER_LENGTH,0,0);
--  PulseDataInSig <= (others => '0');
--  PulseMemWrSig  <= CIIConnGetAreaWriteEnA(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_PULSE,0);
--  PulseMemStrSig <= CIIConnGetAreaStrobe(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_PULSE,0,ii_strobeN);
--  PulseMem: DPM_PROG_PIPE
--    generic map(
--      LPM_DATA_WIDTH	=> MTF7_OPTO.PULSE_DATA_SIZE,
--      LPM_DELAY_WIDTH	=> MTF7_OPTO.PULSE_POS_SIZE,
--      LPM_MDATA_WIDTH	=> MTF7.TB_II_DATA_WIDTH,
--      OUTPUT_SEPARATE	=> TRUE,
--      OUTPUT_REGISTERED => TRUE
--    )
--    port map(
--      resetN		=> ii_resetN,
--      clock		=> clock,
--      delay		=> PulseDelaySig,
--      data_in		=> PulseDataInSig,
--      data_out		=> PulseDataOutSig,
--      clk_ena		=> TimerPulserEngineClkEnaSig,
--      init		=> L,
--      sim_loop		=> H,
--      proc_req		=> TimerPulserProcReqSig,
--      proc_ack		=> PulseProcAckSig,
--      mem_addr		=> ii_addr(MTF7_OPTO.PULSE_MEM_ADDR_SIZE-1 downto 0),
--      mem_data_in	=> ii_data,
--      mem_data_out	=> PulseMemDataOutSig,
--      mem_wr		=> PulseMemWrSig,
--      mem_str		=> PulseMemStrSig
--  );
--
--  --
--  -- internal interface
--  --
--  IIEnableSig  <= TSLconv(TNconv(II_addr(MTF7.TB_II_ADDR_WIDTH_SOFT-1 downto MTF7.TB_II_ADDR_WIDTH_SOFT-MTF7.TB_II_BASE_WIDTH))=(TNconv(ii_base)) and ii_operN='0');
--  IIEnableNSig <= not(IIEnableSig);
--  --
--  interf :CII_interface
--    generic map (
--      IICPAR       => MTF7_OPTO_tab,
--      IICPOS       => 0
--    )
--    port map(
--      II_resetN   => II_resetN,
--      II_operN    => IIEnableNSig,
--      II_writeN   => II_writeN,
--      II_strobeN  => II_strobeN, 
--      II_addr     => II_addr(MTF7.TB_II_ADDR_WIDTH_SOFT-1 downto 0),
--      II_data_in  => IIDataSig,
--      II_data_out => IIDataExport,
--      II_VecInt   => IIVecInt,
--      II_VecAll   => IIVecAll,
--      II_VecEna   => IIVecEna
--    );
--  --
--  IIVecAll <= IIVecInt
--              or CIIConnPutWordIPar(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_CHECKSUM,             0,0,MTF7_OPTO.CHECK_SUM,0)
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_BOARD,                0,0,TSLVconv(MTF7.TB_BOARD_IDENTIFIER,MTF7.TB_II_DATA_WIDTH))
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_IDENTIFIER,           0,0,TSLVconv(MTF7_OPTO.TB_OPTO_IDENTIFIER,MTF7.TB_II_DATA_WIDTH))
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_VERSION,              0,0,TSLVconv(MTF7_OPTO.TB_OPTO_VERSION,MTF7.TB_II_DATA_WIDTH))
--	      --										   
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TEST_CNT_CLK40,       0,0,Clk40Cnt)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TEST_CNT_CLK80,       0,0,Clk80Cnt)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TEST_CNT_BCN0,        0,0,BCN0Cnt)
--	      --							     			   
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_PLL_UNLOCK,    0,0,TSLVconv(PllUnlockHoldSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_STROBE_UNLOCK, 0,0,TSLVconv(Clk8StrobeUnlockHoldSig))
--	      --							     			   
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_OPTO_SIG,         0,0,trans_sd)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_RX_ERROR,         0,0,TLKErrorReg)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_TLK_RX_NO_DATA,       0,0,TLKNoDataReg)
--	      --										   
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_STATUS_REC_SYNCH_ACK, 0,0,StateSynchroFlag)
--              or CIIConnPutBitsTab (IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_REC_FAST_DATA_DELAY,      ReceiverFastDelay_get(ReceiverFastDelayReg))
--              or CIIConnPutBitsTab (IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_REC_DATA_DELAY,           ReceiverDelay_get(ReceiverDelayReg))
--	      --										   
--              or CIIConnPutWordTab (IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_TEST_DATA,            ReceiverTestData_get(ReceiverTestData))
--              or CIIConnPutWordTab (IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_TEST_OR_DATA,         ReceiverTestORData_get(ReceiverTestORdata))
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_REC_ERROR_COUNT,      0,0,RecErrorCountOutSig)
--	      --										   
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_TTC_BCN,              0,0,BCNCnt)
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_TTC_EVN,              0,0,EVNCnt)
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_TTC_TEST_DATA,        0,0,TTCTestDataSig)
--	      --							     			   
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_PULSER_TIMER_COUNT,   0,0,TimerPulserCountSig)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_TIMER_STOP,    0,0,TSLVconv(TimerPulserStopSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_PULSER_PROC_ACK,      0,0,TSLVconv(TimerPulserProcAckSig))
--              --							     			   
--              or CIIConnPutWordData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.WORD_DAQ_TIMER_COUNT,      0,0,TimerDAQCountSig)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_TIMER_STOP,       0,0,TSLVconv(TimerDAQStopSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_PROC_ACK,         0,0,TSLVconv(TimerDAQProcAckSig))
--              --							     			   
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_EMPTY,            0,0,TSLVconv(DAQDiagEmptySig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_EMPTY_ACK,        0,0,TSLVconv(DAQDiagEmptyAckSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_LOST,             0,0,TSLVconv(DAQDiagLostSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_LOST_ACK,         0,0,TSLVconv(DAQDiagLostAckSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_WR_ADDR,          0,0,DAQDiagWrAddrSig)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_WR_ACK,           0,0,TSLVconv(DAQDiagWrAddrAckSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ADDR,          0,0,DAQDiagRdAddrTestSig)
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_RD_ACK,           0,0,TSLVconv(DAQDiagRdAddrTestAckSig))
--              or CIIConnPutBitsData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_DAQ_PROC_ACK,         0,0,TSLVconv(TimerDaqProcAckSig))
--	      --
--              or CIIConnPutAreaMData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_DAQ_DIAG,          0,DAQDiagMemDataOutSig)
--              or CIIConnPutAreaMData(IIVecInt,MTF7_OPTO_tab,0,MTF7_OPTO.AREA_MEM_PULSE,             0,PulseMemDataOutSig)
--	      ;
--  IIDataExportEnable <= IIEnableSig and ii_writeN;
--  CIIData: UTLPM_BUSTRI
--    generic map (LPM_WIDTH => MTF7.TB_II_DATA_WIDTH)
--    port map    (i => IIDataExport,
--                 o => IIDataSig,
--                 p => ii_data,
--                 e => IIDataExportEnable);
--  --
--  ii_irqN <= '1' when (ii_resetN='1') else 'Z';
--  ii_ackN <= '0' when IIEnableSig='1' else 'Z';
--  --
--  process(ii_resetN, II_strobeN)
--  begin
--    if(ii_resetN='0') then
--      ReceiverFastDelayCIIreg <= (ReceiverFastDelayCIIreg'range => (others => '0'));
--      ReceiverDelayCIIreg     <= (ReceiverDelayCIIreg'range => (others => '0'));
--    elsif(II_strobeN'event and II_strobeN='1') then
--      for chan in 0 to MTF7.RPC_LINK_NUM-1 loop
--        if (CIIConnGetBitsWriteEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_REC_FAST_DATA_DELAY)='1') then
--          ReceiverFastDelayCIIreg(chan) <= SLVPartGet(IIDataSig,MTF7_OPTO.RECEIVER_FAST_DELAY_WIDTH,chan);
--        end if;
--        if (CIIConnGetBitsWriteEna(IIVecEna,MTF7_OPTO_tab,0,MTF7_OPTO.BITS_REC_DATA_DELAY)='1') then
--          ReceiverDelayCIIreg(chan) <= SLVPartGet(IIDataSig,MTF7_OPTO.RECEIVER_DELAY_WIDTH,chan);
--        end if;
--      end loop;
--    end if;
--  end process;
--
--  --
--  -- diagnostic interface
--  --
--  dummy <= PllLocksig and AND_REDUCE(ii_addr);
--  --
--  led_main <= LedMainSig when ii_resetN='1' or dummy='0' else (others => '0');
--
--  -- TLK2 signals
--  led_clock: LPM_CLOCK_PULSER
--    generic map (
--      LPM_DIVIDE_PAR		=> OTF.LHC_CLK_FREQ/LPM_LED_PULSE_FREQ,
--      LPM_DATA_PULSE_WIDTH	=> LPM_LED_PULSE_WIDTH,
--      LPM_PULSE_INVERT		=> TRUE	
--    )
--    port map (
--      resetN			=> ii_resetN,
--      Clock			=> clock,
--      pulse			=> LedMainSig(0)
--    );
--  --
--  led_clock2: LPM_CLOCK_PULSER
--    generic map (
--      LPM_DIVIDE_PAR		=> OTF.LHC_CLK_FREQ/LPM_LED_PULSE_FREQ,
--      LPM_DATA_PULSE_WIDTH	=> 2*LPM_LED_PULSE_WIDTH,
--      LPM_PULSE_INVERT		=> TRUE	
--    )
--    port map (
--      resetN			=> ii_resetN,
--      Clock			=> clock80,
--      pulse			=> LedMainSig(1)
--    );
--  --
--  led_iiaccess: LPM_PULSE_GENER
--    generic map (
--      LPM_PULSE_WIDTH		=> LPM_LED_PULSE_WIDTH,
--      LPM_TRIGGER_INVERT	=> FALSE,
--      LPM_PULSE_INVERT		=> TRUE	
--    )
--    port map (
--      resetN			=> ii_resetN,
--      Clock			=> Clock,
--      trigger			=> IIEnableSig,
--      pulse_out			=> LedMainSig(2)
--    );
--  --
--  TLKRxErrLed <= OR_REDUCE(TLKRxEnableSig and tlk_rx_er);
--  led_tlk_error: LPM_PULSE_GENER
--    generic map (
--      LPM_PULSE_WIDTH		=> LPM_LED_PULSE_WIDTH,
--      LPM_TRIGGER_INVERT	=> FALSE,
--      LPM_PULSE_INVERT		=> FALSE	
--    )
--    port map (
--      resetN			=> ii_resetN,
--      Clock			=> Clock,
--      trigger			=> TLKRxErrLed,
--      pulse_out			=> LedMainSig(3)
--    );
--
--  --
--  led_link <= LedLinkSig when ii_resetN='1' or dummy='0' else (others => '1');
--  --
--  loop_link:
--  for index in 0 to MTF7.RPC_LINK_NUM-1 generate
--    --
--    LedLinkSig(2*index)   <= TLKRxEnableSig(index) and TLKRxLckRefNSig(index) and not(trans_sd(index)) and not(tlk_rx_er(index)) and
--                             (not(LedMainSig(0)) or tlk_rx_dv(index));
--    LedLinkSig(2*index+1) <= TLKRxEnableSig(index) and TLKRxLckRefNSig(index) and
--                             ((not(LedMainSig(0)) and tlk_rx_er(index)) or trans_sd(index));
--  end generate;
--  --
--  test_lvds   <= '0';
--
--end behaviour;
