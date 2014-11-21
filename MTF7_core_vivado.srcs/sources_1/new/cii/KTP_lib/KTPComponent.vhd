-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2005 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;

use work.std_logic_1164_ktp.all;

package KTPComponent is

  component KTP_DFF is
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSL := '1';
      d				:in  TSL;
      q				:out TSL
    );
  end component;

  component KTP_CFF is
    generic (
      CLK0_INVERT		:in  boolean := FALSE;
      CLK1_INVERT		:in  boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk0			:in  TSL;
      ena0			:in  TSL := '1';
      clk1			:in  TSL;
      ena1			:in  TSL := '1';
      q				:out TSL
    );
  end component;

  component KTP_ASET_CRES is
    generic (
      ASET_INVERT		:in  boolean := FALSE;
      CLK_INVERT		:in  boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      aena			:in  TSL := '1';
      aset			:in  TSL;
      rena			:in  TSL := '1';
      rclk			:in  TSL;
      q				:out TSL
    );
  end component;

  component KTP_MUXDC is
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      enah			:in  TSL := '1';
      muxh			:in  TSL;
      enal			:in  TSL := '1';
      muxl			:in  TSL;
      mout			:out TSL
    );
  end component;

  component KTP_DFFDC is
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSL := '1';
      d				:in  TSL;
      q				:out TSL
    );
  end component;

  component KTP_LPM_DFF is
    generic (
      LPM_WIDTH			:in natural := 0
    );
    port(
      resetN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      setN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      clk			:in  TSLV(LPM_WIDTH-1 downto 0);
      ena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_REGENA is
    generic (
      LPM_WIDTH			:in natural := 0
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSLV(LPM_WIDTH-1 downto 0);
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_REGPRG is
    generic (
      LPM_WIDTH			:in natural := 0
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      prgN			:in  TSL := '1';
      dprg			:in  TSLV(LPM_WIDTH-1 downto 0);
      clk			:in  TSL;
      ena			:in  TSL;
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_MUXDC is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      enah			:in  TSL := '1';
      muxh			:in  TSLV(LPM_WIDTH-1 downto 0);
      enal			:in  TSL := '1';
      muxl			:in  TSLV(LPM_WIDTH-1 downto 0);
      mout			:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component ;
   
  component KTP_LPM_DFFDC is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
        resetN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
        setN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
        clk			:in  TSLV(LPM_WIDTH-1 downto 0);
        ena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
        d			:in  TSLV(LPM_WIDTH-1 downto 0);
        q			:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;
   
  component KTP_LPM_ASET_CRES is
  generic (
      LPM_WIDTH			:in natural := 4;
      ASET_INVERT		:in boolean := FALSE;
      CLK_INVERT		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL := '1';
      aena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      aset			:in  TSLV(LPM_WIDTH-1 downto 0);
      rena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      rclk			:in  TSL;
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_REGDC is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSL := '1';
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_XREGENA is
    generic (
      LPM_WIDTH			:in natural := 0
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      switch			:in  TSL;
      ena1			:in  TSLV(LPM_WIDTH-1 downto 0);
      d1			:in  TSLV(LPM_WIDTH-1 downto 0);
      q1			:out TSLV(LPM_WIDTH-1 downto 0);
      ena2			:in  TSLV(LPM_WIDTH-1 downto 0);
      d2			:in  TSLV(LPM_WIDTH-1 downto 0);
      q2			:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_REG is
    generic (
      LPM_WIDTH			:in natural := 0
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSL;
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
    );
  end component;

  component KTP_LPM_PULSE is
    generic (
      LPM_WIDTH			:in natural := 0;
      LPM_DELAY			:in natural := 0
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      pulse			:out TSL
    );
  end component;

  component KTP_LPM_SYNCH_IN is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      wr_str			:in  TSL;
      wr_ena			:in  TSL := '1';
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0);
      strobe			:out TSL;
      ack			:out TSL
    );
  end component;

  component KTP_LPM_SYNCH_IN1 is
    port(
      resetN			:in  TSL;
      setN			:in  TSL := '1';
      clk			:in  TSL;
      wr_str			:in  TSL;
      wr_ena			:in  TSL := '1';
      d				:in  TSL;
      q				:out TSL;
      strobe			:out TSL;
      ack			:out TSL
    );
  end component;

  component KTP_LPM_SYNCH_OUT is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      rd_str			:in  TSL;
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0);
      ack			:out TSL
    );
  end component;

  component KTP_LPM_SYNCH_OUT1 is
    generic (
      LPM_WIDTH			:in natural := 4
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      rd_str			:in  TSL;
      d				:in  TSL;
      q				:out TSL;
      ack			:out TSL
    );
  end component;

  component KTP_LPM_COUNT is
    generic (
      LPM_DATA_WIDTH		:in natural := 0;
      COUNT_STOP		:in boolean := FALSE;
      COUNT_RELOAD		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      clk_ena			:in  TSL := '1';
      initN			:in  TSL := '1';
      loadN			:in  TSL := '1';
      downN			:in  TSL := '1';
      setN			:in  TSL := '1';
      reloadN			:in  TSL := '1';
      data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      finishN			:out TSL;
      overN			:out TSL
    );
  end component;

  component KTP_LPM_COUNT_VAL is
    generic (
      LPM_VAL_WIDTH		:in natural := 0;
      LPM_DATA_WIDTH		:in natural := 0;
      COUNT_STOP		:in boolean := FALSE;
      COUNT_RELOAD		:in boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      clk_ena			:in  TSL := '1';
      val			:in  TSLV(LPM_VAL_WIDTH-1 downto 0);
      initN			:in  TSL := '1';
      loadN			:in  TSL := '1';
      downN			:in  TSL := '1';
      setN			:in  TSL := '1';
      reloadN			:in  TSL := '1';
      data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
      count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
      finishN			:out TSL;
      overN			:out TSL
    );
  end component;

  component LPM_RAND_GEN_TRANS_V1 is
    generic(
      LPM_DATA_WIDTH		:integer :=   0
    );
    port (
    resetN			:in  TSL;
    clock			:in  TSL;
    initN			:in  TSL;
    val				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    gen_out			:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    step			:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0)
    );
  end component;

  component LPM_RAND_GEN_TRANS_V2 is
    generic(
      LPM_GEN_WIDTH			:TN := 0;
      LPM_RND_INIT			:TN := 0;
      LPM_DATA_WIDTH			:TN := 0;
      LPM_STROBE_ENA			:TL := FALSE
    );
    port (
      resetN				:in  TSL;
      clock				:in  TSL;
      gen_ena				:in  TSL := '1';
      gen_strobe			:in  TSL := '0';
      gen_init				:in  TSLV(LPM_GEN_WIDTH-1 DOWNTO 0) := (others =>'0');
      gen_out				:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
      gen_in				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0) := (others =>'0');
      valid				:out TSL;
      valid_ena				:out TSL
    );
  end component;

  component KTP_LPM_MPIPE is
    generic (
      LPM_WIDTH			:in TP;
      LPM_MULTI			:in TP range 2 to TN'high;
      LPM_NUMBER		:in TP := 1;
      LPM_PIPE			:in TP := 1;
      LPM_IN_CLK_ENA		:in TL := FALSE;
      LPM_OUT_CLK_ENA		:in TL := FALSE;
      LPM_IN_MULTI		:in TL := TRUE;
      LPM_NUM_SWAP		:in TL := FALSE
    );
    port(
      resetN			:in  TSL;
      mclk			:in  TSL;
      mena			:in  TSL := '0';
      clk			:in  TSLV(LPM_MULTI-1 downto 0) := (others =>'0');
      ds			:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0) := (others =>'0');
      dp			:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0) := (others =>'0');
      qs			:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
      qp			:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
      ps			:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_WIDTH-1 downto 0);
      pp			:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
    );
  end component KTP_LPM_MPIPE;
  component KTP_LPM_MPIPEold is
    generic (
      LPM_WIDTH			:in TP;
      LPM_MULTI			:in TP range 2 to TN'high;
      LPM_NUMBER		:in TP := 1;
      LPM_PIPE			:in TP := 1;
      LPM_IN_MULTI		:in TL := TRUE;
      LPM_NUM_SWAP		:in TL := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      mena			:in  TSL;
      ds			:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0) := (others =>'0');
      dp			:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0) := (others =>'0');
      qs			:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
      qp			:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
      ps			:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_WIDTH-1 downto 0);
      pp			:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
    );
  end component KTP_LPM_MPIPEold;
  
  type     TKTP_LPMV_MPIPE      is record
                                   LPM_WIDTH    :TN;
                                   LPM_MULTI    :TN;
                                   LPM_NUMBER   :TN;
                                   LPM_PIPE     :TN;
                                   LPM_IN_MULTI :TL;
                                   LPM_NUM_SWAP :TL;
                                end record;

  function  KTP_LPMV_MPIPE(LPM_WIDTH, LPM_MULTI, LPM_NUMBER, LPM_PIPE :TP; LPM_IN_MULTI, LPM_NUM_SWAP :TL) return TKTP_LPMV_MPIPE;
  function  KTP_LPMV_MPIPE(LPM_WIDTH, LPM_MULTI, LPM_NUMBER           :TP; LPM_IN_MULTI, LPM_NUM_SWAP :TL) return TKTP_LPMV_MPIPE;
  
  function  KTP_LPMV_MPIPE(ktpc :TKTP_LPMV_MPIPE) return TN;

  procedure \KTP_LPMV_MPIPE\(ena, mena :TSL; ds, dp :TSLV; qs, qp, ps, pp :out TSLV; ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);

  procedure KTP_LPMV_MPIPE(  mena :TSL; d :TSLV;        qs, qp, ps, pp      :out TSLV;        ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE(  mena :TSL; d :TSLV;                       s, p :out TSLV;        ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE(  mena :TSL;                 qs, qp, ps, pp      :out TSLV;        ktpv :      TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE(  mena :TSL;                                s, p :out TSLV;        ktpv :      TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE(  mena :TSL; d :TSLV; signal                                       ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);
  
  procedure KTP_LPMV_MPIPE_S(mena :TSL; d :TSLV; signal qs, qp, ps, pp      :out TSLV; signal ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE_S(mena :TSL; d :TSLV; signal                s, p :out TSLV; signal ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE_S(mena :TSL;          signal qs, qp, ps, pp      :out TSLV;        ktpv :      TSLV; ktpc :TKTP_LPMV_MPIPE);
  procedure KTP_LPMV_MPIPE_S(mena :TSL;          signal                s, p :out TSLV;        ktpv :      TSLV; ktpc :TKTP_LPMV_MPIPE);
  function  KTP_LPMV_MPIPE_S(mena :TSL;                                                       ktpv :      TSLV; ktpc :TKTP_LPMV_MPIPE) return TSLV; -- returns qs

  component KTP_LPM_MPIPE_CUT is
    generic (
      LPM_WIDTH			:in TP;
      LPM_MULTI			:in TP range 2 to TN'high;
      LPM_NUMBER		:in TP := 1;
      LPM_PIPE_LEN		:in TP := 1;
      LPM_CUT_POS		:in TN := 0;
      LPM_IN_CLK_ENA		:in TL := FALSE;
      LPM_OUT_CLK_ENA		:in TL := FALSE;
      LPM_IN_MULTI		:in TL := TRUE;
      LPM_NUM_SWAP		:in TL := FALSE
    );
    port(
      resetN			:in  TSL := '1';
      mclk			:in  TSL;
      mena			:in  TSL;
      clk		        :in  TSLV(LPM_MULTI-1 downto 0);
      cut			:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0) := (others =>'0');
      ds			:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0) := (others =>'0');
      dp			:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0) := (others =>'0');
      qs			:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
      qp			:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
    );
  end component KTP_LPM_MPIPE_CUT;
  
end KTPComponent;

package body KTPComponent is

  
  function KTP_LPMV_MPIPE(LPM_WIDTH, LPM_MULTI, LPM_NUMBER, LPM_PIPE :TP; LPM_IN_MULTI, LPM_NUM_SWAP :TL) return TKTP_LPMV_MPIPE is
    variable res :TKTP_LPMV_MPIPE;
  begin
    res.LPM_WIDTH    := LPM_WIDTH;
    res.LPM_MULTI    := LPM_MULTI;
    res.LPM_NUMBER   := LPM_NUMBER;
    res.LPM_PIPE     := LPM_PIPE;
    res.LPM_IN_MULTI := LPM_IN_MULTI;
    res.LPM_NUM_SWAP := LPM_NUM_SWAP;
    return(res);
  end;
  
  function KTP_LPMV_MPIPE(LPM_WIDTH, LPM_MULTI, LPM_NUMBER :TP; LPM_IN_MULTI, LPM_NUM_SWAP :TL) return TKTP_LPMV_MPIPE is begin
    return(KTP_LPMV_MPIPE(LPM_WIDTH, LPM_MULTI, LPM_NUMBER, 1, LPM_IN_MULTI, LPM_NUM_SWAP));
  end function;

  function KTP_LPMV_MPIPE(ktpc :TKTP_LPMV_MPIPE) return TN is
  begin
    return(1+2*ktpc.LPM_PIPE)*ktpc.LPM_NUMBER*ktpc.LPM_MULTI*ktpc.LPM_WIDTH;
  end;
  
  procedure \KTP_LPMV_MPIPE\(ena, mena :TSL; ds, dp :TSLV; qs, qp, ps, pp :out TSLV; ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    
    constant WIDTH              :TN  := sel(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER, ktpc.LPM_WIDTH, ktpc.LPM_NUM_SWAP);
    constant NUMBER             :TN  := sel(1, ktpc.LPM_NUMBER, ktpc.LPM_NUM_SWAP);
    --
    type     Tmreg              is array(0 to NUMBER*ktpc.LPM_MULTI-1) of TSLV(WIDTH-1 downto 0);
    type     Tmpipe             is array(0 to ktpc.LPM_PIPE-1)  of Tmreg;
    variable MpipeVar           :Tmpipe;
    --
    type     Tpipe              is array(0 to ktpc.LPM_PIPE-1)  of TSLV(NUMBER*ktpc.LPM_MULTI*WIDTH-1 downto 0);
    variable PipeVar            :Tpipe;
    --
    variable ParOutVar          :Tmreg;
    --
    variable pos, len           :TN;
    variable N                  :TN;
  begin
  
    pos := 0; len := WIDTH;
    for p in 0 to ktpc.LPM_PIPE-1 loop
      for n in 0 to NUMBER*ktpc.LPM_MULTI-1 loop
        MpipeVar(p)(n) := ktpv(len+pos-1 downto pos); pos := pos+len;
      end loop;
    end loop;
    for n in 0 to NUMBER*ktpc.LPM_MULTI-1 loop
      ParOutVar(n) := ktpv(len+pos-1 downto pos); pos := pos+len;
    end loop;
    len := NUMBER*ktpc.LPM_MULTI*WIDTH;
    for p in 0 to ktpc.LPM_PIPE-1 loop
      PipeVar(p) := ktpv(len+pos-1 downto pos); pos := pos+len;
    end loop;
    --
    if (ena='1') then
      for num in 0 to NUMBER-1 loop
        N := ktpc.LPM_MULTI*num;
        if (ktpc.LPM_PIPE>1) then
          for p in ktpc.LPM_PIPE-1 downto 1 loop
            for m in 0 to ktpc.LPM_MULTI-2 loop
              MpipeVar(p)(N+m) := MpipeVar(p)(N+m+1);
            end loop;
            MpipeVar(p)(N+ktpc.LPM_MULTI-1) := MpipeVar(p-1)(N+0);
          end loop;
        end if;
        if (ktpc.LPM_IN_MULTI=FALSE and mena='1') then
          for m in 0 to ktpc.LPM_MULTI-1 loop
            MpipeVar(0)(N+m) := SLVPartGet(dp,WIDTH,N+m);
          end loop;
        else
          MpipeVar(0)(N+0 to N+ktpc.LPM_MULTI-2) := MpipeVar(0)(N+1 to N+ktpc.LPM_MULTI-1);
          if (ktpc.LPM_IN_MULTI=FALSE) then
            MpipeVar(0)(N+ktpc.LPM_MULTI-1) := (others => '0');
          else
            MpipeVar(0)(N+ktpc.LPM_MULTI-1) := SLVPartGet(ds,WIDTH,num);
          end if;
        end if;
        if (mena='1') then
          --ParOut <= MpipeVar(LPM_PIPE-1);
          for p in 0 to ktpc.LPM_PIPE-1 loop
            for m in 0 to ktpc.LPM_MULTI-1 loop
              PipeVar(p)(WIDTH*(N+m+1)-1 downto WIDTH*(N+m)) := MpipeVar(p)(N+m);
            end loop;
          end loop;
        end if;
      end loop;
      if (mena='1') then
        ParOutVar := MpipeVar(ktpc.LPM_PIPE-1);
      end if;
      --
      pos := 0; len := WIDTH;
      for p in 0 to ktpc.LPM_PIPE-1 loop
        for n in 0 to NUMBER*ktpc.LPM_MULTI-1 loop
          ktpv(len+pos-1 downto pos) := MpipeVar(p)(n); pos := pos+len;
        end loop;
      end loop;
      for n in 0 to NUMBER*ktpc.LPM_MULTI-1 loop
        ktpv(len+pos-1 downto pos) := ParOutVar(n); pos := pos+len;
      end loop;
      len := NUMBER*ktpc.LPM_MULTI*WIDTH;
      for p in 0 to ktpc.LPM_PIPE-1 loop
        ktpv(len+pos-1 downto pos) := PipeVar(p); pos := pos+len;
      end loop;
    end if;
    --
    for n in 0 to NUMBER-1 loop
      qs(WIDTH*(n+1)-1 downto WIDTH*n) := MpipeVar(ktpc.LPM_PIPE-1)(ktpc.LPM_MULTI*n);
    end loop;
    --
    for M in 0 to NUMBER*ktpc.LPM_MULTI-1 loop
      qp(WIDTH*(M+1)-1 downto WIDTH*M) := ParOutVar(M);
    end loop;
    --
    for p in 0 to ktpc.LPM_PIPE-1 loop
      for n in 0 to NUMBER-1 loop
        ps(WIDTH*((n+NUMBER*p)+1)-1 downto WIDTH*(n+NUMBER*p)) := MpipeVar(p)(ktpc.LPM_MULTI*n);
      end loop;
    end loop;
    --
    for p in 0 to ktpc.LPM_PIPE-1 loop
      pp(NUMBER*ktpc.LPM_MULTI*WIDTH*(p+1)-1 downto NUMBER*ktpc.LPM_MULTI*WIDTH*p) := PipeVar(p);
    end loop;
    --
  end procedure;
  --
  procedure KTP_LPMV_MPIPE(mena :TSL; d:TSLV; qs, qp, ps, pp :out TSLV; ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable dsvar        :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable dpvar        :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
  begin
    dsvar := (others => '0');
    dpvar := (others => '0');
    if (ktpc.LPM_IN_MULTI=TRUE) then dsvar := d; else dpvar := d; end if;
    \KTP_LPMV_MPIPE\('1', mena, dsvar, dpvar, qs, qp, ps, pp, ktpv, ktpc);
  end procedure;
  --
  procedure KTP_LPMV_MPIPE(mena :TSL; d:TSLV; s, p :out TSLV; ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable qsvar :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable qpvar :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
    variable psvar :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
    variable ppvar :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
  begin
    KTP_LPMV_MPIPE(mena, d, qsvar, qpvar, psvar, ppvar, ktpv, ktpc);
    if    (s'length=qsvar'length and p'length=qpvar'length) then s := qsvar; p := qpvar;
    elsif (s'length=psvar'length and p'length=ppvar'length) then s := psvar; p := ppvar;
    else  assert (FALSE)  report "arguments 's' or 'p' have incorrect size"  severity error;
    end if;
  end procedure;
  --
  procedure KTP_LPMV_MPIPE(mena :TSL; qs, qp, ps, pp :out TSLV; ktpv :TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable dsnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable dpnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
    variable ktpvv  :TSLV(ktpv'range);
  begin
    dsnull := (others => '0');
    dpnull := (others => '0');
    ktpvv := ktpv;
    \KTP_LPMV_MPIPE\('0', mena, dsnull, dpnull, qs, qp, ps, pp, ktpvv, ktpc);
  end procedure;

  procedure KTP_LPMV_MPIPE(mena :TSL; s, p :out TSLV; ktpv :TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable qsvar  :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable qpvar  :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
    variable psvar  :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
    variable ppvar  :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
  begin
    KTP_LPMV_MPIPE(mena, qsvar, qpvar, psvar, ppvar, ktpv, ktpc);
    if    (s'length=qsvar'length and p'length=qpvar'length) then s := qsvar; p := qpvar;
    elsif (s'length=psvar'length and p'length=ppvar'length) then s := psvar; p := ppvar;
    else  assert (FALSE)  report "arguments 's' or 'p' have incorrect size"  severity error;
    end if;
  end procedure;
  --
  procedure KTP_LPMV_MPIPE(mena :TSL; d:TSLV; signal ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable qsnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable qpnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
    variable psnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
    variable ppnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER*ktpc.LPM_PIPE-1 downto 0);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, d, qsnull, qpnull, psnull, ppnull, ktpvv, ktpc);
    ktpv <= ktpvv;
  end procedure;
  --
  procedure KTP_LPMV_MPIPE_S(mena :TSL; d:TSLV; signal qs, qp, ps, pp :out TSLV; signal ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable qsvar :TSLV(qs'range);
    variable qpvar :TSLV(qp'range);
    variable psvar :TSLV(ps'range);
    variable ppvar :TSLV(pp'range);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, d, qsvar, qpvar, psvar, ppvar, ktpvv, ktpc);
    qs   <= qsvar;
    qp   <= qpvar;
    ps   <= psvar;
    pp   <= ppvar;
    ktpv <= ktpvv;
  end procedure;
  --
  procedure KTP_LPMV_MPIPE_S(mena :TSL; d:TSLV; signal s, p :out TSLV; signal ktpv :inout TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable svar  :TSLV(s'range);
    variable pvar  :TSLV(p'range);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, d, svar, pvar, ktpvv, ktpc);
    s    <= svar;
    p    <= pvar;
    ktpv <= ktpvv;
  end procedure;
  --
  procedure KTP_LPMV_MPIPE_S(mena :TSL; signal qs, qp, ps, pp :out TSLV; ktpv :TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable qsvar :TSLV(qs'range);
    variable qpvar :TSLV(qp'range);
    variable psvar :TSLV(ps'range);
    variable ppvar :TSLV(pp'range);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, qsvar, qpvar, psvar, ppvar, ktpvv, ktpc);
    qs <= qsvar;
    qp <= qpvar;
    ps <= psvar;
    pp <= ppvar;
  end procedure;

  procedure KTP_LPMV_MPIPE_S(mena :TSL; signal s, p :out TSLV; ktpv :TSLV; ktpc :TKTP_LPMV_MPIPE) is
    variable svar  :TSLV(s'range);
    variable pvar  :TSLV(p'range);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, svar, pvar, ktpvv, ktpc);
    s <= svar;
    p <= pvar;
  end procedure;

  function KTP_LPMV_MPIPE_S(mena :TSL; ktpv :TSLV; ktpc :TKTP_LPMV_MPIPE) return TSLV is
    variable qsvar  :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_NUMBER-1 downto 0);
    variable qpnull :TSLV(ktpc.LPM_WIDTH*ktpc.LPM_MULTI*ktpc.LPM_NUMBER-1 downto 0);
    variable ktpvv :TSLV(ktpv'range);
  begin
    ktpvv := ktpv;
    KTP_LPMV_MPIPE(mena, qsvar, qpnull, ktpvv, ktpc);
    return(qsvar);
  end function;

end KTPComponent;

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_DFF is
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    ena				:in  TSL := '1';
    d				:in  TSL;
    q				:out TSL
  );
end KTP_DFF;

architecture behaviour of KTP_DFF is

  signal   reg			:TSL;

begin

  process(clk, resetN, setN, ena) begin
    if (resetN='0') then
      reg <= '0';
    elsif (setN='0') then
      reg <= '1';
    elsif (clk'event and clk='1') then
      if (ena='1') then
        reg <= d;
      end if;
    end if;
  end process;
  
  q <= reg;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_CFF is
  generic (
    CLK0_INVERT			:in  boolean := FALSE;
    CLK1_INVERT			:in  boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk0			:in  TSL;
    ena0			:in  TSL := '1';
    clk1			:in  TSL;
    ena1			:in  TSL := '1';
    q				:out TSL
  );
end KTP_CFF;

architecture behaviour of KTP_CFF is

  signal   Clk0sig, Clk1Sig	:TSL;
  signal   Reg0, Reg1		:TSL;
  signal   OutSig		:TSL;

begin

  Clk0Sig <= clk0 when (CLK0_INVERT=FALSE) else not(clk0);
  Clk1Sig <= clk1 when (CLK0_INVERT=FALSE) else not(clk1);
  
  process(Clk0Sig, resetN, setN, OutSig) begin
    if (resetN='0') then
      reg0 <= '0';
    elsif (setN='0') then
      reg0 <= '0';
    elsif (Clk0Sig'event and Clk0Sig='1') then
      if (ena0='1' and OutSig='1') then
        Reg0 <= not(Reg0);
      end if;
    end if;
  end process;
  
  process(Clk1Sig, resetN, setN, OutSig) begin
    if (resetN='0') then
      reg1 <= '0';
    elsif (setN='0') then
      reg1 <= '1';
    elsif (Clk1Sig'event and Clk1Sig='1') then
      if (ena1='1' and OutSig='0') then
        Reg1 <= not(Reg1);
      end if;
    end if;
  end process;
  
  OutSig <= Reg0 xor Reg1;
  q <= OutSig;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_ASET_CRES is
  generic (
    ASET_INVERT			:in  boolean := FALSE;
    CLK_INVERT			:in  boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    aena			:in  TSL := '1';
    aset			:in  TSL;
    rena			:in  TSL := '1';
    rclk			:in  TSL;
    q				:out TSL
  );
end KTP_ASET_CRES;

architecture behaviour of KTP_ASET_CRES is

  signal   RclkSig		:TSL;
  signal   AsetSig		:TSL;
  signal   Reg			:TSL;

begin

  AsetSig  <= (aset and aena) when (ASET_INVERT=FALSE) else (not(aset) and aena);
  RclkSig  <= rclk when (CLK_INVERT=FALSE) else not(rclk);
  
  process(resetN, AsetSig, RclkSig) begin
    if (resetN='0') then
      Reg <= '0';
    elsif (AsetSig='1') then
      Reg <= '1';
    elsif (RclkSig'event and RclkSig='1') then
      if (rena='1') then
        Reg <= '0';
      end if;
    end if;
  end process;
  
  q <= Reg;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_MUXDC is
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    enah			:in  TSL := '1';
    muxh			:in  TSL;
    enal			:in  TSL := '1';
    muxl			:in  TSL;
    mout			:out TSL
  );
end KTP_MUXDC;

architecture behaviour of KTP_MUXDC is

  signal Regl, Regh :TSL;

begin

  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regl <= '0';
    elsif (setN='0') then
      Regl <= '0';
    elsif (clk'event and clk='0') then
      if (enal='1') then
        Regl <= Regh xor muxl;
      end if;
    end if;
  end process;
  
  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regh <= '0';
    elsif (setN='0') then
      Regh <= '1';
    elsif (clk'event and clk='1') then
      if (enah='1') then
        Regh <= Regl xor muxh;
      end if;
    end if;
  end process;
    
  mout <= Regl xor Regh;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_DFFDC is
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    ena				:in  TSL := '1';
    d				:in  TSL;
    q				:out TSL
  );
end KTP_DFFDC;

architecture behaviour of KTP_DFFDC is

  signal Regl, Regh :TSL;

begin

  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regl <= '0';
    elsif (setN='0') then
      Regl <= '0';
    elsif (clk'event and clk='0') then
      if (ena='1') then
        Regl <= Regh xor d;
      end if;
    end if;
  end process;
  
  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regh <= '0';
    elsif (setN='0') then
      Regh <= '1';
    elsif (clk'event and clk='1') then
      if (ena='1') then
        Regh <= Regl xor d;
      end if;
    end if;
  end process;
    
  q <= Regl xor Regh;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_DFF is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
      resetN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      setN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      clk			:in  TSLV(LPM_WIDTH-1 downto 0);
      ena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_DFF;

architecture behaviour of KTP_LPM_DFF is
begin

  l1:
  for index in 0 to LPM_WIDTH-1 generate
    creg: KTP_DFF
      port map(
        resetN => resetN(index),
        setN   => setN(index),
        clk    => clk(index),
        ena    => ena(index),
        d      => d(index),
        q      => q(index)
      );
  end generate;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.KTPcomponent.all;

entity KTP_LPM_ASET_CRES is
  generic (
    LPM_WIDTH			:in natural := 4;
    ASET_INVERT			:in boolean := FALSE;
    CLK_INVERT			:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    aena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
    aset			:in  TSLV(LPM_WIDTH-1 downto 0);
    rena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
    rclk			:in  TSL;
    q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_ASET_CRES;

architecture behaviour of KTP_LPM_ASET_CRES is

begin

  l1:
  for index in 0 to LPM_WIDTH-1 generate
    creg: KTP_ASET_CRES
      port map(
        resetN => resetN,
        aena   => aena(index),
        aset   => aset(index),
        rena   => rena(index),
        rclk   => rclk,
        q      => q(index)
      );
  end generate;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_MUXDC is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    enah			:in  TSL := '1';
    muxh			:in  TSLV(LPM_WIDTH-1 downto 0);
    enal			:in  TSL := '1';
    muxl			:in  TSLV(LPM_WIDTH-1 downto 0);
    mout			:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_MUXDC;

architecture behaviour of KTP_LPM_MUXDC is

  signal Regl, Regh :TSLV(LPM_WIDTH-1 downto 0);

begin

  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regl <= (others => '0');
    elsif (setN='0') then
      Regl <= (others => '0');
    elsif (clk'event and clk='0') then
      if (enal='1') then
        Regl <= Regh xor muxl;
      end if;
    end if;
  end process;
  
  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regh <= (others => '0');
    elsif (setN='0') then
      Regh <= (others => '1');
    elsif (clk'event and clk='1') then
      if (enah='1') then
        Regh <= Regl xor muxh;
      end if;
    end if;
  end process;
    
  mout <= Regl xor Regh;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_DFFDC is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
      resetN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      setN			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      clk			:in  TSLV(LPM_WIDTH-1 downto 0);
      ena			:in  TSLV(LPM_WIDTH-1 downto 0) := (others => '1');
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_DFFDC;

use work.KTPComponent.all;

architecture behaviour of KTP_LPM_DFFDC is

  signal Regl, Regh :TSLV(LPM_WIDTH-1 downto 0);

begin

  l1:
  for index in 0 to LPM_WIDTH-1 generate
    cmux: KTP_DFFDC
      port map(
        resetN => resetN(index),
        setN   => setN(index),
        clk    => clk(index),
        ena    => ena(index),
        d      => d(index),
        q      => q(index)
      );
  end generate;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_REGDC is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    ena				:in  TSL := '1';
    d				:in  TSLV(LPM_WIDTH-1 downto 0);
    q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_REGDC;

architecture behaviour of KTP_LPM_REGDC is

  signal Regl, Regh :TSLV(LPM_WIDTH-1 downto 0);

begin

  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regl <= (others => '0');
    elsif (setN='0') then
      Regl <= (others => '0');
    elsif (clk'event and clk='0') then
      if (ena='1') then
        Regl <= Regh xor d;
      end if;
    end if;
  end process;
  
  process(clk, resetN, setN) begin
    if (resetN='0') then
      Regh <= (others => '0');
    elsif (setN='0') then
      Regh <= (others => '1');
    elsif (clk'event and clk='1') then
      if (ena='1') then
        Regh <= Regl xor d;
      end if;
    end if;
  end process;
    
  q <= Regl xor Regh;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_REGENA is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
      resetN			:in  TSL := '1';
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSLV(LPM_WIDTH-1 downto 0);
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_REGENA;

architecture behaviour of KTP_LPM_REGENA is

  signal reg			:TSLV(LPM_WIDTH-1 downto 0);

begin

  process(clk, resetN, setN, ena) begin
    if (resetN='0') then
      reg <= (others => '0');
    elsif (setN='0') then
      reg <= (others => '1');
    elsif (clk'event and clk='1') then
      for index in 0 to LPM_WIDTH-1 loop
        if (ena(index)='1') then
          reg(index) <= d(index);
        end if;
      end loop;
    end if;
  end process;
  
  q <= reg;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_REGPRG is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
      resetN			:in  TSL := '1';
      setN			:in  TSL := '1';
      prgN			:in  TSL := '1';
      dprg			:in  TSLV(LPM_WIDTH-1 downto 0);
      clk			:in  TSL;
      ena			:in  TSL;
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_REGPRG;

architecture behaviour of KTP_LPM_REGPRG is

  signal ResetNsig			:TSLV(LPM_WIDTH-1 downto 0);
  signal SetNsig			:TSLV(LPM_WIDTH-1 downto 0);
  signal ClkSig			:TSLV(LPM_WIDTH-1 downto 0);
  signal EnaSig			:TSLV(LPM_WIDTH-1 downto 0);

begin
  
  ResetNsig <= (others => '0') when (resetN='0') else
               dprg            when (prgN='0')   else
	       (others => '1');

  SetNsig   <= (others => '0') when (setN='0') else
               not(dprg)       when (prgN='0') else
	       (others => '1');
  ClkSig <= (others => clk);
  EnaSig <= (others => ena);

  reg :KTP_LPM_DFF
    generic map (
      LPM_WIDTH => LPM_WIDTH
    )
    port map (
      resetN    => ResetNsig,
      setN      => SetNsig,
      clk       => ClkSig,
      ena       => EnaSig,
      d         => d,
      q         => q
    );
  
end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_XREGENA is
  generic (
    LPM_WIDTH			:in natural := 8
  );
  port(
      resetN			:in  TSL := '1';
      setN			:in  TSL := '1';
      clk			:in  TSL;
      switch			:in  TSL;
      ena1			:in  TSLV(LPM_WIDTH-1 downto 0);
      d1			:in  TSLV(LPM_WIDTH-1 downto 0);
      q1			:out TSLV(LPM_WIDTH-1 downto 0);
      ena2			:in  TSLV(LPM_WIDTH-1 downto 0);
      d2			:in  TSLV(LPM_WIDTH-1 downto 0);
      q2			:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_XREGENA;

architecture behaviour of KTP_LPM_XREGENA is

  signal reg1			:TSLV(LPM_WIDTH-1 downto 0);
  signal reg2			:TSLV(LPM_WIDTH-1 downto 0);

begin

  process(clk, resetN, setN)

    variable ena1var		:TSLV(LPM_WIDTH-1 downto 0);
    variable d1var		:TSLV(LPM_WIDTH-1 downto 0);
    variable reg1var		:TSLV(LPM_WIDTH-1 downto 0);
    variable ena2var		:TSLV(LPM_WIDTH-1 downto 0);
    variable d2var		:TSLV(LPM_WIDTH-1 downto 0);
    variable reg2var		:TSLV(LPM_WIDTH-1 downto 0);

  begin

    if (resetN='0') then
      reg1 <= (others => '0');
      reg2 <= (others => '0');
    elsif (setN='0') then
      reg1 <= (others => '1');
      reg2 <= (others => '1');
    elsif (clk'event and clk='1') then
      ena1var := SLVMux(ena1, ena2, switch);
      d1var   := SLVMux(d1,   d2,   switch);
      reg1var := reg1;
      ena2var := SLVMux(ena2, ena1, switch);
      d2var   := SLVMux(d2,   d1,   switch);
      reg2var := reg2;
      for index in 0 to LPM_WIDTH-1 loop
        if (ena1var(index)='1') then
          reg1var(index) := d1var(index);
        end if;
        if (ena2var(index)='1') then
          reg2var(index) := d2var(index);
        end if;
      end loop;
      reg1 <= reg1var;
      reg2 <= reg2var;
    end if;
  end process;
  
  q1 <= reg1 when switch='0' else reg2;
  q2 <= reg2 when switch='0' else reg1;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_REG is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
      resetN			:in  TSL := '1';
      setN			:in  TSL := '1';
      clk			:in  TSL;
      ena			:in  TSL;
      d				:in  TSLV(LPM_WIDTH-1 downto 0);
      q				:out TSLV(LPM_WIDTH-1 downto 0)
  );
end KTP_LPM_REG;

architecture behaviour of KTP_LPM_REG is

  signal reg			:TSLV(LPM_WIDTH-1 downto 0);

begin

  process(clk, resetN, setN, ena) begin
    if (resetN='0') then
      reg <= (others => '0');
    elsif (setN='0') then
      reg <= (others => '1');
    elsif (clk'event and clk='1') then
      if (ena='1') then
        reg <= d;
      end if;
    end if;
  end process;
  
  q <= reg;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_PULSE is
  generic (
    LPM_WIDTH			:in natural := 2;
    LPM_DELAY			:in natural := 0
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    pulse			:out TSL
  );
end KTP_LPM_PULSE;

architecture behaviour of KTP_LPM_PULSE is

  signal H			:TSL;
  signal ClkSig			:TSLV(LPM_WIDTH-1 downto 0);
  signal QSig			:TSLV(LPM_WIDTH-1 downto 0);
  signal ResetNSig		:TSL;

begin

  H <= '1';
  ClkSig(0) <= clk;
  l1:
  for index in 0 to LPM_WIDTH-1 generate
    creg: component  KTP_DFF
      port map(
        resetN => ResetNSig,
        setN   => H,
        clk    => ClkSig(index),
        ena    => H,
        d      => H,
        q      => QSig(index)
      );
  end generate;

  l2:
  if (LPM_WIDTH>1) generate
     ClkSig(LPM_WIDTH-1 downto 1) <= QSig(LPM_WIDTH-2 downto 0);
  end generate;

  ResetNSig <= ResetN and (not QSig(LPM_WIDTH-1));
  pulse <= OR_REDUCE( QSig(LPM_WIDTH-1 downto LPM_DELAY));

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_SYNCH_IN is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    wr_str			:in  TSL;
    wr_ena			:in  TSL := '1';
    d				:in  TSLV(LPM_WIDTH-1 downto 0);
    q				:out TSLV(LPM_WIDTH-1 downto 0);
    strobe			:out TSL;
    ack				:out TSL
  );
end KTP_LPM_SYNCH_IN;

use work.KTPComponent.all;

architecture behaviour of KTP_LPM_SYNCH_IN is

  signal H			:TSL;
  signal WriteNegSig		:TSL;
  signal AsynchReg		:TSLV(LPM_WIDTH-1 downto 0);
  signal SynchReg		:TSLV(LPM_WIDTH-1 downto 0);
  signal WriteHoldSig		:TSL;
  signal LoadReg		:TSL;
  signal LoadRegNegSig		:TSL;
  signal StrobeReg		:TSL;
  signal AckSig			:TSL;

begin

  H <= '1';
  WriteNegSig <= not(wr_str);
  LoadRegNegSig <= not(LoadReg);

  write_hold_comp: KTP_CFF
    generic map (
      CLK0_INVERT => FALSE,
      CLK1_INVERT => FALSE
    )
    port map (
      resetN => resetN,
      setN   => H,
      clk0   => LoadRegNegSig,
      ena0   => H,
      clk1   => WriteNegSig,
      ena1   => wr_ena,--enable,
      q	     => WriteHoldSig
    );

  ack_comp: KTP_CFF
    generic map (
      CLK0_INVERT => FALSE,
      CLK1_INVERT => FALSE
    )
    port map (
      resetN => resetN,
      setN   => H,
      clk0   => WriteHoldSig,
      ena0   => H,
      clk1   => LoadRegNegSig,
      ena1   => H,
      q	     => AckSig
    );

  process (clk, resetN, setN) begin
    if (resetN='0') then
      SynchReg  <= (others => '0');
      LoadReg   <= '0';
      StrobeReg <= '0';
    elsif (setN='0') then
      SynchReg  <= (others => '1');
      LoadReg   <= '0';
      StrobeReg <='0';
    elsif (clk'event and clk='1') then
      if (WriteHoldSig='1') then
        if (LoadReg='0') then
          LoadReg <='1';
        else
          SynchReg <= AsynchReg;
	  LoadReg <='0';
	end if;
      end if;
      StrobeReg <= LoadReg;
    end if;
  end process;
  
  process (WriteNegSig, resetN) begin
    if (resetN='0') then
      AsynchReg <= (others => '0');
    elsif (WriteNegSig'event and WriteNegSig='1') then
      if (wr_ena='1' and WriteHoldSig='0') then
        AsynchReg <= d;
      end if;
    end if;
  end process;

  q <= SynchReg;
  strobe <= StrobeReg;
  ack <= AckSig;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_SYNCH_IN1 is
  port(
    resetN			:in  TSL := '1';
    setN			:in  TSL := '1';
    clk				:in  TSL;
    wr_str			:in  TSL;
    wr_ena			:in  TSL := '1';
    d				:in  TSL;
    q				:out TSL;
    strobe			:out TSL;
    ack				:out TSL
  );
end KTP_LPM_SYNCH_IN1;

use work.KTPComponent.all;

architecture behaviour of KTP_LPM_SYNCH_IN1 is

  signal DVec			:TSLV(0 downto 0);
  signal QVec			:TSLV(0 downto 0);

begin
  
  DVec(0) <= d;
  --
  sin :KTP_LPM_SYNCH_IN
    generic map (
      LPM_WIDTH	=> 1
    )
    port map(
      resetN	=> resetN,
      setN	=> setN,
      clk	=> clk,
      wr_str	=> wr_str,
      wr_ena	=> wr_ena,
      d		=> DVec,
      q		=> QVec,
      strobe	=> strobe,
      ack	=> ack
    );
  --
  q <= QVec(0);

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_SYNCH_OUT is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    rd_str			:in  TSL;
    d				:in  TSLV(LPM_WIDTH-1 downto 0);
    q				:out TSLV(LPM_WIDTH-1 downto 0);
    ack				:out TSL
  );
end KTP_LPM_SYNCH_OUT;

use work.KTPComponent.all;

architecture behaviour of KTP_LPM_SYNCH_OUT is

  signal H			:TSL;
  signal SynchReg		:TSLV(LPM_WIDTH-1 downto 0);
  signal ClockInvSig		:TSL;
  signal ReadInvSig		:TSL;
  signal ReadHoldSig		:TSL;
  signal Ena1Sig		:TSL;

begin

  H <= '1';
  ClockInvSig <= not(clk);
  ReadInvSig <= not(rd_str);
  Ena1Sig <= not(ReadHoldSig) and not(ReadInvSig);
  read_hold_comp: KTP_CFF
    port map (
      resetN => resetN,
      setN   => H,
      clk0   => ReadInvSig,
      ena0   => H,
      clk1   => ClockInvSig,
      ena1   => Ena1Sig,
      q	     => ReadHoldSig
    );

  process (clk, resetN) begin
    if (resetN='0') then
      SynchReg <= (others => '0');
    elsif (clk'event and clk='1') then
      if (ReadHoldSig='0') then
        SynchReg <= d;
      end if;
    end if;
  end process;
  
  q <= SynchReg;
  ack <= ReadHoldSig;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_SYNCH_OUT1 is
  generic (
    LPM_WIDTH			:in natural := 4
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    rd_str			:in  TSL;
    d				:in  TSL;
    q				:out TSL;
    ack				:out TSL
  );
end KTP_LPM_SYNCH_OUT1;

use work.KTPComponent.all;

architecture behaviour of KTP_LPM_SYNCH_OUT1 is

  signal DVec			:TSLV(0 downto 0);
  signal QVec			:TSLV(0 downto 0);

begin

  DVec(0) <= d;
  --
  sout :KTP_LPM_SYNCH_OUT
    generic map (
      LPM_WIDTH	=> 1
    )
    port map(
      resetN	=> resetN,
      clk	=> clk,
      rd_str	=> rd_str,
      d		=> DVec,
      q		=> QVec,
      ack	=> ack
    );
  --
  q <= QVec(0);

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_COUNT1 is
  generic (
    LPM_DATA_WIDTH		:in natural := 8;
    COUNT_STOP			:in boolean := TRUE;
    COUNT_RELOAD			:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    clk_ena			:in  TSL;
    initN			:in  TSL;
    loadN			:in  TSL;
    downN			:in  TSL;
    setN			:in  TSL;
    reloadN			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    finishN			:out TSL;
    overN			:out TSL
  );
end KTP_LPM_COUNT1;

library ieee;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use work.KTPComponent.all;

architecture behaviour of KTP_LPM_COUNT1 is

  signal CountReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal FinishSig		:TSL;
  signal OverReg		:TSL;

begin

  FinishSig <= not( OR_REDUCE(CountReg)) when downN='0' else
                   AND_REDUCE(CountReg);

  process (clk, resetN, loadN, initN) begin
    if (resetN='0') then
      CountReg <= (others => '0');
      OverReg  <= '0';
    elsif (loadN='0') then
      CountReg <= data;
    elsif (initN = '0' and downN='0') then
      CountReg <= (others => '1');
    elsif (initN = '0' and downN='1') then
      CountReg <= (others => '0');
    elsif (clk'event and clk='1') then
      if (clk_ena='1') then
        if (setN='0' or (FinishSig='1' and COUNT_RELOAD=TRUE)) then
          CountReg <= data;
	elsif (COUNT_STOP=FALSE or FinishSig='0') then
	  if (downN='0') then
	    CountReg <= CountReg - 1;
	  else
	    CountReg <= CountReg + 1;
	  end if;
	end if;
	OverReg  <= FinishSig;
      end if;
    end if;
  end process;
  
  count   <= CountReg;
  finishN <= not(FinishSig);
  overN   <= not(OverReg);

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_COUNT_VAL is
  generic (
    LPM_VAL_WIDTH		:in natural := 4;
    LPM_DATA_WIDTH		:in natural := 8;
    COUNT_STOP			:in boolean := TRUE;
    COUNT_RELOAD			:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    clk_ena			:in  TSL;
    val				:in  TSLV(LPM_VAL_WIDTH-1 downto 0);
    initN			:in  TSL;
    loadN			:in  TSL;
    downN			:in  TSL;
    setN			:in  TSL;
    reloadN			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    finishN			:out TSL;
    overN			:out TSL
  );
end KTP_LPM_COUNT_VAL;

library ieee;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use work.KTPComponent.all;

architecture behaviour of KTP_LPM_COUNT_VAL is

  signal RegInSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal RegOutSig		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal ResetNSig		:TSL;
  signal SetNSig		:TSL;
  signal FinishSig		:TSL;
  signal OverReg		:TSL;

begin

  ResetNSig <= not(TSLconv(resetN='0' or ((initN='0') and (downN='1'))));
  SetNSig   <= not(TSLconv(setN='0'   or ((initN='0') and (downN='0'))));
  
  FinishSig <= not( OR_REDUCE(RegOutSig)) when downN='0' else
                   AND_REDUCE(RegOutSig);

  regprg :KTP_LPM_REGPRG
    generic map (
      LPM_WIDTH => LPM_DATA_WIDTH
    )
    port map (
      resetN    => ResetNSig,
      setN      => SetNSig,
      prgN      => loadN,
      dprg      => data,
      clk       => clk,
      ena       => clk_ena,
      d         => RegInSig,
      q         => RegOutSig
    );
  process (RegOutSig, setN, val, data, downN, clk_ena, FinishSig) begin
    RegInSig <= RegOutSig;
    if (clk_ena='1') then
      if (setN='0' or (FinishSig='1' and COUNT_RELOAD=TRUE)) then
        RegInSig <= data;
      elsif (COUNT_STOP=FALSE or FinishSig='0') then
	if (downN='0') then
	  RegInSig <= RegOutSig - val;
	else
	  RegInSig <= RegOutSig + val;
	end if;
      end if;
    end if;
  end process;

  process (clk, resetN) begin
    if (resetN='0') then
      OverReg  <= '0';
    elsif (clk'event and clk='1') then
      OverReg  <= FinishSig;
    end if;
  end process;
  
  count   <= RegOutSig;
  finishN <= not(FinishSig);
  overN   <= not(OverReg);

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_COUNT is
  generic (
    LPM_DATA_WIDTH		:in natural := 8;
    COUNT_STOP			:in boolean := TRUE;
    COUNT_RELOAD			:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    clk_ena			:in  TSL;
    initN			:in  TSL;
    loadN			:in  TSL;
    downN			:in  TSL;
    setN			:in  TSL;
    reloadN			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    finishN			:out TSL;
    overN			:out TSL
  );
end KTP_LPM_COUNT;

library ieee;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use work.KTPComponent.all;

architecture behaviour of KTP_LPM_COUNT is

  signal H			:TSLV(0 downto 0);

begin

  H <= (others => '1');

  cnt :KTP_LPM_COUNT_VAL
  generic map (
    LPM_VAL_WIDTH  => 1,
    LPM_DATA_WIDTH => LPM_DATA_WIDTH,
    COUNT_STOP     => COUNT_STOP,
    COUNT_RELOAD   => COUNT_RELOAD
  )
  port map (
    resetN         => resetN,
    clk            => clk,		
    clk_ena        => clk_ena,	
    val            => H,	
    initN          => initN,	
    loadN          => loadN,	
    downN          => downN,	
    setN           => setN,	
    reloadN        => reloadN,	
    data           => data,	
    count          => count,	
    finishN        => finishN,	
    overN          => overN	
  );

end behaviour;			   

--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity KTP_LPM_COUNT_VAL1 is
  generic (
    LPM_VAL_WIDTH		:in natural := 4;
    LPM_DATA_WIDTH		:in natural := 8;
    COUNT_STOP			:in boolean := TRUE;
    COUNT_RELOAD			:in boolean := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    clk_ena			:in  TSL;
    val				:in  TSLV(LPM_VAL_WIDTH-1 downto 0);
    initN			:in  TSL;
    loadN			:in  TSL;
    downN			:in  TSL;
    setN			:in  TSL;
    reloadN			:in  TSL;
    data			:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    count			:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    finishN			:out TSL;
    overN			:out TSL
  );
end KTP_LPM_COUNT_VAL1;

library ieee;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use work.KTPComponent.all;

architecture behaviour of KTP_LPM_COUNT_VAL1 is

  signal CountReg		:TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal FinishSig		:TSL;
  signal OverReg		:TSL;

begin

  FinishSig <= not( OR_REDUCE(CountReg)) when downN='0' else
                   AND_REDUCE(CountReg);

  process (clk, resetN, loadN, initN) begin
    if (resetN='0') then
      CountReg <= (others => '0');
      OverReg  <= '0';
    elsif (loadN='0') then
      CountReg <= data;
    elsif (initN = '0' and downN='0') then
      CountReg <= (others => '1');
    elsif (initN = '0' and downN='1') then
      CountReg <= (others => '0');
    elsif (clk'event and clk='1') then
      if (clk_ena='1') then
        if (setN='0' or (FinishSig='1' and COUNT_RELOAD=TRUE)) then
          CountReg <= data;
	elsif (COUNT_STOP=FALSE or FinishSig='0') then
	  if (downN='0') then
	    CountReg <= CountReg - val;
	  else
	    CountReg <= CountReg + val;
	  end if;
	end if;
	OverReg  <= FinishSig;
      end if;
    end if;
  end process;
  
  count   <= CountReg;
  finishN <= not(FinishSig);
  overN   <= not(OverReg);

end behaviour;			   

--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity LPM_RATE_REG is
  generic(
    LPM_DATA_WIDTH			:integer :=   96;
    LPM_COUNT_WIDTH			:integer :=   32
  );
  port (
    resetN				:in  TSL := '0';
    clock				:in  TSL := '1';
    data				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    data_ena				:in  TSL := '1';
    sim_loop				:in  TSL := '0';
    proc_req				:in  TSL := '0';
    proc_ack				:out TSL;
    memory_address			:in  TSLV (TVLcreate(LPM_DATA_WIDTH-1)-1 DOWNTO 0);
    memory_data_in			:in  TSLV (LPM_COUNT_WIDTH-1 DOWNTO 0);
    memory_data_out			:out TSLV (LPM_COUNT_WIDTH-1 DOWNTO 0);
    memory_wr				:in  TSL;
    memory_str				:in  TSL
  );
end LPM_RATE_REG; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;

architecture behaviour of LPM_RATE_REG is
  subtype  TCounter			is TSLV(LPM_COUNT_WIDTH-1 downto 0);
  type     TCounterTab			is array (0 to LPM_DATA_WIDTH-1) of TCounter;
  signal   CounterTab			:TCounterTab;
begin

  process(clock,resetN)
    variable CounterTabVar :TCounterTab;
  begin
    if (resetN = '0') then
      CounterTab <= (TCounterTab'range => (others => '0'));
    elsif (clock'event and clock='1') then
      CounterTabVar := CounterTab;
      for index in 0 to LPM_DATA_WIDTH-1 loop
        if (proc_req = '1') then
          if (data_ena ='1' and AND_REDUCE(CounterTabVar(index))='0' and data(index)='1') then
            CounterTabVar(index) := CounterTabVar(index) + 1;
	  end if;
        else
	  if (memory_wr='1' and TNconv(memory_address)=index) then
            CounterTabVar(index) := memory_data_in;
	  end if;
        end if;
      end loop;
      CounterTab <= CounterTabVar;
    end if;
  end process;
  
  process(CounterTab, memory_address)
    variable res: TSLV (LPM_COUNT_WIDTH-1 DOWNTO 0);
  begin
    res := (others => '0');
    for index in 0 to LPM_DATA_WIDTH-1 loop
      if (TNconv(memory_address)=index) then
        res := CounterTab(index);
      end if;
    end loop;
    memory_data_out <= res;
  end process;
end behaviour;

--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity LPM_RAND_GEN_TRANS_V1 is
  generic(
    LPM_DATA_WIDTH			:integer :=   6
  );
  port (
    resetN				:in  TSL;
    clock				:in  TSL;
    initN				:in  TSL;
    val					:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    gen_out				:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    step				:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0)
  );
end LPM_RAND_GEN_TRANS_V1; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;

architecture behaviour of LPM_RAND_GEN_TRANS_V1 is

  function GetRndVal(rnd :TSLV) return TSLV is
    constant LEN :TVL := rnd'length;
    variable RndVar  :TSLV(LEN-1 downto 0);
  begin
    RndVar := rnd;
    RndVar(LEN/2) := RndVar(0) xor not(RndVar(LEN-1));
    RndVar(LEN-1 downto 0) := (RndVar(LEN-2 downto 0) & RndVar(LEN-1)) xor rnd;
    return (RndVar); 
  end function;
  --
  signal RndReg :TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);

begin

  process (resetN, clock, initN, val) is
  begin
    if (resetN='0') then
      RndReg <= (others => '0');
    elsif (initN='0') then
      RndReg <= val;
    elsif (clock'event and clock='1') then
      RndReg <= GetRndVal(RndReg);
    end if;
  end process;
  --
  gen_out <= RndReg;
  step    <= GetRndVal(val);
  
end behaviour;

--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_1164_ktp.all;

entity LPM_RAND_GEN_TRANS_V2 is
  generic(
    LPM_GEN_WIDTH			:TN := 8;
    LPM_RND_INIT			:TN := 0;
    LPM_DATA_WIDTH			:TN := 1;
    LPM_STROBE_ENA			:TL := TRUE
  );
  port (
    resetN				:in  TSL;
    clock				:in  TSL;
    gen_ena				:in  TSL;
    gen_strobe				:in  TSL;
    gen_init				:in  TSLV(LPM_GEN_WIDTH-1 DOWNTO 0);
    gen_out				:out TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    gen_in				:in  TSLV(LPM_DATA_WIDTH-1 DOWNTO 0);
    valid				:out TSL;
    valid_ena				:out TSL
  );
end LPM_RAND_GEN_TRANS_V2; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_misc.all;
use work.std_logic_1164_ktp.all;

architecture behaviour of LPM_RAND_GEN_TRANS_V2 is
  --
  constant PART_NUM  :TN := SLVPartNum(LPM_GEN_WIDTH,LPM_DATA_WIDTH);
  constant GEN_WIDTH :TN := maximum(LPM_GEN_WIDTH,LPM_DATA_WIDTH);
  --
  function GetRndVal(rnd :TSLV) return TSLV is
    variable RndVar  :TSLV(GEN_WIDTH-1 downto 0);
  begin
    RndVar := rnd;
    RndVar(GEN_WIDTH/2) := RndVar(0) xor not(RndVar(GEN_WIDTH-1));
    RndVar(GEN_WIDTH-1 downto 0) := (RndVar(GEN_WIDTH-2 downto 0) & RndVar(GEN_WIDTH-1)) xor rnd;
    return (RndVar); 
  end function;
  --
  signal TxRndReg :TSLV(GEN_WIDTH-1 DOWNTO 0);
  signal TxShtReg :TSLV(GEN_WIDTH-1 DOWNTO 0);
  signal TxShtCnt :TSLV(TVLcreate(PART_NUM-1)-1 DOWNTO 0);
  signal RxShtReg :TSLV(2*GEN_WIDTH-1 DOWNTO 0);
  signal RxShtCnt :TSLV(TVLcreate(PART_NUM-1)-1 DOWNTO 0);
  signal RxShtSig :TSLV(GEN_WIDTH-1 DOWNTO 0);
  signal RxRndSig :TSLV(GEN_WIDTH-1 DOWNTO 0);
  signal RxValSig :TSL;
  signal RxValReg :TSL;
  signal RxEnaReg :TSL;

begin
  --
  process (resetN, clock) is
    variable cnt0 :TL;
  begin
    if (resetN='0') then
      TxRndReg <= (others => '0');
      TxShtReg <= (others => '0');
      TxShtCnt <= (others => '0');
    elsif (clock'event and clock='1') then
      if (gen_ena='1') then
        cnt0 := (LPM_STROBE_ENA=FALSE and TxShtCnt=0) or (LPM_STROBE_ENA=TRUE and gen_strobe='1');
        if (PART_NUM=1) then
          TxShtReg <= GetRndVal(TxShtReg);
        elsif (cnt0=TRUE) then
          TxRndReg <= GetRndVal(TxRndReg);
          TxShtReg <= TxRndReg;
          TxShtCnt <= TxShtCnt+PART_NUM-1;
        else
          TxShtCnt <= TxShtCnt-1;
          TxShtReg <= TSLVrot(TxShtReg,-LPM_DATA_WIDTH);
        end if;
      else
        TxRndReg <= TSLVconv(LPM_RND_INIT,TxRndReg'length)+gen_init;
        TxShtReg <= TSLVconv(LPM_RND_INIT,TxShtReg'length)+gen_init;
      end if;
    end if;
  end process;
  --
  gen_out <= TxShtReg(gen_out'range);
  --
  --
  RxRndSig <= SLVPartGet(RxShtReg,GEN_WIDTH,0);
  RxShtSig <= SLVPartGet(RxShtReg,GEN_WIDTH,1);
  RxValSig <= TSLconv(RxShtSig=GetRndVal(RxRndSig));
  --
  process (resetN, clock) is
    variable cnt0 :TL;
  begin
    if (resetN='0') then
      RxShtReg <= (others => '0');
      RxShtCnt <= (others => '0');
      RxValReg <= '0';
      RxEnaReg <= '0';
    elsif (clock'event and clock='1') then
      RxEnaReg <= '0';
      RxShtReg <= TSLVsh2l(RxShtReg, gen_in);
      cnt0     := (LPM_STROBE_ENA=FALSE and RxShtCnt=0) or (LPM_STROBE_ENA=TRUE and gen_strobe='1');
      --
      if (cnt0=TRUE) then
        RxShtCnt <= TSLVconv(PART_NUM-1,RxShtCnt'length);
        RxEnaReg <='1';
      else
        RxShtCnt <= RxShtCnt-1;
      end if;
      --
      if (RxValReg='1' and  cnt0=TRUE) then
        RxValReg <= RxValSig;
      elsif (RxValReg='0' and RxValSig='1') then
        RxValReg <= '1';
        RxShtCnt <= TSLVconv(PART_NUM-1,RxShtCnt'length);
      end if;
    end if;
  end process;
  --
  valid     <= RxValReg;
  valid_ena <= RxEnaReg;

end behaviour;

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_MPIPE is
  generic (
    LPM_WIDTH			:in TN := 4;
    LPM_MULTI			:in TN range 2 to TN'high := 2;
    LPM_NUMBER			:in TP := 4;
    LPM_PIPE			:in TP := 3;
    LPM_IN_CLK_ENA		:in TL := FALSE;
    LPM_OUT_CLK_ENA		:in TL := FALSE;
    LPM_IN_MULTI		:in TL := FALSE;
    LPM_NUM_SWAP		:in TL := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    mclk			:in  TSL;
    mena			:in  TSL;
    clk			        :in  TSLV(LPM_MULTI-1 downto 0);
    ds				:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    dp				:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
    qs				:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    qp				:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
    ps				:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_WIDTH-1 downto 0);
    pp				:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
  );
end entity KTP_LPM_MPIPE;

architecture behaviour of KTP_LPM_MPIPE is

  constant WIDTH     :TN := sel(LPM_WIDTH*LPM_NUMBER, LPM_WIDTH, LPM_NUM_SWAP);
  constant NUMBER    :TN := sel(1, LPM_NUMBER, LPM_NUM_SWAP);
  type     Tmreg     is array(0 to NUMBER*LPM_MULTI-1) of TSLV(WIDTH-1 downto 0);
  type     Tmpipe    is array(0 to LPM_PIPE-1)  of Tmreg;
  signal   MpipeSIg  :Tmpipe;
  signal   MpipeReg  :Tmpipe;
  --
  type     Tpipe  is array(0 to LPM_PIPE-1)  of TSLV(NUMBER*LPM_MULTI*WIDTH-1 downto 0);
  signal   Pipe   :Tpipe;
  --
  signal   ParOut :Tmreg;

begin

  process (ds, dp, mena, MpipeReg) is
    variable MpipeVar  :Tmpipe;
    variable N         :TN;
  begin
    MpipeVar := MpipeReg;
    for num in 0 to NUMBER-1 loop
      N := LPM_MULTI*num;
      if (LPM_PIPE>1) then
        for p in LPM_PIPE-1 downto 1 loop
          for m in 0 to LPM_MULTI-2 loop
            MpipeVar(p)(N+m) := MpipeVar(p)(N+m+1);
          end loop;
          MpipeVar(p)(N+LPM_MULTI-1) := MpipeVar(p-1)(N+0);
        end loop;
      end if;
      if (LPM_IN_MULTI=FALSE and mena='1') then
        for m in 0 to LPM_MULTI-1 loop
          MpipeVar(0)(N+m) := SLVPartGet(dp,WIDTH,N+m);
        end loop;
      else
        MpipeVar(0)(N+0 to N+LPM_MULTI-2) := MpipeVar(0)(N+1 to N+LPM_MULTI-1);
        if (LPM_IN_MULTI=FALSE) then
          MpipeVar(0)(N+LPM_MULTI-1) := SLVPartGet(dp,WIDTH,N+LPM_MULTI-1);--(others => '0');
        else
          MpipeVar(0)(N+LPM_MULTI-1) := SLVPartGet(ds,WIDTH,num);
        end if;
      end if;
    end loop;
    MpipeSig <= MpipeVar;
  end process;
  --
  process (resetN , mclk) is
  begin
    if (resetN='0') then
      MpipeReg <= (MpipeReg'range => (MpipeReg(0)'range => (others => '0')));
    elsif (mclk'event and mclk='1') then
      MpipeReg <= MpipeSig;
    end if;
  end process;
  --
  process (resetN, clk(0), mclk, mena, MpipeSig) is
    variable clkv      :TL;
    variable N         :TN;
  begin
    if (LPM_OUT_CLK_ENA=TRUE) then clkv := (clk(0)'event and clk(0)='1'); else clkv := (mclk'event and mclk='1'); end if;
    if (resetN='0') then
      Pipe   <= (Pipe'range => (others => '0'));
      ParOut <= (ParOut'range => (others => '0'));
    elsif (clkv) then
      if (LPM_OUT_CLK_ENA=TRUE or mena='1') then
        for num in 0 to NUMBER-1 loop
          N := LPM_MULTI*num;
          for p in 0 to LPM_PIPE-1 loop
            for m in 0 to LPM_MULTI-1 loop
              Pipe(p)(WIDTH*(N+m+1)-1 downto WIDTH*(N+m)) <= MpipeSig(p)(N+m);
            end loop;
          end loop;
        end loop;
        ParOut <= MpipeSig(LPM_PIPE-1);
      end if;
    end if;
  end process;
  --
  process (MpipeReg, ParOut, Pipe) is
  begin
    for n in 0 to NUMBER-1 loop
      qs(WIDTH*(n+1)-1 downto WIDTH*n) <= MpipeREg(LPM_PIPE-1)(LPM_MULTI*n);
    end loop;
    for M in 0 to NUMBER*LPM_MULTI-1 loop
      qp(WIDTH*(M+1)-1 downto WIDTH*M) <= ParOut(M);
    end loop;
    for p in 0 to LPM_PIPE-1 loop
      for n in 0 to NUMBER-1 loop
        ps(WIDTH*((n+NUMBER*p)+1)-1 downto WIDTH*(n+NUMBER*p)) <= MpipeReg(p)(LPM_MULTI*n);
      end loop;
    end loop;
    for p in 0 to LPM_PIPE-1 loop
      pp(NUMBER*LPM_MULTI*WIDTH*(p+1)-1 downto NUMBER*LPM_MULTI*WIDTH*p) <= Pipe(p);
    end loop;
  end process;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_MPIPEold is
  generic (
    LPM_WIDTH			:in TN := 4;
    LPM_MULTI			:in TN range 2 to TN'high := 2;
    LPM_NUMBER			:in TP := 4;
    LPM_PIPE			:in TP := 3;
    LPM_IN_MULTI		:in TL := TRUE;
    LPM_NUM_SWAP		:in TL := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL;
    mena			:in  TSL;
    ds				:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    dp				:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
    qs				:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    qp				:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
    ps				:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_WIDTH-1 downto 0);
    pp				:out TSLV(LPM_PIPE*LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
  );
end entity KTP_LPM_MPIPEold;

architecture behaviour of KTP_LPM_MPIPEold is

  constant WIDTH  :TN := sel(LPM_WIDTH*LPM_NUMBER, LPM_WIDTH, LPM_NUM_SWAP);
  constant NUMBER :TN := sel(1, LPM_NUMBER, LPM_NUM_SWAP);
  type     Tmreg  is array(0 to NUMBER*LPM_MULTI-1) of TSLV(WIDTH-1 downto 0);
  type     Tmpipe is array(0 to LPM_PIPE-1)  of Tmreg;
  signal   Mpipe  :Tmpipe;
  --
  type     Tpipe  is array(0 to LPM_PIPE-1)  of TSLV(NUMBER*LPM_MULTI*WIDTH-1 downto 0);
  signal   Pipe   :Tpipe;
  --
  signal   ParOut :Tmreg;

begin

  process (resetN , clk) is
    variable MpipeVar  :Tmpipe;
    variable N         :TN;
  begin
    if (resetN='0') then
      Mpipe  <= (Mpipe'range => (Mpipe(0)'range => (others => '0')));
      Pipe   <= (Pipe'range => (others => '0'));
      ParOut <= (ParOut'range => (others => '0'));
    elsif (clk'event and clk='1') then
      MpipeVar := Mpipe;
      for num in 0 to NUMBER-1 loop
        N := LPM_MULTI*num;
        if (LPM_PIPE>1) then
          for p in LPM_PIPE-1 downto 1 loop
            for m in 0 to LPM_MULTI-2 loop
              MpipeVar(p)(N+m) := MpipeVar(p)(N+m+1);
            end loop;
            MpipeVar(p)(N+LPM_MULTI-1) := MpipeVar(p-1)(N+0);
          end loop;
        end if;
        if (LPM_IN_MULTI=FALSE and mena='1') then
          for m in 0 to LPM_MULTI-1 loop
            MpipeVar(0)(N+m) := SLVPartGet(dp,WIDTH,N+m);
          end loop;
        else
          MpipeVar(0)(N+0 to N+LPM_MULTI-2) := MpipeVar(0)(N+1 to N+LPM_MULTI-1);
          if (LPM_IN_MULTI=FALSE) then
            MpipeVar(0)(N+LPM_MULTI-1) := SLVPartGet(dp,WIDTH,N+LPM_MULTI-1);--(others => '0');
          else
            MpipeVar(0)(N+LPM_MULTI-1) := SLVPartGet(ds,WIDTH,num);
          end if;
        end if;
        if (mena='1') then
          --ParOut <= MpipeVar(LPM_PIPE-1);
          for p in 0 to LPM_PIPE-1 loop
            for m in 0 to LPM_MULTI-1 loop
              Pipe(p)(WIDTH*(N+m+1)-1 downto WIDTH*(N+m)) <= MpipeVar(p)(N+m);
            end loop;
          end loop;
        end if;
      end loop;
      if (mena='1') then
        ParOut <= MpipeVar(LPM_PIPE-1);
      end if;
      Mpipe <= MpipeVar;
    end if;
  end process;
  
  process (Mpipe, ParOut, Pipe) is
  begin
    for n in 0 to NUMBER-1 loop
      qs(WIDTH*(n+1)-1 downto WIDTH*n) <= Mpipe(LPM_PIPE-1)(LPM_MULTI*n);
    end loop;
    for M in 0 to NUMBER*LPM_MULTI-1 loop
      qp(WIDTH*(M+1)-1 downto WIDTH*M) <= ParOut(M);
    end loop;
    for p in 0 to LPM_PIPE-1 loop
      for n in 0 to NUMBER-1 loop
        ps(WIDTH*((n+NUMBER*p)+1)-1 downto WIDTH*(n+NUMBER*p)) <= Mpipe(p)(LPM_MULTI*n);
      end loop;
    end loop;
    for p in 0 to LPM_PIPE-1 loop
      pp(NUMBER*LPM_MULTI*WIDTH*(p+1)-1 downto NUMBER*LPM_MULTI*WIDTH*p) <= Pipe(p);
    end loop;
  end process;

end behaviour;			   

--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.KTPComponent.all;

entity KTP_LPM_MPIPE_CUT is
  generic (
    LPM_WIDTH			:in TN := 4;
    LPM_MULTI			:in TN range 2 to TN'high := 2;
    LPM_NUMBER			:in TN := 4;
    LPM_PIPE_LEN		:in TP := 8;
    LPM_CUT_POS		        :in TP := 7;
    LPM_IN_CLK_ENA		:in TL := FALSE;
    LPM_OUT_CLK_ENA		:in TL := TRUE;
    LPM_IN_MULTI		:in TL := FALSE;
    LPM_NUM_SWAP		:in TL := FALSE
  );
  port(
    resetN			:in  TSL := '1';
    mclk			:in  TSL;
    mena			:in  TSL;
    clk			        :in  TSLV(LPM_MULTI-1 downto 0);
    cut				:in  TSLV(TVLcreate(LPM_CUT_POS)-1 downto 0);
    ds				:in  TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    dp				:in  TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0);
    qs				:out TSLV(LPM_NUMBER*LPM_WIDTH-1 downto 0);
    qp				:out TSLV(LPM_NUMBER*LPM_MULTI*LPM_WIDTH-1 downto 0)
  );
end entity KTP_LPM_MPIPE_CUT;

architecture behaviour of KTP_LPM_MPIPE_CUT is

  constant CUT_WIDTH  :TN := cut'length;
  signal   SelSig     :TSLV(CUT_WIDTH-1 downto 0);
  type     TSsig      is array(TN range<>) of TSLV(ds'range);
  type     TPsig      is array(TN range<>) of TSLV(dp'range);
  signal   SinSig     :TSsig(0 to CUT_WIDTH);
  signal   PinSig     :TPsig(0 to CUT_WIDTH);
  signal   SoutSig    :TSsig(0 to CUT_WIDTH-1);
  signal   PoutSig    :TPsig(0 to CUT_WIDTH-1);
  
begin
  --
  mpipe0: KTP_LPM_MPIPE
    generic map (
      LPM_WIDTH		=> LPM_WIDTH,
      LPM_MULTI		=> LPM_MULTI,
      LPM_NUMBER	=> LPM_NUMBER,
      LPM_PIPE		=> 1,
      LPM_IN_CLK_ENA	=> LPM_IN_CLK_ENA,
      LPM_OUT_CLK_ENA	=> LPM_OUT_CLK_ENA,
      LPM_IN_MULTI	=> LPM_IN_MULTI,
      LPM_NUM_SWAP	=> LPM_NUM_SWAP
    )
    port map (
      resetN		=> resetN,
      mclk		=> mclk,
      mena		=> mena,
      clk		=> clk,
      ds		=> ds,
      dp		=> dp,
      qs		=> SinSig(0),
      qp		=> PinSig(0)
    );
  --
  process(cut) is
    constant MIN :TN := minimum(LPM_CUT_POS,LPM_PIPE_LEN);
    variable Val :TSLV(SelSig'range);
  begin
    if (cut<MIN) then SelSig <= MIN-cut; else SelSig <= (others => '0'); end if;
  end process;
  --
  mloop: for index in 0 to CUT_WIDTH-1 generate
    mpipe: KTP_LPM_MPIPE
      generic map (
        LPM_WIDTH	=> LPM_WIDTH,
        LPM_MULTI	=> LPM_MULTI,
        LPM_NUMBER	=> LPM_NUMBER,
        LPM_PIPE	=> 2**index,
        LPM_IN_CLK_ENA	=> LPM_IN_CLK_ENA,
        LPM_OUT_CLK_ENA	=> LPM_OUT_CLK_ENA,
        LPM_IN_MULTI	=> TRUE,
        LPM_NUM_SWAP	=> LPM_NUM_SWAP
      )
      port map (
        resetN		=> resetN,
        mclk		=> mclk,
        mena		=> mena,
        clk		=> clk,
        ds		=> SinSig(index),
        dp		=> open,
        qs		=> SoutSig(index),
        qp		=> PoutSig(index)
      );
    --
    SinSig(index+1) <=  SinSig(index) when (SelSig(index)='0') else SoutSig(index);
    PinSig(index+1) <=  PinSig(index) when (SelSig(index)='0') else PoutSig(index);
    --
  end generate;
  --
  extN: if (LPM_PIPE_LEN<=LPM_CUT_POS) generate
    qs <= SinSig(CUT_WIDTH);
    qp <= PinSig(CUT_WIDTH);
  end generate;
  --
  extT: if (LPM_PIPE_LEN>LPM_CUT_POS) generate
    mpipex: KTP_LPM_MPIPE
      generic map (
        LPM_WIDTH	=> LPM_WIDTH,
        LPM_MULTI	=> LPM_MULTI,
        LPM_NUMBER	=> LPM_NUMBER,
        LPM_PIPE	=> LPM_PIPE_LEN-LPM_CUT_POS,
        LPM_IN_CLK_ENA	=> LPM_IN_CLK_ENA,
        LPM_OUT_CLK_ENA	=> LPM_OUT_CLK_ENA,
        LPM_IN_MULTI	=> TRUE,
        LPM_NUM_SWAP	=> LPM_NUM_SWAP
      )
      port map (
        resetN		=> resetN,
        mclk		=> mclk,
        mena		=> mena,
        clk		=> clk,
        ds		=> SinSig(CUT_WIDTH),
        dp		=> open,
        qs		=> qs,
        qp		=> qp
      );
  end generate;

end behaviour;			   
