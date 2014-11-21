-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2004 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;

package std_logic_arith_ktp is

  -------------------------------------------------------------------
  -- TU2V types families
  -------------------------------------------------------------------
  subtype   TR   is real;
  subtype   TU2V is SIGNED;--TSLV;
  subtype   TNBV is TSLV;


  -------------------------------------------------------------------
  -- TU2V conversion function
  -------------------------------------------------------------------
  function  TNBVtoTU2V(val :TNBV) return TU2V;					-- converts NB to U2 code where 'NB(0)=000..0'
  function  TU2VtoTNBV(val :TU2V) return TNBV;					-- converts U2 to NB code where 'NB(0)=100..0'
  function  TU2Vconv(val :TSLV) return TU2V;					-- converts TSLV (unsigned type) to TU2V type
  function  TIconv(val :TR) return TI;						-- converts TR to TI type
  function  TIconv(arg :TU2V) return TI;					-- converts TU2V to TI type
  function  TIconv(arg :TSLV) return TI;					-- converts signed TSLV to TI type
  function  TIconv(arg :THV) return TI;						-- converts signed THV to TI type
  function  TIconv(arg :TBV) return TI;						-- converts signed THV to TI type

  -------------------------------------------------------------------
  -- TU2V transformation function
  -------------------------------------------------------------------
  function  U2VCreate(val :TI; len :TVL) return TU2V;				-- generates val. with 'len' length
  function  U2VCreateMin(len :TVL) return TU2V;					-- generates min. val. with 'len' length
  function  U2VCreateMax(len :TVL) return TU2V;					-- generates max. val. with 'len' length
  function  U2VCreate0(len :TVL) return TU2V;					-- generates val=0 with 'len' length
  function  U2VCreate1(len :TVL) return TU2V;					-- generates val=1 with 'len' length
  function  U2VCreateN1(len :TVL) return TU2V;					-- generates val=-1 with 'len' length
  function  U2VCreateRange(val :TI; len :TVL) return TU2V;			-- generates <=val. with 'len' len. in range <min.,max>
  function  U2VGetSign(val :TU2V) return TL;					-- returns TRUE when val>=0 others FALSE
  function  U2VComp_GreatEQ(x,y :TU2V) return TL;				-- returns TRUE when x-y>=0 others FALSE
  function  U2VComp_GreatEQ0(x :TU2V) return TL;				-- returns TRUE when x>=0 others FALSE
  function  U2VComp_Great(x,y :TU2V) return TL;					-- returns TRUE when x-y>0 others FALSE
  function  U2VComp_Great0(x :TU2V) return TL;					-- returns TRUE when x>0 others FALSE
  function  U2VComp_LessEQ(x,y :TU2V) return TL;				-- returns TRUE when x-y<=0 others FALSE
  function  U2VComp_LessEQ0(x :TU2V) return TL;					-- returns TRUE when x<=0 others FALSE
  function  U2VComp_Less(x,y :TU2V) return TL;					-- returns TRUE when x-y<0 others FALSE
  function  U2VComp_Less0(x :TU2V) return TL;					-- returns minimum value of 'x' and 'y'
  function  U2VComp_GreatEQabsX(x,y :TU2V) return TL;				-- returns TRUE when abs(x)-y>=0 others FALSE
  function  U2VComp_GreatAbsX(x,y :TU2V) return TL;				-- returns TRUE when abs(x)-y>0 others FALSE
  function  U2VComp_LessEQabsX(x,y :TU2V) return TL;				-- returns TRUE when abs(x)-y<=0 others FALSE
  function  U2VComp_LessAbsX(x,y :TU2V) return TL;				-- returns TRUE when abs(x)-y<0 others FALSE
  function  U2VMinimum(x,y :TU2V) return TU2V;					-- returns maximum value of 'x' and 'y'
  function  U2VMaximum(x,y :TU2V) return TU2V;					-- returns TRUE when x-y<0 others FALSE
  function  U2VNegSign(val :TU2V) return TU2V;					-- returns '-val' but 'min' gets 'max'
  function  U2VNegSignExp(val :TU2V) return TU2V;				-- returns '-val' but returs 'val' expaned of 1 bits
  function  U2VAbs(val :TU2V) return TU2V;					-- returns abs('val')  but 'min' gets 'max'
  function  U2VAbsExp(val :TU2V) return TU2V;					-- returns abs('val') but returs 'val' expaned of 1 bits
  function  U2VInc(val :TU2V) return TU2V;					-- returns 'val'+1
  function  U2VDec(val :TU2V) return TU2V;					-- returns 'val'-1
  function  U2VCut(val :TU2V; len :TVL) return TU2V;				-- returns cut 'val' with 'len' width
  function  U2VExpand(val :TU2V; len :TVL) return TU2V;				-- returns expanded 'val' to 'len' width
  function  U2VResize(val :TU2V; len :TVL) return TU2V;				-- returns 'val' with 'len' width
  function  U2VRound(val :TU2V; len :TVL) return TU2V;				-- returns 'val' with 'len' width nearest original 'val'
  function  U2VShift(val :TU2V; shift :TI) return TU2V;				-- returns 'val' shifted 'shift' bits
  function  U2VShift(val :TU2V; shift :TU2V) return TU2V;			-- returns 'val' shifted 'shift' bits
  function  U2VShiftLen(val :TU2V; len :TI) return TU2V;			-- returns 'val' with 'len' width
  function  U2VShiftLen(val :TU2V; shift, len :TI) return TU2V;			-- returns 'val' with 'len' width, shifted 'shift' bits
  function  U2VExtract(val :TU2V; len, base :TVL) return TU2V;			-- returns 'val(base+len-1 downto base)'
  function  U2VInsert(len :TVL; val :TU2V; base :TVL) return TU2V;		-- returns 'val(base+val'lenhth-1 downto base)'

  -------------------------------------------------------------------
  -- TU2V basic mathematical function
  -------------------------------------------------------------------
  function  U2VSum(val1, val2 :TU2V; len, base :TVL) return TU2V;		-- returns 'val1+val2' with 'len' width & based on 'base' bit
  function  U2VSum(val1, val2 :TU2V; len :TVL) return TU2V;			-- returns 'val1+val2' with 'len' width & based on 0 bit
  function  U2VSub(val1, val2 :TU2V; len, base :TVL) return TU2V;		-- returns 'val1-val2' with 'len' width & based on 'base' bit
  function  U2VSub(val1, val2 :TU2V; len :TVL) return TU2V;			-- returns 'val1-val2' with 'len' width & based on 0 bit
  function  U2VMult(val1, val2 :TU2V; len, base :TVL) return TU2V;		-- returns 'val1*val2' with 'len' width & based on 'base' bit
  function  U2VMult(val1, val2 :TU2V; len :TVL) return TU2V;			-- returns 'val1*val2' with 'len' width & based on 0 bit
  function  U2VPow2(val :TU2V; len, base :TVL) return TU2V;			-- returns 'val*val' with 'len' width & based on 'base' bit
  function  U2VPow2(val :TU2V; len :TVL) return TU2V;				-- returns 'val*val' with 'len' width & based on 0 bit     

  -------------------------------------------------------------------
  -- TU2V matrix emulation
  -------------------------------------------------------------------
  type      TU2M								-- 'TU2M' type covers [c,r] matrix for 'l' cell data width
            is record
              r :TVL; -- row numbers
              c :TVL; -- colums numbers
	      w :TVL; -- cell data width
            end record;
  
  function  TU2Mcreate(rm, cm, wm :TVL) return TU2M;				-- generates 'TU2M' type where:r=rm, c=cm, l=wm
  function  TU2Mcreate(rl,rh, cl,ch, wm :TVL) return TU2M;			-- generates 'TU2M' type where:r=rh-rl+1, c=ch-cl+1, l=wm
  function  TU2Mtransp(mx :TU2M) return TU2M;					-- returns transposition of mx, where:r=c, c=r
  function  U2MPointerLSB(mx :TU2M; r, c :TVI) return TVI;			-- returns TU2V position in U2M[mx](r,c) for LSB of data

  function  U2MSizeArea(rm, cm, wm :TVL) return TVL;				-- returns TU2V size for U2M[mx=(rm,cm,wm)]
  function  U2MSizeArea(mx :TU2M) return TVL;					-- returns TU2V size for U2M[mx]
  function  U2MSizeArea( rl,rh, cl,ch, wm :TVI) return TVL;			-- returns size of v(rl..rh,cl..ch)*wm
  function  U2MSizeArea(mx :TU2M; rl,rh, cl,ch :TVI) return TVL;		-- returns size of v[mx](rl..rh,cl..ch)
  function  U2MSizeVec(l, h, wm :TVI) return TVL;				-- returns size of row/col v(l..h)*wm
  function  U2MSizeVec(mx :TU2M; l, h :TVI) return TVL;				-- returns size of row/col v[mx](l..h)
  function  U2MSizeVec(num, wm :TVI) return TVL;				-- returns size of row/col v(1..num)*wm
  function  U2MSizeVec(mx :TU2M; num :TVI) return TVL;				-- returns size of row/col v[mx](1..num)
  function  U2MSizeAllRow(mx :TU2M) return TVL;					-- returns size of v[mx] all row
  function  U2MSizeAllCol(mx :TU2M) return TVL;					-- returns size of v[mx] all column
  function  U2MSizeCell(mx :TU2M) return TVL;					-- returns size of v[mx] cell

  function  U2MGetArea(v :TU2V; mx :TU2M; rl,rh, cl,ch :TVI) return TU2V;	-- returns v[mx](rl..rh,cl..ch)
  function  U2MGetRow(v :TU2V; mx :TU2M; r, cl,ch :TVI) return TU2V;		-- returns v[mx](r,cl..ch)
  function  U2MGetAllRow(v :TU2V; mx :TU2M; r :TVI) return TU2V;		-- returns v[mx](r)
  function  U2MGetCol(v :TU2V; mx :TU2M; rl,rh, c :TVI) return TU2V;		-- returns v[mx](rl..rh,c)
  function  U2MGetAllCol(v :TU2V; mx :TU2M; c :TVI) return TU2V;		-- returns v[mx](c)
  function  U2MGetCell(v :TU2V; mx :TU2M; r, c :TVI) return TU2V;		-- returns v[mx](r,c)

  function  U2MSetArea(v :TU2V; mx :TU2M; rl,rh, cl,ch :TVI; d :TU2V) return TU2V; -- returns v[mx](rl..rh,cl..ch)=d
  function  U2MSetAllArea(v :TU2V; mx :TU2M; d :TU2V) return TU2V;		-- returns v[mx]=d
  function  U2MSetRow(v :TU2V; mx :TU2M; r, cl, ch :TVI; d :TU2V) return TU2V;	-- returns v[mx](r,cl..ch)=d
  function  U2MSetAllRow(v :TU2V; mx :TU2M; r :TVI; d :TU2V) return TU2V;	-- returns v[mx](r)=d
  function  U2MSetCol(v :TU2V; mx :TU2M; rl, rh, c :TVI; d :TU2V) return TU2V;	-- returns v[mx](rl..rh,c)=d
  function  U2MSetAllCol(v :TU2V; mx :TU2M; c :TVI; d :TU2V) return TU2V;	-- returns v[mx](c)=d
  function  U2MSetCell(v :TU2V; mx :TU2M; r, c :TVI; d :TU2V) return TU2V;	-- returns v[mx](r,c)=d

  function  U2MCopyArea(vs,vd :TU2V; mxs,mxd :TU2M; rls,rhs,cls,chs, rld,cld :TVI) return TU2V;	-- copies vd[mxs](..)=vs[mxd](..)
  function  U2MCopyArea(v :TU2V; mx :TU2M; rls,rhs,cls,chs, rld,cld :TVI) return TU2V;		-- copies vd[mx](..)=vs[mx](..)
  function  U2MCopyRow(vs,vd :TU2V; mxs,mxd :TU2M; rs,cls,chs, rd :TVI) return TU2V;		-- copies vd[mxs](rd,..)=vs[mxd](rs..)
  function  U2MCopyRow(v :TU2V; mx :TU2M; rs,cls,chs, rd :TVI) return TU2V;			-- copies vd[mx](rd,..)=vs[mx](rs..)
  function  U2MCopyAllRow(vs,vd :TU2V; mxs,mxd :TU2M; rs,rd :TVI) return TU2V;			-- copies vd[mxs](rd)=vs[mxd](rs)
  function  U2MCopyAllRow(v :TU2V; mx :TU2M; rs,rd :TVI) return TU2V;				-- copies vd[mx](rd)=vs[mx](rs)
  function  U2MCopyCol(vs,vd :TU2V; mxs,mxd :TU2M; rls,rhs,cs,cd :TVI) return TU2V;		-- copies vd[mxs](..,cd)=vs[mxd](..,cs)
  function  U2MCopyCol(v :TU2V; mx :TU2M; rls,rhs,cs,cd :TVI) return TU2V;			-- copies vd[mx](..,cd)=vs[mx](..,cs)
  function  U2MCopyAllCol(vs,vd :TU2V; mxs,mxd :TU2M; cs,cd :TVI) return TU2V;			-- copies vd[mxs](cd)=vs[mxd](cs)
  function  U2MCopyAllCol(v :TU2V; mx :TU2M; cs,cd :TVI) return TU2V;				-- copies vd[mx](cd)=vs[mx](cs)
  function  U2MCopyCell(vs,vd :TU2V; mxs,mxd :TU2M; rs,cs,rd,cd :TVI) return TU2V;		-- copies vd[mxs](rd,cd)=vs[mxd](rs,cs)
  function  U2MCopyCell(v :TU2V; mx :TU2M; rs,cs,rd,cd :TVI) return TU2V;			-- copies vd[mx](rd,cd)=vs[mx](rs,cs)

  function  U2MTransp(v :TU2V; mx :TU2M) return TU2V;				-- returns v[mx]

  function  U2MCreate(mx :TU2M; d :TU2V) return TU2V;				-- returns TU2V[mx]=d
  function  U2MCreate(mx :TU2M; d :TI) return TU2V;				-- returns TU2V[mx]=d
  function  U2MCreate(mx :TU2M; d :TIV) return TU2V;				-- returns TU2V[mx]=d

  -------------------------------------------------------------------
  -- TU2M basic matrix mathematical function
  -------------------------------------------------------------------
  function  U2MSum(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx1]+[val2]' with 'len' width & 'base' LSB
  function  U2MSum(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V;		-- returns '[vmx1]+[val2]' with 'len' width
  function  U2MSumV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx]+val2' with 'len' width & 'base' LSB
  function  U2MSumV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V;		-- returns '[vmx]+val2' with 'len' width
  function  U2MSub(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx1]-[mx2]' with 'len' width & 'base' LSB
  function  U2MSub(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V;		-- returns '[vmx1]-[mx2]' with 'len' width
  function  U2MSubV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx]-val' with 'len' width & 'base' LSB
  function  U2MSubV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V;		-- returns '[vmx]-val' with 'len' width
  function  U2MMult(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx1]*[mx2]' with 'len' width & 'base' LSB
  function  U2MMult(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V;		-- returns '[vmx1]*[mx2]' with 'len' width
  function  U2MMultV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V;	-- returns '[vmx]*val' with 'len' width & 'base' LSB
  function  U2MMultV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V;		-- returns '[vmx]*val' with 'len' width
  function  U2MPow2(vmx :TU2V; mx :TU2M; len, base :TVL) return TU2V;			-- returns '[vmx]*[mx]' with 'len' width & 'base' LSB
  function  U2MPow2(vmx :TU2V; mx :TU2M; len :TVL) return TU2V;				-- returns '[vmx]*[mx]' with 'len' width

  component LPM_MULT_KTP is
    generic (
      LPM_MULT_WIDTH		:in  positive := 18;
      LPM_DATA_WIDTH		:in  positive := 64;
      LPM_PIPELINE		:in  integer  :=  2
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      clken			:in  TSL;
      dataa			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
      datab			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
      result			:out TU2V(2*LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component LPM_MX_SUM_KTP is
    generic (
      LPM_MX_ROW		:in  positive := 4;
      LPM_MX_COL		:in  positive := 5;
      LPM_MXA_LEN		:in  positive := 14;
      LPM_MXB_LEN		:in  positive := 14;
      LPM_MXR_LEN		:in  positive := 14;
      LPM_REGISTER_IN		:in  boolean  := TRUE;
      LPM_REGISTER_OUT		:in  boolean  := TRUE;
      LPM_PIPELINE		:in  integer  :=  1
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      clken			:in  TSL;
      dataa			:in  TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXA_LEN)-1 downto 0);
      datab			:in  TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXB_LEN)-1 downto 0);
      result			:out TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXR_LEN)-1 downto 0)
    );
  end component;

  component LPM_AVER_SHIFT_KTP is
    generic (
      LPM_DATA_WIDTH		:in  positive := 8;
      LPM_AVER_SHIFT_MAX	:in  positive := 3;
      LPM_OUTPUT_REGISTER	:in  boolean := TRUE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      clken			:in  TSL;
      aver_shift		:in  TSLV(TVLcreate(LPM_AVER_SHIFT_MAX)-1 downto 0);
      data			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
      result			:out TU2V(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

  component LPM_FILTER_KTP is
    generic (
      LPM_DATA_WIDTH		:in  natural := 0;
      LPM_DATA_NUM		:in  natural := 0;
      LPM_DOT_POSITION		:in  natural := 0;
      LPM_INPUT_REGISTER	:in  boolean := FALSE;
      LPM_OUTPUT_REGISTER	:in  boolean := FALSE
    );
    port(
      resetN			:in  TSL;
      clk			:in  TSL;
      filter_start		:in  TSL;
      param			:in  TU2V(LPM_DATA_NUM*LPM_DATA_WIDTH-1 downto 0);
      data			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
      result			:out TU2V(LPM_DATA_WIDTH-1 downto 0)
    );
  end component;

end std_logic_arith_ktp;

package body std_logic_arith_ktp is

  function  TNBVtoTU2V(val :TNBV) return TU2V is
    variable res: TU2V(val'length-1 downto 0);
  begin
    res := TU2V(val);
    res(res'left) := not(val(val'left));
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  TU2VtoTNBV(val :TU2V) return TNBV is
    variable res: TNBV(val'length-1 downto 0);
  begin
    res := TNBV(val);
    res(res'left) := not(val(val'left));
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  TU2Vconv(val :TSLV) return TU2V is
  begin
    return(TU2V(val));
  end function;  

  -------------------------------------------------------------------

  function  TIconv(val :TR) return TI is
  begin
    return(INTEGER(val));
  end function;  

  -------------------------------------------------------------------

  function TIconv(arg :TU2V) return TI is
  begin
    return(CONV_INTEGER(arg));
  end function;  
  
  -------------------------------------------------------------------

  function TIconv(arg :TSLV) return TI is
  begin
    return(CONV_INTEGER(arg));
  end function;  
  
  -------------------------------------------------------------------

  function TIconv(arg :THV) return TI is
    variable res :TI;
  begin
    res := TNconv(arg(arg'left));
    if(res<8) then
      return(TNconv(arg));
    else
      res := 0;
      for index in arg'left downto arg'right loop
        res := 16*res+TIconv(not(TSLVconv(arg(index))));
      end loop;
      res := res-1;
    end if;
    return(res);
  end function;  
  
  -------------------------------------------------------------------

  function TIconv(arg :TBV) return TI is
    variable res :TI;
  begin
    res := TNconv(arg(arg'left));
    if(res<128) then
      return(TNconv(arg));
    else
      res := 0;
      if (arg'left>arg'right) then
        for index in arg'left downto arg'right loop
          res := 16*res-TNconv(not(arg(index)));
        end loop;
      else
        for index in arg'left to arg'right loop
          res := 16*res-TNconv(not(arg(index)));
        end loop;
      end if;
      res := res-1;
    end if;
    return(res);
  end function;
  
  -------------------------------------------------------------------

  function  U2VCreate(val :TI; len :TVL) return TU2V is
  begin
    return(TU2V(CONV_SIGNED(val,len)));
  end function;  

  -------------------------------------------------------------------

  function  U2VCreateMin(len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
  begin
    res := (others =>'0');
    res(len-1) := '1';
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCreateMax(len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
  begin
    res := (others =>'1');
    res(len-1) := '0';
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCreate0(len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
  begin
    res := (others =>'0');
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCreate1(len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
  begin
    res := (others =>'0');
    res(0) := '1';
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCreateN1(len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
  begin
    res := (others =>'1');
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCreateRange(val :TI; len :TVL) return TU2V is
  begin
    if (val<=-2**(len-1)) then return (U2VCreateMin(len)); end if;
    if (val>=2**(len-1)-1) then return (U2VCreateMax(len)); end if;
    return(U2VCreate(val,len));
  end function;  

  -------------------------------------------------------------------

  function  U2VGetSign(val :TU2V) return TL is
  begin
    return(val(val'length-1)='0');
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_GreatEQ(x,y :TU2V) return TL is
    constant L :TN := maximum(x'length,y'length);
    variable xv :TU2V(L-1 downto 0);
    variable yv :TU2V(L-1 downto 0);
  begin
    xv := U2VExpand(x,L);
    yv := U2VExpand(y,L);
    return(xv>=yv);
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_GreatEQ0(x :TU2V) return TL is
  begin
    return(U2VComp_GreatEQ(x,U2VCreate0(x'length)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_Great(x,y :TU2V) return TL is
    constant L :TN := maximum(x'length,y'length);
    variable xv :TU2V(L-1 downto 0);
    variable yv :TU2V(L-1 downto 0);
  begin
    xv := U2VExpand(x,L);
    yv := U2VExpand(y,L);
    return(xv>yv);
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_Great0(x :TU2V) return TL is
  begin
    return(U2VComp_Great(x,U2VCreate0(x'length)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_LessEQ(x,y :TU2V) return TL is
  begin
    return(not(U2VComp_Great(x,y)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_LessEQ0(x :TU2V) return TL is
  begin
    return(U2VComp_LessEQ(x,U2VCreate0(x'length)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_Less(x,y :TU2V) return TL is
  begin
    return(not(U2VComp_GreatEQ(x,y)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_Less0(x :TU2V) return TL is
  begin
    return(U2VComp_Less(x,U2VCreate0(x'length)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_GreatEQabsX(x,y :TU2V) return TL is
    constant L :TN := maximum(x'length,y'length);
    variable xv :TU2V(L downto 0);
    variable yv :TU2V(L downto 0);
  begin
    xv := U2VExpand(x,L+1);
    yv := U2VExpand(y,L+1);
    return((xv>=yv) or (xv+yv<=0));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_GreatAbsX(x,y :TU2V) return TL is
    constant L :TN := maximum(x'length,y'length);
    variable xv :TU2V(L downto 0);
    variable yv :TU2V(L downto 0);
  begin
    xv := U2VExpand(x,L+1);
    yv := U2VExpand(y,L+1);
    return((xv>yv) or (xv+yv<0));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_LessEQabsX(x,y :TU2V) return TL is
  begin
    return(not(U2VComp_GreatAbsX(x,y)));
  end function;  

  -------------------------------------------------------------------

  function  U2VComp_LessAbsX(x,y :TU2V) return TL is
  begin
    return(not(U2VComp_GreatEQabsX(x,y)));
  end function;  

  -------------------------------------------------------------------

  function  U2VMinimum(x,y :TU2V) return TU2V is
  begin
    if (U2VComp_Less(x,y)=TRUE) then return(x); end if;
    return(y);
  end function;  

  -------------------------------------------------------------------

  function  U2VMaximum(x,y :TU2V) return TU2V is
  begin
    if (U2VComp_Great(x,y)=TRUE) then return(x); end if;
    return(y);
 end function;

  -------------------------------------------------------------------

  function  U2VNegSign(val :TU2V) return TU2V is
    variable res: TSLV(val'length-1 downto 0);--TU2V(val'length-1 downto 0);
  begin
      res := not(TSLV(val));
      if (res /= TSLV(U2VCreateMax(val'length))) then
        res := res + 1;
      end if;
    return(TU2V(res));
  end function;  

  -------------------------------------------------------------------

  function  U2VNegSignExp(val :TU2V) return TU2V is
    variable res: TU2V(val'length downto 0);
  begin
      res(res'length-1) := val(val'length-1);
      res(res'length-2 downto 0) := val;
      res := TU2V(not(TSLV(res)))+1;
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VAbs(val :TU2V) return TU2V is
  begin
    if(U2VGetSign(val)=TRUE) then
      return(val);
    else
      return(U2VNegSign(val));
    end if;
  end function;  

  -------------------------------------------------------------------

  function  U2VAbsExp(val :TU2V) return TU2V is
  begin
    if(U2VGetSign(val)=TRUE) then
      return(U2VExpand(val,val'length+1));
    else
      return(U2VNegSignExp(val));
    end if;
  end function;  

  -------------------------------------------------------------------

  function  U2VInc(val :TU2V) return TU2V is
    variable res: TU2V(val'length-1 downto 0);
  begin
      res := val;
      if (res /= U2VCreateMax(val'length)) then
        res := res + 1;
      end if;
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VDec(val :TU2V) return TU2V is
    variable res: TU2V(val'length-1 downto 0);
  begin
      res := val;
      if (res /= U2VCreateMin(val'length)) then
        res := res - 1;
      end if;
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VCut(val :TU2V; len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
    variable src: TU2V(val'length-1 downto 0);
  begin
    if(len=val'length) then
      return(val);
    end if;
    src := val;
    if (TSL(val(val'length-1))='1' and AND_REDUCE(TSLV(src(val'length-1 downto len-1)))='0') then
      return(U2VCreateMin(len));
    elsif (TSL(val(val'length-1))='0' and OR_REDUCE(TSLV(src(val'length-1 downto len-1)))='1') then
      return(U2VCreateMax(len));
    else
      res(res'length-1) := src(val'length-1);
      res(res'length-2 downto 0) := src(res'length-2 downto 0);
      return(res);
    end if;
  end function;  

  -------------------------------------------------------------------

  function  U2VExpand(val :TU2V; len :TVL) return TU2V is
    variable res: TU2V(len-1 downto 0);
    variable src: TU2V(val'length-1 downto 0);
  begin
    if(len=val'length) then
      return(val);
    end if;
    src := val;
    res(res'length-1 downto val'length) := (others => src(val'length-1));
    res(val'length-1 downto 0) := src;
    return(res);
  end function;  

  -------------------------------------------------------------------

  function  U2VResize(val :TU2V; len :TVL) return TU2V is
  begin
    if(val'length>len) then
      return(U2VCut(val,len));
    end if; 
    return(U2VExpand(val,len));
  end function;  

  -------------------------------------------------------------------

  function  U2VRound(val :TU2V; len :TVL) return TU2V is
    variable v :TU2V(len-1 downto 0);
  begin
    if(val'length>len) then
      v := val(val'length-1 downto val'length-len);
      if (val(val'length-len-1)='1') then
        V := U2VInc(v);
      end if; 
      return(v);
    else
      return(U2VExpand(val,len));
    end if; 
  end function;  

  -------------------------------------------------------------------

  function  U2VShift(val :TU2V; shift :TI) return TU2V is
    variable res :TU2V(val'length+abs(shift)-1 downto 0);
    variable src: TU2V(val'length-1 downto 0);
  begin
    src := val;
    if(shift=0) then
      return(src);
    elsif(shift>0) then
      return(U2VCut(TU2Vconv((TSLV(src) & TSLVnew(shift,'0'))),val'length));
    end if;
    res := TU2Vconv(TSLVnew(-shift,src(val'length-1)) & TSLV(src));
    src := res(res'length-1 downto res'length-val'length);
    if (src(val'length-1)='0') then
      if (res(res'length-val'length-1)='1') then
        src := U2VInc(src);
      end if;
    elsif (-shift/=(1)) then
      if (res(res'length-val'length-1)='1' and res(res'length-val'length-2 downto 0)/=0) then
        src := U2VInc(src);
      end if;
    end if;
    return (src);
  end function;  

  -------------------------------------------------------------------

  function  U2VShift(val :TU2V; shift :TU2V) return TU2V is
    variable vsh :TN; -- simulator roblem: range 0 to pow2(shift'length)-1;
  begin
    vsh := CONV_INTEGER(shift);--TIconv(shift);
    vsh := maximum(vsh, -pow2(shift'length-1));
    vsh := minimum(vsh, pow2(shift'length-1)-1);
    for index in -pow2(shift'length-1) to pow2(shift'length-1)-1 loop
      if (index=vsh) then
        return(U2VShift(val,index));
      end if;
    end loop;
    return(val);
  end function;  

  -------------------------------------------------------------------

  function  U2VShiftLen(val :TU2V; len :TI) return TU2V is
  begin
    if(len>val'length) then
      return(U2VShift(U2VExpand(val,len),len-val'length));
    elsif(len<val'length) then
      return(U2VCut(U2VShift(val,len-val'length),len));
    else
      return(val);
    end if;
  end function;  

  -------------------------------------------------------------------

  function  U2VShiftLen(val :TU2V; shift, len :TI) return TU2V is
  begin
    return(U2VResize(U2VShift(val,shift),len));
  end function;  

  -------------------------------------------------------------------

  function  U2VExtract(val :TU2V; len, base :TVL) return TU2V is
  begin
    return(U2VCut(U2VShift(val,-base),len));
  end function;  

  -------------------------------------------------------------------

  function  U2VInsert(len :TVL; val :TU2V; base :TVL) return TU2V is
    variable res :TU2V(base+val'length-1 downto 0);
  begin
    res := (others => '0');
    res(base+val'length-1 downto base) := val;
    return(U2VResize(res,len));
  end function;  

  -------------------------------------------------------------------

  function  U2VSum(val1, val2 :TU2V; len, base :TVL) return TU2V is
    constant RES_WIDTH :TN := maximum(maximum(val1'length,val2'length),len)+1;
    variable v1, v2, res :TU2V(RES_WIDTH-1 downto 0);
  begin
    v1 := U2VExpand(val1,RES_WIDTH);
    v2 := U2VExpand(val2,RES_WIDTH);
    res := v1 + v2;
    return(U2VExtract(res,len, base));
  end function;  

  -------------------------------------------------------------------

  function  U2VSum(val1, val2 :TU2V; len :TVL) return TU2V is
  begin
    return(U2VSum(val1,val2,len,0));
  end function;  

  -------------------------------------------------------------------

  function  U2VSub(val1, val2 :TU2V; len, base :TVL) return TU2V is
    constant RES_WIDTH :TN := maximum(maximum(val1'length,val2'length),len)+1;
    variable v1, v2, res :TU2V(RES_WIDTH-1 downto 0);
  begin
    v1  := U2VExpand(val1,RES_WIDTH);
    v2  := U2VExpand(val2,RES_WIDTH);
    res := v1 - v2;
    return(U2VExtract(res,len, base));
  end function;  

  -------------------------------------------------------------------

  function  U2VSub(val1, val2 :TU2V; len :TVL) return TU2V is
  begin
    return(U2VSub(val1,val2,len,0));
  end function;  

  -------------------------------------------------------------------

  function  U2VMult(val1, val2 :TU2V; len, base :TVL) return TU2V is
    constant RES_WIDTH :TN := maximum(maximum(val1'length,val2'length),(len+1)/2);
    variable sig1, sign2 :TU2V(RES_WIDTH-1 downto 0);
    variable v1, v2 :TU2V(RES_WIDTH-1 downto 0);
    variable res :TU2V(2*RES_WIDTH-1 downto 0);
  begin
    v1  := U2VExpand(val1,RES_WIDTH);
    v2  := U2VExpand(val2,RES_WIDTH);
    res := v1 * v2;
    return(U2VExtract(res,len, base));
  end function;  

  -------------------------------------------------------------------

  function  U2VMult(val1, val2 :TU2V; len :TVL) return TU2V is
  begin
    return(U2VMult(val1,val2,len,0));
  end function;  

  -------------------------------------------------------------------

  function  U2VPow2(val :TU2V; len, base :TVL) return TU2V is
  begin
    return(U2VMult(val,val,len, base));
  end function;  

  -------------------------------------------------------------------

  function  U2VPow2(val :TU2V; len :TVL) return TU2V is
  begin
    return(U2VPow2(val,len,0));
  end function;  



  -------------------------------------------------------------------
  -- two dimentions arrays emulation
  -------------------------------------------------------------------

  function  TU2Mcreate(rm, cm, wm :TVL) return TU2M is
    variable mx :TU2M;
  begin
    mx.r := rm;
    mx.c := cm;
    mx.w := wm;
    return(mx);
  end function;

  -------------------------------------------------------------------

  function  TU2Mcreate(rl,rh, cl,ch, wm :TVL) return TU2M is
    variable mx :TU2M;
  begin
    mx.r := rh-rl+1;
    mx.c := ch-cl+1;
    mx.w := wm;
    return(mx);
  end function;

  -------------------------------------------------------------------

  function  TU2Mtransp(mx :TU2M) return TU2M is
    variable mxt :TU2M;
  begin
    mxt.r := mx.c;
    mxt.c := mx.r;
    mxt.w := mx.w;
    return(mxt);
  end function;

-------------------------------------------------------------------

  function  U2MSizeArea(rm, cm, wm :TVL) return TVL is
  begin
    return(rm*cm*wm);
  end function;

  -------------------------------------------------------------------

  function  U2MSizeArea(mx :TU2M) return TVL is
  begin
    return(U2MSizeArea(mx.r,mx.c,mx.w));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeArea(rl,rh, cl,ch, wm :TVI) return TVL is
  begin
    return((rh-rl+1)*(ch-cl+1)*wm);
  end function;

  -------------------------------------------------------------------

  function  U2MSizeArea(mx :TU2M; rl,rh, cl,ch :TVI) return TVL is
  begin
    return(U2MSizeArea(rl,rh,cl,ch,mx.w));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeVec(l, h, wm :TVI) return TVL is
  begin
    return((h-l+1)*wm);
  end function;

  -------------------------------------------------------------------

  function  U2MSizeVec(mx :TU2M; l, h :TVI) return TVL is
  begin
    return(U2MSizeVec(l,h,mx.w));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeVec(num, wm :TVI) return TVL is
  begin
    return(U2MSizeVec(1,num,wm));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeVec(mx :TU2M; num :TVI) return TVL is
  begin
    return(U2MSizeVec(mx,1,num));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeAllRow(mx :TU2M) return TVL is
  begin
    return(U2MSizeVec(mx,1,mx.r));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeAllCol(mx :TU2M) return TVL is
  begin
    return(U2MSizeVec(mx,1,mx.c));
  end function;

  -------------------------------------------------------------------

  function  U2MSizeCell(mx :TU2M) return TVL is
  begin
    return(mx.w);
  end function;

  -------------------------------------------------------------------

  function  U2MPointerLSB(mx :TU2M; r, c :TVI) return TVI is
  begin
    return((r*mx.c+c)*mx.w);
  end function;

  -------------------------------------------------------------------

  function  U2MGetArea(v :TU2V; mx :TU2M; rl,rh, cl,ch :TVI) return TU2V is
    constant rmx :TU2M := TU2Mcreate(rl,rh,cl,ch,mx.w);
    constant clen :TVI := (ch-cl+1)*mx.w;
    variable res :TU2V(U2MSizeArea(rmx)-1 downto 0);
    variable sp, dp :TVI;
  begin
    for row in rl to rh loop
      sp := U2MPointerLSB(mx, row, cl);
      dp := U2MPointerLSB(rmx, row-rl, 0);
      res(dp+clen-1 downto dp) := v(sp+clen-1 downto sp);
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  U2MGetRow(v :TU2V; mx :TU2M; r, cl,ch :TVI) return TU2V is
  begin
    return(U2MGetArea(v,mx,r,r,cl,ch));
  end function;

  -------------------------------------------------------------------

  function  U2MGetAllRow(v :TU2V; mx :TU2M; r :TVI) return TU2V is
   begin
    return(U2MGetArea(v,mx,r,r,0,mx.c-1));
  end function;

  -------------------------------------------------------------------

  function  U2MGetCol(v :TU2V; mx :TU2M; rl,rh, c :TVI) return TU2V is
  begin
    return(U2MGetArea(v,mx,rl,rh,c,c));
  end function;

  -------------------------------------------------------------------

  function  U2MGetAllCol(v :TU2V; mx :TU2M; c :TVI) return TU2V is
  begin
    return(U2MGetArea(v,mx,0,mx.r-1,c,c));
  end function;

  -------------------------------------------------------------------

  function  U2MGetCell(v :TU2V; mx :TU2M; r, c :TVI) return TU2V is
  begin
    return(TU2V(U2MGetArea(v,mx,r,r,c,c)));
  end function;

  -------------------------------------------------------------------

  function  U2MSetArea(v :TU2V; mx :TU2M; rl,rh, cl,ch :TVI; d :TU2V) return TU2V is
    constant rmx :TU2M := TU2Mcreate(rl,rh,cl,ch,mx.w);
    constant clen :TVI := (ch-cl+1)*mx.w;
    variable res :TU2V(v'length-1 downto 0);
    variable sp, dp :TVI;
  begin
    res := v;
    sp := U2MPointerLSB(mx, rl, cl);
    for col in cl to ch loop
      res(sp+mx.w-1 downto sp) := d;
      sp := sp + mx.w;
    end loop;
    if(rh-rl>0) then
      sp := U2MPointerLSB(mx, rl, cl);
      for row in rl+1 to rh loop
        dp := U2MPointerLSB(mx, row, cl);
        res(dp+clen-1 downto dp) := res(sp+clen-1 downto sp);
	sp := dp;
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  U2MSetAllArea(v :TU2V; mx :TU2M; d :TU2V) return TU2V is
  begin
    return(U2MSetArea(v,mx,0,mx.r-1,0,mx.c-1,d));
  end function;

  -------------------------------------------------------------------

  function  U2MSetRow(v :TU2V; mx :TU2M; r, cl, ch :TVI; d :TU2V) return TU2V is
  begin
    return(U2MSetArea(v,mx,r,r,cl,ch,d));
  end function;

  -------------------------------------------------------------------

  function  U2MSetAllRow(v :TU2V; mx :TU2M; r :TVI; d :TU2V) return TU2V is
   begin
    return(U2MSetArea(v,mx,r,r,0,mx.c-1,d));
  end function;

  -------------------------------------------------------------------

  function  U2MSetCol(v :TU2V; mx :TU2M; rl, rh, c :TVI; d :TU2V) return TU2V is
  begin
    return(U2MSetArea(v,mx,rl,rh,c,c,d));
  end function;

  -------------------------------------------------------------------

  function  U2MSetAllCol(v :TU2V; mx :TU2M; c :TVI; d :TU2V) return TU2V is
  begin
    return(U2MSetArea(v,mx,0,mx.r-1,c,c,d));
  end function;

  -------------------------------------------------------------------

  function  U2MSetCell(v :TU2V; mx :TU2M; r, c :TVI; d :TU2V) return TU2V is
  begin
    return(U2MSetArea(v,mx,r,r,c,c,d));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyArea(vs, vd :TU2V; mxs, mxd :TU2M; rls,rhs,cls,chs, rld,cld :TVI) return TU2V is
    variable res :TU2V(vd'length-1 downto 0);
  begin
    res := vd;
    if (rld>rls) then
      for row in rhs downto rls loop
        res := U2MSetRow(res,mxd,rld+row-rls,cld,cld+chs-cls,U2MGetRow(vs,mxs,row,cls,chs));
      end loop;
    elsif (rld<rls) then
      for row in rls to rhs loop
        res := U2MSetRow(res,mxd,rld+row-rls,cld,cld+chs-cls,U2MGetRow(vs,mxs,row,cls,chs));
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  U2MCopyArea(v :TU2V; mx :TU2M; rls,rhs,cls,chs, rld,cld :TVI) return TU2V is
  begin
    return(U2MCopyArea(v,v,mx,mx,rls,rhs,cls,chs,rld,cld));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyRow(vs, vd :TU2V; mxs, mxd :TU2M; rs, cls, chs, rd :TVI) return TU2V is
  begin
    return(U2MCopyArea(vs,vd,mxs,mxd,rs,rs,cls,chs,rd,cls));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyRow(v :TU2V; mx :TU2M; rs, cls, chs, rd :TVI) return TU2V is
  begin
    return(U2MCopyRow(v,v,mx,mx,rs,cls,chs,rd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyAllRow(vs, vd :TU2V; mxs, mxd :TU2M; rs, rd :TVI) return TU2V is
   begin
    return(U2MCopyArea(vs,vd,mxs,mxd,rs,rs,0,mxs.c-1,rd,0));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyAllRow(v :TU2V; mx :TU2M; rs, rd :TVI) return TU2V is
   begin
    return(U2MCopyAllRow(v,v,mx,mx,rs,rd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyCol(vs, vd :TU2V; mxs, mxd :TU2M; rls, rhs, cs, cd :TVI) return TU2V is
  begin
    return(U2MCopyArea(vs,vd,mxs,mxd,rls,rhs,cs,cs,rls,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyCol(v :TU2V; mx :TU2M; rls, rhs, cs, cd :TVI) return TU2V is
  begin
    return(U2MCopyCol(v,v,mx,mx,rls,rhs,cs,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyAllCol(vs, vd :TU2V; mxs, mxd :TU2M; cs, cd :TVI) return TU2V is
  begin
    return(U2MCopyArea(vs,vd,mxs,mxd,0,mxs.r-1,cs,cs,0,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyAllCol(v :TU2V; mx :TU2M; cs, cd :TVI) return TU2V is
  begin
    return(U2MCopyAllCol(v,v,mx,mx,cs,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyCell(vs, vd :TU2V; mxs, mxd :TU2M; rs, cs, rd, cd :TVI) return TU2V is
  begin
    return(U2MCopyArea(vs,vd,mxs,mxd,rs,rs,cs,cs,rd,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MCopyCell(v :TU2V; mx :TU2M; rs, cs, rd, cd :TVI) return TU2V is
  begin
    return(U2MCopyCell(v,v,mx,mx,rs,cs,rd,cd));
  end function;

  -------------------------------------------------------------------

  function  U2MTransp(v :TU2V; mx :TU2M) return TU2V is
    constant mxt   :TU2M := TU2Mcreate(mx.c,mx.r,mx.w);
    variable res :TU2V(v'range);
  begin
    for row in 0 to mx.r loop
      res := U2MSetAllCol(v,mxt,row,U2MGetAllRow(v,mx,row));
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  U2MCreate(mx :TU2M; d :TU2V) return TU2V is
    variable res :TU2V(U2MSizeArea(mx)-1 downto 0);
  begin
    return(U2MSetAllArea(res,mx,d));
  end function;

  -------------------------------------------------------------------

  function  U2MCreate(mx :TU2M; d :TI) return TU2V is
    variable res :TU2V(U2MSizeArea(mx)-1 downto 0);
  begin
    return(U2MSetAllArea(res,mx,U2VCreate(d,mx.w)));
  end function;

  -------------------------------------------------------------------

  function  U2MCreate(mx :TU2M; d :TIV) return TU2V is
    variable res :TU2V(U2MSizeArea(mx)-1 downto 0);
    variable val :TU2V(mx.w-1 downto 0);
  begin
    for row in 0 to mx.r-1 loop
      for col in 0 to mx.c-1 loop
        val := U2VCreate(d(mx.c*row+col),mx.w);
        res := U2MSetCell(res,mx,row,col,val);
      end loop;
    end loop;
    return(res);
  end function;


  -------------------------------------------------------------------
  -- TU2M matrix mathematical function
  -------------------------------------------------------------------

  function  U2MSum(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V is
    constant check :TN := TNconv((mx1.r=mx2.r) and (mx1.c=mx2.c)); -- matrix checking
    constant mxr   :TU2M := TU2Mcreate(mx1.r,mx1.c,len);
    variable vres :TU2V(U2MSizeArea(mx1.r,mx1.c,len)-1 downto 0);
    variable val1 :TU2V(mx1.w-1 downto 0);
    variable val2 :TU2V(mx2.w-1 downto 0);
    variable res  :TU2V(len-1 downto 0);
  begin
    for row in 0 to mx1.r-1 loop
      for col in 0 to mx1.c-1 loop
        val1 := U2MGetCell(vmx1,mx1,row,col);
        val2 := U2MGetCell(vmx2,mx2,row,col);
        res  := U2VSum(val1,val2,len, base);
        vres := U2MSetCell(vres,mxr,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MSum(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V is
  begin
    return(U2MSum(vmx1,vmx2, mx1,mx2, len,0));
  end function;
  
  -------------------------------------------------------------------

  function  U2MSumV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V is
    variable vres :TU2V(U2MSizeArea(mx.r,mx.c,len)-1 downto 0);
    variable val1 :TU2V(mx.w-1 downto 0);
    variable res  :TU2V(len-1 downto 0);
  begin
    for row in 0 to mx.r-1 loop
      for col in 0 to mx.c-1 loop
        val1 := U2MGetCell(vmx,mx,row,col);
        res  := U2VSum(val1,val,len, base);
        vres := U2MSetCell(vres,mx,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MSumV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V is
  begin
    return(U2MSumV(vmx,val,mx,len,0));
  end function;
  
  -------------------------------------------------------------------
  
  function  U2MSub(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V is
    constant check :TN := TNconv((mx1.r=mx2.r) and (mx1.c=mx2.c)); -- matrix checking
    constant mxr   :TU2M := TU2Mcreate(mx1.r,mx1.c,len);
    variable vres :TU2V(U2MSizeArea(mx1.r,mx1.c,len)-1 downto 0);
    variable val1 :TU2V(mx1.w-1 downto 0);
    variable val2 :TU2V(mx2.w-1 downto 0);
    variable res  :TU2V(len-1 downto 0);
  begin
    for row in 0 to mx1.r-1 loop
      for col in 0 to mx1.c-1 loop
        val1 := U2MGetCell(vmx1,mx1,row,col);
        val2 := U2MGetCell(vmx2,mx2,row,col);
        res  := U2VSub(val1,val2,len, base);
        vres := U2MSetCell(vres,mxr,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MSub(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V is
  begin
    return(U2MSub(vmx1,vmx2, mx1,mx2, len,0));
  end function;
  
  -------------------------------------------------------------------

  function  U2MSubV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V is
    variable vres :TU2V(U2MSizeArea(mx.r,mx.c,len)-1 downto 0);
    variable val1 :TU2V(mx.w-1 downto 0);
    variable res  :TU2V(len-1 downto 0);
  begin
    for row in 0 to mx.r-1 loop
      for col in 0 to mx.c-1 loop
        val1 := U2MGetCell(vmx,mx,row,col);
        res  := U2VSub(val1,val,len, base);
        vres := U2MSetCell(vres,mx,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MSubV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V is
  begin
    return(U2MSubV(vmx,val,mx,len,0));
  end function;
  
  -------------------------------------------------------------------

  function  U2MMult(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len, base :TVL) return TU2V is
    constant check :TN := TNconv(mx1.c=mx2.r); -- matrix checking
    constant rmx   :TU2M := TU2Mcreate(mx1.r,mx2.c,len);
    variable vres  :TU2V(U2MSizeArea(rmx)-1 downto 0);
    variable val1  :TU2V(mx1.w-1 downto 0);
    variable val2  :TU2V(mx2.w-1 downto 0);
    variable res   :TU2V(check*len-1 downto 0);
  begin
    for row in 0 to mx1.r-1 loop
      for col in 0 to mx2.c-1 loop
        res := (others => '0');
        for index in 0 to mx1.c-1 loop
          val1 := U2MGetCell(vmx1,mx1,row,index);
          val2 := U2MGetCell(vmx2,mx2,index,col);
          res  := U2VSum(res,U2VMult(val1,val2,len,base),len,0);
	end loop;
       vres := U2MSetCell(vres,rmx,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MMult(vmx1, vmx2 :TU2V; mx1, mx2 :TU2M; len :TVL) return TU2V is
  begin
    return(U2MMult(vmx1,vmx2, mx1,mx2, len,0));
  end function;
  
  -------------------------------------------------------------------

  function  U2MMultV(vmx :TU2V; val :TU2V; mx :TU2M; len, base :TVL) return TU2V is
    constant rmx   :TU2M := TU2Mcreate(mx.r,mx.c,len);
    variable vres  :TU2V(U2MSizeArea(rmx)-1 downto 0);
    variable val1  :TU2V(mx.w-1 downto 0);
    variable res   :TU2V(len-1 downto 0);
  begin
    for row in 0 to mx.r-1 loop
      for col in 0 to mx.c-1 loop
        val1 := U2MGetCell(vmx,mx,row,col);
        res  := U2VMult(val1,val,len, base);
        vres := U2MSetCell(vres,mx,row,col,res);
      end loop;
    end loop;
    return(vres);
  end function;

  -------------------------------------------------------------------
  
  function  U2MMultV(vmx :TU2V; val :TU2V; mx :TU2M; len :TVL) return TU2V is
  begin
    return(U2MMultV(vmx,val,mx,len,0));
  end function;
  
  -------------------------------------------------------------------

  function  U2MPow2(vmx :TU2V; mx :TU2M; len, base :TVL) return TU2V is
  begin
    return(U2MMult(vmx,vmx, mx,mx, len,base));
  end function;

  -------------------------------------------------------------------

  function  U2MPow2(vmx :TU2V; mx :TU2M; len :TVL) return TU2V is
  begin
    return(U2MMult(vmx,vmx, mx,mx, len,0));
  end function;

end std_logic_arith_ktp;


--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_signed.all;
--use ieee.std_logic_misc.all;
--use work.std_logic_1164_ktp.all;
--use work.std_logic_arith_ktp.all;
--
--entity std_logic_arith_ktp_process_test is
--  generic (
--    LPM_DATA_WIDTH		:in  positive := 16;
--    LPM_CUT_SIZE		:in  integer  := 12;
--    LPM_EXPAND_SIZE		:in  integer  := 20;
--    LPM_SHIFT			:in  integer  := 1;
--    LPM_EXTRACT_LEN		:in  integer  := 8;
--    LPM_EXTRACT_BASE		:in  integer  := 2;
--    LPM_INSERT_LEN		:in  integer  := 28;
--    LPM_INSERT_BASE		:in  integer  := 4
--  );
--  port(
--    data_in1			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
--    data_in2			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreate_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreateMin_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreateMax_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreate0_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreate1_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VCreateN1_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VGetSign_out		:out TSL;
--    U2VNegSign_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VNegSignExp_out		:out TU2V(LPM_DATA_WIDTH downto 0);
--    U2VAbs_out			:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VAbsExp_out		:out TU2V(LPM_DATA_WIDTH downto 0);
--    U2VCut_out			:out TU2V(LPM_CUT_SIZE-1 downto 0);
--    U2VExpand_out		:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
--    U2VResize_cut_out		:out TU2V(LPM_CUT_SIZE-1 downto 0);
--    U2VResize_expand_out	:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
--    U2VShift_left_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VShift_right_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
--    U2VShiftLen_cut_out		:out TU2V(LPM_CUT_SIZE-1 downto 0);
--    U2VShiftLen_expand_out	:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
--    U2VExtract_out		:out TU2V(LPM_EXTRACT_LEN-1 downto 0);
--    U2VInsert_out		:out TU2V(LPM_INSERT_LEN-1 downto 0)
--  );
--end std_logic_arith_ktp_process_test;
--
--architecture behaviour of std_logic_arith_ktp_process_test is
--
--begin
--
--  U2VCreate_out          <= U2VCreate(-1234, LPM_DATA_WIDTH);
--  U2VCreateMin_out       <= U2VCreateMin(LPM_DATA_WIDTH);
--  U2VCreateMax_out       <= U2VCreateMax(LPM_DATA_WIDTH);
--  U2VCreate0_out         <= U2VCreate0(LPM_DATA_WIDTH);
--  U2VCreate1_out         <= U2VCreate1(LPM_DATA_WIDTH);
--  U2VCreateN1_out        <= U2VCreateN1(LPM_DATA_WIDTH);
--  U2VGetSign_out         <= TSLconv(U2VGetSign(data_in1));
--  U2VNegSign_out         <= U2VNegSign(data_in1);
--  U2VNegSignExp_out      <= U2VNegSignExp(data_in1);
--  U2VAbs_out             <= U2VAbs(data_in1);
--  U2VAbsExp_out          <= U2VAbsExp(data_in1);
--  U2VCut_out             <= U2VCut(data_in1, LPM_CUT_SIZE);
--  U2VExpand_out          <= U2VExpand(data_in1,LPM_EXPAND_SIZE);
--  U2VResize_cut_out      <= U2VResize(data_in1, LPM_CUT_SIZE);
--  U2VResize_expand_out   <= U2VResize(data_in1, LPM_EXPAND_SIZE);
--  U2VShift_left_out      <= U2VShift(data_in1, LPM_SHIFT);
--  U2VShift_right_out     <= U2VShift(data_in1, -LPM_SHIFT);
--  U2VShiftLen_cut_out    <= U2VShiftLen(data_in1, LPM_CUT_SIZE);
--  U2VShiftLen_expand_out <= U2VShiftLen(data_in1, LPM_EXPAND_SIZE);
--  U2VExtract_out         <= U2VExtract(data_in1, LPM_EXTRACT_LEN, LPM_EXTRACT_BASE);
--  U2VInsert_out          <= U2VInsert(LPM_INSERT_LEN, data_in1, LPM_INSERT_BASE);
--
--end behaviour;			   


--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_signed.all;
--use ieee.std_logic_misc.all;
--use work.std_logic_1164_ktp.all;
--use work.std_logic_arith_ktp.all;
--
--entity std_logic_arith_ktp_math_test is
--  generic (
--    LPM_DATA_IN_WIDTH		:in  positive := 16;
--    LPM_DATA_OUT_WIDTH		:in  positive := 12
--  );
--  port(
--    data_in1			:in  TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
--    data_in2			:in  TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
--
--    U2VSumB_out			:out TU2V(LPM_DATA_OUT_WIDTH-1 downto 0);
--    U2VSum_out			:out TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
--    U2VSubB_out			:out TU2V(LPM_DATA_OUT_WIDTH-1 downto 0);
--    U2VSub_out			:out TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
--    U2VMultB_out		:out TU2V(LPM_DATA_OUT_WIDTH-1 downto 0);
--    U2VMult_out			:out TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
--    U2VPow2B_out		:out TU2V(LPM_DATA_OUT_WIDTH-1 downto 0);
--    U2VPow2_out			:out TU2V(LPM_DATA_IN_WIDTH-1 downto 0)
--    
--  );
--end std_logic_arith_ktp_math_test;
--
--architecture behaviour of std_logic_arith_ktp_math_test is
--
--  constant OUT_BASE		:TI  := LPM_DATA_IN_WIDTH-LPM_DATA_OUT_WIDTH;
--
--begin
--
--  U2VSumB_out            <= U2VSum(data_in1,data_in2,LPM_DATA_OUT_WIDTH,OUT_BASE);
--  U2VSum_out             <= U2VSum(data_in1,data_in2,LPM_DATA_IN_WIDTH);
--  U2VSubB_out            <= U2VSub(data_in1,data_in2,LPM_DATA_OUT_WIDTH,OUT_BASE);
--  U2VSub_out             <= U2VSub(data_in1,data_in2,LPM_DATA_IN_WIDTH);
--  U2VMultB_out           <= U2VMult(data_in1,data_in2,LPM_DATA_OUT_WIDTH,OUT_BASE);
--  U2VMult_out            <= U2VMult(data_in1,data_in2,LPM_DATA_IN_WIDTH);
--  U2VPow2B_out           <= U2VPow2(data_in1,LPM_DATA_OUT_WIDTH,OUT_BASE);
--  U2VPow2_out            <= U2VPow2(data_in1,LPM_DATA_IN_WIDTH);
--
--end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity ktp_math_speed_test is
  generic (
    LPM_DATA_IN_WIDTH		:in  positive := 8;
    LPM_DATA_OUT_WIDTH		:in  positive := 8;
    LPM_OPER_TYPE		:in  string := "OPER_MULT"
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    data_in1			:in  TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
    data_in2			:in  TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
    data_out			:out TU2V(LPM_DATA_OUT_WIDTH-1 downto 0)
  );
end ktp_math_speed_test;

architecture behaviour of ktp_math_speed_test is

  constant OUT_BASE		:TI  := LPM_DATA_IN_WIDTH-LPM_DATA_OUT_WIDTH;

  signal data_in1R		:TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
  signal data_in2R		:TU2V(LPM_DATA_IN_WIDTH-1 downto 0);
  signal data_outR		:TU2V(LPM_DATA_OUT_WIDTH-1 downto 0);

begin

  sum:if (LPM_OPER_TYPE="OPER_SUM") generate
    process (clk, resetN)
    begin
      if (resetN='0') then
        data_in1R <= (others =>'0');
        data_in2R <= (others =>'0');
        data_outR <= (others =>'0');
      elsif (clk'event and clk='1') then
        data_in1R <= data_in1;
        data_in2R <= data_in2;
        data_outR <= U2VSum(data_in1R,data_in2R,LPM_DATA_OUT_WIDTH,OUT_BASE);
      end if;
    end process;
    data_out <= data_outR;
  end generate;

  sub:if (LPM_OPER_TYPE="OPER_SUB") generate
    process (clk, resetN)
    begin
      if (resetN='0') then
        data_in1R <= (others =>'0');
        data_in2R <= (others =>'0');
        data_outR <= (others =>'0');
      elsif (clk'event and clk='1') then
        data_in1R <= data_in1;
        data_in2R <= data_in2;
        data_outR <= U2VSub(data_in1R,data_in2R,LPM_DATA_OUT_WIDTH,OUT_BASE);
      end if;
    end process;
    data_out <= data_outR;
  end generate;

  mult:if (LPM_OPER_TYPE="OPER_MULT") generate
    process (clk, resetN)
    begin
      if (resetN='0') then
        data_in1R <= (others =>'0');
        data_in2R <= (others =>'0');
        data_outR <= (others =>'0');
      elsif (clk'event and clk='1') then
        data_in1R <= data_in1;
        data_in2R <= data_in2;
        data_outR <= U2VMult(data_in1R,data_in2R,LPM_DATA_OUT_WIDTH,OUT_BASE);
      end if;
    end process;
    data_out <= data_outR;
  end generate;

  pow2:if (LPM_OPER_TYPE="OPER_POW2") generate
    process (clk, resetN)
    begin
      if (resetN='0') then
        data_in1R <= (others =>'0');
        data_outR <= (others =>'0');
      elsif (clk'event and clk='1') then
        data_in1R <= data_in1;
        data_outR <= U2VPow2(data_in1R,LPM_DATA_OUT_WIDTH,OUT_BASE);
      end if;
    end process;
    data_out <= data_outR;
  end generate;
 
end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity std_logic_arith_ktp_test is
  generic (
    LPM_DATA_WIDTH		:in  positive := 6;
    LPM_CUT_SIZE		:in  integer  := 4;
    LPM_EXPAND_SIZE		:in  integer  := 10;
    LPM_SHIFT			:in  integer  := 1;
    LPM_EXTRACT_LEN		:in  integer  := 4;
    LPM_EXTRACT_BASE		:in  integer  := 2;
    LPM_INSERT_LEN		:in  integer  := 20;
    LPM_INSERT_BASE		:in  integer  := 4;
    LPM_U2M1_ROW		:in  integer  := 6;
    LPM_U2M1_COL		:in  integer  := 5;
    LPM_U2M1_WIDTH		:in  integer  := 4;
    LPM_U2M1_RL			:in  integer  := 1;
    LPM_U2M1_RH			:in  integer  := 4;
    LPM_U2M1_CL			:in  integer  := 0;
    LPM_U2M1_CH			:in  integer  := 2;
    LPM_U2M2_ROW		:in  integer  := 2;
    LPM_U2M2_COL		:in  integer  := 3;
    LPM_U2M2_WIDTH		:in  integer  := 8;
    LPM_U2M2_PARAM		:in  integer  := -1
  );
  port(
    data_in1			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    data_in2			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VCreate_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VCreateMin_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VCreateMax_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VGetSign_out		:out TSL;
    U2VNegSign_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VNegSignExp_out		:out TU2V(LPM_DATA_WIDTH downto 0);
    U2VAbs_out			:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VAbsExp_out		:out TU2V(LPM_DATA_WIDTH downto 0);
    U2VCut_out			:out TU2V(LPM_CUT_SIZE-1 downto 0);
    U2VExpand_out		:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
    U2VResize_cut_out		:out TU2V(LPM_CUT_SIZE-1 downto 0);
    U2VResize_expand_out	:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
    U2VShift_left_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VShift_right_out		:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VShiftLen_cut_out		:out TU2V(LPM_CUT_SIZE-1 downto 0);
    U2VShiftLen_expand_out	:out TU2V(LPM_EXPAND_SIZE-1 downto 0);
    U2VExtract_out		:out TU2V(LPM_EXTRACT_LEN-1 downto 0);
    U2VInsert_out		:out TU2V(LPM_INSERT_LEN-1 downto 0);
    U2VSum_out			:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VSub_out			:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    U2VMult_out			:out TU2V(LPM_DATA_WIDTH-1 downto 0);
    
    vec_mx_in			:in  TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    data_u2v_in			:in  TU2V(LPM_U2M1_WIDTH-1 downto 0);
    U2MGetArea_out		:out TU2V(U2MSizeArea(LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_CL,LPM_U2M1_CH,LPM_U2M1_WIDTH)-1 downto 0);
    U2MGetRow_out		:out TU2V(U2MSizeVec(LPM_U2M1_CL,LPM_U2M1_CH,LPM_U2M1_WIDTH)-1 downto 0);
    U2MGetAllRow_out		:out TU2V(U2MSizeVec(LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MGetCol_out		:out TU2V(U2MSizeVec(LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_WIDTH)-1 downto 0);
    U2MGetAllCol_out		:out TU2V(U2MSizeVec(LPM_U2M1_ROW,LPM_U2M1_WIDTH)-1 downto 0);
    U2MGetCell_out		:out TU2V(LPM_U2M1_WIDTH-1 downto 0);
    U2MSetArea_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetAllArea_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetRow_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetAllRow_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetCol_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetAllCol_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    U2MSetCell_out		:out TU2V(U2MSizeArea(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH)-1 downto 0);
    
    U2MCreate_out		:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0);
    U2MSum_out			:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0);
    U2MSumV_out			:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0);
    U2MSub_out			:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0);
    U2MSubV_out			:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0);
    U2MMult_out			:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_ROW,LPM_U2M2_WIDTH)-1 downto 0);
    U2MMultV_out		:out TU2V(U2MSizeArea(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH)-1 downto 0)
  );
end std_logic_arith_ktp_test;

architecture behaviour of std_logic_arith_ktp_test is

  constant MX1   :TU2M := TU2Mcreate(LPM_U2M1_ROW,LPM_U2M1_COL,LPM_U2M1_WIDTH);
  constant MX2   :TU2M := TU2Mcreate(LPM_U2M2_ROW,LPM_U2M2_COL,LPM_U2M2_WIDTH);
  constant VMX1D :TIV(MX2.R*MX2.C-1 downto 0) := (1,2,3,4,5,6);
  constant VMX1  :TU2V(U2MSizeArea(MX2)-1 downto 0) := U2MCreate(MX2, VMX1D);
  constant VMX2D :TIV(MX2.R*MX2.C-1 downto 0) := (-1,1,-1,1,-1,1);
  constant VMX2  :TU2V(U2MSizeArea(MX2)-1 downto 0) := U2MCreate(MX2, VMX2D);
  constant U2M2_PARAM :TU2V(LPM_U2M2_WIDTH-1 downto 0) := U2VCreate(LPM_U2M2_PARAM,LPM_U2M2_WIDTH);
  constant MXT   :TU2M := TU2Mcreate(LPM_U2M2_COL,LPM_U2M2_ROW,LPM_U2M2_WIDTH);
  constant VMXTD :TIV(MX2.C*MX2.R-1 downto 0) := (6,5,4,3,2,1);
  constant VMXT  :TU2V(U2MSizeArea(MX2)-1 downto 0) := U2MCreate(MX2, VMXTD);

begin

  U2VCreate_out          <= U2VCreate(-1234, LPM_DATA_WIDTH);
  U2VCreateMin_out       <= U2VCreateMin(LPM_DATA_WIDTH);
  U2VCreateMax_out       <= U2VCreateMax(LPM_DATA_WIDTH);
  U2VGetSign_out         <= TSLconv(U2VGetSign(data_in1));
  U2VNegSign_out         <= U2VNegSign(data_in1);
  U2VNegSignExp_out      <= U2VNegSignExp(data_in1);
  U2VAbs_out             <= U2VAbs(data_in1);
  U2VAbsExp_out          <= U2VAbsExp(data_in1);
  U2VCut_out             <= U2VCut(data_in1, LPM_CUT_SIZE);
  U2VExpand_out          <= U2VExpand(data_in1,LPM_EXPAND_SIZE);
  U2VResize_cut_out      <= U2VResize(data_in1, LPM_CUT_SIZE);
  U2VResize_expand_out   <= U2VResize(data_in1, LPM_EXPAND_SIZE);
  U2VShift_left_out      <= U2VShift(data_in1, LPM_SHIFT);
  U2VShift_right_out     <= U2VShift(data_in1, -LPM_SHIFT);
  U2VShiftLen_cut_out    <= U2VShiftLen(data_in1, LPM_CUT_SIZE);
  U2VShiftLen_expand_out <= U2VShiftLen(data_in1, LPM_EXPAND_SIZE);
  U2VExtract_out         <= U2VExtract(data_in1, LPM_EXTRACT_LEN, LPM_EXTRACT_BASE);
  U2VInsert_out          <= U2VInsert(LPM_INSERT_LEN, data_in1, LPM_INSERT_BASE);
  U2VSum_out             <= U2VSum(data_in1,data_in2,LPM_DATA_WIDTH);
  U2VSub_out             <= U2VSub(data_in1,data_in2,LPM_DATA_WIDTH);
  U2VMult_out            <= U2VMult(data_in1,data_in2,LPM_DATA_WIDTH);

  U2MGetArea_out    <= U2MGetArea(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_CL,LPM_U2M1_CH);
  U2MGetRow_out     <= U2MGetRow(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_CL,LPM_U2M1_CH);
  U2MGetAllRow_out  <= U2MGetAllRow(vec_mx_in,MX1,LPM_U2M1_RL);
  U2MGetCol_out     <= U2MGetCol(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_CL);
  U2MGetAllCol_out  <= U2MGetAllCol(vec_mx_in,MX1,LPM_U2M1_CL);
  U2MGetCell_out    <= U2MGetCell(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_CL);
  U2MSetArea_out    <= U2MSetArea(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_CL,LPM_U2M1_CH,data_u2v_in);
  U2MSetAllArea_out <= U2MSetAllArea(vec_mx_in,MX1,data_u2v_in);
  U2MSetRow_out     <= U2MSetRow(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_CL,LPM_U2M1_CH,data_u2v_in);
  U2MSetAllRow_out  <= U2MSetAllRow(vec_mx_in,MX1,LPM_U2M1_RL,data_u2v_in);
  U2MSetCol_out     <= U2MSetCol(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_RH,LPM_U2M1_CL,data_u2v_in);
  U2MSetAllCol_out  <= U2MSetAllCol(vec_mx_in,MX1,LPM_U2M1_CL,data_u2v_in);
  U2MSetCell_out    <= U2MSetCell(vec_mx_in,MX1,LPM_U2M1_RL,LPM_U2M1_CL,data_u2v_in);

  U2MCreate_out <= VMX1;
  U2MSum_out    <= U2MSum(VMX1,VMX2,MX2,MX2,LPM_U2M2_WIDTH);
  U2MSumV_out   <= U2MSumV(VMX1,U2M2_PARAM,MX2,LPM_U2M2_WIDTH);
  U2MSub_out    <= U2MSub(VMX1,VMX2,MX2,MX2,LPM_U2M2_WIDTH);
  U2MSubV_out   <= U2MSubV(VMX1,U2M2_PARAM,MX2,LPM_U2M2_WIDTH);
  U2MMult_out   <= U2MMult(VMX1,VMXT,MX2,MXT,LPM_U2M2_WIDTH);
  U2MMultV_out  <= U2MMultV(VMX1,U2M2_PARAM,MX2,LPM_U2M2_WIDTH);

end behaviour;			   

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_MULT_KTP is
  generic (
    LPM_MULT_WIDTH		:in  positive := 18;
    LPM_DATA_WIDTH		:in  positive := 128;
    LPM_PIPELINE		:in  integer  :=  2
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    clken			:in  TSL;
    dataa			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    datab			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    result			:out TU2V(2*LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_MULT_KTP;

architecture behaviour of LPM_MULT_KTP is

  constant INPUT_REG		:TL := TRUE;
  constant ABSOLUTE_REG		:TL := TRUE;
  constant MULTIPL_REG		:TL := TRUE;
  constant SUM_REG		:TL := TRUE;
  constant OUTPUT_REG		:TL := TRUE;

  constant DATA_CMULT_NUM	:TP := SLVPartNum(LPM_DATA_WIDTH-1,LPM_MULT_WIDTH-1);
  constant DATA_WIDTH		:TP := DATA_CMULT_NUM*(LPM_MULT_WIDTH-1)+1;

  subtype  CmultRes		is TU2V(2*LPM_MULT_WIDTH-1 downto 0);
  type     CmultResVec		is array (0 to DATA_CMULT_NUM-1) of CmultRes;
  type     CmultResTab		is array (0 to DATA_CMULT_NUM-1) of CmultResVec;

  signal   DataAreg		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   DataBreg		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   DataAminReg		:TSL;
  signal   DataBminReg		:TSL;
  signal   DataAsignReg1	:TSL;
  signal   DataBsignReg1	:TSL;
  signal   DataAsignReg2	:TSL;
  signal   DataBsignReg2	:TSL;
  signal   DataAsignReg3	:TSL;
  signal   DataBsignReg3	:TSL;
  signal   DataAabsReg		:TU2V(DATA_WIDTH-1 downto 0);
  signal   DataBabsReg		:TU2V(DATA_WIDTH-1 downto 0);
  signal   CmultResTabReg	:CmultResTab;
  signal   CmultSumEvnReg	:TU2V(2*DATA_WIDTH-1 downto 0);
  signal   CmultSumOddReg	:TU2V(2*DATA_WIDTH-1 downto 0);
  signal   ResultReg		:TU2V(2*LPM_DATA_WIDTH-1 downto 0);

begin

  -------------------------------------------------- 
  process (clk, resetN,dataa,datab) begin
    if (INPUT_REG=TRUE and resetN='0') then
      DataAreg <= (others=>'0');
      DataBreg <= (others=>'0');
    elsif (INPUT_REG=FALSE or (clk'event and clk='1')) then
      if (INPUT_REG=FALSE or clken='1') then
        DataAreg <= dataa;
	DataBreg <= datab;
      end if;
    end if;
  end process;

  -------------------------------------------------- 
  process (clk, resetN, DataAreg, DataBreg) begin 
    if (ABSOLUTE_REG=TRUE and resetN='0') then
      DataAminReg   <= '0';
      DataBminReg   <= '0';
      DataAsignReg1 <= '0';
      DataBsignReg1 <= '0';
      DataAabsReg   <= (others=>'0');
      DataBabsReg   <= (others=>'0');
    elsif (ABSOLUTE_REG=FALSE or (clk'event and clk='1')) then
      if (ABSOLUTE_REG=FALSE or clken='1') then
        DataAminReg   <= TSLconv(DataAreg = U2VCreateMin(LPM_DATA_WIDTH));
        DataBminReg   <= TSLconv(DataBreg = U2VCreateMin(LPM_DATA_WIDTH));
        DataAsignReg1 <= TSLconv(U2VGetSign(DataAreg));
        DataBsignReg1 <= TSLconv(U2VGetSign(DataBreg));
        DataAabsReg   <= U2VExpand(U2VAbs(DataAreg)(DataAreg'range),DATA_WIDTH);
	DataBabsReg   <= U2VExpand(U2VAbs(DataBreg)(DataBreg'range),DATA_WIDTH);
      end if;
    end if;
  end process;

  -------------------------------------------------- 
  process (clk, resetN, DataAsignReg1, DataBsignReg1, -->
                        DataAabsReg, DataBabsReg, -->
      		  	DataAminReg, DataBminReg) begin
    if (MULTIPL_REG=TRUE and resetN='0') then
      DataAsignReg2 <= '0';
      DataBsignReg2 <= '0';
      CmultResTabReg  <= (CmultResTab'range => (CmultResVec'range => (others=>'0')));
    elsif (MULTIPL_REG=FALSE or (clk'event and clk='1')) then
      if (MULTIPL_REG=FALSE or clken='1') then
        DataAsignReg2 <= DataAsignReg1 xor DataAminReg;
        DataBsignReg2 <= DataBsignReg1 xor DataBminReg;
	if(DATA_CMULT_NUM=1) then
	  CmultResTabReg(0)(0) <= DataAabsReg * DataBabsReg;
	else
          for a in 0 to DATA_CMULT_NUM-1 loop
            for b in 0 to DATA_CMULT_NUM-1 loop
              CmultResTabReg(a)(b) <=   TU2V('0' & SLVPartGet(TSLV(DataAabsReg),LPM_MULT_WIDTH-1,a,'0')) -->
	                              * TU2V('0' & SLVPartGet(TSLV(DataBabsReg),LPM_MULT_WIDTH-1,b,'0'));
	    end loop;
	  end loop;
	end if;
      end if;
    end if;
  end process;

  -------------------------------------------------- 
  process (clk, resetN, DataAsignReg2, DataBsignReg2, CmultResTabReg)
    subtype  CmultSum    is TU2V(2*DATA_WIDTH-1 downto 0);
    type     CmultSumVec is array (0 to 2*DATA_CMULT_NUM-2) of CmultSum;
    variable CmultSumVecVar :CmultSumVec;
    variable CmultSumEvnVar :TU2V(2*DATA_WIDTH-1 downto 0);
    variable CmultSumOddVar :TU2V(2*DATA_WIDTH-1 downto 0);
    variable even :TN;
  begin
    if (SUM_REG=TRUE and resetN='0') then
      DataAsignReg3 <= '0';
      DataBsignReg3 <= '0';
      CmultSumEvnReg  <= (others=>'0');
      CmultSumOddReg  <= (others=>'0');
    elsif (SUM_REG=FALSE or (clk'event and clk='1')) then
      if (SUM_REG=FALSE or clken='1') then
        DataAsignReg3 <= DataAsignReg2;
        DataBsignReg3 <= DataBsignReg2;
        CmultSumVecVar  := (CmultSumVec'range => (others=>'0'));
        for a in 0 to DATA_CMULT_NUM-1 loop
          for b in 0 to DATA_CMULT_NUM-1 loop
	    if ((a+b)=0) then
              CmultSumVecVar(a+b) := CmultSumVecVar(a+b)+CmultResTabReg(a)(b);
	    else
              CmultSumVecVar(a+b) := CmultSumVecVar(a+b)+TU2Vconv(TSLV(CmultResTabReg(a)(b)) & TSLVnew((a+b)*(LPM_MULT_WIDTH-1),'0'));
	    end if;
	  end loop;
	end loop;
        CmultSumEvnVar := (others=>'0');
        CmultSumOddVar := (others=>'0');
	even := 0;
        for s in 0 to 2*DATA_CMULT_NUM-2 loop
	  if(even=1) then 
            CmultSumEvnVar := CmultSumEvnVar + CmultSumVecVar(s);
	    even := 0;
	  else
            CmultSumOddVar := CmultSumOddVar + CmultSumVecVar(s);
	    even := 1;
	  end if;
	end loop;
	CmultSumEvnReg <= CmultSumEvnVar;
        CmultSumOddReg <= CmultSumOddVar;
      end if;
    end if;
  end process;

  -------------------------------------------- 
  process (clk, resetN,DataAsignReg3, DataBsignReg3, CmultSumEvnReg, CmultSumOddReg)
    variable ResAbsVar :TU2V(2*DATA_WIDTH-1 downto 0);
    variable ResVar    :TU2V(2*LPM_DATA_WIDTH-1 downto 0);
  begin
    if (OUTPUT_REG=TRUE and resetN='0') then
       ResultReg <= (others => '0');
    elsif (OUTPUT_REG=FALSE or (clk'event and clk='1')) then
      if (OUTPUT_REG=FALSE or clken='1') then
        ResAbsVar := CmultSumEvnReg + CmultSumOddReg;
	ResVar    := ResAbsVar(ResVar'range);
        if (DataAsignReg3 /= DataBsignReg3) then
          ResVar := U2VNegSign(ResVar)(ResVar'range);
	end if;
	if (ABSOLUTE_REG=FALSE and MULTIPL_REG=FALSE and SUM_REG=FALSE) then
	  ResultReg <= DataAreg * DataBreg; --!!!! standard VHDL multiplication !!!!!
	else
          ResultReg <= ResVar;
	end if;
      end if;
    end if;
  end process;

  result <= ResultReg;
  
end behaviour;			   

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_MX_SUM_KTP is
  generic (
    LPM_MX_ROW			:in  positive := 4;
    LPM_MX_COL			:in  positive := 5;
    LPM_MXA_LEN			:in  positive := 4;
    LPM_MXB_LEN			:in  positive := 4;
    LPM_MXR_LEN			:in  positive := 4;
    LPM_REGISTER_IN		:in  boolean  := TRUE;
    LPM_REGISTER_OUT		:in  boolean  := TRUE;
    LPM_SUM_MUX			:in  positive := 4
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    clken			:in  TSL;
    dinstr			:in  TSL;
    doutstr			:out TSL;
    dataa			:in  TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXA_LEN)-1 downto 0);
    datab			:in  TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXB_LEN)-1 downto 0);
    result			:out TU2V(U2MSizeArea(LPM_MX_ROW,LPM_MX_COL,LPM_MXR_LEN)-1 downto 0)
  );
end LPM_MX_SUM_KTP;

architecture behaviour of LPM_MX_SUM_KTP is

  constant REGISTER_OUT :TL   := LPM_REGISTER_OUT or (LPM_SUM_MUX>1);
  constant PART_NUM	:TP   := SLVPartNum(LPM_MX_ROW*LPM_MX_COL,LPM_SUM_MUX);
  constant MXA          :TU2M := TU2Mcreate(LPM_MX_ROW*LPM_MX_COL,1,LPM_MXA_LEN);
  constant MXB          :TU2M := TU2Mcreate(LPM_MX_ROW*LPM_MX_COL,1,LPM_MXB_LEN);
  constant MXR          :TU2M := TU2Mcreate(LPM_MX_ROW*LPM_MX_COL,1,LPM_MXR_LEN);

  signal DataAreg  :TU2V(PART_NUM*LPM_SUM_MUX*LPM_MXA_LEN-1 downto 0);
  signal DataBreg  :TU2V(PART_NUM*LPM_SUM_MUX*LPM_MXB_LEN-1 downto 0);
  signal ResultReg :TU2V(PART_NUM*LPM_SUM_MUX*LPM_MXR_LEN-1 downto 0);
  signal StopSig   :TSL;

  signal count     :TN range 0 to LPM_SUM_MUX-1;

begin

  process (clk, resetN, dataa, datab)
    variable pta   :TVI;
    variable ptb   :TVI;
  begin
    if (LPM_REGISTER_IN=TRUE and resetN='0') then
      DataAreg <= (others=>'0');
      DataBreg <= (others=>'0');
    elsif (LPM_REGISTER_IN=FALSE or (clk'event and clk='1')) then
      if (LPM_REGISTER_IN=FALSE or (clken='1' and ((count=LPM_SUM_MUX-1) or ((count=0) and (dinstr='0'))))) then
        DataAreg <= TU2V(TSLVresize(TSLV(dataa),DataAreg'length,'0'));
        DataBreg <= TU2V(TSLVresize(TSLV(datab),DataBreg'length,'0'));
      else
	if (LPM_SUM_MUX>1) then
	  DataAreg <= TU2V(SLVPartCopyRep(TSLV(DataAreg),LPM_MXA_LEN,1,LPM_SUM_MUX-1,0,LPM_SUM_MUX,PART_NUM));
	  DataBreg <= TU2V(SLVPartCopyRep(TSLV(DataBreg),LPM_MXB_LEN,1,LPM_SUM_MUX-1,0,LPM_SUM_MUX,PART_NUM));
	end if;
      end if;
    end if;
  end process;

  process (clk, resetN, DataAreg, DataBreg)
    variable val1  :TU2V(LPM_MXA_LEN-1 downto 0);
    variable val2  :TU2V(LPM_MXB_LEN-1 downto 0);
    variable res   :TU2V(LPM_MXR_LEN-1 downto 0);
    variable vres  :TU2V(ResultReg'range);
    variable index :TN;
    variable ptr   :TVI;
    variable StopVar :TSL;
  begin
    if (REGISTER_OUT=TRUE and resetN='0') then
      count	<= 0;
      ResultReg <= (others=>'0');
      StopSig <= '0';
    elsif (REGISTER_OUT=FALSE or (clk'event and clk='1')) then
      if (REGISTER_OUT=FALSE) then
        ResultReg <= U2MSum(DataAreg,DataBreg,MXA,MXB,LPM_MXR_LEN);
	StopSig <= '1';
      elsif(clken='1') then
        StopVar := '0';
        if (count>0 or dinstr='1') then
	  if (count<LPM_SUM_MUX-1) then
	    count <= count+1;
	  else
	    count <= 0;
            StopVar := '1';
	  end if;
	  vres := ResultReg;
	  if (LPM_SUM_MUX>1) then
	    vres := TU2V(SLVPartCopyRep(TSLV(vres),LPM_MXR_LEN,1,LPM_SUM_MUX-1,0,LPM_SUM_MUX,PART_NUM));
	  end if;
          for pos in 0 to PART_NUM-1 loop
            val1 := U2MGetCell(DataAreg,MXA,pos*LPM_SUM_MUX,0);
            val2 := U2MGetCell(DataBreg,MXB,pos*LPM_SUM_MUX,0);
            res  := U2VSum(val1,val2,LPM_MXR_LEN);
	    vres := TU2V(SLVPartPut(TSLV(vres),LPM_MXR_LEN,(pos+1)*LPM_SUM_MUX-1,TSLV(res)));
          end loop;
	  ResultReg <= vres;
	end if;
	StopSig <= StopVar;
      end if;
    end if;
  end process;

  result  <= TU2V(TSLVresize(TSLV(ResultReg),result'length));
  doutstr <= StopSig;

end behaviour;			   

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_MX_MULT_KTP is
  generic (
    LPM_MXA_ROW			:in  positive := 4;
    LPM_MXA_COL			:in  positive := 5;
    LPM_MXA_LEN			:in  positive := 18;
    LPM_MXB_ROW			:in  positive := 5;
    LPM_MXB_COL			:in  positive := 4;
    LPM_MXB_LEN			:in  positive := 18;
    LPM_MXR_LEN			:in  positive := 18;
    LPM_REGISTER_IN		:in  boolean  := TRUE;
    LPM_REGISTER_OUT		:in  boolean  := TRUE;
    LPM_SUM_MUX			:in  positive := 4
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    clken			:in  TSL;
    start			:in  TSL;
    stop			:out TSL;
    dataa			:in  TU2V(U2MSizeArea(LPM_MXA_ROW,LPM_MXA_COL,LPM_MXA_LEN)-1 downto 0);
    datab			:in  TU2V(U2MSizeArea(LPM_MXB_ROW,LPM_MXB_COL,LPM_MXB_LEN)-1 downto 0);
    result			:out TU2V(U2MSizeArea(LPM_MXA_ROW,LPM_MXB_COL,LPM_MXR_LEN)-1 downto 0)
  );
end LPM_MX_MULT_KTP;

architecture behaviour of LPM_MX_MULT_KTP is
  constant MXA     :TU2M := TU2Mcreate(LPM_MXA_ROW,LPM_MXA_COL,LPM_MXA_LEN);
  constant MXB     :TU2M := TU2Mcreate(LPM_MXB_ROW,LPM_MXB_COL,LPM_MXB_LEN);
  signal DataAreg  :TU2V(dataa'range);
  signal DataBreg  :TU2V(datab'range);
  signal ResultReg :TU2V(result'range);
begin
  process (clk, resetN) begin
    if (resetN='0') then
      DataAreg  <= (others=>'0');
      DataBreg  <= (others=>'0');
      ResultReg <= (others=>'0');
    elsif (clk'event and clk='1') then
      if (clken='1') then
        DataAreg  <= dataa;
        DataBreg  <= datab;
	ResultReg <= U2MMult(DataAreg,DataBreg,MXA,MXB,LPM_MXR_LEN);
      end if;
    end if;
  end process;
  result <= ResultReg;
end behaviour;			   

  

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_AVER_SHIFT_KTP is
  generic (
    LPM_DATA_WIDTH		:in  positive := 8;
    LPM_AVER_SHIFT_MAX		:in  positive := 3;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    clken			:in  TSL;
    aver_shift			:in  TSLV(TVLcreate(LPM_AVER_SHIFT_MAX)-1 downto 0);
    data			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    result			:out TU2V(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_AVER_SHIFT_KTP;

architecture behaviour of LPM_AVER_SHIFT_KTP is

  constant AVER_WIDTH		:TP := TVLcreate(LPM_AVER_SHIFT_MAX);
  constant DATA_WIDTH		:TP := LPM_DATA_WIDTH+LPM_AVER_SHIFT_MAX;

  subtype  DataPos		is TU2V(DATA_WIDTH-1 downto 0);
  type     DataPosVec		is array (0 to pow2(LPM_AVER_SHIFT_MAX)-2) of DataPos;
  
  signal   DataPosSum		:DataPosVec;
  signal   ResultSig		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   ResultReg		:TU2V(LPM_DATA_WIDTH-1 downto 0);

begin

  process (clk, resetN)
  begin
    if (resetN='0') then
      DataPosSum <= (DataPosVec'range => (others => '0'));
    elsif (clk'event and clk='1') then
      if (clken='1') then
        DataPosSum(0) <= U2VExpand(data,DATA_WIDTH);
        if (DataPosVec'length>1) then
          for index in 1 to DataPosVec'length-1 loop
	    DataPosSum(index) <= U2VSum(data,DataPosSum(index-1),DATA_WIDTH);
	  end loop;
	end if;
      end if;
    end if;
  end process;
  
  process (data, DataPosSum, aver_shift)
    variable AverVar :TN;
    variable ResultVar :DataPos;
  begin
    if (OR_REDUCE(aver_shift)='0') then
      ResultSig <= data;
    else
      for index in 1 to pow2(AVER_WIDTH)-1 loop
        if (index = TNconv(aver_shift)) then
          AverVar    := minimum(index,LPM_AVER_SHIFT_MAX);
	  ResultVar := U2VSum(data,DataPosSum(pow2(AverVar)-2),DATA_WIDTH);
          ResultSig <= U2VShift(ResultVar,-AverVar)(result'range);
	  exit;
        end if;
      end loop;
    end if;
  end process;

  process (clk, resetN, ResultSig) begin
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      ResultReg <= (others=>'0');
    elsif (LPM_OUTPUT_REGISTER=FALSE or (clk'event and clk='1')) then
      if (LPM_OUTPUT_REGISTER=FALSE or clken='1') then
        ResultReg <= ResultSig;
      end if;
    end if;
  end process;

  result <= ResultReg;

end behaviour;			   


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_FILTER_KTP is
  generic (
    LPM_DATA_WIDTH		:in  natural := 16;
    LPM_DATA_NUM		:in  natural := 6;
    LPM_DOT_POSITION		:in  natural := 14;
    LPM_INPUT_REGISTER		:in  boolean := FALSE;
    LPM_OUTPUT_REGISTER		:in  boolean := FALSE
  );
  port(
    resetN			:in  TSL;
    clk				:in  TSL;
    filter_start		:in  TSL;
    param			:in  TU2V(LPM_DATA_NUM*LPM_DATA_WIDTH-1 downto 0);
    data			:in  TU2V(LPM_DATA_WIDTH-1 downto 0);
    result			:out TU2V(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_FILTER_KTP;

architecture behaviour of LPM_FILTER_KTP is

  constant PIPE_LEN             :TN := LPM_DATA_NUM-1;
  constant PIPE_LEN1            :TN := maximum(PIPE_LEN,1);
  constant SUM_LEN              :TN := LPM_DATA_WIDTH+TVLcreate(LPM_DATA_NUM);
  signal   InDataReg		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   ProcCnt		:TSLV(TVLcreate(PIPE_LEN1-1)-1 downto 0);
  type     TPipe		is array (0 to PIPE_LEN1-1) of TU2V(LPM_DATA_WIDTH-1 downto 0);  
  signal   DataPipe 		:TPipe;
  signal   ParamPipe 		:TPipe;
  signal   MultPipeSig		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   MultSumPipeSig	:TU2V(SUM_LEN-1 downto 0);
  signal   MultSumPipeReg	:TU2V(SUM_LEN-1 downto 0);
  signal   MultSumReg		:TU2V(SUM_LEN-1 downto 0);
  signal   MultData0Sig		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   MultSumData0Sig	:TU2V(SUM_LEN-1 downto 0);
  signal   ResultReg		:TU2V(LPM_DATA_WIDTH-1 downto 0);
  signal   StartReg		:TSL;

begin

  process (clk, resetN, data, filter_start) begin
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      InDataReg <= (others=>'0');
      StartReg  <= '0';
    elsif (LPM_INPUT_REGISTER=FALSE or (clk'event and clk='1')) then
      InDataReg <= data;
      StartReg  <= filter_start;
    end if;
  end process;
  --
  process (clk, resetN) begin
    if (resetN='0') then
      ProcCnt <= (others=>'0');
    elsif (clk'event and clk='1') then
      if ((StartReg='1' and ProcCnt=0 and PIPE_LEN>1) or (ProcCnt>0 and ProcCnt<PIPE_LEN)) then
        ProcCnt <= ProcCnt+1;
      elsif (ProcCnt=PIPE_LEN) then
        ProcCnt <= (others=>'0');
      end if;
    end if;
  end process;
  --
  process (clk, resetN) begin
    if (resetN='0') then
      DataPipe  <= (TPipe'range => (others=>'0'));
      ParamPipe <= (TPipe'range => (others=>'0'));
    elsif (clk'event and clk='1') then
      if (ProcCnt=0 and StartReg='1') then
        DataPipe(0) <= InDataReg;
        DataPipe(1 to TPipe'length-1)  <= DataPipe(0 to TPipe'length-2);
        for index in 0 to PIPE_LEN-1 loop
          ParamPipe(index) <= TU2V(SLVPartGet(TSLV(param),LPM_DATA_WIDTH,index+1));
        end loop;
      elsif (ProcCnt/=0) then
        DataPipe(0) <= DataPipe(TPipe'length-1);
        DataPipe(1 to TPipe'length-1)  <= DataPipe(0 to TPipe'length-2);
        --
        ParamPipe(0) <= (others => '0');
        ParamPipe(1 to TPipe'length-1) <= ParamPipe(0 to TPipe'length-2);
      end if;
    end if;
  end process;
  --
  MultPipeSig    <= U2VMult(DataPipe(TPipe'length-1),ParamPipe(TPipe'length-1),LPM_DATA_WIDTH,LPM_DOT_POSITION);
  MultSumPipeSig <= U2VSum(MultPipeSig,MultSumPipeReg,SUM_LEN,0);
  --
  process (clk, resetN) begin
    if (resetN='0') then
      MultSumPipeReg <= (others=>'0');
    elsif (clk'event and clk='1') then
      if (ProcCnt=0 and StartReg='1') then
        MultSumPipeReg <= (others=>'0');
      elsif (ProcCnt/=0) then
        MultSumPipeReg <= MultSumPipeSig;
      end if;
    end if;
  end process;
  --
  process (clk, resetN) begin
    if (resetN='0') then
      MultSumReg <= (others=>'0');
    elsif (clk'event and clk='1') then
      if (ProcCnt=PIPE_LEN) then
        MultSumReg <= MultSumPipeSig;
      end if;
    end if;
  end process;
  --
  MultData0Sig    <= U2VMult(InDataReg,param(LPM_DATA_WIDTH-1 downto 0),LPM_DATA_WIDTH,LPM_DOT_POSITION);
  MultSumData0Sig <= U2VSum(MultData0Sig,MultSumReg,SUM_LEN,0);
  --
  process (clk, resetN, MultSumData0Sig) begin
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      ResultReg <= (others=>'0');
    elsif (LPM_OUTPUT_REGISTER=FALSE or (clk'event and clk='1')) then
      ResultReg <= U2VCut(MultSumData0Sig,LPM_DATA_WIDTH);
    end if;
  end process;
  --
  result <= ResultReg;

end behaviour;			   


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1s is
  generic (
    LPM_DATA_WIDTH		:in  natural := 36;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1s;

architecture behaviour of LPM_KTP_DIVIDER_1s is

  signal   aReg                 :unsigned(a'range);
  signal   bReg                 :unsigned(b'range);
  signal   dReg                 :unsigned(d'range);
  signal   rReg                 :unsigned(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= unsigned(a);
      bReg <= unsigned(b);
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      if (bReg=0) then
        if (aReg=0) then
          dReg <= (others=>'1');
        else
          dReg <= (others=>'0');
        end if;
        rReg <= (others=>'1');
      else
        dReg <= aReg  /  bReg;
        rReg <= aReg rem bReg;
      end if;
    end if;
  end process;
  
  d <= TSLV(dReg);
  r <= TSLV(rReg);

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1a;

architecture behaviour of LPM_KTP_DIVIDER_1a is

  constant DATA_MAX            :TN := 2**LPM_DATA_WIDTH-1;
  --
  type     TCoefvec             is array (0 to DATA_MAX) of TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  type     TCoefArr             is array (0 to DATA_MAX) of TCoefvec;
  --
  function DRtabGet return TCoefArr is
    variable ResVar :TCoefArr;
  begin
    ResVar := (ResVar'range => (ResVar(0)'range => (others =>'0')));
    for a in 1 to DATA_MAX loop
      ResVar(a)(0)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := (others => '1');
    end loop;
    for b in 1 to DATA_MAX loop
      for a in b to minimum(2*b-1,DATA_MAX) loop
        ResVar(a)(b)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := TSLVconv(1,LPM_DATA_WIDTH);
      end loop;
      for a in 2*b to DATA_MAX loop
        ResVar(a)(b)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := TSLVconv(a/b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    --
    for a in 0 to DATA_MAX loop
      ResVar(a)(0)(LPM_DATA_WIDTH-1 downto 0) := (others => '1');
    end loop;
    for b in 2 to DATA_MAX loop
      for a in 1 to DATA_MAX loop
        ResVar(a)(b)(LPM_DATA_WIDTH-1 downto 0) := TSLVconv(a rem b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    --
    return( ResVar);
  end function;
  --
  constant DRtab                :TCoefArr := DRtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable aVar   :TN;
    variable bVar   :TN;
    variable tVar   :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      aVar := TNconv(aReg);
      bVar := TNconv(bReg);
      tVar := DRtab(aVar)(bVar);
      dReg <= tVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH);
      rReg <= tVar(LPM_DATA_WIDTH-1 downto 0);
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1al is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1al;

architecture behaviour of LPM_KTP_DIVIDER_1al is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  --
  type     TCoefvec             is array (0 to DATA_BASE*DATA_BASE-1) of TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  --
  function DRtabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    ResVar := (ResVar'range => (others =>'0'));
    for a in 1 to DATA_MAX loop
      ResVar(DATA_BASE*a)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := (others => '1');
    end loop;
    for b in 1 to DATA_MAX loop
      for a in b to minimum(2*b-1,DATA_MAX) loop
        ResVar(DATA_BASE*a+b)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := TSLVconv(1,LPM_DATA_WIDTH);
      end loop;
      for a in 2*b to DATA_MAX loop
        ResVar(DATA_BASE*a+b)(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := TSLVconv(a/b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    --
    for a in 0 to DATA_MAX loop
      ResVar(DATA_BASE*a)(LPM_DATA_WIDTH-1 downto 0) := (others => '1');
    end loop;
    for b in 2 to DATA_MAX loop
      for a in 1 to DATA_MAX loop
        ResVar(DATA_BASE*a+b)(LPM_DATA_WIDTH-1 downto 0) := TSLVconv(a rem b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant DRtab                :TCoefvec := DRtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable iVar :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable tVar :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      iVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := aReg;
      iVar(LPM_DATA_WIDTH-1 downto 0) := bReg;
      tVar := DRtab(TNconv(iVar));
      dReg <= tVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH);
      rReg <= tVar(LPM_DATA_WIDTH-1 downto 0);
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------

		   
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1b is
  generic (
    LPM_DATA_WIDTH		:in  natural := 7;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1b;

architecture behaviour of LPM_KTP_DIVIDER_1b is

  constant DATA_MAX            :TN := 2**LPM_DATA_WIDTH-1;
  --
  type     TCoefvec             is array (0 to DATA_MAX) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  type     TCoefArr             is array (0 to DATA_MAX) of TCoefvec;
  --
  function DtabGet return TCoefArr is
    variable ResVar :TCoefArr;
  begin
    ResVar := (ResVar'range => (ResVar(0)'range => (others =>'0')));
    for a in 1 to DATA_MAX loop
      ResVar(a)(0) := TSLVconv(DATA_MAX,LPM_DATA_WIDTH);
    end loop;
    for b in 1 to DATA_MAX loop
      for a in b to minimum(2*b-1,DATA_MAX) loop
        ResVar(a)(b) := TSLVconv(1,LPM_DATA_WIDTH);
      end loop;
      for a in 2*b to DATA_MAX loop
        ResVar(a)(b) := TSLVconv(a/b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant Dtab                 :TCoefArr := DtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable aVar   :TN;
    variable bVar   :TN;
    variable dVar   :TSLV(r'range);
    variable mVar   :TSLV(2*r'length-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      aVar := TNconv(aReg);
      bVar := TNconv(bReg);
      dVar := Dtab(aVar)(bVar);
      dReg <= dVar;
      mVar := dVar*bReg;
      rReg <= aReg-mVar(r'length-1 downto 0);
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;			   


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1bl is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1bl;

architecture behaviour of LPM_KTP_DIVIDER_1bl is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  --
  type     TCoefvec             is array (0 to DATA_BASE*DATA_BASE-1) of TSLV(LPM_DATA_WIDTH-1 downto 0);
  --
  function DtabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    ResVar := (ResVar'range => (others =>'0'));
    for a in 1 to DATA_MAX loop
      ResVar(DATA_BASE*a) := (others => '1');
    end loop;
    for b in 1 to DATA_MAX loop
      for a in b to minimum(2*b-1,DATA_MAX) loop
        ResVar(DATA_BASE*a+b) := TSLVconv(1,LPM_DATA_WIDTH);
      end loop;
      for a in 2*b to DATA_MAX loop
        ResVar(DATA_BASE*a+b) := TSLVconv(a/b,LPM_DATA_WIDTH);
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant Dtab                 :TCoefvec := DtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable iVar   :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable dVar   :TSLV(r'range);
    variable mVar   :TSLV(2*r'length-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      iVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := aReg;
      iVar(LPM_DATA_WIDTH-1 downto 0) := bReg;
      dVar := Dtab(TNconv(iVar));
      dReg <= dVar;
      if (bReg=0) then
        rReg <= (others=>'1');
      else
        mVar := dVar*bReg;
        rReg <= aReg-mVar(r'length-1 downto 0);
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------

		   
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1c is
  generic (
    LPM_DATA_WIDTH		:in  natural := 4;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1c;

architecture behaviour of LPM_KTP_DIVIDER_1c is

  constant DATA_MAX            :TN := 2**LPM_DATA_WIDTH-1;
  constant TAB_AMAX            :TN := 2**(LPM_DATA_WIDTH-1)-2;
  constant TAB_BMAX            :TN := 2**(LPM_DATA_WIDTH-1)-3;
  --
  type     TCoefvec             is array (0 to TAB_BMAX) of TSLV(LPM_DATA_WIDTH-2 downto 0);
  type     TCoefArr             is array (0 to TAB_AMAX) of TCoefvec;
  --
  function DtabGet return TCoefArr is
    variable ResVar :TCoefArr;
  begin
    for a in 4 to DATA_MAX loop
      for b in 2 to DATA_MAX/2 loop
        if (a>=(2*b)) then
          if (a<=2**(LPM_DATA_WIDTH-1)) then
            ResVar(2**(LPM_DATA_WIDTH-1)-a)(TAB_BMAX-b+2) := TSLVconv(a/b,LPM_DATA_WIDTH-1);
          else          
            ResVar(a-2**(LPM_DATA_WIDTH-1)-1)(b-2) := TSLVconv(a/b,LPM_DATA_WIDTH-1);
          end if;
        end if;
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant Dtab                 :TCoefArr := DtabGet;
  --
  function RtabGet return TCoefArr is
    variable ResVar :TCoefArr;
  begin
    for a in 4 to DATA_MAX loop
      for b in 2 to DATA_MAX/2 loop
        if (a>=(2*b)) then
          if (a<=2**(LPM_DATA_WIDTH-1)) then
            ResVar(2**(LPM_DATA_WIDTH-1)-a)(TAB_BMAX-b+2) := TSLVconv(a rem b,LPM_DATA_WIDTH-1);
          else          
            ResVar(a-2**(LPM_DATA_WIDTH-1)-1)(b-2) := TSLVconv(a rem b,LPM_DATA_WIDTH-1);
          end if;
        end if;
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant Rtab                 :TCoefArr := RtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable aVar :TN;
    variable bVar :TN;
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      aVar := TNconv(aReg);
      bVar := TNconv(bReg);
      if (aVar=0 and bVar=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      elsif (bVar=0) then
        dReg <= (others => '1');
        rReg <= (others => '1');
      elsif (aVar=0) then
        dReg <= (others => '0');
        rReg <= (others => '0');
      elsif (bVar=1) then
        dReg <= aReg;
        rReg <= (others => '0');
      elsif (aVar=bVar) then
        dReg <= (others => '0');
        dReg(0) <= '1';
        rReg <= (others => '0');
      elsif (aVar<bVar) then
        dReg <= (others => '0');
        rReg <= aReg;
      elsif ((aVar-bVar)<bVar) then
        dReg <= (others => '0');
        dReg(0) <= '1';
        rReg <= aReg-bReg;
      elsif (aVar<=2**(LPM_DATA_WIDTH-1)) then
        dReg <= '0' & Dtab(2**(LPM_DATA_WIDTH-1)-aVar)(TAB_BMAX-bVar+2);
        rReg <= '0' & Rtab(2**(LPM_DATA_WIDTH-1)-aVar)(TAB_BMAX-bVar+2);
      else          
        dReg <= '0' & Dtab(aVar-2**(LPM_DATA_WIDTH-1)-1)(bVar-2);
        rReg <= '0' & Rtab(aVar-2**(LPM_DATA_WIDTH-1)-1)(bVar-2);
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;			   


-----------------------------------------------------------------------------------------------------------------------

		   
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_1d is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_1d;

architecture behaviour of LPM_KTP_DIVIDER_1d is

  constant DATA_MAX            :TN := 2**LPM_DATA_WIDTH-1;
  constant TAB_AMAX            :TN := 2**(LPM_DATA_WIDTH-1)-2;
  constant TAB_BMAX            :TN := 2**(LPM_DATA_WIDTH-1)-3;
  --
  type     TCoefvec             is array (0 to TAB_BMAX) of TSLV(LPM_DATA_WIDTH-2 downto 0);
  type     TCoefArr             is array (0 to TAB_AMAX) of TCoefvec;
  --
  function DtabGet return TCoefArr is
    variable ResVar :TCoefArr;
  begin
    for a in 4 to DATA_MAX loop
      for b in 2 to DATA_MAX/2 loop
        if (a>=(2*b)) then
          if (a<=2**(LPM_DATA_WIDTH-1)) then
            ResVar(2**(LPM_DATA_WIDTH-1)-a)(TAB_BMAX-b+2) := TSLVconv(a/b,LPM_DATA_WIDTH-1);
          else          
            ResVar(a-2**(LPM_DATA_WIDTH-1)-1)(b-2) := TSLVconv(a/b,LPM_DATA_WIDTH-1);
          end if;
        end if;
      end loop;
    end loop;
    return( ResVar);
  end function;
  --
  constant Dtab                 :TCoefArr := DtabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable aVar   :TN;
    variable bVar   :TN;
    variable dVar   :TSLV(r'range);
    variable mVar   :TSLV(2*r'length-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      aVar := TNconv(aReg);
      bVar := TNconv(bReg);
      if (aVar=0 and bVar=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      elsif (bVar=0) then
        dReg <= (others => '1');
        rReg <= (others => '1');
      elsif (aVar=0) then
        dReg <= (others => '0');
        rReg <= (others => '0');
      elsif (bVar=1) then
        dReg <= aReg;
        rReg <= (others => '0');
      elsif (aVar=bVar) then
        dReg <= (others => '0');
        dReg(0) <= '1';
        rReg <= (others => '0');
      elsif (aVar<bVar) then
        dReg <= (others => '0');
        rReg <= aReg;
      elsif ((aVar-bVar)<bVar) then
        dReg <= (others => '0');
        dReg(0) <= '1';
        rReg <= aReg-bReg;
      elsif (aVar<=2**(LPM_DATA_WIDTH-1)) then
        dVar := '0' & Dtab(2**(LPM_DATA_WIDTH-1)-aVar)(TAB_BMAX-bVar+2);
        dReg <= dVar;
        mVar := dVar*bReg;
        rReg <= aReg-mVar(r'length-1 downto 0);
      else          
        dVar := '0' & Dtab(aVar-2**(LPM_DATA_WIDTH-1)-1)(bVar-2);
        dReg <= dVar;
        mVar := dVar*bReg;
        rReg <= aReg-mVar(r'length-1 downto 0);
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;			   


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_3a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 16;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_3a;

architecture behaviour of LPM_KTP_DIVIDER_3a is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  constant M_BASE              :TN := 2*LPM_DATA_WIDTH;
  constant M                   :TN := 2**M_BASE;
  --
  type     TCoefvec             is array (1 to DATA_MAX) of TSLV(M_BASE downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in 1 to DATA_MAX loop
      ResVar(b) := TSLVconv(M/b,M_BASE+1);
      if ((M rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable mVar   :TSLV(M_BASE+LPM_DATA_WIDTH downto 0);
    variable dVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable rVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      if (TNconv(bReg)/=0) then
        mVar := bTab(TNconv(bReg))*aReg;
        dVar := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE);
        mVar(2*LPM_DATA_WIDTH-1 downto 0) := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE)*bReg;
        rVar := aReg-mVar(LPM_DATA_WIDTH-1 downto 0);
        dReg <= dVar;
        rReg <= rVar;
      elsif (TNconv(aReg)=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      else
        dReg <= (others => '1');
        rReg <= (others => '1');
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_3b is
  generic (
    LPM_DATA_WIDTH		:in  natural := 14;
    LPM_INPUT_REGISTER		:in  boolean := true;
    LPM_OUTPUT_REGISTER		:in  boolean := true
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_3b;

architecture behaviour of LPM_KTP_DIVIDER_3b is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  constant M_BASE              :TN := 2*LPM_DATA_WIDTH;
  constant M                   :TN := 2**M_BASE;
  --
  type     TCoefvec             is array (2 to DATA_BASE/2-1) of TSLV(M_BASE-1 downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in 2 to DATA_BASE/2-1 loop
      ResVar(b) := TSLVconv(M/b,M_BASE);
      if ((M rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable mVar   :TSLV(M_BASE+LPM_DATA_WIDTH-1 downto 0);
    variable dVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable rVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      if (TNconv(bReg)/=0) then
        if (bReg=1) then
          dVar := aReg;
          rVar := (others => '0');
        elsif (bReg<DATA_BASE/2) then
          mVar := bTab(TNconv(bReg))*aReg;
          dVar := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE);
          mVar(2*LPM_DATA_WIDTH-1 downto 0) := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE)*bReg;
          rVar := aReg-mVar(LPM_DATA_WIDTH-1 downto 0);
        elsif (aReg<bReg) then
          dVar := (others => '0');
          rVar := aReg;
        else
          dVar := TSLVconv(1,LPM_DATA_WIDTH);
          rVar := aReg-bReg;
        end if;        
        dReg <= dVar;
        rReg <= rVar;
      elsif (TNconv(aReg)=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      else
        dReg <= (others => '1');
        rReg <= (others => '1');
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_3c is
  generic (
    LPM_DATA_WIDTH		:in  natural := 18;
    LPM_INPUT_REGISTER		:in  boolean := true;
    LPM_OUTPUT_REGISTER		:in  boolean := true
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_3c;

architecture behaviour of LPM_KTP_DIVIDER_3c is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  constant M_BASE              :TN := LPM_DATA_WIDTH;
  constant M                   :TN := 2**M_BASE;
  --
  type     TCoefvec             is array (1 to DATA_MAX) of TSLV(M_BASE downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in 1 to DATA_MAX loop
      ResVar(b) := TSLVconv(M/b,M_BASE+1);
      if ((M rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable mVar   :TSLV(M_BASE+LPM_DATA_WIDTH downto 0);
    variable dVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable rVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      if (TNconv(bReg)/=0) then
        mVar := bTab(TNconv(bReg))*aReg;
        dVar := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE);
        mVar(2*LPM_DATA_WIDTH-1 downto 0) := dVar*bReg;
        if (mVar>aReg) then
          dVar := dVar - 1;
          mVar(2*LPM_DATA_WIDTH-1 downto 0) := mVar(2*LPM_DATA_WIDTH-1 downto 0) - bReg;
        end if;
        rVar := aReg-mVar(LPM_DATA_WIDTH-1 downto 0);
        dReg <= dVar;
        rReg <= rVar;
      elsif (TNconv(aReg)=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      else
        dReg <= (others => '1');
        rReg <= (others => '1');
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_3d is
  generic (
    LPM_DATA_WIDTH		:in  natural := 18;
    LPM_INPUT_REGISTER		:in  boolean := true;
    LPM_OUTPUT_REGISTER		:in  boolean := true
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_3d;

architecture behaviour of LPM_KTP_DIVIDER_3d is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  constant M_BASE              :TN := LPM_DATA_WIDTH;
  constant M                   :TN := 2**M_BASE;
  --
  type     TCoefvec             is array (2 to DATA_BASE/2-1) of TSLV(M_BASE-1 downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in 2 to DATA_BASE/2-1 loop
      ResVar(b) := TSLVconv(M/b,M_BASE);
      if ((M rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable mVar   :TSLV(M_BASE+LPM_DATA_WIDTH-1 downto 0);
    variable dVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable rVar   :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      if (TNconv(bReg)/=0) then
        if (bReg=1) then
          dVar := aReg;
          rVar := (others => '0');
        elsif (bReg<DATA_BASE/2) then
          mVar := bTab(TNconv(bReg))*aReg;
          dVar := mVar(M_BASE+LPM_DATA_WIDTH-1 downto M_BASE);
          mVar(2*LPM_DATA_WIDTH-1 downto 0) := dVar*bReg;
          if (mVar>aReg) then
            dVar := dVar - 1;
            mVar(2*LPM_DATA_WIDTH-1 downto 0) := mVar(2*LPM_DATA_WIDTH-1 downto 0) - bReg;
          end if;
          rVar := aReg-mVar(LPM_DATA_WIDTH-1 downto 0);
        elsif (aReg<bReg) then
          dVar := (others => '0');
          rVar := aReg;
        else
          dVar := TSLVconv(1,LPM_DATA_WIDTH);
          rVar := aReg-bReg;
        end if;        
          dReg <= dVar;
          rReg <= rVar;
      elsif (TNconv(aReg)=0) then
        dReg <= (others => '0');
        rReg <= (others => '1');
      else
        dReg <= (others => '1');
        rReg <= (others => '1');
      end if;
    end if;
  end process;
  
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_4a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 24;
    LPM_INPUT_REGISTER		:in  boolean := true;
    LPM_OUTPUT_REGISTER		:in  boolean := true
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_4a;

architecture behaviour of LPM_KTP_DIVIDER_4a is

  constant HDATA_WIDTH         :TN := (LPM_DATA_WIDTH+1)/2;
  constant HDATA_BASE          :TN := 2**HDATA_WIDTH;
  constant HDATA_MAX           :TN := HDATA_BASE-1;
  constant M_BASE              :TN := 2*HDATA_WIDTH;
  constant M                   :TN := 2**M_BASE;
  constant HDATA_0             :TSLV(HDATA_WIDTH-1 downto 0) := (others=>'0');
  --
  type     TCoefvec             is array (0 to HDATA_BASE-1) of TSLV(M_BASE downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    ResVar(0) := (others=>'0');
    for b in 1 to HDATA_MAX loop
      ResVar(b) := TSLVconv(M/b,ResVar(0)'length);
      if ((M rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  constant b1Tab                :TCoefvec := bTabGet;
  --
  function bbTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in 0 to HDATA_MAX loop
      ResVar(b) := TSLVconv(M/(HDATA_BASE+b),ResVar(0)'length);
      if ((M rem (HDATA_BASE+b)) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  constant bbTab                :TCoefvec := bbTabGet;
  --
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (clk, resetN, aReg, bReg)
    variable a0Var    :TSLV(HDATA_WIDTH-1 downto 0);
    variable a1Var    :TSLV(HDATA_WIDTH-1 downto 0);
    variable b0Var    :TSLV(HDATA_WIDTH-1 downto 0);
    variable b1Var    :TSLV(HDATA_WIDTH-1 downto 0);
    variable bTabVar  :TSLV(b1Tab(0)'range);
    variable bbTabVar :TSLV(bbTab(0)'range);
    variable m1Var    :TSLV(b1Tab(0)'length+HDATA_WIDTH-1 downto 0);
    variable m2Var    :TSLV(m1Var'range);
    variable m3Var    :TSLV(m1Var'length+HDATA_WIDTH downto 0);
    variable m4Var    :TSLV(b1Tab(0)'length+bbTab(0)'length-1 downto 0);
    variable m5Var    :TSLV(m4Var'length+HDATA_WIDTH-1 downto 0);
    variable m6Var    :TSLV(m5Var'range);
    variable m7Var    :TSLV(m5Var'length+HDATA_WIDTH downto 0);
    variable m8Var    :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable m9Var    :TSLV(m8Var'range);
    variable d0Var    :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable dVar     :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable rVar     :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable clkVar   :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_OUTPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      a0Var  := aReg(HDATA_WIDTH-1 downto 0);
      a1Var  := (others => '0');
      a1Var(aReg'length-HDATA_WIDTH-1 downto 0)  := aReg(aReg'length-1 downto HDATA_WIDTH);
      b0Var  := bReg(HDATA_WIDTH-1 downto 0);
      b1Var  := (others => '0');
      b1Var(bReg'length-HDATA_WIDTH-1 downto 0)  := bReg(bReg'length-1 downto HDATA_WIDTH);
      if (bReg=0) then
        if (aReg=0) then
          dVar := (others => '1');
          rVar := (others => '1');
        else
          dVar := (others => '0');
          rVar := (others => '1');
        end if;
      else
        if (b1Var=0) then
          bTabVar  := b1Tab(TNconv(b0Var));
          m1Var    := bTabVar * a0Var;
          m2Var    := bTabVar * a1Var;
          m3Var    := ('0' & m2Var & HDATA_0) + ('0' & HDATA_0 & m1Var);
          d0Var    := m3Var(dVar'length+M_BASE-1 downto M_BASE);
        else
          bTabVar  := b1Tab(TNconv(b1Var));        
          m1Var    := bTabVar * b0Var;
          bbTabVar := bbTab(TNconv(m1Var(b1Var'length+M_BASE-1 downto M_BASE)));
          m4Var    := bTabVar * bbTabVar;
          m5Var    := m4Var * a0Var;
          m6Var    := m4Var * a1Var;
          m7Var    := ('0' & m6Var & HDATA_0) + ('0' & HDATA_0 & m5Var);
          d0Var    := m7Var(d0Var'length+2*M_BASE-1 downto 2*M_BASE);
        end if;
        m8Var := d0Var * bReg;
        if (m8Var>aReg) then
          m9Var := m8Var - bReg;
          rVar  := aReg - m9Var(aReg'range);
          dVar  := d0Var - 1;
        else
          rVar  := aReg - m8Var(aReg'range);
          dVar  := d0Var;
        end if;        
      end if;
      dReg <= dVar;
      rReg <= rVar;
    end if;
  end process;
  
  d <= dReg(d'range);
  r <= rReg(r'range);

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_5a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := true;
    LPM_OUTPUT_REGISTER		:in  boolean := true
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );          
end LPM_KTP_DIVIDER_5a;

architecture behaviour of LPM_KTP_DIVIDER_5a is

  constant QDATA_WIDTH         :TN := (LPM_DATA_WIDTH+3)/4;
  constant QDATA_BASE          :TN := 2**QDATA_WIDTH;
  constant M_WIDTH             :TN := 4*QDATA_WIDTH;
  constant M_BASE              :TN := 2**M_WIDTH;
  constant E_WIDTH             :TN := QDATA_WIDTH/4+1;
  constant E_BASE              :TN := 2**E_WIDTH;
  --
  type     TbTabvec             is array (0 to QDATA_BASE-1) of TSLV(M_WIDTH downto 0);
  function bTabGet return TbTabvec is
    variable ResVar :TbTabvec;
  begin
    ResVar(0) := (others => '0');
    for b in 1 to TbTabvec'length-1 loop
      ResVar(b) := TSLVconv(M_BASE/b,ResVar(1)'length);
      if ((M_BASE rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  constant bTab                :TbTabvec := bTabGet;
  --
  type     TbbTabvec            is array (0 to E_BASE*QDATA_BASE-1) of TSLV(M_WIDTH downto 0);
  function bbTabGet return TbbTabvec is
    variable ResVar :TbbTabvec;
  begin
    for b in TbbTabvec'range loop
      ResVar(b) := TSLVconv((M_BASE*E_BASE)/(E_BASE*QDATA_BASE+b),ResVar(0)'length);
      if (((M_BASE*E_BASE) rem (E_BASE*QDATA_BASE+b)) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  constant bbTab                :TbbTabvec := bbTabGet;
  --
  constant Data0                :TSLV(QDATA_WIDTH-1 downto 0) := (others => '0');
  --
  signal   aReg                 :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal   bReg                 :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal   dSig                 :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal   rSig                 :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal   dReg                 :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal   rReg                 :TSLV(4*QDATA_WIDTH-1 downto 0);

  signal a3sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal a2sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal a1sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal a0sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal b3sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal b2sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal b1sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal b0sig  :TSLV(QDATA_WIDTH-1 downto 0);
  signal m1sig  :TSLV(M_WIDTH downto 0);
  signal m2sig  :TSLV(m1sig'length+QDATA_WIDTH+E_WIDTH-1 downto 0);
  signal m3sig  :TSLV(m1sig'length+M_WIDTH downto 0);
  signal m4sig  :TSLV(m3sig'length+2*QDATA_WIDTH-1 downto 0);
  signal m5sig  :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal m6sig  :TSLV(m5sig'length+4*QDATA_WIDTH-1 downto 0);
  signal m7sig  :TSLV(4*QDATA_WIDTH downto 0);
  signal m8sig  :TSLV(m3sig'length+m7sig'length downto 0);
  signal m9sig  :TSLV(4*QDATA_WIDTH downto 0);
  signal m10sig :TSLV(m9sig'length+4*QDATA_WIDTH downto 0);
  signal m11sig :TSLV(4*QDATA_WIDTH downto 0);
  signal m12sig :TSLV(4*QDATA_WIDTH downto 0);
  signal m13sig :TSLV(4*QDATA_WIDTH downto 0);
  signal m14sig :TSLV(4*QDATA_WIDTH-1 downto 0);
  signal td     : TSL;
  signal tr     : TSL;


begin

  process (clk, resetN, a, b)
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
      aReg(a'range) <= a;
      bReg(b'range) <= b;
    end if;
  end process;
  --
  process (aReg, bReg)
    variable a3var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable a2var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable a1var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable a0var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable b3var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable b2var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable b1var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable b0var  :TSLV(QDATA_WIDTH-1 downto 0);
    variable m1var  :TSLV(M_WIDTH downto 0);
    variable m2var  :TSLV(m1var'length+QDATA_WIDTH+E_WIDTH-1 downto 0);
    variable m3var  :TSLV(m1var'length+M_WIDTH downto 0);
    variable m4var  :TSLV(m3var'length+2*QDATA_WIDTH-1 downto 0);
    variable m5var  :TSLV(4*QDATA_WIDTH-1 downto 0);
    variable m6var  :TSLV(m5var'length+4*QDATA_WIDTH-1 downto 0);
    variable m7var  :TSLV(4*QDATA_WIDTH downto 0);
    variable m8var  :TSLV(m3var'length+m7var'length downto 0);
    variable m9var  :TSLV(4*QDATA_WIDTH downto 0);
    variable m10var :TSLV(m9var'length+4*QDATA_WIDTH downto 0);
    variable m11var :TSLV(4*QDATA_WIDTH downto 0);
    variable m12var :TSLV(4*QDATA_WIDTH downto 0);
    variable m13var :TSLV(4*QDATA_WIDTH downto 0);
    variable m14var :TSLV(4*QDATA_WIDTH-1 downto 0);
    variable dVar   :TSLV(4*QDATA_WIDTH-1 downto 0);
    variable rVar   :TSLV(4*QDATA_WIDTH-1 downto 0);
  begin
    a3Var := aReg(4*QDATA_WIDTH-1 downto 3*QDATA_WIDTH);
    a2Var := aReg(3*QDATA_WIDTH-1 downto 2*QDATA_WIDTH);
    a1Var := aReg(2*QDATA_WIDTH-1 downto 1*QDATA_WIDTH);
    a0Var := aReg(1*QDATA_WIDTH-1 downto 0*QDATA_WIDTH);
    b3Var := bReg(4*QDATA_WIDTH-1 downto 3*QDATA_WIDTH);
    b2Var := bReg(3*QDATA_WIDTH-1 downto 2*QDATA_WIDTH);
    b1Var := bReg(2*QDATA_WIDTH-1 downto 1*QDATA_WIDTH);
    b0Var := bReg(1*QDATA_WIDTH-1 downto 0*QDATA_WIDTH);
    if (bReg = 0) then
      if (aReg=0) then
        dVar := (others => '1');
        rVar := (others => '1');
      else
        dVar := (others => '0');
        rVar := (others => '1');
      end if;
    else
      if (b3Var /= 0) then
        m1var := Btab(conv_integer('0' & b3var));
        m2Var := m1var * (b2Var & b1Var(b1Var'length-1 downto b1Var'length-E_WIDTH));
      elsif (b2Var /= 0) then
        m1var := Btab(conv_integer(b2var));
        m2Var := m1var * (b1Var & b0Var(b1Var'length-1 downto b1Var'length-E_WIDTH));
      elsif     (b1Var /= 0) then
        m1var := Btab(conv_integer(b1var));
        m2Var := m1var * (b0Var & Data0(b1Var'length-1 downto b1Var'length-E_WIDTH));
      else
        m1var := Btab(conv_integer(b0var));
        m2Var := m1var * (Data0 & Data0(b1Var'length-1 downto b1Var'length-E_WIDTH));
      end if;
      m3var := m1var * BBtab(conv_integer('0' & m2Var(E_WIDTH+QDATA_WIDTH+M_WIDTH-1 downto M_WIDTH))); --b 
      m4var := m3var * (a3var & a2var);
      m5var := (others => '0'); 
      if    (b3Var /= 0) then m5var(m4Var'length-2*M_WIDTH+0*QDATA_WIDTH-1 downto 0) := m4Var(m4Var'length-1 downto 2*M_WIDTH-0*QDATA_WIDTH);
      elsif (b2Var /= 0) then m5var(m4Var'length-2*M_WIDTH+1*QDATA_WIDTH-1 downto 0) := m4Var(m4Var'length-1 downto 2*M_WIDTH-1*QDATA_WIDTH);
      else                    m5var := m4Var(m5Var'length+2*M_WIDTH-2*QDATA_WIDTH-1 downto 2*M_WIDTH-2*QDATA_WIDTH);
      end if; -- d1
      m6var := m5var * bReg;
      m7var := ('0' & aReg) - m6var(4*QDATA_WIDTH downto 0);
      m8var := signed('0'& m3var) * signed(m7var);
      m9var := (others => m8var(m8var'length-1)); 
      if    (b3Var /= 0) then m9var(m8Var'length-2*M_WIDTH-2*QDATA_WIDTH-1 downto 0) := m8Var(m8Var'length-1 downto 2*M_WIDTH+2*QDATA_WIDTH);
      elsif (b2Var /= 0) then m9var(m8Var'length-2*M_WIDTH-1*QDATA_WIDTH-1 downto 0) := m8Var(m8Var'length-1 downto 2*M_WIDTH+1*QDATA_WIDTH);
      elsif (b1Var /= 0) then m9var := m8Var(m9Var'length+2*M_WIDTH+0*QDATA_WIDTH-1 downto 2*M_WIDTH+0*QDATA_WIDTH);
      else                    m9var := m8Var(m9Var'length+2*M_WIDTH-1*QDATA_WIDTH-1 downto 2*M_WIDTH-1*QDATA_WIDTH);
      end if; -- d2
      m10var := signed(m9var) * signed('0' & bReg);
      m11var := m7var - m10var(4*QDATA_WIDTH downto 0);
      m12var := ('0' & m5var) + m9var;
      if(m11var(m11var'length-1)='1') then
        m13var := m11var+bReg;
        m14var := m12var(m14var'range)-1;
      elsif (m11var(bReg'range)>=bReg) then
        m13var := m11var-bReg;
        m14var := m12var(m14var'range)+1;
      else
        m13var := m11var;
        m14var := m12var(m14var'range);
      end if;            
      dVar := m14var;
      rVar := m13var(rSig'range);
      --
      a3sig  <= a3var;
      a2sig  <= a2var;
      a1sig  <= a1var;
      a0sig  <= a0var;
      b3sig  <= b3var;
      b2sig  <= b2var;
      b1sig  <= b1var;
      b0sig  <= b0var;
      m1sig  <= m1var;
      m2sig  <= m2var;
      m3sig  <= m3var;
      m4sig  <= m4var;
      m5sig  <= m5var;
      m6sig  <= m6var;
      m7sig  <= m7var;
      m8sig  <= m8var;
      m9sig  <= m9var;
      m10sig <= m10var;
      m11sig <= m11var;
      m12sig <= m12var;
      m13sig <= m13var;
      m14sig <= m14var;
      if (TNconv(bReg) /= 0) then
        td <= TSLconv(((TNconv(aReg) / TNconv(bReg))   - TNconv(dVar))=0);  --
        tr <= TSLconv(((TNconv(aReg) rem TNconv(bReg)) - TNconv(rVar))=0);  --  
      else
        td <= '1';  --
        tr <= '1';  -- 
      end if;
    end if;
    dSig <= dVar;
    rSig <= rVar;
  end process;
  --
  process (clk, resetN, dSig, rSig)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      dReg <= dSig;
      rReg <= rSig;
    end if;
  end process;
  --
  d <= dReg(d'range);
  r <= rReg(r'range);
  --
end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_6a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 24;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_6a;

architecture behaviour of LPM_KTP_DIVIDER_6a is

  constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  constant DATA_MAX            :TN := DATA_BASE-1;
  constant E_WIDTH             :TN := (LPM_DATA_WIDTH+1)/2+1;
  constant E_BASE              :TN := 2**E_WIDTH;
  constant M_WIDTH             :TN := 2*E_WIDTH;
  constant M_BASE              :TN := 2**M_WIDTH;
  --
  function sGet return TI is
    variable sVar :integer;
  begin
    sVar := LPM_DATA_WIDTH;
    for i in 0 to LPM_DATA_WIDTH-1 loop
      if (sVar=1) then
        return(i);
      end if;
      sVar := (sVar+1)/2;
    end loop;
    return(0);
  end function;
  --
  constant S_WIDTH              :TN := sGet;
  type     TsTab                is array (0 to S_WIDTH) of TI;
  function sTabGet return TsTab is
    variable tVar :TsTab;
  begin
    tVar(0) := LPM_DATA_WIDTH;
    for i in 1 to S_WIDTH loop
      tVar(i) := (tVar(i-1)+1)/2;
    end loop;
    return(tVar);
  end function;
  --
  constant sTab                 :TsTab := sTabGet;
  --
  type     TCoefvec             is array (2**(E_WIDTH-1) to 2**E_WIDTH-1) of TSLV(M_WIDTH-1 downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in TCoefvec'range loop
      ResVar(b) := TSLVconv(M_BASE/b,M_WIDTH);
      if ((M_BASE rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dSig                 :TSLV(d'range);
  signal   rSig                 :TSLV(r'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

  signal   iSig                 :TSLV(S_WIDTH downto 0);
  signal   nSig                 :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  signal   bSig                 :TSLV(E_WIDTH-1 downto 0);
  signal   m1Sig                :TSLV(M_WIDTH+LPM_DATA_WIDTH-1 downto 0);
  signal   m2Sig                :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);
  signal   m3Sig                :TSLV(LPM_DATA_WIDTH-1 downto 0);
  signal   m4Sig                :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  signal   m5Sig                :TSLV(LPM_DATA_WIDTH downto 0);
  signal   td                   :TSL;
  signal   tr                   :TSL;

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (aReg, bReg)
    variable iVar  :TSLV(S_WIDTH downto 0);
    variable nVar  :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable bVar  :TSLV(E_WIDTH-1 downto 0);
    variable m1Var :TSLV(M_WIDTH+LPM_DATA_WIDTH-1 downto 0);
    variable m2Var :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);
    variable m3Var :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable m4Var :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable m5Var :TSLV(LPM_DATA_WIDTH downto 0);
    variable dVar  :TSLV(d'range);
    variable rVar  :TSLV(r'range);
  begin
    if (TNconv(bReg)/=0) then
      iVar := (others => '0');
      nVar := (others => '0');
      nVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := bReg;
      for i in 1 to S_WIDTH loop
        if(nVar(2*LPM_DATA_WIDTH-1 downto 2*LPM_DATA_WIDTH-sTab(i)) = 0) then
          iVar(i) := '1';
          nVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := nVar(2*LPM_DATA_WIDTH-sTab(i)-1 downto LPM_DATA_WIDTH-sTab(i));
        end if;
      end loop;
      bVar  := nVar(2*LPM_DATA_WIDTH-1 downto 2*LPM_DATA_WIDTH-E_WIDTH);
      m1Var := bTab(TNconv(bVar))*aReg;
      m2Var := (others => '0');
      m2Var(m1Var'range) := m1Var;
      for i in 1 to S_WIDTH loop
        if(iVar(i)='1') then
          m2Var(M_WIDTH+2*LPM_DATA_WIDTH-1 downto sTab(i)) := m2Var(M_WIDTH+2*LPM_DATA_WIDTH-sTab(i)-1 downto 0);
        end if;
      end loop;
      m3Var := m2Var(2*LPM_DATA_WIDTH+M_WIDTH-E_WIDTH-1 downto LPM_DATA_WIDTH+M_WIDTH-E_WIDTH);
      m4Var := m3Var*bReg;
      m5var := ('0' & aReg)-m4Var(LPM_DATA_WIDTH downto 0);
      dVar := m3Var;
      rVar := m5var(LPM_DATA_WIDTH-1 downto 0);
      if (m5var(m5var'length-1)='1') then
        dVar := dVar-1;
        rVar := rVar+bReg;
      end if;
    elsif (TNconv(aReg)=0) then
      dVar := (others => '0');
      rVar := (others => '1');
    else
      dVar := (others => '1');
      rVar := (others => '1');
    end if;
    dSig <= dVar;
    rSig <= rVar;
    
    iSig  <= iVar; 
    nSig  <= nVar; 
    bSig  <= bVar; 
    m1Sig <= m1Var;
    m2Sig <= m2Var;
    m3Sig <= m3Var;
    m4Sig <= m4Var;
    m5Sig <= m5Var;
    if (TNconv(bReg) /= 0) then
      td <= TSLconv(((TNconv(aReg) / TNconv(bReg))   - TNconv(dVar))=0);  --
      tr <= TSLconv(((TNconv(aReg) rem TNconv(bReg)) - TNconv(rVar))=0);  --  
    else
      td <= '1';  --
      tr <= '1';  -- 
    end if;
    
  end process;
  --
  process (clk, resetN, dSig, rSig)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      dReg <= dSig;
      rReg <= rSig;
    end if;
  end process;
  --
  d <= dReg;
  r <= rReg;

end behaviour;	


-----------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.std_logic_1164_ktp.all;
use work.std_logic_arith_ktp.all;

entity LPM_KTP_DIVIDER_7a is
  generic (
    LPM_DATA_WIDTH		:in  natural := 8;
    LPM_INPUT_REGISTER		:in  boolean := TRUE;
    LPM_OUTPUT_REGISTER		:in  boolean := TRUE
  );
  port(
    resetN			:in  TSL := '1';
    clk				:in  TSL := '1';
    a				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    b				:in  TSLV(LPM_DATA_WIDTH-1 downto 0);
    d				:out TSLV(LPM_DATA_WIDTH-1 downto 0);
    r				:out TSLV(LPM_DATA_WIDTH-1 downto 0)
  );
end LPM_KTP_DIVIDER_7a;

architecture behaviour of LPM_KTP_DIVIDER_7a is

  --constant DATA_BASE           :TN := 2**LPM_DATA_WIDTH;
  --constant DATA_MAX            :TN := DATA_BASE-1;
  constant E_WIDTH             :TN := LPM_DATA_WIDTH/4+(15/LPM_DATA_WIDTH)+2;
  constant E_BASE              :TN := 2**E_WIDTH;
  constant M_WIDTH             :TN := 2*E_WIDTH;
  constant M_BASE              :TN := 2**M_WIDTH;
  --
  function sGet return TI is
    variable sVar :integer;
  begin
    sVar := LPM_DATA_WIDTH;
    for i in 0 to LPM_DATA_WIDTH-1 loop
      if (sVar=1) then
        return(i);
      end if;
      sVar := (sVar+1)/2;
    end loop;
    return(0);
  end function;
  --
  constant S_WIDTH              :TN := sGet;
  type     TsTab                is array (0 to S_WIDTH) of TI;
  function sTabGet return TsTab is
    variable tVar :TsTab;
  begin
    tVar(0) := LPM_DATA_WIDTH;
    for i in 1 to S_WIDTH loop
      tVar(i) := (tVar(i-1)+1)/2;
    end loop;
    return(tVar);
  end function;
  --
  constant sTab                 :TsTab := sTabGet;
  --
  type     TCoefvec             is array (2**(E_WIDTH-1) to 2**E_WIDTH-1) of TSLV(M_WIDTH-1 downto 0);
  function bTabGet return TCoefvec is
    variable ResVar :TCoefvec;
  begin
    for b in TCoefvec'range loop
      ResVar(b) := TSLVconv(M_BASE/b,M_WIDTH);
      if ((M_BASE rem b) /= 0 ) then
        ResVar(b) := ResVar(b)+1;
      end if;
    end loop;
    return( ResVar);
  end function;
  --
  constant bTab                 :TCoefvec := bTabGet;
  --
  signal   aReg                 :TSLV(a'range);
  signal   bReg                 :TSLV(b'range);
  signal   dSig                 :TSLV(d'range);
  signal   rSig                 :TSLV(r'range);
  signal   dReg                 :TSLV(d'range);
  signal   rReg                 :TSLV(r'range);

  signal   iSig                 :TSLV(S_WIDTH downto 0);
  signal   nSig                 :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
  signal   bSig                 :TSLV(E_WIDTH-1 downto 0);
  signal   m0Sig                :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);  
  signal   m1Sig                :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);  
  signal   m2Sig                :TSLV(M_WIDTH+LPM_DATA_WIDTH-1 downto 0);    
  signal   m3Sig                :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);  
  signal   m4Sig                :TSLV(LPM_DATA_WIDTH-1 downto 0);            
  signal   m5Sig                :TSLV(2*LPM_DATA_WIDTH-1 downto 0);          
  signal   m6Sig                :TSLV(LPM_DATA_WIDTH downto 0);              
  signal   m7Sig                :TSLV(M_WIDTH+2*LPM_DATA_WIDTH+1 downto 0);  
  signal   m8Sig                :TSLV(LPM_DATA_WIDTH downto 0);              
  signal   m9Sig                :TSLV(E_WIDTH+LPM_DATA_WIDTH+1 downto 0);    
  signal   m10Sig               :TSLV(LPM_DATA_WIDTH downto 0);              
  signal   dvSig                :TSLV(LPM_DATA_WIDTH downto 0);              
  signal   rvSig                :TSLV(LPM_DATA_WIDTH downto 0);              
  signal   td                   :TSL;
  signal   tr                   :TSL;

begin

  process (clk, resetN, a, b)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      aReg <= (others=>'0');
      bReg <= (others=>'0');
    elsif (clkVar) then
      aReg <= a;
      bReg <= b;
    end if;
  end process;
  --
  process (aReg, bReg)
    variable iVar   :TSLV(S_WIDTH downto 0);
    variable nVar   :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable bVar   :TSLV(E_WIDTH-1 downto 0);
    variable m0Var  :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);
    variable m1Var  :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);
    variable m2Var  :TSLV(M_WIDTH+LPM_DATA_WIDTH-1 downto 0);
    variable m3Var  :TSLV(M_WIDTH+2*LPM_DATA_WIDTH-1 downto 0);
    variable m4Var  :TSLV(LPM_DATA_WIDTH-1 downto 0);
    variable m5Var  :TSLV(2*LPM_DATA_WIDTH-1 downto 0);
    variable m6Var  :TSLV(LPM_DATA_WIDTH downto 0);
    variable m7Var  :TSLV(M_WIDTH+2*LPM_DATA_WIDTH+1 downto 0);
    variable m8Var  :TSLV(LPM_DATA_WIDTH downto 0);
    variable m9Var  :TSLV(E_WIDTH+LPM_DATA_WIDTH+1 downto 0);    
    variable m10Var :TSLV(LPM_DATA_WIDTH downto 0);
    variable dVar   :TSLV(LPM_DATA_WIDTH downto 0);
    variable rVar   :TSLV(LPM_DATA_WIDTH downto 0);
  begin
    if (TNconv(bReg)/=0) then
      iVar := (others => '0');
      nVar := (others => '0');
      nVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := bReg;
      for i in 1 to S_WIDTH loop
        if(nVar(2*LPM_DATA_WIDTH-1 downto 2*LPM_DATA_WIDTH-sTab(i)) = 0) then
          iVar(i) := '1';
          nVar(2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := nVar(2*LPM_DATA_WIDTH-sTab(i)-1 downto LPM_DATA_WIDTH-sTab(i));
        end if;
      end loop;
      bVar  := nVar(2*LPM_DATA_WIDTH-1 downto 2*LPM_DATA_WIDTH-E_WIDTH);
      m0Var := (others => '0');
      m0Var(M_WIDTH+LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH) := bTab(TNconv(bVar));
      m1Var := m0Var;
      for i in 1 to S_WIDTH loop
        if(iVar(i)='1') then
          m1Var(m1Var'length-1 downto sTab(i)) := m1Var(m1Var'length-sTab(i)-1 downto 0);
        end if;
      end loop;
      m2Var := m1var(M_WIDTH+2*LPM_DATA_WIDTH-1 downto LPM_DATA_WIDTH);
      m3Var := m2var*aReg;
      m4Var := m3Var(2*LPM_DATA_WIDTH+M_WIDTH-E_WIDTH-1 downto LPM_DATA_WIDTH+M_WIDTH-E_WIDTH);
      m5Var := m4Var*bReg;
      --
      m6var := m5Var(LPM_DATA_WIDTH downto 0)-('0' & aReg);
      m7Var := signed(m6var)*signed('0'& m2Var);
      m8Var := m7Var(2*LPM_DATA_WIDTH+M_WIDTH-E_WIDTH downto LPM_DATA_WIDTH+M_WIDTH-E_WIDTH);
      m9Var := signed(m8Var(E_WIDTH downto 0))*signed('0'& bReg);
      --      
      m10var := m9Var(LPM_DATA_WIDTH downto 0)-m6var;
      dVar := ('0' & m4Var)-m8Var;
      rVar := m10var;
      if (m10var(m10var'length-1)='1') then
        dVar := dVar-1;
        rVar := rVar+('0' & bReg);
      end if;
    elsif (TNconv(aReg)=0) then
      dVar := (others => '0');
      rVar := (others => '1');
    else
      dVar := (others => '1');
      rVar := (others => '1');
    end if;
    dSig <= dVar(dSig'range);
    rSig <= rVar(rSig'range);
    
    iSig   <= iVar; 
    nSig   <= nVar; 
    bSig   <= bVar; 
    m0Sig  <= m0Var;
    m1Sig  <= m1Var;
    m2Sig  <= m2Var;
    m3Sig  <= m3Var;
    m4Sig  <= m4Var;
    m5Sig  <= m5Var;
    m6Sig  <= m6Var;
    m7Sig  <= m7Var;
    m8Sig  <= m8Var;
    m9Sig  <= m9Var;
    m10Sig <= m10Var;
    dvSig  <= dVar;
    rvSig  <= rVar;
    if (TNconv(bReg) /= 0) then
      td <= TSLconv(((TNconv(aReg) / TNconv(bReg))   - TNconv(dVar))=0);  --
      tr <= TSLconv(((TNconv(aReg) rem TNconv(bReg)) - TNconv(rVar))=0);  --  
    else
      td <= '1';  --
      tr <= '1';  -- 
    end if;
    
  end process;
  --
  process (clk, resetN, dSig, rSig)
    variable dVar   :TSLV(d'range);
    variable clkVar :TL;
  begin
    if (LPM_INPUT_REGISTER=FALSE) then
      clkVar := TRUE;
    else
      clkVar := clk'event and clk='1';
    end if;
    if (LPM_INPUT_REGISTER=TRUE and resetN='0') then
      dReg <= (others=>'1');
      rReg <= (others=>'1');
    elsif (clkVar) then
      dReg <= dSig;
      rReg <= rSig;
    end if;
  end process;
  --
  d <= dReg;
  r <= rReg;

end behaviour;	
