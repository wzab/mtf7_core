-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * Copyright (c) 1998-2005 by Krzysztof Pozniak		       *
-- * All Rights Reserved.					       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

package std_logic_1164_ktp is

  -------------------------------------------------------------------
  -- standard package extentions
  -------------------------------------------------------------------
  subtype   TI  is integer;	     
  subtype   TN  is natural;
  subtype   TP  is positive;
  subtype   TL  is boolean;
  subtype   TC  is character;
  subtype   TS  is string;
  subtype   TT  is time;

  type      TIV is array(TN range<>) of integer;
  type      TNV is array(TN range<>) of natural;
  type      TPV is array(TN range<>) of positive;
  type      TLV is array(TN range<>) of boolean;


  function  minimum(a, b :TS) return TS;				-- returns less value from 'a' or 'b'
  function  maximum(a, b :TS) return TS;				-- returns biger value from 'a' or 'b'
  function  sel(t, f :TS; c :TL) return TS;				-- returns 't' for 'c'=TRUE or 'f' for 'c'=FALSE
  function  TNconv(arg :TL) return TN;					-- returns 0 when arg='false' or 1
  function  TLconv(arg :TI) return TL;					-- returns 'false' when arg=0 or 'true'
  function  "+" (l, r :TS) return TS;					-- adds 'l' to 'r' and generates common 'TS' vec.

  -------------------------------------------------------------------
  -- std_logic_arith package extentions
  -------------------------------------------------------------------
  function  minimum(a, b :TI) return TI;				-- returns less value from 'a' or 'b'
  function  maximum(a, b :TI) return TI;				-- returns biger value from 'a' or 'b'
  function  sel(t, f :TI; c :TL) return TI;				-- returns 't' for 'c'=TRUE or 'f' for 'c'=FALSE
  function  modulo(v, l, h :TI) return TI;				-- returns  value v modulo between 'l' and 'h'
  function  modulo(v, h :TP) return TI;					-- returns  value v modulo between 0 and 'h'
  
  function  minimum(v :TIV) return TI;					-- returns smallest value from vector 'v' of integers
  function  maximum(v :TIV) return TI;					-- returns bigest value from vector 'v' of integers
  function  minimum(v :TNV) return TN;					-- returns smallest value from vector 'v' of naturals
  function  maximum(v :TNV) return TN;					-- returns bigest value from vector 'v' of naturals
  function  minimum(v :TPV) return TP;					-- returns smallest value from vector 'v' of positives
  function  maximum(v :TPV) return TP;					-- returns bigest value from vector 'v' of positives
  function  pow2(v :TN) return TN;					-- returns 2^'v'
  function  rest(v,r :TN) return TN;					-- returns rest of 'v' for 'r' range
  function  div(v,r :TN) return TN;					-- returns the best natural value after 'v' divided by 'r'

  -------------------------------------------------------------------
  -- vectors range family
  -------------------------------------------------------------------
  subtype   TVL is TN;							-- 'TVL' defines vector length range
  constant  NO_VEC_LEN :TVL := 0;					-- 'NO_VEC_LEN' occurs not defined vector length

  subtype   TVI is TI range -1 to TVL'high;				-- 'TVI' defines vector index range
  constant  NO_VEC_INDEX :TVI := -1;					-- 'NO_VEC_INDEX' occurs not defined vector index
  constant  VEC_INDEX_MIN :TVI := 0;					-- 'VEC_INDEX_MIN' occurs minimal vector index

  type      TVR								-- 'TVR' type covers vector range parameters(l,r)
	    is record
	      l :TVI;
	      r :TVI;
	    end record;
  
  type      TVLV is array(TN range<>) of TVL;
  type      TVIV is array(TN range<>) of TVI;
  type      TVRV is array(TN range<>) of TVR;


  function  TVRcreate(l, r :TVI) return TVR;				-- generates 'TVR' for 'l' and 'r' input variables
  function  TVRcreate(len :TVL) return TVR;				-- generates 'TVR': 'l'=len-1 and 'r'=VEC_INDEX_MIN
  function  TVLcreate(l, r :TVI) return TVL;				-- computes length:abs('l'-'r')+1
  function  TVLcreate(par :TVR) return TVL;				-- computes length:abs('par.l'-'par.r')+1
  function  minimum(v :TVLV) return TVL;				-- returns smallest value from vector 'v' of TVL
  function  maximum(v :TVLV) return TVL;				-- returns bigest value from vector 'v' of TVL
  function  minimum(v :TVIV) return TVI;				-- returns smallest value from vector 'v' of TVI
  function  maximum(v :TVIV) return TVI;				-- returns bigest value from vector 'v' of TVI
  function  "**" (l, r :TVR) return TVR;				-- returns maximal common 'TVR' size for 'l' and 'r'

  function  TVRVconv(arg :TVR) return TVRV;				-- generates 'TVIV' vector(0 downto 0) = (arg)
  function  TVLcreate(arg :TVRV) return TVL;				-- returns length of vector from 'arg';
  function  "+" (l, r :TVRV) return TVRV;				-- adds 'l' to 'r' and generates common 'TVIV' vec.
  function  "+" (l, r :TVR) return TVRV;				-- adds 'l' to 'r' and generates common 'TVIV' vec.
  function  "+" (l :TVRV; r :TVR) return TVRV;				-- adds 'l' to 'r' and generates common 'TVIV' vec.
  function  "+" (l :TVR; r :TVRV) return TVRV;				-- adds 'l' to 'r' and generates common 'TVIV' vec.

  -------------------------------------------------------------------
  -- TSL and TSLV types families
  -------------------------------------------------------------------
  subtype   TSL is std_logic;
  subtype   TSLV is std_logic_vector;

  function  TSLVhigh(v: TSLV) return TVI;
  function  TSLVlow(v: TSLV) return TVI;
  function  TSLVleft(v: TSLV) return TVI;
  function  TSLVright(v: TSLV) return TVI;
  function  TSLVlength(v: TSLV) return TVL;


  function  TSLconv(arg :TN) return TSL;				-- 'TN' type converts to 'TSL' type
  function  TSLconv(arg :TL) return TSL;				-- 'TL' type converts to 'TSL' type
  function  TSLconv(arg:TSLV) return TSL;				-- returns arg(arg'low) as 'TSL' type
  function  TNconv(arg :TSL) return TN;					-- 'TSL' type converts to 'TN' type
  function  TLconv(arg :TSL) return TL;					-- returns result of logical condition :(arg='1')

  function  TSLVconv(arg :TN; len :TVL) return TSLV;			-- converts 'TN' to TSLV(len-1 downto VEC_INDEX_MIN)
  function  TSLVconv(arg :TN) return TSLV;				-- converts 'TN' to TSLV with minimal size
  function  TSLVconv(arg :TL; len :TVL) return TSLV;			-- converts 'TL' to TSLV(len-1 downto VEC_INDEX_MIN)
  function  TSLVconv(arg :TL) return TSLV;				-- converts 'TL' to TSLV with minimal size
  function  TSLVconv(arg:TSL; len :TVL) return TSLV;			-- converts 'TSL' to TSLV(len-1 downto VEC_INDEX_MIN)
  function  TSLVconv(arg:TSL) return TSLV;				-- converts 'TSL' to TSLV with minimal size
  function  TNconv(arg :TSLV) return TN;				-- 'TSLV' type converts to 'TN' type
  function  TSLV2TN(arg :TSLV) return TN;				-- 'TSLV' type converts to 'TN' type
  function  TNconv(arg :TSLV; l, h :TN) return TN;			-- 'TSLV' type converts to 'TN' type from 'l' to 'h'
  function  TLconv(arg :TSLV) return TL;				-- returns FALSE if 'arg' contains only '0' bits
  function  TNVconv(arg :TSLV; len :TP) return TNV;			-- 'TSLV' type converts to 'TNV' type for 'len' data width
  function  TNVconv(arg :TSLV) return TNV;				-- 'TSLV' type converts to 'TNV' type for full int width
  function  TSLVconv(arg :TNV; len :TP) return TSLV;                    -- converts each 'TN' to TSLV(len-1 downto VEC_INDEX_MIN) part
  function  TSLVconv(arg :TNV) return TSLV;                             -- converts each 'TN' to TSLV part for full int width

  function  TSLVput(vec, dst, src :TSLV) return TSLV;			-- performs:vec(dst'range)=src; returns 'vec'
  procedure TSLVputS(signal vec :inout TSLV; dst, src :TSLV);		-- performs:vec(dst'range)=src; returns 'vec'
  function  TSLVput(vec, dst :TSLV; src :TSL) return TSLV;		-- performs:vec(dst'right)=src; returns 'vec'
  procedure TSLVputS(signal vec :inout TSLV; dst :TSLV; src :TSL);	-- performs:vec(dst'right)=src; returns 'vec'
  function  TSLVput(dst, src :TSLV) return TSLV;			-- performs:dst(src'range)=src; returns 'dst'
  procedure TSLVputS(signal dst :inout TSLV; src :TSLV);		-- performs:dst(src'range)=src; returns 'dst'
  function  TSLVput(dst :TSLV; l,r :TVI; src :TSLV) return TSLV;	-- performs:vec(l .. r)=src; returns 'vec'
  procedure TSLVputS(signal dst :inout TSLV; l,r :TVI; src :TSLV);	-- performs:vec(l .. r)=src; returns 'vec'
  function  TSLVput(dst :TSLV; b :TVI; src :TSLV) return TSLV;		-- performs:vec(b <..> b+src'length-1)=src; returns 'vec'
  procedure TSLVputS(signal dst :inout TSLV; b :TVI; src :TSLV);	-- performs:vec(b <..> b+src'length-1)=src; returns 'vec'

  function  TSLVor(vec, dst, src :TSLV) return TSLV;			-- performs:vec(dst'range) OR src; returns 'vec'
  procedure TSLVorS(signal vec :inout TSLV; dst, src :TSLV);		-- performs:vec(dst'range) OR src; returns 'vec'
  function  TSLVor(vec, dst :TSLV; src :TSL) return TSLV;		-- performs:vec(dst'right) OR src; returns 'vec'
  procedure TSLVorS(signal vec :inout TSLV; dst :TSLV; src :TSL);	-- performs:vec(dst'right) OR src; returns 'vec'
  function  TSLVor(dst, src :TSLV) return TSLV;				-- performs:dst(src'range) OR src; returns 'dst'
  procedure TSLVorS(signal dst :inout TSLV; src :TSLV);			-- performs:dst(src'range) OR src; returns 'dst'
  function  TSLVor(dst :TSLV; l,r :TVI; src :TSLV) return TSLV;		-- performs:vec(l .. r) OR src; returns 'vec'
  procedure TSLVorS(signal dst :inout TSLV; l,r :TVI; src :TSLV);	-- performs:vec(l .. r) OR src; returns 'vec'

  function  TSLVnew(l,r :TVI; f:TSL) return TSLV;			-- creates TSLV(l .. r) and fills 'f'
  function  TSLVnew(l,r :TVI; f:TSLV) return TSLV;			-- creates TSLV(l .. r) and fills 'f'
  function  TSLVnew(l,r :TVI) return TSLV;				-- creates TSLV(l .. r) and fills '0'
  function  TSLVnew(length :TVL; f:TSL) return TSLV;			-- creates TSLV(length-1 downto VEC_INDEX_MIN) + fills 'f'
  function  TSLVnew(length :TVL; f:TSLV) return TSLV;			-- creates TSLV(length-1 downto VEC_INDEX_MIN) + fills 'f'
  function  TSLVnew(length :TVL) return TSLV;				-- creates TSLV(length-1 downto VEC_INDEX_MIN) + fills '0'

  function  TSLVfill(dst :TSLV; f :TSL) return TSLV;			-- fills dst of 'f'; returns 'dst'
  function  TSLVfill(dst :TSLV; f :TSLV) return TSLV;			-- fills dst of 'f'; returns 'dst'
  function  TSLVfill0(dst :TSLV) return TSLV;			        -- fills dst of '0'; returns 'dst'
  function  TSLVfill1(dst :TSLV) return TSLV;			        -- fills dst of '1'; returns 'dst'
  procedure TSLVfillS(signal dst :inout TSLV; f :TSL);			-- fills dst of 'f'; returns 'dst'
  procedure TSLVfillS(signal dst :inout TSLV; f :TSLV);			-- fills dst of 'f'; returns 'dst'

  function  TSLVrightor(src: TSLV) return TSLV;				-- return  src when each bit is ored with all right bits  
  function  TSLVleftor(src: TSLV) return TSLV;				-- return  src when each bit is ored with all left bits  
  function  TSLVrightand(src: TSLV) return TSLV;			-- return  src when each bit is anded with all right bits  
  function  TSLVleftand(src: TSLV) return TSLV;				-- return  src when each bit is anded with all left bits  
  function  TSLVrightxor(src: TSLV) return TSLV;			-- return  src when each bit is xored with all right bits  
  function  TSLVleftxor(src: TSLV) return TSLV;				-- return  src when each bit is xored with all left bits  
  function  TSLVrev(src: TSLV) return TSLV;				-- return  src(src'right .. src'left)
  function  TSLVrot(src: TSLV; step :TI) return TSLV;			-- returns 'src' rotated 'step' bits: (left for 'step'>0)
  function  TSLVsh(src: TSLV; step :TI; f :TSL) return TSLV;		-- returns 'src' shifted 'step' bits: (left for 'step'>0), free bits = 'f'
  function  TSLVsh(src: TSLV; step :TI) return TSLV;			-- returns 'src' shifted 'step' bits: (left for 'step'>0), free bits = '0'
  function  TSLVsh2l(dst, src: TSLV) return TSLV;			-- returns dst(src'high..src'low,dst'high..dst'low+src'length) 
  function  TSLVsh2l(dst: TSLV; src: TSL) return TSLV;			-- returns dst(src,dst'high..dst'low+1) 
  function  TSLVsh2h(dst, src: TSLV) return TSLV;			-- returns dst(dst'high-src'length..dst'low,src'high..src'low) 
  function  TSLVsh2h(dst: TSLV; src: TSL) return TSLV;			-- returns dst(dst'high-1..dst'low,src) 

  function  TVLcreate(arg:TN) return TVL;				-- returns minimal TSLV size to store 'arg'
  function  SLVMax(arg:TN) return TN;					-- returns maximum. value for min. TSLV size to store 'arg'

  function  SLVBitCount(arg:TSLV; b :TSL) return TN;			-- returns number of 'b' bits from 'arg'
  function  SLVBit0Count(arg:TSLV) return TN;				-- returns number of '0' bits from 'arg'
  function  SLVBit1Count(arg:TSLV) return TN;				-- returns number of '1' bits from 'arg'
  
  function  "**"(a, b :TSLV) return TSLV;				-- returns TSLV(a'length + b'length-1 downto 0)
  function  "&"(a, b :TSLV) return TSLV;				-- returns TSLV(a'length + b'length-1 downto 0)
--  procedure TSLVsplit(signal a,b :inout TSLV; src :TSLV);		-- splits 'vec' to 'a' and 'b' variables
  procedure TSLVsplitS(signal h,l :inout TSLV; src :TSLV);		-- splits 'vec' to 'a' and 'b' signals

  function  minimum(a, b :TSLV) return TSLV;				-- returns less value from 'a' or 'b'
  function  maximum(a, b :TSLV) return TSLV;				-- returns biger value from 'a' or 'b'
  function  minimum(a :TSLV; b :TN) return TSLV;			-- returns less value from 'a' or 'b'
  function  maximum(a :TSLV; b :TN) return TSLV;			-- returns biger value from 'a' or 'b'
  function  sel(t, f :TSL; c :TL) return TSL;				-- returns 't' for 'c'=TRUE or 'f' for 'c'=FALSE
  function  sel(t, f, c :TSL) return TSL;				-- returns 't' for 'c'='1' or 'f' for 'c'='0'
  function  sel(t, f :TSLV; c :TL) return TSLV;				-- returns 't' for 'c'=TRUE or 'f' for 'c'=FALSE
  function  sel(t :TSLV; f: TSL; c :TL) return TSLV;			-- returns 't' for 'c'=TRUE or fill 'f' for 'c'=FALSE
  function  sel(t, f :TSLV; c :TSL) return TSLV;			-- returns 't' for 'c'='1' or 'f' for 'c'='0'
  function  sel(t :TSLV; f, c: TSL) return TSLV;			-- returns 't' for 'c'=TRUE or fill 'f' for 'c'='0'
  function  sel(t, f, c :TSLV) return TSLV;			        -- returns 't(i)' for 'c(i)'='1' or 'f(i)' for 'c(i)'='0'

  function  TNconv(arg:TC) return TN;					-- 'TC' type convertion to 'TI' (as ANSII code)
  function  TCconv(constant arg:TN) return TC;				-- 'TN' type convertion to 'TC' (as ANSII code)
  function  TSLVconv(arg:TC; len :TVL) return TSLV;			-- 'TC' type convertion to 'TSLV' with 'len' size
  function  TSLVconv(arg:TC) return TSLV;				-- 'TC' type convertion to 'TSLV' with 8 bit size
  function  TNconv(arg:TS) return TN;					-- 'TS' type convertion to 'TI' (as ANSII word)
  function  TS2TN(arg:TS) return TN;					-- 'TS' type convertion to 'TI' (as ANSII word)
  function  TSconv(arg:TSLV) return TS;					-- 'TSLV' type convertion to 'TS'
  function  TSconv(arg:TI; len :TVL; fdec :TL) return TS;		-- 'TN' type convertion to 'TS' (as BIN for 'fdec'=FALSE or ANSII word)
  function  TSconv(arg:TI; len :TVL) return TS;				-- 'TN' type convertion to 'TS' (as BIN word)
  function  TSLVconv(arg:TS; len :TVL) return TSLV;			-- 'TS' type convertion to 'TSLV' with 'len' size
  function  TSLVconv(arg:TS) return TSLV;				-- 'TS' type convertion to 'TSLV' with 8*'arg' size
  function  TSLVconv(arg:TS; dst :TSLV) return TSLV;			-- 'TS' converts to TSLV with dst'lenght size

  -------------------------------------------------------------------
  -- vectors translate family
  -------------------------------------------------------------------
  type      TVT								-- 'TVT' type covers line function  parameters
            is record
	      a :TI;
	      b :TI;
	    end record;

  function  TVTcreate(sl, sr, dl, dr :TVI) return TVT;			-- generates 'TVT' where dl=a*dr+b, dr=a*sr+b
  function  VTindex(vt :TVT; index :TVI) return TVI;			-- counts y=vt.a*index+vt.b
  function  VTindex(sl, sr, dl, dr, index :TVI) return TVI;		-- generates 'TVT' for sl,..,dr and count y
  
  -------------------------------------------------------------------
  -- vectors translate family for SLV
  -------------------------------------------------------------------
  function  TVTcreate(src :TSLV; dl, dr :TVI) return TVT;		-- generates 'TVT' for src'left,src'right,dl,dr
  function  TVTcreate(src, dst :TSLV) return TVT;			-- generates 'TVT' for 'src' and 'dst' ranges
  function  VTnorm(src :TSLV) return TVT;				-- 'TVT' tranlates to(src'lenght-1 downto VEC_INDEX_MIN)
  function  VTrevNorm(src :TSLV) return TVT;				-- 'TVT' tranlates to(VEC_INDEX_MIN to src'lenght-1)
  function  TSLVtrans(src, dst :TSLV) return TSLV;			-- converts 'src' to TSLV(dst'left .. dst'right)    
  function  SLVNorm(src :TSLV) return TSLV;				-- converts 'src' to TSLV(src'lenght-1 downto VEC_INDEX_MIN)    
  function  SLVrevNorm(src :TSLV) return TSLV;				-- converts 'src' to TSLV(VEC_INDEX_MIN to src'lenght-1)    
  function  SLVrevRange(src :TSLV) return TSLV;				-- converts 'src' to TSLV(src'reverse_range)


  -------------------------------------------------------------------
  -- vectors cut family for TSLV
  -------------------------------------------------------------------
  function  TSLVCut(src :TSLV; l,r :TVI) return TSLV;			-- cut 'src' to TSLV(l .. r)
  function  TSLVCut(src :TSLV; len :TVL) return TSLV;			-- cut 'src' to TSLV(len-1 downto VEC_INDEX_MIN)
  function  TSLVCutPos(src :TSLV; pos :TVI; len :TVL) return TSLV;	-- cut 'src' to TSLV(pos+len-1 downto pos)
  function  TSLVCut(src, dst :TSLV) return TSLV;			-- cut 'src' to TSLV(dst'left .. dst'right)

  -------------------------------------------------------------------
  -- vectors extract family for TSLV
  -------------------------------------------------------------------
  function  TSLVExtract(src :TSLV; l,r :TVI) return TSLV;		-- extract 'src' to TSLV(l .. r)
  function  TSLVExtract(src :TSLV; len :TVL) return TSLV;		-- extract 'src' to TSLV(len-1 downto VEC_INDEX_MIN)
  function  TSLVExtract(src, dst :TSLV) return TSLV;			-- extract 'src' to TSLV(dst'left .. dst'right)

  -------------------------------------------------------------------
  -- vectors resize family for TSLV
  -------------------------------------------------------------------
  function  TSLVResize(src :TSLV; l,r :TVI; f :TSL) return TSLV;	-- resize 'src' to TSLV(l .. r), fills 'f' new bits
  function  TSLVResize(src :TSLV; l,r :TVI) return TSLV;		-- resize 'src' to TSLV(l .. r), fills '0' new bits
  function  TSLVResize(src :TSLV; len :TVL; f :TSL) return TSLV;	-- resize 'src' to TSLV(len-1 downto VEC_INDEX_MIN) + fill 'f'
  function  TSLVResize(src :TSLV; len :TVL) return TSLV;		-- resize 'src' to TSLV(len-1 downto VEC_INDEX_MIN) + fill '0'
  function  TSLVResize(src, dst :TSLV; f :TSL) return TSLV;		-- resize 'src' to TSLV(dst'left .. dst'right) + fill 'f'
  function  TSLVResize(src, dst :TSLV) return TSLV;			-- resize 'src' to TSLV(dst'left .. dst'right) + fill '0'
  function  TSLVResizeMin(src :TSLV; min :TVL; f :TSL) return TSLV;	-- resize 'src' to TSLV(max(src'length,min)-1 downto VEC_INDEX_MIN) + fill 'f'
  function  TSLVResizeMin(src :TSLV; min :TVL) return TSLV;		-- resize 'src' to TSLV(max(src'length,min)-1 downto VEC_INDEX_MIN) + fill '0'
  function  TSLVResizeMax(src :TSLV; max :TVL; f :TSL) return TSLV;	-- resize 'src' to TSLV(min(src'length,max)-1 downto VEC_INDEX_MIN) + fill 'f'
  function  TSLVResizeMax(src :TSLV; max :TVL) return TSLV;		-- resize 'src' to TSLV(min(src'length,max)-1 downto VEC_INDEX_MIN) + fill '0'

  -------------------------------------------------------------------
  -- HEX type family
  -------------------------------------------------------------------
  type      TH is (							-- 'TH' definition
	      '0', '1', '2', '3', '4', '5', '6', '7',
              '8', '9',	'A', 'B', 'C', 'D', 'E', 'F'
	    );
  type      THV is array(TN range<>) of TH;
  
  function  TNconv(arg:TH) return TN;					-- 'TH' type convertion to 'TI' 
  function  THconv(arg:TN) return TH;					-- 'TN' type convertion to 'TH' (invalid value=0)
  function  TSLVconv(arg:TH; len :TVL) return TSLV;			-- 'TH' type convertion to 'TSLV' with 'len' size
  function  TSLVconv(arg:TH) return TSLV;				-- 'TH' type convertion to 'TSLV' with 4 bit size
  function  TNconv(arg:THV) return TN;					-- 'THVec' type convertion to 'TI'
  function  THV2TN(arg:THV) return TN;					-- 'THVec' type convertion to 'TI'
  function  THVconv(arg:TN; len :TVL) return THV;			-- 'TN' type convertion to 'THV' with 'len' size
  function  TSLVconv(arg:THV; len :TVL) return TSLV;			-- 'THVec' type convertion to 'TSLV' with 'len' size
  function  THV2TSLV(arg:THV; len :TVL) return TSLV;			-- 'THVec' type convertion to 'TSLV' with 'len' size
  function  TSLVconv(arg:THV) return TSLV;				-- 'THVec' type convertion to 'TSLV' with 4*'arg' size
  function  TSLVconv(arg:THV; dst :TSLV) return TSLV;			-- 'THVec' converts to TSLV with dst'lenght size
  function  "&"(a, b :THV) return THV;  				-- returns THV(a'length + b'length-1 downto 0)

  -------------------------------------------------------------------
  -- BYTE type family
  -------------------------------------------------------------------
  
  subtype   TB is TSLV(7 downto 0);	     
  type      TBV is array(TN range<>) of TB;
  
  function  TBconv (arg :TN) return TB;
  function  TS2TBV (arg :TS) return TBV;
  function  TBV2TS (arg :TBV) return TS;
  function  THV2TBV (arg :THV) return TBV;
  function  TBV2THV (arg :TBV) return THV;
  function  TNconv(arg:TBV) return TN;					-- 'TBV' type convertion to 'TN'
  
  -------------------------------------------------------------------
  -- vectors range family for TSLV
  -------------------------------------------------------------------
  function  TVRcreate(src:TSLV) return TVR;				-- generates 'TVR' for v'left and v'right
  function  TSLVnew(par :TVR; f :TSL) return TSLV;			-- generates TSLV(par.l .. par.r) + fill 'f'
  function  TSLVnew(par :TVR; f :TSLV) return TSLV;			-- generates TSLV(par.l .. par.r) + fill 'f'
  function  TSLVnew(par :TVR) return TSLV;				-- generates TSLV(par.l .. par.r) + fill '0'
  function  TSLVCut(src :TSLV; par :TVR) return TSLV;			-- cut 'src' to TSLV(par.l .. par.r)
  function  TSLVExtract(src :TSLV; par :TVR) return TSLV;		-- extract 'src' to TSLV(par.l .. par.r)
  function  TSLVResize(src :TSLV; par :TVR; f :TSL) return TSLV;	-- resize 'src' to TSLV(par.l .. par.r) + fill 'f'
  function  TSLVResize(src :TSLV; par :TVR) return TSLV;		-- resize 'src' to TSLV(par.l .. par.r) + fill '0'
  function  TSLconv(src:TSLV; vr :TVR) return TSL;			-- converts 'src' to TSL as TSLV(vr.r)
  function  TSLVcut(src:TSL; vr :TVR) return TSLV;			-- cut 'src' to TSLV(vr.l .. vr.r)
  function  TSLVextract(src:TSL; vr :TVR) return TSLV;			-- extract 'src' to TSLV(vr.l .. vr.r)
  function  TSLVresize(src:TSL; vr :TVR) return TSLV;			-- resize 'src' to TSLV(vr.l .. vr.r)
  function  TSLVcut(src:TSLV; vt :TVT; vr :TVR) return TSLV;		-- cut 'src' to TSLV(vt(vr.l) .. vt(vr.r))
  function  TSLVextract(src:TSLV; vt :TVT; vr :TVR) return TSLV;	-- extract 'src' to TSLV(vt(vr.l) .. vt(vr.r))
  function  TSLVresize(src:TSLV; vt :TVT; vr :TVR) return TSLV;		-- resize 'src' to TSLV(vt(vr.l) .. vt(vr.r))
  function  TSLconv(src:TSLV; vt :TVT; vr :TVR) return TSL;		-- converts 'src' to TSL as TSLV(vt(vr.r))
  function  TSLVresize(src:TSL; vt :TVT; vr :TVR) return TSLV;		-- resize 'src' to TSLV(vt(vr.l) .. vt(vr.r))
  function  TSLVtrans(src :TSLV; par :TVR) return TSLV;			-- converts 'src' to TSLV(par.l .. par.r)
  function  TSLVtrans(src :TSL; par :TVR) return TSLV;			-- converts 'src' to TSLV(par.l .. par.r)
  function  TSLVput(dst :TSLV; par :TVR; src :TSLV) return TSLV;	-- performs:dst(par.l .. par.r)=src; returns 'dst'
  procedure TSLVputS(signal dst :inout TSLV; par :TVR; src :TSLV);	-- performs:dst(par.l .. par.r)=src; returns 'dst'
  function  TSLVput(dst :TSLV; par :TVR; src :TSL) return TSLV;		-- performs:dst(par.l)=src; returns 'dst'
  procedure TSLVputS(signal dst :inout TSLV; par :TVR; src :TSL);	-- performs:dst(par.l)=src; returns 'dst'
  function  TSLVor(dst :TSLV; par :TVR; src :TSLV) return TSLV;		-- performs:dst(par.l .. par.r) OR src; returns 'dst'
  procedure TSLVorS(signal dst :inout TSLV; par :TVR; src :TSLV);	-- performs:dst(par.l .. par.r) OR src; returns 'dst'
  function  TSLVor(dst :TSLV; par :TVR; src :TSL) return TSLV;		-- performs:dst(par.l) OR src; returns 'dst'
  procedure TSLVorS(signal dst :inout TSLV; par :TVR; src :TSL);	-- performs:dst(par.l) OR src; returns 'dst'

  -------------------------------------------------------------------
  -- vectors partitioning
  -------------------------------------------------------------------
  function  SLVPartNum(vlen, plen :TVL) return TP;			-- calculates part numbers (len:'plen') in vector (len:'vlen')
  function  SLVPartNum(v :TSLV; plen :TVL) return TP;			-- calculates part numbers (len:'plen') in vector 'v'
  function  SLVPartSize(vlen, plen :TVL; index :TVI) return TVL;	-- calculates size of part number 'index' in vector
  function  SLVPartSize(v :TSLV; plen :TVL; index :TVI) return TVL;	-- calculates size of part number 'index' in vector 'v'
  function  SLVPartSize(v :TSLV; plen :TVL; vi :TSLV) return TVL;	-- calculates size of part selected by 'vi' in vector 'v'
  function  SLVPartLastSize(vlen, plen :TVL) return TVL;		-- calculates size of last part in vector
  function  SLVPartLastSize(v :TSLV; plen :TVL) return TVL;		-- calculates size of last part in vector 'v'
  function  SLVPartGet(v :TSLV; plen :TVL; index :TN) return TSLV;	-- returns 'v' part number 'index'
  function  SLVPartGet(v :TSLV; plen :TVL; index, il, ih :TN) return TSLV; -- returns 'v' part number 'index' from 0 to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; index :TN; f:TSL) return TSLV; -- returns 'v' part number 'index'
  function  SLVPartGet(v :TSLV; plen :TVL; index, il, ih :TN; f:TSL) return TSLV; -- returns 'v' part number 'index' from 0 to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; il, ih :TN) return TSLV;	-- returns 'v' parts from numbers 'il' to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; il, ih :TN) return TSLV;	-- returns 'v' part selected by 'vi' range 'il' to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; ih :TN) return TSLV;	-- returns 'v' part selected by 'vi' range 0 to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV) return TSLV;	-- returns 'v' part selected by 'vi'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; il, ih :TN ; f:TSL) return TSLV; -- returns 'v' part selected by 'vi' range 'il' to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; ih :TN ; f:TSL) return TSLV; -- returns 'v' part selected by 'vi' range 0 to 'ih'
  function  SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; f:TSL) return TSLV; -- returns 'v' part selected by 'vi'
  function  SLVPartPut(v :TSLV; plen :TVL; index :TVI; src :TSLV) return TSLV;	-- returns 'v' with 'src' part number 'index'
  function  SLVPartPut(v :TSLV; plen :TVL; index :TVI; il, ih :TN; src :TSLV) return TSLV; -- returns 'v' with 'src' part number 'index' range 'il' to 'ih'
  function  SLVPartPut(v :TSLV;            index :TVI; src :TSLV) return TSLV;	-- returns 'v' with 'src' part number 'index'
  function  SLVPartPut(v :TSLV;            index :TVI; il, ih :TN; src :TSLV) return TSLV; -- returns 'v' with 'src' part number 'index' range 'il' to 'ih'
  function  SLVPartPut(v :TSLV; plen :TVL; index :TVI; src :TSLV; f:TSL) return TSLV; -- returns 'v' with 'src' part number 'index'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; il, ih :TN) return TSLV;	-- returns 'v' with 'src' part selected by 'vi'	range 'il' to 'ih'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; ih :TN) return TSLV;	-- returns 'v' with 'src' part selected by 'vi'	range 0 to 'ih'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV) return TSLV;	-- returns 'v' with 'src' part selected by 'vi'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; il, ih :TN; f:TSL) return TSLV; -- returns 'v' with 'src' part selected by 'vi' range 'il' to 'ih'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; ih :TN; f:TSL) return TSLV; -- returns 'v' with 'src' part selected by 'vi' range 0 to 'ih'
  function  SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; f:TSL) return TSLV; -- returns 'v' with 'src' part selected by 'vi'
  function  SLVPartOR(v :TSLV; plen :TVL; f:TSL) return TSLV;		-- returns OR of 'v' parts for 'plen' part lenght and 'f' free bits
  function  SLVPartOR(v :TSLV; plen :TVL) return TSLV;			-- returns OR of  'v' parts for 'plen' part lenght
  function  SLVPartAND(v :TSLV; plen :TVL; f:TSL) return TSLV;		-- returns AND of 'v' parts for 'plen' part lenght and 'f' free bits
  function  SLVPartAND(v :TSLV; plen :TVL) return TSLV;			-- returns OAN of 'v' parts for 'plen' part lenght
  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixs,ixd :TVI) return TSLV; -- copies 'vs(ixs)' data part into vd(ixd)
  function  SLVPartCopy(v :TSLV; plen :TVL; ixs,ixd :TVI) return TSLV;	-- copies 'v(ixs)' data part into v(ixd)
  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixs,ixd :TVI; f:TSL) return TSLV; -- copies 'vs(ixs)' data part into vd(ixd)
  function  SLVPartCopy(v :TSLV; plen :TVL; ixs,ixd :TVI; f:TSL) return TSLV; -- copies 'v(ixs)' data part into v(ixd)
  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixls,ixhs,ixld :TVI) return TSLV; -- copies 'vs(ixls,ixlh)' data parts into vd(ixd..)
  function  SLVPartCopy(v :TSLV; plen :TVL; ixls,ixhs,ixld :TVI) return TSLV; -- copies 'v(ixls,ixlh)' data parts into v(ixd..)
  function  SLVPartCopyRep(vs,vd :TSLV; plen :TVL; ixls,ixhs,ixld :TVI; step,cnt:TVL) return TSLV; -- copies 'vs(ixls,ixlh)' data parts into vd(ixd..)*'cnt'
  function  SLVPartCopyRep(v :TSLV; plen :TVL; ixls,ixhs,ixld :TVI; step,cnt:TVL) return TSLV; -- copies 'v(ixls,ixlh)' data parts into v(ixd..)*'cnt'
  function  SLVPartAddrExpand(vlen, plen :TVL) return TN;		-- calculates address size selecting parts
  function  SLVPartAddrExpand(v :TSLV; plen :TVL) return TN;		-- calculates address size selecting parts in vectopr 'v'

  -------------------------------------------------------------------
  -- vectors structur
  -------------------------------------------------------------------
  function  SLVStructPosLow(s :TVLV; i :TVI) return TVI;		-- returns LSB vector positon from 'i' index of 's' structure
  function  SLVStructPosHigh(s :TVLV; i :TVI) return TVI;		-- returns MSB vector positon from 'i' index of 's' structure
  function  SLVStructLen(s :TVLV) return TVL;				-- returns vector length of 's' structure
  function  SLVStructCreate(s :TVLV) return TSLV;			-- returns TSLV-'0' vector of 's' structure
  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TSLV) return TSLV; -- returns 'v' with 'd' part indexed 'i' of 's' structure
  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TSL) return TSLV;	-- returns 'v' with 'd' part indexed 'i' of 's' structure
  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TN) return TSLV;	-- returns 'v' with 'd' value indexed 'i' of 's' structure
  function  SLVStructPut(s :TVLV; i :TVI; d :TSLV) return TSLV;	        -- returns TSLV-'0' vector with 'd' vector part indexed 'i' of 's' structure
  function  SLVStructPut(s :TVLV; i :TVI; d :TSL) return TSLV;	        -- returns TSLV-'0' vector with 'd' single bit part indexed 'i' of 's' structure
  function  SLVStructPut(s :TVLV; i :TVI; d :TN) return TSLV;	        -- returns TSLV-'0' vector with 'd' value part indexed 'i' of 's' structure
  function  SLVStructGet(v :TSLV; s :TVLV; i :TVI) return TSLV;		-- returns TSLV part indexed 'i' of 's' structure
  function  SLVStructGet(v :TSLV; s :TVLV; il, ih :TVI) return TSLV;	-- returns TSLV part indexed from 'il' to 'ih' of 's' structure

  -------------------------------------------------------------------
  -- vectors bits multiplexing
  -------------------------------------------------------------------
  function  SLVBitDemux(src:TSLV; level:TVL; pos: TVI) return TSLV;	-- demuxing on 'level' vectors, output: 'pos' vector
  function  SLVBitMux(src0, src1 :TSLV) return TSLV;			-- muxing two vectors
  function  SLVBitMux(src0, src1, src2 :TSLV) return TSLV;		-- muxing three vectors
  function  SLVBitMux(src0, src1, src2, src3 :TSLV) return TSLV;	-- muxing four vectors
  function  SLVBitORcompress(src :TSLV; len :TVL) return TSLV;		-- OR bits compress
  function  SLVBitDecompress(src :TSLV; len :TVL) return TSLV;		-- muxing fou vectors

  -------------------------------------------------------------------
  -- vectors multiplexing
  -------------------------------------------------------------------
  function  SLVMux(src0, src1 :TSLV; sel :TN) return TSLV;		-- muxing two vectors
  function  SLVMux(src0, src1, src2:TSLV; sel :TN) return TSLV;		-- muxing three vectors
  function  SLVMux(src0, src1, src2, src3 :TSLV; sel :TN) return TSLV;	-- muxing four vectors
  function  SLVMux(src0, src1 :TSLV; sel :TSL) return TSLV;		-- muxing two vectors
  function  SLVMux(src0, src1, sel :TSLV) return TSLV;			-- muxing two vectors
  function  SLVMux(src0, src1, src2, sel :TSLV) return TSLV;		-- muxing three vectors
  function  SLVMux(src0, src1, src2, src3, sel :TSLV) return TSLV;	-- muxing four vectors

  -------------------------------------------------------------------
  -- vectors spliting
  -------------------------------------------------------------------
  procedure SLVSplit(dst2, dst1 :out TSLV; src :TSLV);			-- spliting 2 vectors
  procedure SLVSplit(dst3, dst2, dst1 :out TSLV; src :TSLV);		-- spliting 3 vectors
  procedure SLVSplit(dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); 	-- spliting 4 vectors
  procedure SLVSplit(dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); -- spliting 5 vectors
  procedure SLVSplit(dst6, dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); -- spliting 6 vectors
  
  procedure SLVSplitS(signal dst2, dst1 :out TSLV; src :TSLV);		-- spliting 2 vectors
  procedure SLVSplitS(signal dst3, dst2, dst1 :out TSLV; src :TSLV);	-- spliting 3 vectors
  procedure SLVSplitS(signal dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); -- spliting 4 vectors
  procedure SLVSplitS(signal dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); -- spliting 5 vectors
  procedure SLVSplitS(signal dst6, dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV); -- spliting 6 vectors

  -------------------------------------------------------------------
  -- vectors counting
  -------------------------------------------------------------------
  function  SLVCntStep(cnt :TSLV; l, h :TN; s :TI) return TSLV;		-- returns 'cnt'+'step' modulo <l,h> range
  function  SLVCntStep(cnt :TSLV; h :TN; s :TI) return TSLV;		-- returns 'cnt'+'step' modulo <0,h> range
  function  SLVCntInc(cnt :TSLV; l, h :TN) return TSLV;			-- returns 'cnt'+1 modulo <l,h> range
  function  SLVCntInc(cnt :TSLV; h :TN) return TSLV;			-- returns 'cnt'+1 modulo <0,h> range
  function  SLVCntDec(cnt :TSLV; l, h :TN) return TSLV;			-- returns 'cnt'-1 modulo <l,h> range
  function  SLVCntDec(cnt :TSLV; h :TN) return TSLV;			-- returns 'cnt'-1 modulo <0,h> range

  -------------------------------------------------------------------
  -- vectors checking
  -------------------------------------------------------------------
  function  SLVCheckXORset(data :TSLV; plen, pnum :TP) return TSLV;	-- returns 'data'+XOR type check vector
  function  SLVCheckXORres(data :TSLV; plen, pnum, dlen :TP) return TSLV; -- returns inverse XOR type check vector

  -------------------------------------------------------------------
  -- triple logic
  -------------------------------------------------------------------
  type      T3L  is (false, true, undef);
  type      T3LV is array(TN range<>) of T3L;
  
  function  T3LisFalse(arg :T3L) return TL;				-- returns TL.true if arg=T3L.false
  function  T3LisTrue(arg :T3L) return TL;				-- returns TL.true if arg=T3L.true
  function  T3LisUndef(arg :T3L) return TL;				-- returns TL.true if arg=T3L.undef
  function  T3Lconv(arg :TL) return T3L;				-- returns T3L.true if arg=TL.true else T3L.false
  function  TLconv(arg :T3L) return TL;					-- returns TL.true if arg=T3L.true else TL.false
  
  -------------------------------------------------------------------
  -- two dimentions arrays emulation
  -------------------------------------------------------------------
  type      TA2D							-- 'TA2D' type covers column(y) and row(x) area sizes
            is record
              y :TVL;
              x :TVL;
            end record;
  
  function  TA2Dcreate(ya, xa :TVL) return TA2D;			-- generates 'TA2D' type where:y=ya and x=xa => A2D[ya,xa]
  function  A2DSize(ya, xa :TVL) return TVL;				-- returns TSLV size for A2D[ya,xa]
  function  A2DSize(ad :TA2D) return TVL;				-- returns TSLV size for A2D[ad]
  function  A2DIndex(ya, xa :TVL; y, x :TVI) return TVI;		-- returns TSLV position in A2D[ya,xa](x,y)
  function  A2DIndex(ad :TA2D; y, x :TVI) return TVI;			-- returns TSLV position in A2D[ad](x,y)

  -------------------------------------------------------------------
  -- two dimentions arrays emulation for TSLV
  -------------------------------------------------------------------
  function  A2DInitArea(ya, xa :TVL; d :TSL) return TSLV;		-- returns TSLV emulates A2D[ya,xa] => TSLV[ya,xa]
  function  A2DInitArea(ad :TA2D; d :TSL) return TSLV;			-- returns TSLV[ad.y,ad.x] => TSLV[ya,xa]

  function  A2DGetCell(v :TSLV; ya, xa :TVL; y, x :TVI) return TSL;	-- returns v[ya,xa](y,x)
  function  A2DGetCell(v :TSLV; ad :TA2D; y, x :TVI) return TSL;	-- returns v[ad](y,x)
  function  A2DGetRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI) return TSLV; -- returns v[ya,xa](y,xh downto xl)
  function  A2DGetRange(v :TSLV; ad :TA2D; y, xh, xl :TVI) return TSLV;	-- returns v[ad](y,xh downto xl)
  function  A2DGetRow(v :TSLV; ya, xa :TVL; y :TVI) return TSLV;	-- returns v[ya,xa](y,xa-1 downto VEC_INDEX_MIN)
  function  A2DGetRow(v :TSLV; ad :TA2D; y :TVI) return TSLV;		-- returns v[ad](y,ad.x-1 downto VEC_INDEX_MIN)
  function  A2DGetLastRow(v :TSLV; ya, xa :TVL) return TSLV;		-- returns v[ya,xa](ya,xa-1 downto VEC_INDEX_MIN)
  function  A2DGetLastRow(v :TSLV; ad :TA2D) return TSLV;		-- returns v[ad](ad.y,ad.x-1 downto VEC_INDEX_MIN)

  function  A2DSetCell(v :TSLV; ya, xa :TVL; y, x :TVI; d :TSL) return TSLV; -- set v[ya,xa](y,x)=d; returns v
  function  A2DSetCell(v :TSLV; ad :TA2D; y, x :TVI; d :TSL) return TSLV; -- set v[ad](y,x)=d; returns v
  function  A2DSetRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI; d :TSLV) return TSLV; -- set v[ya,xa](y,xh downto xl)=d; returns v
  function  A2DSetRange(v :TSLV; ad :TA2D; y, xh, xl :TVI; d :TSLV) return TSLV; -- set v[ad](y,xh downto xl)=d; returns v
  function  A2DSetRow(v :TSLV; ya, xa :TVL; y :TVI; d :TSLV) return TSLV; -- set v[ya,xa](y,xa-1 downto VEC_INDEX_MIN)=d; returns v
  function  A2DSetRow(v :TSLV; ad :TA2D; y :TVI; d :TSLV) return TSLV;	-- set v[ad](y,ad.x-1 downto VEC_INDEX_MIN)=d; returns v

  function  A2DFillRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI; d :TSL) return TSLV; -- fill v[ya,xa](y,xh downto xl)=d; returns v
  function  A2DFillRange(v :TSLV; ad :TA2D; y, xh, xl :TVI; d :TSL) return TSLV; -- fill v[ad](y,xh downto xl)=d; returns v
  function  A2DFillRow(v :TSLV; ya, xa :TVL; y :TVI; d :TSL) return TSLV; -- fill v[ya,xa](y,xa-1 downto VEC_INDEX_MIN)=d; returns v
  function  A2DFillRow(v :TSLV; ad :TA2D; y :TVI; d :TSL) return TSLV;	-- fill v[ad](y,ad.x-1 downto VEC_INDEX_MIN)=d; returns v

  -------------------------------------------------------------------
  -- two dimentions arrays for TSLV
  -------------------------------------------------------------------
  type      TSLA is array(TN range <>, TN range <>) of TSL;		-- array(Y,X)
  
  function  TSLAnew(yl, yr, xl, xr :TN; s :TSL) return TSLA;		-- returns array a(yl..yr,xl..xr) cells with value 's'
  function  TSLAnew(yl, yr, xl, xr :TN) return TSLA;			-- returns array a(yl..yr,xl..xr) cells value '0'
  function  TSLAnew(y, x :TI; s :TSL) return TSLA;			-- returns array a(max(y,0)..max(-y,0),max(x,0)..max(-x,0)) cells with value 's'
  function  TSLAnew(y, x :TI) return TSLA;				-- returns array a(max(y,0)..max(-y,0),max(x,0)..max(-x,0)) cells with value '0'
  function  TSLAset(a :TSLA; yl, yr, xl, xr :TN; s :TSL) return TSLA;	-- set into subarray a(yl,xl) .. a(yr,xr) cells value 's'
  function  TSLAsetX(a :TSLA; y, xl, xr :TN; s :TSL) return TSLA;	-- set into subrow a(y,xl) .. a(y,xr) cells value 's'
  function  TSLAsetX(a :TSLA; y :TN; s :TSL) return TSLA;		-- set into row a(y,..) of cells value 's';
  function  TSLAsetY(a :TSLA; yl, yr, x :TN; s :TSL) return TSLA;	-- set into subcol a(yl,x) .. a(yr,x) cells value 's'
  function  TSLAsetY(a :TSLA; x :TN; s :TSL) return TSLA;		-- set into col a(..,x) of cells value 's';
  function  TSLAset(a :TSLA; s :TSL) return TSLA;			-- set into array 'a' value 's';
  function  TSLVget(a :TSLA; yl, yr, xl, xr :TN) return TSLV;		-- returns a(yl,xl) .. a(yr,xr) subarray of cells as TSLV;
  function  TSLVgetX(a :TSLA; y, xl, xr :TN) return TSLV;		-- returns a(y,xl) .. a(y,xr) subrow of cells as TSLV;
  function  TSLVgetX(a :TSLA; y :TN) return TSLV;			-- returns a(y,..) row of cells as TSLV
  function  TSLVgetY(a :TSLA; yl, yr, x :TN) return TSLV;		-- returns a(yl,x) .. a(yr,x) subcol of cells as TSLV;
  function  TSLVgetY(a :TSLA; x :TN) return TSLV;			-- returns a(..,x) col of cells as TSLV
  function  TSLVget(a :TSLA) return TSLV;				-- returns 'a' array as TSLV
  function  TSLAput(a :TSLA; yl, yr, xl, xr :TN; s :TSLV) return TSLA;	-- puts into a(yl,xl) .. a(yr,xr) subarray vector 's'
  function  TSLAputX(a :TSLA; y, xl, xr :TN; s :TSLV) return TSLA;	-- puts into a(y,xl) .. a(y,xr) subrow vector 's'
  function  TSLAputX(a :TSLA; y, x :TN; s :TSLV) return TSLA;		-- puts into a(y,x) .. a(y,x+v'length-1) subrow vector 's'
  function  TSLAputX(a :TSLA; y :TN; s :TSLV) return TSLA;		-- puts into a(y,..) row vector 's';
  function  TSLAputY(a :TSLA; yl, yr, x :TN; s :TSLV) return TSLA;	-- puts into a(yl,x) .. a(yr,x) subcol vector 's'
  function  TSLAputY(a :TSLA; y, x :TN; s :TSLV) return TSLA;		-- puts into a(y,x) .. a(y+v'length-1,x) subrcol vector 's'
  function  TSLAputY(a :TSLA; x :TN; s :TSLV) return TSLA;		-- puts into a(..,x) col vector 's';
  function  TSLAput(a :TSLA; s :TSLV) return TSLA;			-- puts into 'a' array vector 's';
  function  TSLAmov(a :TSLA; yl, yr, xl, xr :TN; ys, xs, n :TI) return TSLA; -- meves from subarr a(yl,xl) .. a(yr,xr) for 'xs','ys' steps by 'n' times
  function  TSLAmovX(a :TSLA; yl, yr :TN; ys, n :TI) return TSLA;	-- moves from subarr a(yl,x'left) .. a(yr,x'right) for 'ys' steps by 'n' times
  function  TSLAmovX(a :TSLA; y :TN; ys, n :TI) return TSLA;		-- moves from row a(y) for 'ys' steps by 'n' times
  function  TSLAmovX(a :TSLA; ys :TI) return TSLA;			-- moves all rows for 'ys' steps
  function  TSLAmovY(a :TSLA; xl, xr :TN; xs, n :TI) return TSLA;	-- moves from subarr a(y'left,xl) .. a(y'right,xr) for 'xs' steps by 'n' times
  function  TSLAmovY(a :TSLA; x :TN; xs, n :TI) return TSLA;		-- moves from col a(x) for 'xs' steps by 'n' times
  function  TSLAmovY(a :TSLA; xs :TI) return TSLA;			-- moves all columns for 'xs' steps

  -------------------------------------------------------------------
  -- three dimentions arrays for TSLV
  -------------------------------------------------------------------
  type      TSLC is array(TN range <>, TN range <>, TN range <>) of TSL; -- cubic(Z,Y,X)
  
  function  TSLCnew(zl, zr, yl, yr, xl, xr :TN; s :TSL) return TSLC;	-- returns array a(zl..zr,yl..yr,xl..xr) cells with value 's'
  function  TSLCnew(zl, zr, yl, yr, xl, xr :TN) return TSLC;		-- returns array a(zl..zr,yl..yr,xl..xr) cells value '0'
  function  TSLCnew(z, y, x :TI; s :TSL) return TSLC;			-- returns array a(max(z,0)..max(-z,0),max(y,0)..max(-y,0),max(x,0)..max(-x,0)) cells with value 's'
  function  TSLCnew(z, y, x :TI) return TSLC;				-- returns array a(max(z,0)..max(-z,0),max(y,0)..max(-y,0),max(x,0)..max(-x,0)) cells with value '0'
  function  TSLCset(c :TSLC; zl, zr, yl, yr, xl, xr :TN; s :TSL) return TSLC; -- set into subcub a(zl,yl,xl) .. a(zr,yr,xr) cells value 's'
  function  TSLCsetYX(c :TSLC; z, yl, yr, xl, xr :TN; s :TSL) return TSLC; -- set into subarr a(z,yl,xl) .. a(z,yl,xr) cells value 's'
  function  TSLCsetYX(c :TSLC; z :TN; s :TSL) return TSLC;		-- set into subarr a(z) cells value 's'
  function  TSLCsetZX(c :TSLC; zl, zr, y, xl, xr :TN; s :TSL) return TSLC; -- set into subarr a(zl,y,xl) .. a(zl,y,xr) cells value 's'
  function  TSLCsetZX(c :TSLC; y :TN; s :TSL) return TSLC;		-- set into subarr a(y) cells value 's'
  function  TSLCsetZY(c :TSLC; zl, zr, yl, yr, x :TN; s :TSL) return TSLC; -- set into subarr a(zl,yl,x) .. a(zl,yl,x) cells value 's'
  function  TSLCsetZY(c :TSLC; x :TN; s :TSL) return TSLC;		-- set into subarr a(x) cells value 's'
  function  TSLCsetX(c :TSLC; z, y, xl, xr :TN; s :TSL) return TSLC;	-- set into subarr a((z,y,xl) .. a(z,y,xr) cells value 's'
  function  TSLCsetX(c :TSLC; z, y :TN; s :TSL) return TSLC;		-- set into row a(z,y,..) of cells value 's';
  function  TSLCsetY(c :TSLC; z, yl, yr, x :TN; s :TSL) return TSLC;	-- set into subcol a(z,yl,x) .. a(z,yr,x) cells value 's'
  function  TSLCsetY(c :TSLC; z, x :TN; s :TSL) return TSLC;		-- set into col a(z,..,x) of cells value 's';
  function  TSLCsetZ(c :TSLC; zl, zr, y, x :TN; s :TSL) return TSLC;	-- set into subdepth a(zl,y,x) .. a(zr,y,x) cells value 's'
  function  TSLCsetZ(c :TSLC; y, x :TN; s :TSL) return TSLC;		-- set into depth a(..,y,x) of cells value 's';
  function  TSLCset(c :TSLC; s :TSL) return TSLC;			-- set into cubic 'a' value 's';
  function  TSLAgetYX(c :TSLC; z, yl, yr, xl, xr :TN) return TSLA;	-- returns a(z,yl,xr) .. a(z,yr,xr) subarr of cells as TSLA;
  function  TSLAgetYX(c :TSLC; z :TN) return TSLA;			-- returns a(z) subarr of cells as TSLA;
  function  TSLAgetZX(c :TSLC; zl, zr, y, xl, xr :TN) return TSLA;	-- returns a(zl,y,xr) .. a(zr,y,xr) subarr of cells as TSLA;
  function  TSLAgetZX(c :TSLC; y :TN) return TSLA;			-- returns a(y) subarr of cells as TSLA;
  function  TSLAgetZY(c :TSLC; zl, zr, yl, yr, x :TN) return TSLA;	-- returns a(zl,yl,x) .. a(zr,yr,x) subarr of cells as TSLA;
  function  TSLAgetZY(c :TSLC; x :TN) return TSLA;			-- returns a(x) subarr of cells as TSLA;
  function  TSLVget(c :TSLC; zl, zr, yl, yr, xl, xr :TN) return TSLV;	-- returns a(zl,yl,xl) .. a(zr,yr,xr) subcub of cells as TSLV;
  function  TSLVgetX(c :TSLC; z, y, xl, xr :TN) return TSLV;		-- returns a(z,y,xl) .. a(z,y,xr) subrow of cells as TSLV;
  function  TSLVgetX(c :TSLC; z, y :TN) return TSLV;			-- returns a(z,y,..) row of cells as TSLV
  function  TSLVgetY(c :TSLC; z, yl, yr, x :TN) return TSLV;		-- returns a(z,yl,x) .. a(z,yr,x) subcol of cells as TSLV;
  function  TSLVgetY(c :TSLC; z, x :TN) return TSLV;			-- returns a(z,..,x) col of cells as TSLV
  function  TSLVgetZ(c :TSLC; zl, zr, y, x :TN) return TSLV;		-- returns a(zl,y,x) .. a(zr,y,x) subdepth of cells as TSLV;
  function  TSLVgetZ(c :TSLC; y, x :TN) return TSLV;			-- returns a(..,y,x) depth of cells as TSLV
  function  TSLVget(c :TSLC) return TSLV;				-- returns 'a' cubic as TSLV
  function  TSLCputYX(c :TSLC; z, y, x :TN; a :TSLA) return TSLC;       -- puts from c(z,y,x) base cell array 'a' as YX subarray
  function  TSLCputYX(c :TSLC; z :TN; a :TSLA) return TSLC;             -- puts 'c(z)=a'
  function  TSLCputZX(c :TSLC; z, y, x :TN; a :TSLA) return TSLC;       -- puts from c(z,y,x) base cell array 'a' as ZX subarray
  function  TSLCputZX(c :TSLC; y :TN; a :TSLA) return TSLC;             -- puts 'c(y)=a'
  function  TSLCputZY(c :TSLC; z, y, x :TN; a :TSLA) return TSLC;       -- puts from c(z,y,x) base cell array 'a' as ZY subarray
  function  TSLCputZY(c :TSLC; x :TN; a :TSLA) return TSLC;             -- puts 'c(x)=a'
  function  TSLCput(c :TSLC; zl, zr, yl, yr, xl, xr :TN; s :TSLV) return TSLC; -- puts into a(zl,yl,xl) .. a(zr,yr,xr) subcub vector 's'
  function  TSLCputX(c :TSLC; z, y, xl, xr :TN; s :TSLV) return TSLC;	-- puts into a(z,y,xl) .. a(z,y,xr) subrow vector 's'
  function  TSLCputX(c :TSLC; z, y, x :TN; s :TSLV) return TSLC;	-- puts into a(z,y,x) .. a(z,y,x+v'length-1) subrow vector 's'
  function  TSLCputX(c :TSLC; z, y :TN; s :TSLV) return TSLC;		-- puts into a(z,y,..) row vector 's';
  function  TSLCputY(c :TSLC; z, yl, yr, x :TN; s :TSLV) return TSLC;	-- puts into a(z,yl,x) .. a(z,yr,x) subcol vector 's'
  function  TSLCputY(c :TSLC; z, y, x :TN; s :TSLV) return TSLC;	-- puts into a(z,y,x) .. a(z,y+v'length-1,x) subrcol vector 's'
  function  TSLCputY(c :TSLC; z, x :TN; s :TSLV) return TSLC;		-- puts into a(z,..,x) col vector 's';
  function  TSLCputZ(c :TSLC; zl, zr, y, x :TN; s :TSLV) return TSLC;	-- puts into a(zl,y,x) .. a(zr,y,x) subdepth vector 's'
  function  TSLCputZ(c :TSLC; z, y, x :TN; s :TSLV) return TSLC;	-- puts into a(z,y,x) .. a(z+v'length-1,y,x) subdepth vector 's'
  function  TSLCputZ(c :TSLC; y, x :TN; s :TSLV) return TSLC;		-- puts into a(..,y,x) depth vector 's';
  function  TSLCput(c :TSLC; s :TSLV) return TSLC;			-- puts into 'a' array vector 's';
  function  TSLCmov(c :TSLC; zl, zr, yl, yr, xl, xr :TN; zs, ys, xs, n :TI) return TSLC; -- meves from subcub a(zl,yl,xl) .. a(zr,yr,xr) for 'zs','xs','ys' steps by 'n' times
  function  TSLCmovX(c :TSLC; zl, zr, yl, yr :TN; zs, ys, n :TI) return TSLC; -- moves from subcub a(zl,yl,x'left) .. a(zr,yr,x'right) for 'zs','ys' steps by 'n' times
  function  TSLCmovX(c :TSLC; z, y :TN; zs, ys, n :TI) return TSLC;	-- moves from row a(z,y) for 'zs','ys' steps by 'n' times
  function  TSLCmovX(c :TSLC; zs, ys :TI) return TSLC;			-- moves all rows for 'zs','ys' steps
  function  TSLCmovY(c :TSLC; zl, zr, xl, xr :TN; zs, xs, n :TI) return TSLC; -- moves from subcub a(zl,y'left,xl) .. a(zr,y'right,xr) for 'zs','xs' steps by 'n' times
  function  TSLCmovY(c :TSLC; z, x :TN; zs, xs, n :TI) return TSLC;	-- moves from col a(z,x) for 'xs' steps by 'n' times
  function  TSLCmovY(c :TSLC; zs, xs :TI) return TSLC;			-- moves all columns for 'zs','xs' steps
  function  TSLCmovZ(c :TSLC; yl, yr, xl, xr :TN; ys, xs, n :TI) return TSLC; -- moves from subcub a(z'left,yl,xl) .. a(z'right,yr,xr) for 'ys','xs' steps by 'n' times
  function  TSLCmovZ(c :TSLC; y, x :TN; ys, xs, n :TI) return TSLC;	-- moves from depth a(y,x) for 'ys','xs' steps by 'n' times
  function  TSLCmovZ(c :TSLC; ys, xs :TI) return TSLC;			-- moves all depths for 'ys','xs' steps
  function  TSLCmovYX(c :TSLC; zl, zr :TN; zs, n :TI) return TSLC;	-- moves from subcub a(zl,y'left,x'left) .. a(zr,y'right,x'right) for 'zs' steps by 'n' times
  function  TSLCmovYX(c :TSLC; z :TN; zs,  n :TI) return TSLC;		-- moves from area a(z) for 'zs' steps by 'n' times
  function  TSLCmovYX(c :TSLC; zs :TI) return TSLC;			-- moves all z-areas for 'zs' steps
  function  TSLCmovZX(c :TSLC; yl, yr :TN; ys, n :TI) return TSLC;	-- moves from subcub a(z'left,yl,x'left) .. a(z'right,yr,x'right) for 'ys' steps by 'n' times
  function  TSLCmovZX(c :TSLC; y :TN; ys,  n :TI) return TSLC;		-- moves from area a(y) for 'ys' steps by 'n' times
  function  TSLCmovZX(c :TSLC; ys :TI) return TSLC;			-- moves all y-areas for 'zs' steps
  function  TSLCmovZY(c :TSLC; xl, xr :TN; xs, n :TI) return TSLC;	-- moves from subcub a(z'left,y'left,xl) .. a(z'right,y'right,xr) for 'xs' steps by 'n' times
  function  TSLCmovZY(c :TSLC; x :TN; xs,  n :TI) return TSLC;		-- moves from area a(x) for 'xs' steps by 'n' times
  function  TSLCmovZY(c :TSLC; xs :TI) return TSLC;			-- moves all x-areas for 'zs' steps

  -------------------------------------------------------------------
  -- debug
  -------------------------------------------------------------------
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val :TIV; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0 :TI; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1 :TI; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2 :TI; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3 :TI; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI; idx :TL);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI; des5 :TS; val5 :TI);
  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val :TS);

  procedure DebugMsg(level :severity_level; msg :TS);
  procedure DebugMsg(level :severity_level; msg :TS; val :TIV; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0 :TI; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1 :TI; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2 :TI; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3 :TI; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI; idx :TL);
  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI; des5 :TS; val5 :TI);
  procedure DebugMsg(level :severity_level; msg :TS; val :TS);

end std_logic_1164_ktp;

package body std_logic_1164_ktp is

  constant \TNVconvSize\ :TN := 30;

  -------------------------------------------------------------------
  -- standard package extentions
  -------------------------------------------------------------------
  function minimum(a, b :TS) return TS is
  begin
    if (a<b) then
      return(a);
    else
      return(b);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function maximum(a, b :TS) return TS is
  begin
    if (a>b) then
      return(a);
    else
      return(b);
    end if;
  end function; 

  -------------------------------------------------------------------

  function sel(t, f :TS; c :TL) return TS is
  begin
    if (c=TRUE) then
      return(t);
    else
      return(f);
    end if;
  end function;  

  -------------------------------------------------------------------

  function  modulo(v, l, h :TI) return TI is
    variable len :TP;
    variable res :TI;
  begin
    res := v;
    len := h-l+1;
    if (v<l) then
      res := res-h;
      res := res+((-res)/len)*len+h;
    elsif (v>h) then
      res := res-l;
      res := res-(res/len)*len+l;
    end if;
    return(res);
  end function;  

   -------------------------------------------------------------------

  function  modulo(v, h :TP) return TI is
  begin
    return(modulo(v, 0, h));
  end function;  

 -------------------------------------------------------------------

  function  TNconv(arg :TL) return TN is
  begin
    if (arg=TRUE) then
      return(1);
    else
      return(0);
    end if;
  end function;  
 
  -------------------------------------------------------------------

  function  TLconv(arg :TI) return TL is
  begin
    if (arg=0) then
      return(FALSE);
    else
      return(TRUE);
    end if;
  end function;  
 
 
  function  "+" (l, r :TS) return TS is
    variable res :TS(1 to maximum(l'length+r'length,1));
  begin
    if(l'length+r'length=0) then
      return("");
    end if;
    if(l'length>0) then
      res(1 to l'length) := l;
    end if;
    if(r'length>0) then
      res(l'length+1 to res'length) := r;
    end if;
    return(res);
  end;
  

  -------------------------------------------------------------------
  -- std_logic_arith package extensions
  -------------------------------------------------------------------
  function minimum(a, b :TI) return TI is
  begin
    if (a<b) then
      return(a);
    else
      return(b);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function maximum(a, b :TI) return TI is
  begin
    if (a>b) then
      return(a);
    else
      return(b);
    end if;
  end function; 

  -------------------------------------------------------------------

  function sel(t, f :TI; c :TL) return TI is
  begin
    if (c=TRUE) then
      return(t);
    else
      return(f);
    end if;
  end function;  

  -------------------------------------------------------------------

  function minimum(v :TIV) return TI is
    variable var :TI;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)<var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function maximum(v :TIV) return TI is
    variable var :TI;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)>var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function minimum(v :TNV) return TN is
    variable var :TN;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)<var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function maximum(v :TNV) return TN is
    variable var :TN;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)>var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function minimum(v :TPV) return TP is
    variable var :TP;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)<var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function maximum(v :TPV) return TP is
    variable var :TP;
  begin
    var := v(v'left);
    if (v'length>1) then
      for index in v'range loop
        if (v(index)>var) then
          var := v(index);
        end if;
      end loop;
    end if;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function  pow2(v :TN) return TN is
  begin
    return (2 ** v);
  end function;

  -------------------------------------------------------------------

  function  rest(v,r :TN) return TN is
  begin
    return (v-r*(v/r));
  end function;

  -------------------------------------------------------------------

  function  div(v,r :TN) return TN is
    variable res :TN;
  begin
    res := v/r;
    if ((v-res*r)<((res+1)*r-v)) then
      return(res);
    end if;
    return (res+1);
  end function;

  -------------------------------------------------------------------
  -- vectors range family
  -------------------------------------------------------------------

  function TVRcreate(l, r :TVI) return TVR is
    variable vr :TVR;
  begin
    vr.l := l;
    vr.r := r;
    return(vr);
  end function;

  -------------------------------------------------------------------

  function TVRcreate(len :TVL) return TVR is
  begin
    return(TVRcreate(len-1,minimum(len-1,VEC_INDEX_MIN)));
  end function;

  -------------------------------------------------------------------

  function TVLcreate(l, r :TVI) return TVL is
  begin
    return(maximum(l,r)-minimum(l,r)+1);
  end function;

  -------------------------------------------------------------------

  function TVLcreate(par :TVR) return TVL is
  begin
    return(TVLcreate(par.l,par.r));
  end function;

  -------------------------------------------------------------------

  function minimum(v :TVLV) return TVL is
    variable var :TVL;
  begin
    var := v(v'left);
    for index in v'range loop
      if (v(index)<var) then
        var := v(index);
      end if;
    end loop;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function maximum(v :TVLV) return TVL is
    variable var :TVL;
  begin
    var := v(v'left);
    for index in v'range loop
      if (v(index)>var) then
        var := v(index);
      end if;
    end loop;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function minimum(v :TVIV) return TVI is
    variable var :TVI;
  begin
    var := v(v'left);
    for index in v'range loop
      if (v(index)<var) then
        var := v(index);
      end if;
    end loop;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function maximum(v :TVIV) return TVI is
    variable var :TVI;
  begin
    var := v(v'left);
    for index in v'range loop
      if (v(index)>var) then
        var := v(index);
      end if;
    end loop;
    return(var);
  end function; 

  -------------------------------------------------------------------

  function "**" (l, r :TVR) return TVR is
    variable vr :TVR;
    variable vmin, vmax :TVI;
  begin
    vmin := minimum(minimum(l.l,l.r),minimum(r.l,r.r));
    vmax := maximum(maximum(l.l,l.r),maximum(r.l,r.r));
    if ((l.l<l.r) and (r.l<r.r)) then
      vr.l := vmin;
      vr.r := vmax;
    else
      vr.l := vmax;
      vr.r := vmin;
    end if;
    return(vr);
  end function; 

  -------------------------------------------------------------------

  function TVRVconv(arg :TVR) return TVRV is
    variable vec :TVRV(VEC_INDEX_MIN to VEC_INDEX_MIN);
  begin
    vec(VEC_INDEX_MIN) := arg;
    return(vec);
  end function; 

  -------------------------------------------------------------------
			    
  function TVLcreate(arg :TVRV) return TVL is
  begin
    return(arg(arg'left).l-arg(arg'right).r+1);
  end function;

  -------------------------------------------------------------------
			    
  function "+" (l, r :TVRV) return TVRV is
    variable vec :TVRV(l'length+r'length-1 downto VEC_INDEX_MIN);
    variable base :TVI;
  begin
    vec(r'length-1 downto VEC_INDEX_MIN) := r;
    vec(vec'left downto r'length) := l;
    if (r(r'left).l>=r(r'right).r) then
      base := r(r'left).l+1;
      for index in vec'left downto r'length loop
        vec(index).l := vec(index).l + base;
        vec(index).r := vec(index).r + base;
      end loop;
    else
      base := l(r'right).r+1;
      for index in r'length-1 downto VEC_INDEX_MIN loop
        vec(index).l := vec(index).l + base;
        vec(index).r := vec(index).r + base;
      end loop;
    end if;
    return(vec);
  end function; 

  -------------------------------------------------------------------
			    
  function "+" (l, r :TVR) return TVRV is
  begin
    return(TVRVconv(l)+TVRVconv(r));
  end function; 

  -------------------------------------------------------------------

  function "+" (l :TVRV; r :TVR) return TVRV is
  begin
    return(l+TVRVconv(r));
  end function; 

  -------------------------------------------------------------------
			    
  function "+" (l :TVR; r :TVRV) return TVRV is
  begin
    return(TVRVconv(l)+r);
  end function; 
 

  -------------------------------------------------------------------
  -- TSL & TSLV family
  -------------------------------------------------------------------


  function TSLVhigh(v: TSLV) return TVI is
  begin
    return(v'high);
  end function;
  
  -------------------------------------------------------------------

  function TSLVlow(v: TSLV) return TVI is
  begin
    return(v'low);
  end function;
  
  -------------------------------------------------------------------
 
  function TSLVleft(v: TSLV) return TVI is
  begin
    return(v'left);
  end function;
  
  -------------------------------------------------------------------
 
  function TSLVright(v: TSLV) return TVI is
  begin
    return(v'right);
  end function;
  
  -------------------------------------------------------------------

  function TSLVlength(v: TSLV) return TVL is
  begin
    return(v'length);
  end function;
  
  -------------------------------------------------------------------

  function TSLconv(arg :TN) return TSL is
  begin
    if (arg = 0) then
      return('0');
    else
      return('1');
    end if;
  end function;
  
  -------------------------------------------------------------------

  function TSLconv(arg :TL) return TSL is
  begin
    if (arg = TRUE) then
      return('1');
    else
      return('0');
    end if;
  end function;
  
  -------------------------------------------------------------------

  function TSLconv(arg :TSLV) return TSL is
  begin
    return(arg(arg'low));
  end function;
  
  -------------------------------------------------------------------

  function TNconv(arg :TSL) return TN is
  begin
    if (arg = '0') then
      return(0);
    else
      return(1);
    end if;
  end function;
    
  -------------------------------------------------------------------

  function TLconv(arg :TSL) return TL is
  begin
    if (arg = '0') then
      return(FALSE);
    else
      return(TRUE);
    end if;
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TN; len :TVL) return TSLV is
    variable res :TSLV(len-1 downto 0);
  begin
    --res := (others => '0');
    --res := res + arg;
    --return(res);
    return(CONV_STD_LOGIC_VECTOR(arg,len));
    --return(TSLV(CONV_UNSIGNED(arg,len)));
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TN) return TSLV is
  begin
    return(TSLVconv(arg,TVLcreate(arg)));
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TL; len :TVL) return TSLV is
  begin
    return(TSLVconv(TSLconv(arg),len));
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TL) return TSLV is
  begin
    return(TSLVconv(arg,1));
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg:TSL; len :TVL) return TSLV is
    variable vec :TSLV(len-1 downto VEC_INDEX_MIN);
  begin
    vec := (others => '0');
    vec(VEC_INDEX_MIN) := arg;
    return(vec);
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg:TSL) return TSLV is 
  begin
    return(TSLVconv(arg,1));
  end function;  
  
  -------------------------------------------------------------------

  function TNconv(arg :TSLV) return TN is
  begin
    return(CONV_INTEGER(UNSIGNED(arg)));
  end function;  
  
  -------------------------------------------------------------------

  function TSLV2TN(arg :TSLV) return TN is
  begin
    return(TNconv(arg));
  end function;  
  
  -------------------------------------------------------------------

  function TNconv(arg :TSLV; l,h :TN) return TN is
  begin
    return(minimum(maximum(TNconv(arg),l),h));
  end function;  
  
  -------------------------------------------------------------------

  function TLconv(arg :TSLV) return TL is
  begin
    return(TLconv(OR_REDUCE(arg)));
  end function;  
  
  -------------------------------------------------------------------

  function  TNVconv(arg :TSLV; len :TP) return TNV is
    constant pos :TP := SLVPartNum(arg'length,len);
    variable res :TNV(0 to maximum(pos-1,1));
  begin
    res := (others =>0);
    for index in 0 to pos-1 loop
      res(index) := TNconv(SLVnorm(SLVPartGet(arg,len,index,'0')));
    end loop;
    return(res);
  end function;  
  
  -------------------------------------------------------------------

  function TNVconv(arg :TSLV) return TNV is
  begin
    return(TNVconv(arg,\TNVconvSize\));
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TNV; len :TP) return TSLV is
    variable res  :TSLV(arg'length*len-1 downto 0);
  begin
    res := (others =>'0');
    for index in 0 to arg'length-1 loop
      res := SLVPartPut(res,index,TSLVconv(arg(index),len));
    end loop;
    return(res);
  end function;  
  
  -------------------------------------------------------------------

  function TSLVconv(arg :TNV) return TSLV is
  begin
   return(TSLVconv(arg,\TNVconvSize\));
  end function;  
  -------------------------------------------------------------------

  function TSLVput(vec, dst, src :TSLV) return TSLV is
    variable vec_out :TSLV(vec'range);
  begin
    vec_out := vec;
--    for index in 0 to dst'length-1 loop
--      vec_out(dst'low+index):=src(src'low+index);
--    end loop;
    if (dst'length>1) then
      vec_out(dst'range):=src;
    else
      vec_out(dst'right):=TSLconv(src);
    end if;
	return (vec_out);
  end function;
  
  -------------------------------------------------------------------

  procedure TSLVputS(signal vec :inout TSLV; dst, src :TSLV) is
  begin
    if (dst'length>1) then
      vec(dst'range)<=src;
    else
      vec(dst'right)<=TSLconv(src);
    end if;
  end procedure;
  
  -------------------------------------------------------------------

  function TSLVput(vec, dst :TSLV; src :TSL) return TSLV is
    variable vec_out :TSLV(vec'range);
  begin
    vec_out := vec;
    vec_out(dst'right):=src;
    return(vec_out);
  end function;
  
  -------------------------------------------------------------------

  procedure TSLVputS(signal vec :inout TSLV; dst :TSLV; src :TSL) is
  begin
    vec(dst'right)<=src;
  end procedure;
  
  -------------------------------------------------------------------

  function TSLVput(dst, src :TSLV) return TSLV is
  begin
    return(TSLVput(dst,src,src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVputS(signal dst :inout TSLV; src :TSLV) is
  begin
    dst(src'range)<=src;
  end procedure;

  -------------------------------------------------------------------

  function TSLVput(dst :TSLV; l,r :TVI; src :TSLV) return TSLV is
  begin
    return(TSLVput(dst,TSLVnew(l,r),src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVputS(signal dst :inout TSLV; l,r :TVI; src :TSLV) is
  begin
    TSLVputS(dst,TSLVnew(l,r),src);
  end procedure;

  -------------------------------------------------------------------

  function TSLVput(dst :TSLV; b :TVI; src :TSLV) return TSLV is
  begin
    if (src'left<src'right) then
      return(TSLVput(dst,TSLVnew(b,b+src'length-1),src));
    else
      return(TSLVput(dst,TSLVnew(b+src'length-1,b),src));
    end if;
  end function;

  -------------------------------------------------------------------

  procedure TSLVputS(signal dst :inout TSLV; b :TVI; src :TSLV) is
  begin
    if (src'left<src'right) then
      TSLVputS(dst,TSLVnew(b,b+src'length-1),src);
    else
      TSLVputS(dst,TSLVnew(b+src'length-1,b),src);
    end if;
  end procedure;

  -------------------------------------------------------------------

  function TSLVor(vec, dst, src :TSLV) return TSLV is
    variable vec_out :TSLV(vec'range);
  begin
    vec_out := vec;
    if (dst'length>1) then
      vec_out(dst'range):=vec_out(dst'range) or src;
    else
      vec_out(dst'right):=vec_out(dst'right) or TSLconv(src);
    end if;
	return (vec_out);
  end function;
  
  -------------------------------------------------------------------

  procedure TSLVorS(signal vec :inout TSLV; dst, src :TSLV) is
  begin
    if (dst'length>1) then
      vec(dst'range)<=vec(dst'range) or src;
    else
      vec(dst'right)<=vec(dst'right) or TSLconv(src);
    end if;
  end procedure;
  
  -------------------------------------------------------------------

  function TSLVor(vec, dst :TSLV; src :TSL) return TSLV is
    variable vec_out :TSLV(vec'range);
  begin
    vec_out := vec;
    vec_out(dst'right):=vec_out(dst'right) or src;
    return(vec_out);
  end function;
  
  -------------------------------------------------------------------

  procedure TSLVorS(signal vec :inout TSLV; dst :TSLV; src :TSL) is
  begin
    vec(dst'right)<=vec(dst'right) or src;
  end procedure;
  
  -------------------------------------------------------------------

  function TSLVor(dst, src :TSLV) return TSLV is
  begin
    return(TSLVor(dst,src,src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVorS(signal dst :inout TSLV; src :TSLV) is
  begin
    dst(src'range)<=dst(src'range) or src;
  end procedure;

  -------------------------------------------------------------------

  function TSLVor(dst :TSLV; l,r :TVI; src :TSLV) return TSLV is
  begin
    return(TSLVor(dst,TSLVnew(l,r),src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVorS(signal dst :inout TSLV; l,r :TVI; src :TSLV) is
  begin
    TSLVorS(dst,TSLVnew(l,r),src);
  end procedure;

  -------------------------------------------------------------------

  function TSLVnew(l,r :TVI; f:TSL) return TSLV is
    variable hvec :TSLV(maximum(l,r) downto minimum(l,r));
    variable lvec :TSLV(minimum(l,r) to maximum(l,r));
  begin
    if (l>=r) then
      hvec := (others => f);
      return(hvec);
    else
      lvec := (others => f);
      return(lvec);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function TSLVnew(l,r :TVI; f:TSLV) return TSLV is
    variable hvec :TSLV(maximum(l,r) downto minimum(l,r));
    variable lvec :TSLV(minimum(l,r) to maximum(l,r));
    variable step  :TI;
    variable pos   :TI;
  begin
    if (f'left>=f'right) then
      step  :=1;
    else
      step  :=-1;
    end if;
    pos := f'right;
    if (l>=r) then
      for index in r to l loop 
        hvec(index) := f(pos);
	if (pos=f'left) then
	  pos := f'right;
	else
	  pos := pos + step;
	end if;
      end loop;
      return(hvec);
    else
      for index in r downto l loop 
        lvec(index) := f(pos);
	if (pos=f'left) then
	  pos := f'right;
	else
	  pos := pos + step;
	end if;
      end loop;
      return(lvec);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function TSLVnew(l,r :TVI) return TSLV is
  begin
    return(TSLVnew(l,r,'0'));
  end function;
  
  -------------------------------------------------------------------

  function TSLVnew(length :TVL; f:TSL) return TSLV is
  begin
    return(TSLVnew(length-1,VEC_INDEX_MIN,f));
  end function;
  
  -------------------------------------------------------------------

  function TSLVnew(length :TVL; f:TSLV) return TSLV is
  begin
    return(TSLVnew(length-1,VEC_INDEX_MIN,f));
  end function;
  
  -------------------------------------------------------------------

  function TSLVnew(length :TVL) return TSLV is
  begin
    return(TSLVnew(length-1,VEC_INDEX_MIN,'0'));
  end function;
  
  -------------------------------------------------------------------

  function TSLVfill(dst :TSLV; f :TSL) return TSLV is
    variable dst_out :TSLV(dst'range);
  begin
    dst_out := TSLVnew(dst'left,dst'right,f);
    return(dst_out);
  end function;

  -------------------------------------------------------------------

  function TSLVfill(dst :TSLV; f :TSLV) return TSLV is
    variable dst_out :TSLV(dst'range);
  begin
    dst_out := TSLVnew(dst'left,dst'right,f);
    return(dst_out);
  end function;
  
  -------------------------------------------------------------------

  function TSLVfill0(dst :TSLV) return TSLV is
  begin
    return(TSLVfill(dst,'0'));
  end function;

  
  -------------------------------------------------------------------

  function TSLVfill1(dst :TSLV) return TSLV is
  begin
    return(TSLVfill(dst,'1'));
  end function;

  -------------------------------------------------------------------

  procedure TSLVfillS(signal dst :inout TSLV; f :TSL) is
    variable dst_var :TSLV(dst'range);
  begin
    dst_var := TSLVnew(dst'left,dst'right,f);
    dst <= dst_var;
  end procedure;

  -------------------------------------------------------------------

  procedure TSLVfillS(signal dst :inout TSLV; f :TSLV) is
    variable dst_var :TSLV(dst'range);
  begin
    dst_var := TSLVnew(dst'left,dst'right,f);
    dst <= dst_var;
  end procedure;

  -------------------------------------------------------------------

  function  TSLVrightor(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '0';
    if (src'right>src'left) then
      for index in src'right downto src'left loop
        var := var or src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'right to src'left loop
        var := var or src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  TSLVleftor(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '0';
    if (src'left>src'right) then
      for index in src'left downto src'right loop
        var := var or src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'left to src'right loop
        var := var or src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVrightand(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '1';
    if (src'right>src'left) then
      for index in src'right downto src'left loop
        var := var and src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'right to src'left loop
        var := var and src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  TSLVleftand(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '1';
    if (src'left>src'right) then
      for index in src'left downto src'right loop
        var := var and src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'left to src'right loop
        var := var and src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  TSLVrightxor(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '0';
    if (src'right>src'left) then
      for index in src'right downto src'left loop
        var := var xor src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'right to src'left loop
        var := var xor src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  TSLVleftxor(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
    variable var :TSL;
  begin
    var := '0';
    if (src'left>src'right) then
      for index in src'left downto src'right loop
        var := var xor src(index);
        dst(index) := var;
      end loop;
    else
      for index in src'left to src'right loop
        var := var xor src(index);
        dst(index) := var;
      end loop;
    end if;
    return(dst);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVrev(src: TSLV) return TSLV is
    variable dst :TSLV(src'range);
  begin
    for index in 0 to src'length-1 loop
      dst(src'high-index) := src(src'low+index);
    end loop;
    return(dst);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVrot(src: TSLV; step :TI) return TSLV is
    variable dst :TSLV(src'range);
    variable pos :TI;
  begin
    for index in src'low to src'high loop
      pos := modulo(index+step,src'low,src'high);
      dst(pos) := src(index);
    end loop;
    return(dst);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh(src: TSLV; step :TI; f :TSL) return TSLV is
    variable dst :TSLV(src'range);
  begin
    dst := (others => f);
    if (step=0) then
      dst := src;
    elsif (step<0) then
      for index in src'high downto src'low-step loop
        dst(index+step) := src(index);
      end loop;
    else
      for index in src'low to src'high-step loop
        dst(index+step) := src(index);
      end loop;
    end if;
    return(dst);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh(src: TSLV; step :TI) return TSLV is
  begin
    return(TSLVsh(src,step,'0'));
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh2l(dst, src: TSLV) return TSLV is
    variable res :TSLV(dst'range);
  begin
    for index in dst'low to dst'high-src'length loop
      res(index) := dst(index+src'length);
    end loop;
    for index in 0 to src'length-1 loop
      res(dst'high-index) := src(src'high-index);
    end loop;
    return(res);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh2l(dst: TSLV; src: TSL) return TSLV is
  begin
    return(TSLVsh2l(dst,TSLVconv(src)));
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh2h(dst, src: TSLV) return TSLV is
    variable res :TSLV(dst'range);
  begin
    for index in dst'high-src'length downto dst'low loop
      res(index+src'length) := dst(index);
    end loop;
    for index in 0 to src'length-1 loop
      res(dst'low+index) := src(src'low+index);
    end loop;
    return(res);
  end function;
  
  -------------------------------------------------------------------

  function  TSLVsh2h(dst: TSLV; src: TSL) return TSLV is
  begin
    return(TSLVsh2h(dst,TSLVconv(src)));
  end function;
  
  -------------------------------------------------------------------

  function TVLcreate(arg :TN) return TVL is
    constant BIT_RANGE :TVL := 32;  -- arbitrary !!!
    variable sum :TVL;
  begin
    sum := 1;
    for index in 1 to BIT_RANGE loop
      sum := 2*sum;
      if (sum>arg) then
        return(index);
      end if;
    end loop;
    return(BIT_RANGE);
  end function;
  
  -------------------------------------------------------------------

  function SLVMax(arg :TN) return TN is
  begin
    return((2**TVLcreate(arg))-1);
  end function;
  
  -------------------------------------------------------------------

  function SLVBitCount(arg :TSLV; b :TSL) return TN is
    variable sum:TN;
  begin
    sum:=0;
    for index in arg'range loop
      if (arg(index)=b) then
        sum:=sum+1;
      end if;
    end loop;
    return(sum);
  end function;  
  
  -------------------------------------------------------------------

  function SLVBit0Count(arg :TSLV) return TN is
  begin
    return(SLVBitCount(arg,'0'));
  end function;  
  
  -------------------------------------------------------------------

  function SLVBit1Count(arg :TSLV) return TN is
  begin
    return(SLVBitCount(arg,'1'));
  end function;  

  -------------------------------------------------------------------

  function "**"(a, b :TSLV) return TSLV is
    function \_**_\(v, a, b :TSLV) return TSLV is
      variable vec :TSLV(v'range);
    begin
      vec := v;
      for index in a'range loop
        vec(index) := a(index);
      end loop;
      for index in b'range loop
        vec(index) := b(index);
      end loop;
      return(vec);
    end function;
  begin
    return(\_**_\(TSLVnew(TVRcreate(a) ** TVRcreate(b)),a,b));
  end function;  

  -------------------------------------------------------------------

  function "&"(a, b :TSLV) return TSLV is
    variable vec :TSLV(a'length+b'length-1 downto 0);
  begin
    vec(b'length-1 downto 0) := b;
    vec(vec'length-1 downto b'length) := a;
    return(vec);
  end function;  

  -------------------------------------------------------------------

  procedure TSLVsplitS(signal h,l :inout TSLV; src :TSLV) is
  begin
    l <= src(l'length-1 downto 0);
    h <= src(src'length-1 downto l'length);
  end procedure;  

  -------------------------------------------------------------------

  function minimum(a, b :TSLV) return TSLV is
  begin
    if (a<b) then
      return(a);
    else
      return(b);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function maximum(a, b :TSLV) return TSLV is
  begin
    if (a>b) then
      return(a);
    else
      return(b);
    end if;
  end function;
  
  -------------------------------------------------------------------

  function minimum(a :TSLV; b :TN) return TSLV is
  begin
    if (TNconv(a)<b) then
      return(a);
    else
      return(TSLVconv(b,a'length));
    end if;
  end function;
  
  -------------------------------------------------------------------

  function maximum(a :TSLV; b :TN) return TSLV is
  begin
    if (TNconv(a)>b) then
      return(a);
    else
      return(TSLVconv(b,a'length));
    end if;
  end function;
  
  -------------------------------------------------------------------

  function sel(t, f :TSL; c :TL) return TSL is
  begin
    if (c=TRUE) then
      return(t);
    else
      return(f);
    end if;
  end function;  

  -------------------------------------------------------------------

  function sel(t, f, c :TSL) return TSL is
  begin
    return(sel(t,f,c='1'));
  end function;  

  -------------------------------------------------------------------

  function sel(t, f :TSLV; c :TL) return TSLV is
  begin
    if (c=TRUE) then
      return(t);
    else
      return(f);
    end if;
  end function;  

  -------------------------------------------------------------------

  function sel(t :TSLV; f: TSL; c :TL) return TSLV is
  begin
    if (c=TRUE) then
      return(t);
    else
      return(TSLVnew(t'length,f));
    end if;
  end function;  

  -------------------------------------------------------------------

  function sel(t, f :TSLV; c :TSL) return TSLV is
  begin
    return(sel(t,f,c='1'));
  end function;  

  -------------------------------------------------------------------

  function sel(t :TSLV; f, c :TSL) return TSLV is
  begin
    return(sel(t,f,c='1'));
  end function;  

  -------------------------------------------------------------------

  function sel(t, f, c :TSLV) return TSLV is
    variable result :TSLV(c'range);
  begin
    for index in c'range loop
     result(index) := sel(t(index),f(index),c=(index));
    end loop;
    return(result);
  end function;  

  -------------------------------------------------------------------

  function TNconv(arg:TC) return TN is
  begin
    return(TC'pos(arg));
  end;

  function TCconv(constant arg:TN) return TC is
  type TTCtab is array(0 to 255) of  TC;
  constant CharTab :TTCtab :=(
		NUL,	SOH,	STX,	ETX,	EOT,	ENQ,	ACK,	BEL,
		BS,	HT,	LF,	VT,	FF,	CR,	SO,	SI,
		DLE,	DC1,	DC2,	DC3,	DC4,	NAK,	SYN,	ETB,
		CAN,	EM,	SUB,	ESC,	FSP,	GSP,	RSP,	USP,

		' ',	'!',	'"',	'#',	'$',	'%',	'&',	''',
		'(',	')',	'*',	'+',	',',	'-',	'.',	'/',
		'0',	'1',	'2',	'3',	'4',	'5',	'6',	'7',
		'8',	'9',	':',	';',	'<',	'=',	'>',	'?',

		'@',	'A',	'B',	'C',	'D',	'E',	'F',	'G',
		'H',	'I',	'J',	'K',	'L',	'M',	'N',	'O',
		'P',	'Q',	'R',	'S',	'T',	'U',	'V',	'W',
		'X',	'Y',	'Z',	'[',	'\',	']',	'^',	'_',

		'`',	'a',	'b',	'c',	'd',	'e',	'f',	'g',
		'h',	'i',	'j',	'k',	'l',	'm',	'n',	'o',
		'p',	'q',	'r',	's',	't',	'u',	'v',	'w',
		'x',	'y',	'z',	'{',	'|',	'}',	'~',	DEL,

	        C128,   C129,   C130,   C131,   C132,   C133,   C134,   C135,
	        C136,   C137,   C138,   C139,   C140,   C141,   C142,   C143,
	        C144,   C145,   C146,   C147,   C148,   C149,   C150,   C151,
	        C152,   C153,   C154,   C155,   C156,   C157,   C158,   C159,

		' ',   '¡',   '¢',   '£',   '¤',   '¥',   '¦',   '§',
	        '¨',   '©',   'ª',   '«',   '¬',   '­',   '®',   '¯',
	        '°',   '±',   '²',   '³',   '´',   'µ',   '¶',   '·',
	        '¸',   '¹',   'º',   '»',   '¼',   '½',   '¾',   '¿',
	        'À',   'Á',   'Â',   'Ã',   'Ä',   'Å',   'Æ',   'Ç',
	        'È',   'É',   'Ê',   'Ë',   'Ì',   'Í',   'Î',   'Ï',
	        'Ð',   'Ñ',   'Ò',   'Ó',   'Ô',   'Õ',   'Ö',   '×',
	        'Ø',   'Ù',   'Ú',   'Û',   'Ü',   'Ý',   'Þ',   'ß',
	        'à',   'á',   'â',   'ã',   'ä',   'å',   'æ',   'ç',
	        'è',   'é',   'ê',   'ë',   'ì',   'í',   'î',   'ï',
	        'ð',   'ñ',   'ò',   'ó',   'ô',   'õ',   'ö',   '÷',
	        'ø',   'ù',   'ú',   'û',   'ü',   'ý',   'þ',   'ÿ'    );
   begin
    return(CharTab(arg));
  end;

  -------------------------------------------------------------------

  function TSLVconv(arg:TC; len:TVL) return TSLV is
  begin
    return(TSLVconv(TNconv(arg),len));  
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:TC) return TSLV is
  begin
    return(TSLVconv(arg,8));  
  end function;

  -------------------------------------------------------------------

  function TNconv(arg:TS) return TN is
    constant tv :TVT := TVTcreate(arg'left, arg'right, arg'length-1, 0);	
    variable val :TN;
  begin
    val := 0;
    if (arg'length>0) then
      for index in arg'range loop
        val:=val+(256**(tv.a*index+tv.b))*TNconv(arg(index));
      end loop;
    end if;
    return(val);
  end function;

  -------------------------------------------------------------------

  function  TS2TN(arg:TS) return TN is
  begin
    return(TNconv(arg));
  end function;

  -------------------------------------------------------------------

  function  TSconv(arg:TSLV) return TS is
    constant low :TN := arg'low;
    variable res :TS(1 to arg'length);
  begin
    res := (others => '0');
    for i in arg'range loop
      if (arg(i)='1') then
        res(i-low+1) := '1';
      end if;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSconv(arg:TI; len :TVL; fdec:TL) return TS is
    function DecConv(arg:TI) return TS is
      variable res    :TS(10 downto 1);
      variable base   :TN := 1000000000;
      variable valloc :TN;
      variable valdig :TN;
      variable fpos   :TN;
    begin
      valloc := abs(arg);
      fpos   := 10;
      for index in 10 downto 1 loop
        valdig := valloc/base;
        valloc := valloc - base*valdig;
        base := base/10;
        res(index) := TCconv(48+valdig);
        if (valdig=0 and fpos=index and index/=1) then
          fpos:=index-1;
        end if;
      end loop;
      if (arg>=0) then
        return(res(fpos downto 1));
      end if;
      return("-"+res(fpos downto 1));      
    end function;
    function BinConv(arg:TN) return TS is
      variable varg :TN;
      variable vpow :TN;
      variable vhex :TN;
      variable res :TS(4 downto 1);
    begin
      vpow := 256**3;
      varg := arg;
      for index in 4 downto 1 loop
        vhex       := varg/vpow;
        res(index) := TCconv(vhex);
        varg       := varg - vpow*vhex;
        vpow       := vpow/256;
      end loop;
      return(res);
    end function;
  begin
    if (fdec=TRUE) then
      if (len=0) then
        return(DecConv(arg));
      else
        return(DecConv(arg)(len downto 1));
      end if;
    else
      if (len=0) then
        return(BinConv(arg));
      else
        return(BinConv(arg)(len downto 1));
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSconv(arg:TI; len :TVL) return TS is
  begin
    return(TSconv(arg,len,FALSE));
  end function;
  -------------------------------------------------------------------

  function TSLVconv(arg:TS) return TSLV is
    constant tv :TVT := TVTcreate(arg'left,arg'right,arg'length-1,VEC_INDEX_MIN);
    variable val :TSLV((arg'length*8)-1 downto VEC_INDEX_MIN);
    variable pos :TVI;
  begin
    for index in arg'range loop
      pos := 8*(tv.a*index+tv.b);
      val(pos+7 downto pos) := TSLVconv(TNconv(arg(index)),8);
    end loop;
    return(val);  
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:TS; len :TVL) return TSLV is
  begin
    return(TSLVResize(TSLVconv(arg),len));
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:TS; dst :TSLV) return TSLV is
  begin
    return(TSLVconv(arg,dst'length));
  end function;


  -------------------------------------------------------------------
  -- vectors translate family
  -------------------------------------------------------------------

  function TVTcreate(sl, sr, dl, dr :TVI) return TVT is
    variable tv :TVT;
  begin
    tv := (0,0);
    if (abs(sl-sr)=abs(dl-dr)) then
      if(dl/=dr) then
        tv.a := (dl-dr)/(sl-sr);
        tv.b := dl-(tv.a*sl);
      else
	tv := (0,dl);
      end if;
    end if;
    return(tv);
  end function;

  -------------------------------------------------------------------

  function VTindex(vt :TVT; index :TVI) return TVI is
  begin
    return(vt.a*index+vt.b);
  end function;
    
  -------------------------------------------------------------------

  function VTindex(sl, sr, dl, dr, index :TVI) return TVI is
    constant vt :TVT := TVTcreate(sl,sr,dl,dr);
  begin
    return(VTindex(vt,index));
  end function;


  -------------------------------------------------------------------
  -- vectors translate family for SLV
  -------------------------------------------------------------------

  function TVTcreate(src :TSLV; dl, dr :TVI) return TVT is
  begin
    return(TVTcreate(src'left,src'right,dl,dr));
  end function;

  -------------------------------------------------------------------

  function TVTcreate(src, dst :TSLV) return TVT is
  begin
    return(TVTcreate(src'left,src'right,dst'left,dst'right));
  end function;

  -------------------------------------------------------------------

  function VTnorm(src :TSLV) return TVT is
  begin
    return(TVTcreate(src'left,src'right,src'length-1,VEC_INDEX_MIN));
  end function;

  -------------------------------------------------------------------

  function VTrevNorm(src :TSLV) return TVT is
  begin
    return(TVTcreate(src'left,src'right,VEC_INDEX_MIN,src'length-1));
  end function;

  -------------------------------------------------------------------

  function TSLVtrans(src, dst :TSLV) return TSLV is
    constant tv :TVT := TVTcreate(src,dst);
    variable vec :TSLV(dst'range);
  begin
    if(tv.a=1) then
      vec:=src;
    else
      for index in src'range loop
        vec(VTindex(tv,index)):=src(index);
      end loop;
    end if;
    return(vec);
  end function;

  -------------------------------------------------------------------

  function SLVNorm(src :TSLV) return TSLV is
    variable dst :TSLV(src'length-1 downto VEC_INDEX_MIN);
  begin
    dst := (others =>'0');
    return(TSLVtrans(src,dst));
  end function;

  -------------------------------------------------------------------

  function SLVrevNorm(src :TSLV) return TSLV is
    variable dst :TSLV(VEC_INDEX_MIN to src'length-1);
  begin
    dst := (others =>'0');
    return(TSLVtrans(src,dst));
  end function;

  -------------------------------------------------------------------

  function SLVrevRange(src :TSLV) return TSLV is
    variable dst :TSLV(src'reverse_range);
  begin
    dst := (others =>'0');
    return(TSLVtrans(src,dst));
  end function;


  -------------------------------------------------------------------
  -- vectors cut family for TSLV
  -------------------------------------------------------------------

  function TSLVCut(src :TSLV; l,r :TVI) return TSLV is
  begin
    if (l>=r or (l=r and src'left>src'right)) then
      return(src(l downto r));
    else
      return(src(l to r));
    end if;
  end function;

  -------------------------------------------------------------------

  function TSLVCut(src :TSLV; len :TVL) return TSLV is
  begin
    return(TSLVCut(src,len-1,VEC_INDEX_MIN));
  end function;

  -------------------------------------------------------------------

  function TSLVCutPos(src :TSLV; pos :TVI; len :TVL) return TSLV is
  begin
    return(TSLVCut(src,pos+len-1,pos));
  end function;

  -------------------------------------------------------------------

  function TSLVCut(src, dst :TSLV) return TSLV is
  begin
    return(TSLVCut(src,dst'left,dst'right));
  end function;


  -------------------------------------------------------------------
  -- vectors extract family for TSLV
  -------------------------------------------------------------------

  function TSLVExtract(src :TSLV; l,r :TVI) return TSLV is
    variable srcrev :TSLV(src'reverse_range);
  begin
    srcrev := SLVrevRange(src);
    if(src'left>src'right) then
      if (l>r) then
        return(src(l downto r));
      else
        return(srcrev(l to r));
      end if;
    else
      if (l>r) then
        return(srcrev(l downto r));
      else
        return(src(l to r));
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function TSLVExtract(src :TSLV; len :TVL) return TSLV is
  begin
    return(TSLVExtract(src,len-1,VEC_INDEX_MIN));
  end function;

  -------------------------------------------------------------------

  function TSLVExtract(src, dst :TSLV) return TSLV is
  begin
    return(TSLVExtract(src,dst'left,dst'right));
  end function;


  -------------------------------------------------------------------
  -- vectors resize family for TSLV
  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; l,r :TVI; f :TSL) return TSLV is
    function \_TSLVResize_\(v, src :TSLV) return TSLV is
      variable vec :TSLV(v'range);
    begin
      vec := v;
      for index in vec'range loop
        if ((index>=src'low) and (index<=src'high)) then
          vec(index) := src(index);
        end if;
      end loop;
      return(vec);
    end function;
  begin
    return(\_TSLVResize_\(TSLVnew(l,r,f),src));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; l,r :TVI) return TSLV is
  begin
    return(TSLVResize(src,l,r,'0'));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; len :TVL; f :TSL) return TSLV is
  begin
    return(TSLVResize(src,len-1,VEC_INDEX_MIN,f));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; len :TVL) return TSLV is
  begin
    return(TSLVResize(src,len,'0'));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src, dst :TSLV; f :TSL) return TSLV is
  begin
    return(TSLVResize(src,dst'left,dst'right,f));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src, dst:TSLV) return TSLV is
  begin
    return(TSLVResize(src,dst'left,dst'right,'0'));
  end function;

  -------------------------------------------------------------------

  function  TSLVResizeMin(src :TSLV; min :TVL; f :TSL) return TSLV is
    constant l :TVI := src'left+sel(0,maximum(min-src'length,0),src'left< src'right);
    constant r :TVI := src'right+sel(maximum(min-src'length,0),0,src'left< src'right);
  begin
    return(TSLVResize(src,l,r,f));
  end function;

  -------------------------------------------------------------------

  function  TSLVResizeMin(src :TSLV; min :TVL) return TSLV is
  begin
    return(TSLVResizeMin(src,min,'0'));
  end function;

  -------------------------------------------------------------------

  function  TSLVResizeMax(src :TSLV; max :TVL; f :TSL) return TSLV is
    constant l :TVI := src'left+sel(0,minimum(max-src'length,0),src'left< src'right);
    constant r :TVI := src'right+sel(minimum(max-src'length,0),0,src'left< src'right);
  begin
    return(TSLVResize(src,l,r,f));
  end function;

  -------------------------------------------------------------------

  function  TSLVResizeMax(src :TSLV; max :TVL) return TSLV is
  begin
    return(TSLVResizeMax(src,max,'0'));
  end function;

  -------------------------------------------------------------------
  -- HEX type family
  -------------------------------------------------------------------

  function TNconv(arg:TH) return TN is
    variable res :TN;
  begin
    res := TH'pos(arg);
    return(res);
  end function;
  
  -------------------------------------------------------------------

  function THconv(arg:TN) return TH is
    type     TTHtab is array(0 to 15) of TH;
    constant THtab :TTHtab := (
	      '0', '1', '2', '3', '4', '5', '6', '7',
              '8', '9',	'A', 'B', 'C', 'D', 'E', 'F'
	    );
  begin
    return(THtab(arg));
  end function;
  
  -------------------------------------------------------------------
  function TSLVconv(arg:TH; len:TVL) return TSLV is
    variable res :TN;
  begin
    res := TNconv(arg);  
    return(TSLVconv(res,len));  
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:TH) return TSLV is
  begin
    return(TSLVconv(arg,4));  
  end function;

  -------------------------------------------------------------------

  function TNconv(arg:THV) return TN is
    constant tv :TVT := TVTcreate(arg'left, arg'right, arg'length-1, 0);	
    variable val :TN;
  begin
    val := 0;
    for index in arg'range loop
      val:=val+(16**(tv.a*index+tv.b))*TNconv(arg(index));
    end loop;
    return(val);
  end function;

  -------------------------------------------------------------------

  function  THV2TN(arg:THV) return TN is
  begin
    return(TNconv(arg));
  end function;

  -------------------------------------------------------------------

  function  THVconv(arg:TN; len :TVL) return THV is
    variable varg :TN;
    variable vpow :TN;
    variable vhex :TN;
    variable res :THV(7 downto 0);
  begin
    vpow := 16**7;
    varg := arg;
    for index in 7 downto 0 loop
      vhex       := varg/vpow;
      res(index) := THconv(vhex);
      varg       := varg - vpow*vhex;
      vpow       := vpow/16;
    end loop;
    return(res(len-1 downto 0));
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:THV) return TSLV is
    constant tv :TVT :=TVTcreate(arg'left,arg'right,arg'length-1,VEC_INDEX_MIN);
    variable val :TSLV((arg'length*4)-1 downto VEC_INDEX_MIN);
    variable pos :TVI;
  begin
    for index in arg'range loop
      pos := 4*(tv.a*index+tv.b);
      val(pos+3 downto pos) := TSLVconv(arg(index));
    end loop;
    return(val);  
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:THV; len :TVL) return TSLV is
  begin
    return(TSLVResize(TSLVconv(arg),len));
  end function;

  -------------------------------------------------------------------

  function THV2TSLV(arg:THV; len :TVL) return TSLV is
  begin
    return(TSLVconv(arg,len));
  end function;

  -------------------------------------------------------------------

  function TSLVconv(arg:THV; dst :TSLV) return TSLV is
  begin
    return(TSLVconv(arg,dst'length));
  end function;

  -------------------------------------------------------------------

  function  "&"(a, b :THV) return THV is
    variable vec :THV(a'length+b'length-1 downto 0);
  begin
    vec(b'length-1 downto 0) := b;
    vec(vec'length-1 downto b'length) := a;
    return(vec);
  end function;

  -------------------------------------------------------------------
  -- BYTE type family
  -------------------------------------------------------------------

  function TBconv (arg :TN) return TB is
  begin
    return (TSLVconv(arg,8));
  end;
  
  function TS2TBV (arg :TS) return TBV is
    variable res :TBV(0 to arg'length-1);
    variable cnt :TN;
  begin
    cnt := 0;
    for index in arg'range loop
      res(cnt) := TBconv(TNconv(arg(index)));
      cnt := cnt + 1;
    end loop;
    return (res);
  end;
  
  function TBV2TS (arg :TBV) return TS is
    variable res :TS(1 to arg'length);
  begin
    for index in arg'range loop
      res(index+1) := TCconv(TNconv(arg(index)));
    end loop;
    return (res);
  end;

  function THV2TBV (arg :THV) return TBV is
    variable res :TBV(0 to arg'length/2-1);
  begin
    for index in res'range loop
      res(index) := TBconv(TNconv(arg(arg'low+2*index to arg'low+2*index+1)));
    end loop;
    return (res);
  end;

  function TBV2THV (arg :TBV) return THV is
    variable res :THV(0 to arg'length*2-1);
  begin
    for index in arg'range loop
      res(2*index)   := THconv(TNconv(arg(index)(7 downto 4)));
      res(2*index+1) := THconv(TNconv(arg(index)(3 downto 0)));
    end loop;
    return (res);
  end;

  function  TNconv(arg:TBV) return TN is
    constant tv :TVT := TVTcreate(arg'left, arg'right, arg'length-1, 0);	
    variable val :TN;
  begin
    val := 0;
    for index in arg'range loop
      val:=val+(256**(tv.a*index+tv.b))*TNconv(arg(index));
    end loop;
    return(val);
  end function;

  -------------------------------------------------------------------
  -- vectors range family for TSLV
  -------------------------------------------------------------------

  function TVRcreate(src:TSLV) return TVR is
  begin
    return(TVRcreate(src'left, src'right));
  end function;

  -------------------------------------------------------------------

  function TSLVnew(par :TVR; f :TSL) return TSLV is
  begin
    return(TSLVnew(par.l,par.r,f));
  end function;

  -------------------------------------------------------------------

  function TSLVnew(par :TVR; f :TSLV) return TSLV is
  begin
    return(TSLVnew(par.l,par.r,f));
  end function;

  -------------------------------------------------------------------

  function TSLVnew(par :TVR) return TSLV is
  begin
    return(TSLVnew(par.l,par.r));
  end function;

  -------------------------------------------------------------------

  function TSLVCut(src :TSLV; par :TVR) return TSLV is
  begin
    return(TSLVCut(src,par.l,par.r));
  end function;

  -------------------------------------------------------------------

  function TSLVExtract(src :TSLV; par :TVR) return TSLV is
  begin
    return(TSLVExtract(src,par.l,par.r));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; par :TVR; f :TSL) return TSLV is
  begin
    return(TSLVResize(src,par.l,par.r,f));
  end function;

  -------------------------------------------------------------------

  function TSLVResize(src :TSLV; par :TVR) return TSLV is
  begin
    return(TSLVResize(src,par.l,par.r));
  end function;

  -------------------------------------------------------------------

  function TSLconv(src:TSLV; vr :TVR) return TSL is
  begin
    return(TSLconv(TSLVresize(src,vr)));
  end function;
  
  -------------------------------------------------------------------

  function TSLVcut(src :TSL; vr :TVR) return TSLV is
  begin
    return(TSLVCut(TSLVconv(src),vr.l,vr.r));
  end function;

  -------------------------------------------------------------------

  function TSLVextract(src :TSL; vr :TVR) return TSLV is
  begin
    return(TSLVExtract(TSLVconv(src),vr.l,vr.r));
  end function;

  -------------------------------------------------------------------

  function TSLVresize(src :TSL; vr :TVR) return TSLV is
  begin
    return(TSLVResize(TSLVconv(src),vr.l,vr.r));
  end function;

  -------------------------------------------------------------------

  function TSLVcut(src :TSLV; vt : TVT; vr :TVR) return TSLV is
  begin
    return(TSLVCut(src,VTindex(vt,vr.l),VTindex(vt,vr.r)));
  end function;

  -------------------------------------------------------------------

  function TSLVextract(src :TSLV; vt : TVT; vr :TVR) return TSLV is
  begin
    return(TSLVExtract(src,VTindex(vt,vr.l),VTindex(vt,vr.r)));
  end function;

  -------------------------------------------------------------------

  function TSLVresize(src :TSLV; vt : TVT; vr :TVR) return TSLV is
  begin
    return(TSLVResize(src,VTindex(vt,vr.l),VTindex(vt,vr.r)));
  end function;

  -------------------------------------------------------------------

  function TSLconv(src:TSLV; vt : TVT; vr :TVR) return TSL is
  begin
    return(TSLconv(TSLVResize(src,vt,vr)));
  end function;
  
  -------------------------------------------------------------------

  function TSLVresize(src :TSL; vt : TVT; vr :TVR) return TSLV is
  begin
    return(TSLVresize(TSLVconv(src),vt,vr));
  end function;


  -------------------------------------------------------------------

  function TSLVtrans(src :TSLV; par :TVR) return TSLV is
  begin
    return(TSLVtrans(src,TSLVnew(par)));
  end function;

  -------------------------------------------------------------------

  function TSLVtrans(src :TSL; par :TVR) return TSLV is
  begin
    return(TSLVtrans(TSLVconv(src),TSLVnew(par)));
  end function;

  -------------------------------------------------------------------

  function TSLVput(dst :TSLV; par :TVR; src :TSLV)  return TSLV is
  begin
    return(TSLVput(dst,TSLVCut(dst,par),src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVputS(signal dst :inout TSLV; par :TVR; src :TSLV) is
  begin
    TSLVputS(dst,TSLVCut(dst,par),src);
  end procedure;

  -------------------------------------------------------------------

  function TSLVput(dst :TSLV; par :TVR; src :TSL)  return TSLV is
  begin
    return(TSLVput(dst,par,TSLVconv(src)));
  end function;

  -------------------------------------------------------------------

  procedure TSLVputS(signal dst :inout TSLV; par :TVR; src :TSL) is
  begin
    TSLVputS(dst,TSLVResize(dst,par),TSLVconv(src));
  end procedure;

  -------------------------------------------------------------------

  function TSLVor(dst :TSLV; par :TVR; src :TSLV)  return TSLV is
  begin
    return(TSLVor(dst,TSLVCut(dst,par),src));
  end function;

  -------------------------------------------------------------------

  procedure TSLVorS(signal dst :inout TSLV; par :TVR; src :TSLV) is
  begin
    TSLVorS(dst,TSLVCut(dst,par),src);
  end procedure;

  -------------------------------------------------------------------

  function TSLVor(dst :TSLV; par :TVR; src :TSL)  return TSLV is
  begin
    return(TSLVor(dst,par,TSLVconv(src)));
  end function;

  -------------------------------------------------------------------

  procedure TSLVorS(signal dst :inout TSLV; par :TVR; src :TSL) is
  begin
    TSLVorS(dst,TSLVResize(dst,par),TSLVconv(src));
  end procedure;

  -------------------------------------------------------------------
  -- vectors partitioning
  -------------------------------------------------------------------

  function SLVPartNum(vlen, plen :TVL) return TP is
  begin
    return(((vlen-1)/plen)+1);
  end function;

  -------------------------------------------------------------------

  function SLVPartNum(v :TSLV; plen :TVL) return TP is
  begin
    return(SLVPartNum(v'length,plen));
  end function;

  -------------------------------------------------------------------

  function SLVPartSize(vlen, plen :TVL; index :TVI) return TVL is
    variable num :TP;
  begin
    num := SLVPartNum(vlen,plen);
    if (index<num-1) then
      return(plen);
    end if;
    return(vlen-(num-1)*plen);
  end function;

  -------------------------------------------------------------------

  function SLVPartSize(v :TSLV; plen :TVL; index :TVI) return TVL is
  begin
    return(SLVPartSize(v'length,plen,index));
  end function;

  -------------------------------------------------------------------

  function SLVPartSize(v :TSLV; plen :TVL; vi :TSLV) return TVL is
  begin
    return(SLVPartSize(v'length,plen,TNconv(vi)));
  end function;

  -------------------------------------------------------------------

  function SLVPartLastSize(vlen, plen :TVL) return TVL is
  begin
    return(SLVPartSize(vlen,plen,SLVPartNum(vlen,plen)-1));
  end function;

  -------------------------------------------------------------------

  function SLVPartLastSize(v :TSLV; plen :TVL) return TVL is
  begin
    return(SLVPartLastSize(v'length,plen));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; index :TN) return TSLV is
    variable vt :TVT;
    variable vr :TVR;
  begin
    vt := TVTcreate(v,v'length-1,0);
    vr.r := index*plen;
    vr.l := vr.r + SLVPartSize(v,plen,index)-1;
    return(TSLVCut(v,vt,vr));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; index, il, ih :TN) return TSLV is
  begin
    for pos in il to ih loop
      if (index=pos) then
        return(SLVPartGet(v,plen,pos));
      end if;
    end loop;
    if(index>ih) then
      return(SLVPartGet(v,plen,ih));
    end if;
    return(SLVPartGet(v,plen,il));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; index :TN; f :TSL) return TSLV is
    constant PART_NUM :TN := SLVPartNum(v'length,plen);
  begin
    return(TSLVresizeMin(SLVNorm(SLVPartGet(TSLVresizeMin(v,plen,f),plen,index)),plen,f));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; index, il, ih :TN; f :TSL) return TSLV is
  begin
    for pos in il to ih loop
      if (index=pos) then
        return(SLVPartGet(v,plen,pos,f));
      end if;
    end loop;
    if(index>ih) then
      return(SLVPartGet(v,plen,ih,f));
    end if;
    return(SLVPartGet(v,plen,il,f));
  end function;

  -------------------------------------------------------------------

  function  SLVPartGet(v :TSLV; plen :TVL; il, ih :TN) return TSLV is
    variable vt :TVT;
    variable vr :TVR;
  begin
    vt := TVTcreate(v,v'length-1,0);
    vr.r := il*plen;
    vr.l := vr.r + (ih-il)*plen + SLVPartSize(v,plen,ih)-1;
    return(TSLVCut(v,vt,vr));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; il, ih :TN) return TSLV is
    variable indexval :TVI;
  begin
    indexval := TNconv(vi);
    if(indexval<il) then
      return(SLVPartGet(v,plen,il));
    elsif(indexval>ih) then
      return(SLVPartGet(v,plen,ih));
    else
      for index in il to ih loop
        if (index=indexval) then
          return(SLVPartGet(v,plen,index));
        end if;
      end loop;
    end if;
    return(SLVPartGet(v,plen,ih));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; ih :TN) return TSLV is
  begin
    return(SLVPartGet(v,plen,vi,0,ih));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV) return TSLV is
  begin
    return(SLVPartGet(v,plen,vi,0,SLVMax(vi'length)));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; il, ih :TN; f :TSL) return TSLV is
  begin
    return(TSLVResize(SLVNorm(SLVPartGet(v,plen,vi,il,ih)),plen,f));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; ih :TN; f :TSL) return TSLV is
  begin
    return(TSLVResize(SLVNorm(SLVPartGet(v,plen,vi,0,ih)),plen,f));
  end function;

  -------------------------------------------------------------------

  function SLVPartGet(v :TSLV; plen :TVL; vi :TSLV; f :TSL) return TSLV is
  begin
    return(TSLVResize(SLVNorm(SLVPartGet(v,plen,vi)),plen,f));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; index :TVI; src :TSLV) return TSLV is
    variable vr :TVR;
  begin
    vr.r := index*plen;
    vr.l := vr.r + SLVPartSize(v,plen,index)-1;
    return(TSLVPut(v,vr,src));
  end function;

   -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; index :TVI; il, ih :TN; src :TSLV) return TSLV is
    variable vr :TVR;
  begin
    for pos in il to ih loop
      if (index=pos) then
        return(SLVPartPut(v,plen,pos,src));
      end if;
    end loop;
    if(index>ih) then
      return(SLVPartPut(v,plen,ih,src));
    end if;
    return(SLVPartPut(v,plen,il,src));
  end function;

 -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; index :TVI; src :TSLV) return TSLV is
  begin
    return(SLVPartPut(v,src'length,index,src));
  end function;

 -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; index :TVI; il, ih :TN; src :TSLV) return TSLV is
  begin
    return(SLVPartPut(v,src'length,index,il,ih,src));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; index :TVI; src :TSLV; f :TSL) return TSLV is
  begin
    return(SLVPartPut(v,plen,index,SLVNorm(TSLVResize(src,plen,f))));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; il, ih :TN) return TSLV is
    variable indexval :TVI;
  begin
    indexval := TNconv(vi);
    for index in il to ih loop
      if (index=indexval) then
        return(SLVPartPut(v,plen,index,src));
      end if;
    end loop;
    return(v);
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; ih :TN) return TSLV is
  begin
    return(SLVPartPut(v,plen,vi,src,0,ih));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV) return TSLV is
  begin
    return(SLVPartPut(v,plen,vi,src,0,SLVMax(vi'length)));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; il, ih :TN; f :TSL) return TSLV is
  begin
    return(SLVPartPut(v,plen,vi,SLVNorm(TSLVResize(src,plen,f)),il,ih));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; ih :TN; f :TSL) return TSLV is
  begin
    return(SLVPartPut(v,plen,vi,src,0,ih,f));
  end function;

  -------------------------------------------------------------------

  function SLVPartPut(v :TSLV; plen :TVL; vi, src :TSLV; f :TSL) return TSLV is
  begin
    return(SLVPartPut(v,plen,vi,src,0,SLVMax(vi'length),f));
  end function;

  -------------------------------------------------------------------

  function SLVPartOR(v :TSLV; plen :TVL; f :TSL) return TSLV is
    variable res :TSLV(plen-1 downto 0);
    variable num :TN := SLVPartNum(v,plen);
  begin
    res := (others => '0');
    for index in 0 to num-1 loop
      res := res or SLVPartGet(v,plen,index,f);
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function SLVPartOR(v :TSLV; plen :TVL) return TSLV is
  begin
    return(SLVPartOR(v, plen, '1'));
  end function;

  -------------------------------------------------------------------

  function SLVPartAND(v :TSLV; plen :TVL; f :TSL) return TSLV is
    variable res :TSLV(plen-1 downto 0);
    variable num :TN := SLVPartNum(v,plen);
  begin
    res := (others => '0');
    for index in 0 to num-1 loop
      res := res and SLVPartGet(v,plen,index,f);
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function SLVPartAND(v :TSLV; plen :TVL) return TSLV is
  begin
    return(SLVPartOR(v, plen, '0'));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixs,ixd :TVI) return TSLV is
  begin
    return(SLVPartPut(vd,plen,ixd,SLVPartGet(vs,plen,ixs)));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(v :TSLV; plen :TVL; ixs,ixd :TVI) return TSLV is
  begin
    return(SLVPartCopy(v,v,plen,ixs,ixd));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixs,ixd :TVI; f :TSL) return TSLV is
  begin
    return(SLVPartPut(vd,plen,ixd,SLVPartGet(vs,plen,ixs),f));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(v :TSLV; plen :TVL; ixs,ixd :TVI; f :TSL) return TSLV is
  begin
    return(SLVPartCopy(v,plen,ixs,ixd,f));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(vs,vd :TSLV; plen :TVL; ixls,ixhs,ixld :TVI) return TSLV is
    variable res :TSLV(vd'range);
  begin
    res := vd;
    if (ixld>ixls) then
      for index in ixhs downto ixhs loop
        res := SLVPartPut(res,plen,index-ixls+ixld,SLVPartGet(vs,plen,index));
      end loop;
    elsif (ixld<ixls) then
      for index in ixls to ixhs loop
        res := SLVPartPut(res,plen,index-ixls+ixld,SLVPartGet(vs,plen,index));
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopy(v :TSLV; plen :TVL; ixls,ixhs,ixld :TVI) return TSLV is
  begin
    return(SLVPartCopy(v,v,plen,ixls,ixhs,ixld));
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopyRep(vs,vd :TSLV; plen :TVL; ixls,ixhs,ixld :TVI; step,cnt:TVL) return TSLV is
    variable res :TSLV(vd'range);
  begin
    res := vd;
    for index in 0 to cnt-1 loop
      res := SLVPartCopy(vs,res,plen,ixls+index*step,ixhs+index*step,ixld+index*step);
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  SLVPartCopyRep(v :TSLV; plen :TVL; ixls,ixhs,ixld :TVI; step,cnt:TVL) return TSLV is
  begin
    return(SLVPartCopyRep(v,v,plen,ixls,ixhs,ixld,step,cnt));
  end function;

  -------------------------------------------------------------------

  function SLVPartAddrExpand(vlen, plen :TVL) return TN is
    variable num :TP;
  begin
    num := SLVPartNum(vlen,plen);
    if (num=1) then
      return(0);
    end if;
    return(TVLcreate(num-1));
  end function;

  -------------------------------------------------------------------

  function SLVPartAddrExpand(v :TSLV; plen :TVL) return TN is
  begin
    return(SLVPartAddrExpand(v'length,plen));
  end function;


  -------------------------------------------------------------------
  -- vectors structuring
  -------------------------------------------------------------------
  function  SLVStructPosLow(s :TVLV; i :TVI) return TVI is
    variable Pos :TVI;
  begin
    Pos := VEC_INDEX_MIN;
    for index in s'range loop
      if (index=i) then
        return(Pos);
      end if;
      Pos := Pos + s(index);
    end loop;
    return(NO_VEC_INDEX);
  end function;

  -------------------------------------------------------------------

  function  SLVStructPosHigh(s :TVLV; i :TVI) return TVI is
  begin
    return(SLVStructPosLow(s,i)+s(i)-1);
  end function;

  -------------------------------------------------------------------

  function  SLVStructLen(s :TVLV) return TVL is
  begin
    return(SLVStructPosHigh(s,s'right)+1);
  end function;

  -------------------------------------------------------------------

  function  SLVStructCreate(s :TVLV) return TSLV is
  begin
    return(TSLVnew(SLVStructLen(s)));
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TSLV) return TSLV is
    constant VLow  :TVI := SLVStructPosLow(s,i);
    constant VHigh :TVI := SLVStructPosHigh(s,i);
    variable Vec   :TSLV(v'range);
  begin
    Vec := v;
    vec(VHigh downto VLow) := d;
    return(Vec);
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TSL) return TSLV is
  begin
    return(SLVStructPut(v,s,i,TSLVconv(d)));
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(v :TSLV; s :TVLV; i :TVI; d :TN) return TSLV is
  begin
    return(SLVStructPut(v,s,i,TSLVconv(d,s(i))));
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(s :TVLV; i :TVI; d :TSLV) return TSLV is
  begin
    return(SLVStructPut(SLVStructCreate(s),s,i,d));
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(s :TVLV; i :TVI; d :TSL) return TSLV is
  begin
    return(SLVStructPut(s,i,TSLVconv(d)));
  end function;

  -------------------------------------------------------------------

  function  SLVStructPut(s :TVLV; i :TVI; d :TN) return TSLV is
  begin
    return(SLVStructPut(s,i,TSLVconv(d,s(i))));
  end function;

  -------------------------------------------------------------------

  function  SLVStructGet(v :TSLV; s :TVLV; i :TVI) return TSLV is
    constant VLow  :TVI := SLVStructPosLow(s,i);
    constant VHigh :TVI := SLVStructPosHigh(s,i);
  begin
    return(v(VHigh downto VLow));
  end function;

  -------------------------------------------------------------------

  function  SLVStructGet(v :TSLV; s :TVLV; il, ih :TVI) return TSLV is
    constant VLow  :TVI := SLVStructPosLow(s,il);
    constant VHigh :TVI := SLVStructPosHigh(s,ih);
  begin
    return(v(VHigh downto VLow));
  end function;


  -------------------------------------------------------------------
  -- vectors bit multiplexing
  -------------------------------------------------------------------
  function SLVBitDemux(src:TSLV; level:TVL; pos: TVI) return TSLV is
    variable dst :TSLV((src'length+level-1)/level-1 downto 0);
  begin
    for index in dst'range loop
      if(index<dst'length) then
        dst(index) := src(index*level+pos);
      else
        dst(index) := '0';
      end if;
    end loop;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function SLVBitMux(src0, src1 :TSLV) return TSLV is
    variable dst :TSLV((src0'length*2)-1 downto 0);
  begin
    for index in src0'range loop
      dst(2*index+0) := src0(index);
      dst(2*index+1) := src1(index);
    end loop;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function SLVBitMux(src0, src1, src2 :TSLV) return TSLV is
    variable dst :TSLV(src0'length*3-1 downto 0);
  begin
    for index in src0'range loop
      dst(3*index+0) := src0(index);
      dst(3*index+1) := src1(index);
      dst(3*index+2) := src2(index);
    end loop;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function SLVBitMux(src0, src1, src2, src3 :TSLV) return TSLV is
    variable dst :TSLV(src0'length*4-1 downto 0);
  begin
    for index in src0'range loop
      dst(4*index+0) := src0(index);
      dst(4*index+1) := src1(index);
      dst(4*index+2) := src2(index);
      dst(4*index+3) := src3(index);
    end loop;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  SLVBitORcompress(src :TSLV; len :TVL) return TSLV is
    variable dst      :TSLV(len-1 downto 0);
    constant PART_LEN :TVL := SLVPartNum(src'length,len);
  begin
    dst := (others =>'0');
    for index in 0 to len-1 loop
      dst(index) := OR_REDUCE(SLVPartGet(src,PART_LEN,index,'0'));
    end loop;
    return(dst);
  end function;

  -------------------------------------------------------------------

  function  SLVBitDecompress(src :TSLV; len :TVL) return TSLV is
    variable dst      :TSLV(len-1 downto 0);
    constant PART_LEN :TVL := SLVPartNum(len,src'length);
  begin
    for index in 0 to src'length-1 loop
      dst := SLVPartPut(dst,PART_LEN,index,TSLVnew(PART_LEN,src(index)));
    end loop;
    return(dst);
  end function;


  -------------------------------------------------------------------
  -- vectors multiplexing
  -------------------------------------------------------------------

  function SLVMux(src0, src1 :TSLV; sel :TN) return TSLV is
  begin
    if (sel=0) then return(src0); end if;
    return(src1);
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1, src2 :TSLV; sel :TN) return TSLV is
  begin
    if (sel=0) then return(src0); end if;
    if (sel=1) then return(src1); end if;
    return(src2);
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1, src2, src3 :TSLV; sel :TN) return TSLV is
  begin
    if (sel=0) then return(src0); end if;
    if (sel=1) then return(src1); end if;
    if (sel=2) then return(src2); end if;
    return(src3);
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1 :TSLV; sel :TSL) return TSLV is
  begin
    return(SLVMux(src0,src1,TNconv(sel)));
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1, sel :TSLV) return TSLV is
  begin
    return(SLVMux(src0,src1,TNconv(sel)));
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1, src2, sel :TSLV) return TSLV is
  begin
    return(SLVMux(src0,src1,src2,TNconv(sel)));
  end function;

  -------------------------------------------------------------------

  function SLVMux(src0, src1, src2, src3, sel :TSLV) return TSLV is
  begin
    return(SLVMux(src0,src1,src2,src3,TNconv(sel)));
  end function;


  -------------------------------------------------------------------
  -- vectors spliting
  -------------------------------------------------------------------

  procedure SLVSplit(dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 := src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 := src(dst2'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplit(dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 := src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 := src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 := src(dst3'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplit(dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 := src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 := src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 := src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 := src(dst4'length+pos-1 downto pos);
   return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplit(dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 := src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 := src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 := src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 := src(dst4'length+pos-1 downto pos);
    pos := pos+dst4'length;
    dst5 := src(dst5'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplit(dst6, dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 := src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 := src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 := src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 := src(dst4'length+pos-1 downto pos);
    pos := pos+dst4'length;
    dst5 := src(dst5'length+pos-1 downto pos);
    pos := pos+dst5'length;
    dst6 := src(dst6'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplitS(signal dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 <= src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 <= src(dst2'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplitS(signal dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 <= src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 <= src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 <= src(dst3'length+pos-1 downto pos);
    return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplitS(signal dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 <= src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 <= src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 <= src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 <= src(dst4'length+pos-1 downto pos);
   return;
  end procedure;

  -------------------------------------------------------------------

  procedure SLVSplitS(signal dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 <= src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 <= src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 <= src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 <= src(dst4'length+pos-1 downto pos);
    pos := pos+dst4'length;
    dst5 <= src(dst5'length+pos-1 downto pos);
    return;
  end procedure;


  -------------------------------------------------------------------

  procedure SLVSplitS(signal dst6, dst5, dst4, dst3, dst2, dst1 :out TSLV; src :TSLV) is
    variable pos :TVI;
  begin
    pos := 0;
    dst1 <= src(dst1'length+pos-1 downto pos);
    pos := pos+dst1'length;
    dst2 <= src(dst2'length+pos-1 downto pos);
    pos := pos+dst2'length;
    dst3 <= src(dst3'length+pos-1 downto pos);
    pos := pos+dst3'length;
    dst4 <= src(dst4'length+pos-1 downto pos);
    pos := pos+dst4'length;
    dst5 <= src(dst5'length+pos-1 downto pos);
    pos := pos+dst5'length;
    dst6 <= src(dst6'length+pos-1 downto pos);
    return;
  end procedure;


  -------------------------------------------------------------------
  -- vectors counting
  -------------------------------------------------------------------

  function  SLVCntStep(cnt :TSLV; l, h :TN; s :TI) return TSLV is
    variable ResVal :TI;
  begin
    ResVal := TNconv(cnt)+s;
    if (ResVal>h) then
      ResVal := ResVal-h+l-1;
    elsif (ResVal<l) then
      ResVal := ResVal+h-l+1;
    end if;
    return(TSLVconv(ResVal,cnt'length));
  end function;

  -------------------------------------------------------------------

  function  SLVCntStep(cnt :TSLV; h :TN; s :TI) return TSLV is
  begin
    return(SLVCntStep(cnt,0,h,s));
  end function;

  -------------------------------------------------------------------

  function  SLVCntInc(cnt :TSLV; l, h :TN) return TSLV is
  begin
    return(SLVCntStep(cnt,l,h,1));
  end function;

  -------------------------------------------------------------------

  function  SLVCntInc(cnt :TSLV; h :TN) return TSLV is
  begin
    return(SLVCntStep(cnt,0,h,1));
  end function;

  -------------------------------------------------------------------

  function  SLVCntDec(cnt :TSLV; l, h :TN) return TSLV is
  begin
    return(SLVCntStep(cnt,l,h,-1));
  end function;

  -------------------------------------------------------------------

  function  SLVCntDec(cnt :TSLV; h :TN) return TSLV is
  begin
    return(SLVCntStep(cnt,0,h,-1));
  end function;


  -------------------------------------------------------------------
  -- vectors checking
  -------------------------------------------------------------------

  function  SLVCheckXORset(data :TSLV; plen, pnum :TP) return TSLV is
    constant DATA_WIDTH	       :TP := plen*pnum;
    constant DATA_CHECK_WIDTH  :TP := data'length;
    constant CHECK_WIDTH       :TN := maximum(DATA_WIDTH-DATA_CHECK_WIDTH,1);
    constant CHECK_PART_NUM    :TN := maximum(div(pnum,CHECK_WIDTH),1);
    constant CHECK_PART_WIDTH  :TN := plen*CHECK_PART_NUM;
    constant CHECK_PART_SIZE   :TN := maximum(div(CHECK_WIDTH,pnum),1);
    constant CHECK_PART_REP    :TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(pnum,CHECK_PART_NUM),CHECK_WIDTH)-1);
    constant CHECK_LPART_NUM   :TN := pnum-CHECK_PART_REP*CHECK_PART_NUM;
    constant CHECK_LPART_WIDTH :TN := plen*CHECK_LPART_NUM;
    constant CHECK_LPART_SIZE  :TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
    variable DataCheckVar      :TSLV(DATA_WIDTH-1 downto 0);
  begin
    DataCheckVar := (others => '0');
    DataCheckVar(DATA_CHECK_WIDTH-1 downto 0) := data;
    for index in 0 to CHECK_PART_REP-1 loop
      DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
      :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
      xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
    end loop;
    DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
    :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
    xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH)));
    return(DataCheckVar);
  end function;

  -------------------------------------------------------------------

  function  SLVCheckXORres(data :TSLV; plen, pnum, dlen :TP) return TSLV is
    constant DATA_WIDTH	       :TP := plen*pnum;
    constant DATA_CHECK_WIDTH  :TP := dlen;
    constant CHECK_WIDTH       :TN := maximum(DATA_WIDTH-DATA_CHECK_WIDTH,1);
    constant CHECK_PART_NUM    :TN := maximum(div(pnum,CHECK_WIDTH),1);
    constant CHECK_PART_WIDTH  :TN := plen*CHECK_PART_NUM;
    constant CHECK_PART_SIZE   :TN := maximum(div(CHECK_WIDTH,pnum),1);
    constant CHECK_PART_REP    :TN := minimum(CHECK_WIDTH/CHECK_PART_SIZE,minimum(SLVPartNum(pnum,CHECK_PART_NUM),CHECK_WIDTH)-1);
    constant CHECK_LPART_NUM   :TN := pnum-CHECK_PART_REP*CHECK_PART_NUM;
    constant CHECK_LPART_WIDTH :TN := plen*CHECK_LPART_NUM;
    constant CHECK_LPART_SIZE  :TN := CHECK_WIDTH-CHECK_PART_REP*CHECK_PART_SIZE;
    variable DataCheckVar      :TSLV(DATA_WIDTH-1 downto 0);
  begin
    DataCheckVar := data;
    for index in 0 to CHECK_PART_REP-1 loop
      DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
      :=  DataCheckVar(DATA_CHECK_WIDTH+CHECK_PART_SIZE*(index+1)-1 downto DATA_CHECK_WIDTH+CHECK_PART_SIZE*index)
      xor TSLVnew(CHECK_PART_SIZE,XOR_REDUCE(SLVPartGet(DataCheckVar(DATA_CHECK_WIDTH-1 downto 0),CHECK_PART_WIDTH-CHECK_PART_SIZE,index)));
    end loop;
    DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
    :=  DataCheckVar(DATA_WIDTH-1 downto DATA_WIDTH-CHECK_LPART_SIZE)
    xor TSLVnew(CHECK_LPART_SIZE,XOR_REDUCE(DataCheckVar(DATA_CHECK_WIDTH-1 downto DATA_CHECK_WIDTH-CHECK_LPART_WIDTH)));
    return(DataCheckVar);
  end function;


  -------------------------------------------------------------------
  -- triple logic
  -------------------------------------------------------------------
  function  T3LisFalse(arg :T3L) return TL is
  begin
    return(arg=false);
  end function;

  -------------------------------------------------------------------

  function  T3LisTrue(arg :T3L) return TL is
  begin
    return(arg=true);
  end function;

  -------------------------------------------------------------------

  function  T3LisUndef(arg :T3L) return TL is
  begin
    return(arg=T3L(undef));
  end function;

  -------------------------------------------------------------------

  function  T3Lconv(arg :TL) return T3L is
  begin
    if (arg) then return (true); end if;
    return(false);
  end function;

  -------------------------------------------------------------------

  function  TLconv(arg :T3L) return TL is
  begin
    return(arg=true);
  end function;


  -------------------------------------------------------------------
  -- two dimentions arrays emulation
  -------------------------------------------------------------------

  function TA2Dcreate(ya, xa :TVL) return TA2D is
    variable ad :TA2D;
  begin
    ad.y := ya;
    ad.x := xa;
    return(ad);
  end function;

  -------------------------------------------------------------------

  function A2DSize(ya, xa :TVL) return TVL is
  begin
    return(ya*xa);
  end function;

  -------------------------------------------------------------------

  function A2DSize(ad :TA2D) return TVL is
  begin
    return(A2DSize(ad.y,ad.x));
  end function;

  -------------------------------------------------------------------

  function A2DIndex(ya, xa :TVL; y, x :TVI) return TVI is
  begin
    return(y*xa+x);
  end function;

  -------------------------------------------------------------------

  function A2DIndex(ad :TA2D; y, x :TVI) return TVI is
  begin
    return(A2DIndex(ad.y,ad.x,y,x));
  end function;


  -------------------------------------------------------------------
  -- two dimentions arrays emulation for TSLV
  -------------------------------------------------------------------

  function A2DInitArea(ya, xa :TVL; d :TSL) return TSLV is
    variable vec :TSLV(A2DSize(ya,xa)-1 downto VEC_INDEX_MIN);
  begin
    vec := (others => d);
    return(vec);
  end function;

  -------------------------------------------------------------------

  function A2DInitArea(ad :TA2D; d :TSL) return TSLV is
  begin
    return(A2DInitArea(ad.y,ad.x,d));
  end function;

  -------------------------------------------------------------------

  function A2DGetCell(v :TSLV; ya, xa :TVL; y, x :TVI) return TSL is
  begin
    return(SLVNorm(v)(A2DIndex(ya,xa,y,x)));
  end function;

  -------------------------------------------------------------------

  function A2DGetCell(v :TSLV; ad :TA2D; y, x :TVI) return TSL is
  begin
    return(A2DGetCell(v,ad.y,ad.x,y,x));
  end function;

  -------------------------------------------------------------------

  function A2DGetRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI) return TSLV is
  begin
    return(SLVNorm(v)(A2DIndex(ya,xa,y,xh) downto A2DIndex(ya,xa,y,xl)));
  end function;

  -------------------------------------------------------------------

  function A2DGetRange(v :TSLV; ad :TA2D; y, xh, xl :TVI) return TSLV is
  begin
    return(A2DGetRange(v,ad.y,ad.x,y,xh,xl));
  end function;

  -------------------------------------------------------------------

  function A2DGetRow(v :TSLV; ya, xa :TVL; y :TVI) return TSLV is
  begin
    return(A2DGetRange(v,ya,xa,y,xa-1,VEC_INDEX_MIN));
  end function;

  -------------------------------------------------------------------

  function A2DGetRow(v :TSLV; ad :TA2D; y :TVI) return TSLV is
  begin
    return(A2DGetRow(v,ad.y,ad.x,y));
  end function;

  -------------------------------------------------------------------

  function A2DGetLastRow(v :TSLV; ya, xa :TVL) return TSLV is
  begin
    return(A2DGetRow(v,ya,xa,ya-1));
  end function;

  -------------------------------------------------------------------

  function A2DGetLastRow(v :TSLV; ad :TA2D) return TSLV is
  begin
    return(A2DGetLastRow(v,ad.y,ad.x));
  end function;

  -------------------------------------------------------------------

  function A2DSetCell(v :TSLV; ya, xa :TVL; y, x :TVI; d :TSL) return TSLV is
    variable vec :TSLV(v'length-1 downto VEC_INDEX_MIN);
  begin
    vec := v;
    vec(A2DIndex(ya,xa,y,x)) := d;
    return(vec);
  end function;

  -------------------------------------------------------------------

  function A2DSetCell(v :TSLV; ad :TA2D; y, x :TVI; d :TSL) return TSLV is
  begin
    return(A2DSetCell(v,ad.y,ad.x,y,x,d));
  end function;

  -------------------------------------------------------------------

  function A2DSetRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI; d :TSLV) return TSLV is
    variable vec :TSLV(v'length-1 downto VEC_INDEX_MIN);
  begin
    vec := v;
    vec(A2DIndex(ya,xa,y,xh) downto A2DIndex(ya,xa,y,xl)) := d;
    return(vec);
  end function;

  -------------------------------------------------------------------

  function A2DSetRange(v :TSLV; ad :TA2D; y, xh, xl :TVI; d :TSLV) return TSLV is
  begin
    return(A2DSetRange(v,ad.y,ad.x,y,xh,xl,d));
  end function;

  -------------------------------------------------------------------

  function A2DSetRow(v :TSLV; ya, xa :TVL; y :TVI; d :TSLV) return TSLV is
  begin
    return(A2DSetRange(v,ya,xa,y,xa-1,VEC_INDEX_MIN,d));
  end function;

  -------------------------------------------------------------------

  function A2DSetRow(v :TSLV; ad :TA2D; y :TVI; d :TSLV) return TSLV is
   begin
    return(A2DSetRow(v,ad.y,ad.x,y,d));
  end function;

  -------------------------------------------------------------------

  function A2DFillRange(v :TSLV; ya, xa :TVL; y, xh, xl :TVI; d :TSL) return TSLV is
    variable vec :TSLV(v'length-1 downto VEC_INDEX_MIN);
  begin
    vec := v;
    for index in xh downto xl loop
      vec(index) := d;
    end loop;
    return(vec);
  end function;

  -------------------------------------------------------------------

  function A2DFillRange(v :TSLV; ad :TA2D; y, xh, xl :TVI; d :TSL) return TSLV is
  begin
    return(A2DFillRange(v,ad.y,ad.x,y,xh,xl,d));
  end function;

  -------------------------------------------------------------------

  function A2DFillRow(v :TSLV; ya, xa :TVL; y :TVI; d :TSL) return TSLV is
  begin
    return(A2DFillRange(v,ya,xa,y,xa-1,VEC_INDEX_MIN,d));
  end function;

  -------------------------------------------------------------------

  function A2DFillRow(v :TSLV; ad :TA2D; y :TVI; d :TSL) return TSLV is
  begin
    return(A2DFillRange(v,ad.y,ad.x,y,ad.x-1,VEC_INDEX_MIN,d));
  end function;



  -------------------------------------------------------------------
  -- two dimentions arrays for TSLV
  -------------------------------------------------------------------
  
  function  TSLAnew(yl, yr, xl, xr :TN; s :TSL) return TSLA is
    constant Ymin  :TN := minimum(yl,yr);
    constant Ymax  :TN := maximum(yl,yr);
    constant Xmin  :TN := minimum(xl,xr);
    constant Xmax  :TN := maximum(xl,xr);
    variable reshh :TSLA(Ymax downto Ymin, Xmax downto Xmin);
    variable reshl :TSLA(Ymax downto Ymin, Xmin to     Xmax);
    variable reslh :TSLA(Ymin to     Ymax, Xmax downto Xmin);
    variable resll :TSLA(Ymin to     Ymax, Xmin to     Xmax);
  begin
    if (yl>yr) then
      if (xl>xr) then return(reshh);
      else            return(reshl); end if;
    else
      if (xl>xr) then return(reslh);
      else            return(resll); end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLAnew(yl, yr, xl, xr :TN) return TSLA is
  begin
    return(TSLAnew(yl, yr, xl, xr, '0'));
  end function;

  -------------------------------------------------------------------

  function  TSLAnew(y, x :TI; s :TSL) return TSLA is
  begin
    return(TSLAnew(TN(maximum(y,0)), TN(maximum(-y,0)), TN(maximum(x,0)), TN(maximum(-x,0)), s));
  end function;

  -------------------------------------------------------------------

  function  TSLAnew(y, x :TI) return TSLA is
  begin
    return(TSLAnew(x, y, '0'));
  end function;

  -------------------------------------------------------------------

  function  TSLAset(a :TSLA; yl, yr, xl, xr :TN; s :TSL) return TSLA is
    constant Ymin :TN := minimum(yl,yr);
    constant Ymax :TN := maximum(yl,yr);
    constant Xmin :TN := minimum(xl,xr);
    constant Xmax :TN := maximum(xl,xr);
    variable res  :TSLA(a'range(1),a'range(2));
  begin
    for y in Ymin to Ymax loop
      for x in Xmin to Xmax loop
        res(y,x) := s;
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAsetX(a :TSLA; y, xl, xr :TN; s :TSL) return TSLA is
  begin
    return(TSLAset(a,y,y,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAsetX(a :TSLA; y :TN; s :TSL) return TSLA is
  begin
    return(TSLAset(a,y,y,a'left(2),a'right(2),s));
  end function;

  -------------------------------------------------------------------

  function  TSLAsetY(a :TSLA; yl, yr, x :TN; s :TSL) return TSLA is
  begin
    return(TSLAset(a,yl,yr,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAsetY(a :TSLA; x :TN; s :TSL) return TSLA is
  begin
    return(TSLAset(a,a'left(1),a'right(1),x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAset(a :TSLA; s :TSL) return TSLA is
  begin
    return(TSLAset(a,a'left(1),a'right(1),a'left(2),a'right(2),s));
  end function;

  -------------------------------------------------------------------

  function  TSLVget(a :TSLA; yl, yr, xl, xr :TN) return TSLV is
    constant len :TN := (abs(yl-yr)+1)*(abs(xl-xr)+1)-1;
    constant tmp :TSLV := TSLVnew(len*TNconv(a'left(2)>a'right(2)),len*TNconv(a'left(2)<a'right(2)));
    variable res :TSLV(tmp'range);
    variable pos :TN;
  begin
    pos := 0;
    if (yl>=yr) then
      for y in yr to yl loop
        if (xl>=xr) then
          for x in xr to xl loop
            res(pos) := a(y,x); pos := pos+1;
          end loop;
        else
          for x in xr downto xl loop
            res(pos) := a(y,x); pos := pos+1;
          end loop;
        end if;
      end loop;
    else
      for y in yr downto yl loop
        if (xl>=xr) then
          for x in xr to xl loop
            res(pos) := a(y,x); pos := pos+1;
          end loop;
        else
          for x in xr downto xl loop
            res(pos) := a(y,x); pos := pos+1;
          end loop;
        end if;
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLVgetX(a :TSLA; y, xl, xr :TN) return TSLV is
  begin
    return(TSLVget(a,y,y,xl,xr));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetX(a :TSLA; y :TN) return TSLV is
  begin
    return(TSLVgetX(a,y,a'left(2),a'right(2)));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetY(a :TSLA; yl, yr, x :TN) return TSLV is
  begin
    return(TSLVget(a,yl,yr,x,x));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetY(a :TSLA; x :TN) return TSLV is
  begin
    return(TSLVgetY(a,a'left(1),a'right(1),x));
  end function;

  -------------------------------------------------------------------

  function  TSLVget(a :TSLA) return TSLV is
  begin
    return(TSLVget(a,a'left(1),a'right(1),a'left(2),a'right(2)));
  end function;

  -------------------------------------------------------------------

  function  TSLAput(a :TSLA; yl, yr, xl, xr :TN; s :TSLV) return TSLA is
    variable res :TSLA(a'range(1),a'range(2));
    variable pos :TN;
  begin
    res := a;
    pos := minimum(s'left,s'right);
    if (yl>=yr) then
      for y in yr to yl loop
        if (xl>=xr) then
          for x in xr to xl loop
            res(y,x) := s(pos); pos := pos+1;
          end loop;
        else
          for x in xr downto xl loop
            res(y,x) := s(pos); pos := pos+1;
          end loop;
        end if;
      end loop;
    else
      for y in yr downto yl loop
        if (xl>=xr) then
          for x in xr to xl loop
            res(y,x) := s(pos); pos := pos+1;
          end loop;
        else
          for x in xr downto xl loop
            res(y,x) := s(pos); pos := pos+1;
          end loop;
        end if;
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAputX(a :TSLA; y, xl, xr :TN; s :TSLV) return TSLA is
  begin
    return(TSLAput(a,y,y,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAputX(a :TSLA; y, x :TN; s :TSLV) return TSLA is
  begin
    if (s'left>s'right) then
      return(TSLAputX(a,y,x+s'length-1,x,s));
    end if;
    return(TSLAputX(a,y,x,x+s'length-1,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAputX(a :TSLA; y :TN; s :TSLV) return TSLA is
  begin
    return(TSLAputX(a,y,minimum(a'left(2),a'right(2)),s));
  end function;

  -------------------------------------------------------------------

  function  TSLAputY(a :TSLA; yl, yr, x :TN; s :TSLV) return TSLA is
  begin
    return(TSLAput(a,yl,yr,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAputY(a :TSLA; y, x :TN; s :TSLV) return TSLA is
  begin
    if (s'left>s'right) then
      return(TSLAputY(a,y+s'length-1,y,x,s));
    end if;
    return(TSLAputY(a,y,y+s'length-1,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAputY(a :TSLA; x :TN; s :TSLV) return TSLA is
  begin
    return(TSLAputY(a,minimum(a'left(1),a'right(1)),x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLAput(a :TSLA; s :TSLV) return TSLA is
  begin
    return(TSLAput(a,a'left(1),a'right(1),a'left(2),a'right(2),s));
  end function;

  -------------------------------------------------------------------

  function  TSLAmov(a :TSLA; yl, yr, xl, xr :TN; ys, xs, n :TI) return TSLA is
    variable Ymin :TN;
    variable Ymax :TN;
    variable Xmin :TN;
    variable Xmax :TN;
    variable res  :TSLA(a'range(1),a'range(2));
  begin
    Ymin := minimum(yl,yr);
    Ymax := maximum(yl,yr);
    Xmin := minimum(xl,xr);
    Xmax := maximum(xl,xr);
    res  := a;
    for cnt in 1 to abs(n) loop
      if (ys>=0) then
        if (xs>=0) then
          for y in Ymin to Ymax loop
            for x in Xmin to Xmax loop
              res(y+ys,x+xs) := res(y,x);
            end loop;
          end loop;
        else
          for y in Ymin to Ymax loop
            for x in Xmax downto Xmin loop
              res(y+ys,x+xs) := res(y,x);
            end loop;
          end loop;
        end if;
      else
        if (xs>=0) then
          for y in Ymax downto Ymin loop
            for x in Xmin to Xmax loop
              res(y+ys,x+xs) := res(y,x);
            end loop;
          end loop;
        else
          for y in Ymax downto Ymin loop
            for x in Xmax downto Xmin loop
              res(y+ys,x+xs) := res(y,x);
            end loop;
          end loop;
        end if;
      end if;
      if (n>0) then
        Ymin := Ymin + ys;
        Ymax := Ymax + ys;
        Xmin := Xmin + xs;
        Xmax := Xmax + xs;
      else
        Ymin := Ymin - ys;
        Ymax := Ymax - ys;
        Xmin := Xmin - xs;
        Xmax := Xmax - xs;
      end if;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAmovX(a :TSLA; yl, yr :TN; ys, n :TI) return TSLA is
  begin
    return(TSLAmov(a,yl,yr,a'left(2),a'right(2),ys,0,n));
  end function;

  -------------------------------------------------------------------

  function  TSLAmovX(a :TSLA; y :TN; ys, n :TI) return TSLA is
  begin
    return(TSLAmovX(a,y,y,ys,n));
  end function;

  -------------------------------------------------------------------

  function  TSLAmovX(a :TSLA; ys :TI) return TSLA is
    constant Ymin :TN := minimum(a'left(1),a'right(1));
    constant Ymax :TN := maximum(a'left(1),a'right(1));
    constant num  :TN := a'length(1)-abs(ys);
  begin
    if (ys>0) then
      return(TSLAmovX(a,Ymax-ys,ys,-num));
    else
      return(TSLAmovX(a,Ymin-ys,ys,-num));
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLAmovY(a :TSLA; xl, xr :TN; xs, n :TI) return TSLA is
  begin
    return(TSLAmov(a,a'left(1),a'right(1),xl,xr,0,xs,n));
  end function;

  -------------------------------------------------------------------

  function  TSLAmovY(a :TSLA; x :TN; xs, n :TI) return TSLA is
  begin
    return(TSLAmovY(a,x,x,xs,n));
  end function;

  -------------------------------------------------------------------

  function  TSLAmovY(a :TSLA; xs :TI) return TSLA is
    constant Xmin :TN := minimum(a'left(2),a'right(2));
    constant Xmax :TN := maximum(a'left(2),a'right(2));
    constant num  :TN := a'length(2)-abs(xs);
  begin
    if (xs>0) then
      return(TSLAmovY(a,Xmax-xs,xs,-num));
    else
      return(TSLAmovY(a,Xmin-xs,xs,-num));
    end if;
  end function;


  -------------------------------------------------------------------
  -- three dimentions arrays for TSLV
  -------------------------------------------------------------------
  
  function  TSLCnew(zl, zr, yl, yr, xl, xr :TN; s :TSL) return TSLC is
    constant Zmin   :TN := minimum(zl,zr);
    constant Zmax   :TN := maximum(zl,zr);
    constant Ymin   :TN := minimum(yl,yr);
    constant Ymax   :TN := maximum(yl,yr);
    constant Xmin   :TN := minimum(xl,xr);
    constant Xmax   :TN := maximum(xl,xr);
    variable reshhh :TSLC(Zmax downto Zmin, Ymax downto Ymin, Xmax downto Xmin);
    variable reshhl :TSLC(Zmax downto Zmin, Ymax downto Ymin, Xmin to     Xmax);
    variable reshlh :TSLC(Zmax downto Zmin, Ymin to     Ymax, Xmax downto Xmin);
    variable reshll :TSLC(Zmax downto Zmin, Ymin to     Ymax, Xmin to     Xmax);
    variable reslhh :TSLC(Zmin to     Zmax, Ymax downto Ymin, Xmax downto Xmin);
    variable reslhl :TSLC(Zmin to     Zmax, Ymax downto Ymin, Xmin to     Xmax);
    variable resllh :TSLC(Zmin to     Zmax, Ymin to     Ymax, Xmax downto Xmin);
    variable reslll :TSLC(Zmin to     Zmax, Ymin to     Ymax, Xmin to     Xmax);
  begin
    if (zl>zr) then
      if (yl>yr) then
        if (xl>xr) then return(reshhh);
        else            return(reshhl); end if;
      else
        if (xl>xr) then return(reshlh);
        else            return(reshll); end if;
      end if;
    else
      if (yl>yr) then
        if (xl>xr) then return(reslhh);
        else            return(reslhl); end if;
      else
        if (xl>xr) then return(resllh);
        else            return(reslll); end if;
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCnew(zl, zr, yl, yr, xl, xr :TN) return TSLC is
  begin
    return(TSLCnew(zl, zr, yl, yr, xl, xr, '0'));
  end function;

  -------------------------------------------------------------------

  function  TSLCnew(z, y, x :TI; s :TSL) return TSLC is
  begin
    return(TSLCnew(TN(maximum(z,0)), TN(maximum(-z,0)), TN(maximum(y,0)), TN(maximum(-y,0)), TN(maximum(x,0)), TN(maximum(-x,0)), s));
  end function;

  -------------------------------------------------------------------

  function  TSLCnew(z, y, x :TI) return TSLC is
  begin
    return(TSLCnew(z, x, y, '0'));
  end function;


  -------------------------------------------------------------------

  function  TSLCset(c :TSLC; zl, zr, yl, yr, xl, xr :TN; s :TSL) return TSLC is
    constant Zmin :TN := minimum(zl,zr);
    constant Zmax :TN := maximum(zl,zr);
    constant Ymin :TN := minimum(yl,yr);
    constant Ymax :TN := maximum(yl,yr);
    constant Xmin :TN := minimum(xl,xr);
    constant Xmax :TN := maximum(xl,xr);
    variable res  :TSLC(c'range(1),c'range(2),c'range(3));
  begin
    for z in Zmin to Zmax loop
      for y in Ymin to Ymax loop
        for x in Xmin to Xmax loop
          res(z,y,x) := s;
        end loop;
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCsetYX(c :TSLC; z, yl, yr, xl, xr :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,z,z,yl,yr,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetYX(c :TSLC; z :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetYX(c,z,c'left(2),c'right(2),c'left(3),c'right(3),s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZX(c :TSLC; zl, zr, y, xl, xr :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,zl,zr,y,y,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZX(c :TSLC; y :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetYX(c,c'left(1),c'right(1),y,c'left(3),c'right(3),s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZY(c :TSLC; zl, zr, yl, yr, x :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,zl,zl,yl,yr,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZY(c :TSLC; x :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetZY(c,c'left(1),c'right(1),c'left(2),c'right(2),x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetX(c :TSLC; z, y, xl, xr :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,z,z,y,y,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetX(c :TSLC; z, y :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetX(c,z,y,c'left(3),c'right(3),s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetY(c :TSLC; z, yl, yr, x :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,z,z,yl,yr,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetY(c :TSLC; z, x :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetY(c,z,c'left(2),c'right(2),x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZ(c :TSLC; zl, zr, y, x :TN; s :TSL) return TSLC is
  begin
    return(TSLCset(c,zl,zr,y,y,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCsetZ(c :TSLC; y, x :TN; s :TSL) return TSLC is
  begin
    return(TSLCsetZ(c,c'left(1),c'right(1),y,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCset(c :TSLC; s :TSL) return TSLC is
  begin
    return(TSLCset(c,c'left(1),c'right(1),c'left(2),c'right(2),c'left(3),c'right(3),s));
  end function;

  -------------------------------------------------------------------

  function  TSLAgetYX(c :TSLC; z, yl, yr, xl, xr :TN) return TSLA is
    constant Ymin :TN := minimum(yl,yr);
    constant Ymax :TN := maximum(yl,yr);
    constant Xmin :TN := minimum(xl,xr);
    constant Xmax :TN := maximum(xl,xr);
    constant tmp  :TSLA := TSLAnew(yl, yr, xl, xr);
    variable res  :TSLA(tmp'range(1),tmp'range(2));
  begin
    for y in Ymin to Ymax loop
      for X in Xmin to Xmax loop
        res(y,x) := c(z,y,x);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAgetYX(c :TSLC; z :TN) return TSLA is
  begin
    return(TSLAgetYX(c, z, c'left(2), c'right(2), c'left(3), c'right(3)));
  end function;

  -------------------------------------------------------------------

  function  TSLAgetZX(c :TSLC; zl, zr, y, xl, xr :TN) return TSLA is
    constant Zmin :TN := minimum(zl,zr);
    constant Zmax :TN := maximum(zl,zr);
    constant Xmin :TN := minimum(xl,xr);
    constant Xmax :TN := maximum(xl,xr);
    constant tmp  :TSLA := TSLAnew(zl, zr, xl, xr);
    variable res  :TSLA(tmp'range(1),tmp'range(2));
  begin
    for z in Zmin to Zmax loop
      for X in Xmin to Xmax loop
        res(z,x) := c(z,y,x);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAgetZX(c :TSLC; y :TN) return TSLA is
  begin
    return(TSLAgetZX(c, c'left(1), c'right(1), y, c'left(3), c'right(3)));
  end function;

  -------------------------------------------------------------------

  function  TSLAgetZY(c :TSLC; zl, zr, yl, yr, x :TN) return TSLA is
    constant Zmin :TN := minimum(zl,zr);
    constant Zmax :TN := maximum(zl,zr);
    constant Ymin :TN := minimum(yl,yr);
    constant Ymax :TN := maximum(yl,yr);
    constant tmp  :TSLA := TSLAnew(zl, zr, yl, yr);
    variable res  :TSLA(tmp'range(1),tmp'range(2));
  begin
    for z in Zmin to Zmax loop
      for Y in Ymin to Ymax loop
        res(z,y) := c(z,y,x);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLAgetZY(c :TSLC; x :TN) return TSLA is
  begin
    return(TSLAgetZY(c, c'left(1), c'right(1), c'left(2), c'right(2), x));
  end function;

  -------------------------------------------------------------------

  function  TSLVget(c :TSLC; zl, zr, yl, yr, xl, xr :TN) return TSLV is
    constant len :TN := (abs(zl-zr)+1)*(abs(yl-yr)+1)*(abs(xl-xr)+1)-1;
    constant tmp :TSLV := TSLVnew(len*TNconv(c'left(3)>c'right(3)),len*TNconv(c'left(3)<c'right(3)));
    variable res :TSLV(tmp'range);
    variable pos :TN;
  begin
    pos := 0;
    if (zl>=zr) then
      for z in zr to zl loop
        if (yl>=yr) then
          for y in yr to yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(pos) := c(z,y,x); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(pos) := c(z,y,x); pos := pos+1; end loop;
            end if;
          end loop;
        else
          for y in yr downto yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(pos) := c(z,y,x); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(pos) := c(z,y,x); pos := pos+1; end loop;
            end if;
          end loop;
        end if;
      end loop;
    else
      for z in zr downto zl loop
        if (yl>=yr) then
          for y in yr to yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(pos) := c(z,y,x); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(pos) := c(z,y,x); pos := pos+1; end loop;
            end if;
          end loop;
        else
          for y in yr downto yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(pos) := c(z,y,x); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(pos) := c(z,y,x); pos := pos+1; end loop;
            end if;
          end loop;
        end if;
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLVgetX(c :TSLC; z, y, xl, xr :TN) return TSLV is
  begin
    return(TSLVget(c,z,z,y,y,xl,xr));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetX(c :TSLC; z, y :TN) return TSLV is
  begin
    return(TSLVgetX(c,z,y,c'left(3),c'right(3)));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetY(c :TSLC; z, yl, yr, x :TN) return TSLV is
  begin
    return(TSLVget(c,z,z,yl,yr,x,x));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetY(c :TSLC; z, x :TN) return TSLV is
  begin
    return(TSLVgetY(c,z,c'left(2),c'right(2),x));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetZ(c :TSLC; zl, zr, y, x :TN) return TSLV is
  begin
    return(TSLVget(c,zl,zr,y,y,x,x));
  end function;

  -------------------------------------------------------------------

  function  TSLVgetZ(c :TSLC; y, x :TN) return TSLV is
  begin
    return(TSLVgetZ(c,c'left(1),c'right(1),y,x));
  end function;

  -------------------------------------------------------------------

  function  TSLVget(c :TSLC) return TSLV is
  begin
    return(TSLVget(c,c'left(1),c'right(1),c'left(2),c'right(2),c'left(3),c'right(3)));
  end function;

  -------------------------------------------------------------------

  function  TSLCputYX(c :TSLC; z, y, x :TN; a :TSLA) return TSLC is
    constant Ymin :TN := minimum(a'left(2),a'right(2));
    constant Xmin :TN := minimum(a'left(1),a'right(1));
    variable res  :TSLC(c'range(1),c'range(2),c'range(3));
  begin
    res := c;
    for iy in 0 to a'length(2)-1 loop
      for iX in 0 to a'length(1)-1 loop
        res(z,y+iy,x+ix) := a(iy+Ymin,ix+Xmin);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCputYX(c :TSLC; z :TN; a :TSLA) return TSLC is
  begin
    if (c'length(2)/=a'length(2) or c'length(1)/=a'length(1)) then
      assert false report "[TSLCputYX] diffrent ranges" severity error;
    end if;
    return(TSLCputYX(c,z,minimum(c'left(2),c'right(2)),minimum(c'left(3),c'right(3)),a));
  end function;

  -------------------------------------------------------------------

  function  TSLCputZX(c :TSLC; z, y, x :TN; a :TSLA) return TSLC is
    constant Ymin :TN := minimum(a'left(2),a'right(2));
    constant Xmin :TN := minimum(a'left(1),a'right(1));
    variable res  :TSLC(c'range(1),c'range(2),c'range(3));
  begin
    res := c;
    for iy in 0 to a'length(2)-1 loop
      for iX in 0 to a'length(1)-1 loop
        res(z+iy,y,x+ix) := a(iy+Ymin,ix+Xmin);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCputZX(c :TSLC; y :TN; a :TSLA) return TSLC is
  begin
    if (c'length(1)/=a'length(2) or c'length(1)/=a'length(1)) then
      assert false report "[TSLCputZX] diffrent ranges" severity error;
    end if;
    return(TSLCputZX(c,minimum(c'left(1),c'right(1)),y,minimum(c'left(3),c'right(3)),a));
  end function;

  -------------------------------------------------------------------

  function  TSLCputZY(c :TSLC; z, y, x :TN; a :TSLA) return TSLC is
    constant Ymin :TN := minimum(a'left(2),a'right(2));
    constant Xmin :TN := minimum(a'left(1),a'right(1));
    variable res  :TSLC(c'range(1),c'range(2),c'range(3));
  begin
    res := c;
    for iy in 0 to a'length(2)-1 loop
      for iX in 0 to a'length(1)-1 loop
        res(z+iy,y+ix,x) := a(iy+Ymin,ix+Xmin);
      end loop;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCputZY(c :TSLC; x :TN; a :TSLA) return TSLC is
  begin
    if (c'length(1)/=a'length(2) or c'length(2)/=a'length(1)) then
      assert false report "[TSLCputZY] diffrent ranges" severity error;
    end if;
    return(TSLCputZY(c,minimum(c'left(1),c'right(1)),minimum(c'left(2),c'right(2)),x,a));
  end function;

  -------------------------------------------------------------------

  function  TSLCput(c :TSLC; zl, zr, yl, yr, xl, xr :TN; s :TSLV) return TSLC is
    variable res :TSLC(c'range(1),c'range(2),c'range(3));
    variable pos :TN;
  begin
    res := c;
    pos := minimum(s'left,s'right);
    if (zl>=zr) then
      for z in zr to zl loop
        if (yl>=yr) then
          for y in yr to yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(z,y,x) := s(pos); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(z,y,x) := s(pos); pos := pos+1; end loop;
            end if;
          end loop;
        else
          for y in yr downto yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(z,y,x) := s(pos); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(z,y,x) := s(pos); pos := pos+1; end loop;
            end if;
          end loop;
        end if;
      end loop;
    else
      for z in zr downto zl loop
        if (yl>=yr) then
          for y in yr to yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(z,y,x) := s(pos); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(z,y,x) := s(pos); pos := pos+1; end loop;
            end if;
          end loop;
        else
          for y in yr downto yl loop
            if (xl>=xr) then
              for x in xr to xl loop     res(z,y,x) := s(pos); pos := pos+1; end loop;
            else
              for x in xr downto xl loop res(z,y,x) := s(pos); pos := pos+1; end loop;
            end if;
          end loop;
        end if;
      end loop;
    end if;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCputX(c :TSLC; z, y, xl, xr :TN; s :TSLV) return TSLC is
  begin
    return(TSLCput(c,z,z,y,y,xl,xr,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputX(c :TSLC; z, y, x :TN; s :TSLV) return TSLC is
  begin
    if (s'left>s'right) then
      return(TSLCputX(c,z,y,x+s'length-1,x,s));
    end if;
    return(TSLCputX(c,z,y,x,x+s'length-1,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputX(c :TSLC; z, y :TN; s :TSLV) return TSLC is
  begin
    return(TSLCputX(c,z,y,minimum(c'left(3),c'right(3)),s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputY(c :TSLC; z, yl, yr, x :TN; s :TSLV) return TSLC is
  begin
    return(TSLCput(c,z,z,yl,yr,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputY(c :TSLC; z, y, x :TN; s :TSLV) return TSLC is
  begin
    if (s'left>s'right) then
      return(TSLCputY(c,z,y+s'length-1,y,x,s));
    end if;
    return(TSLCputY(c,z,y,y+s'length-1,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputY(c :TSLC; z, x :TN; s :TSLV) return TSLC is
  begin
    return(TSLCputY(c,z,minimum(c'left(2),c'right(2)),x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputZ(c :TSLC; zl, zr, y, x :TN; s :TSLV) return TSLC is
  begin
    return(TSLCput(c,zl,zr,y,y,x,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputZ(c :TSLC; z, y, x :TN; s :TSLV) return TSLC is
  begin
    if (s'left>s'right) then
      return(TSLCputZ(c,z+s'length-1,z,y,x,s));
    end if;
    return(TSLCputZ(c,z,z+s'length-1,y,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCputZ(c :TSLC; y, x :TN; s :TSLV) return TSLC is
  begin
    return(TSLCputZ(c,minimum(c'left(1),c'right(1)),y,x,s));
  end function;

  -------------------------------------------------------------------

  function  TSLCput(c :TSLC; s :TSLV) return TSLC is
  begin
    return(TSLCput(c,c'left(1),c'right(1),c'left(2),c'right(2),c'left(3),c'right(3),s));
  end function;

  -------------------------------------------------------------------

  function  TSLCmov(c :TSLC; zl, zr, yl, yr, xl, xr :TN; zs, ys, xs, n :TI) return TSLC is
    variable Zmin :TN;
    variable Zmax :TN;
    variable Ymin :TN;
    variable Ymax :TN;
    variable Xmin :TN;
    variable Xmax :TN;
    variable res  :TSLC(c'range(1),c'range(2),c'range(3));
  begin
    Zmin := minimum(zl,zr);
    Zmax := maximum(zl,zr);
    Ymin := minimum(yl,yr);
    Ymax := maximum(yl,yr);
    Xmin := minimum(xl,xr);
    Xmax := maximum(xl,xr);
    res := c;
    for cnt in 1 to abs(n) loop
      if (zs>=0) then
        if (ys>=0) then
          if (xs>=0) then
            for z in Ymin to Ymax loop
              for y in Ymin to Ymax loop
                for x in Xmin to Xmax loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          else
            for z in Ymin to Ymax loop
              for y in Ymin to Ymax loop
                for x in Xmax downto Xmin loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          end if;
        else
          if (xs>=0) then
            for z in Ymin to Ymax loop
              for y in Ymax downto Ymin loop
                for x in Xmin to Xmax loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          else
            for z in Ymin to Ymax loop
              for y in Ymax downto Ymin loop
                for x in Xmax downto Xmin loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          end if;
        end if;
      else
        if (ys>=0) then
          if (xs>=0) then
            for z in Ymax downto Ymin loop
              for y in Ymin to Ymax loop
                for x in Xmin to Xmax loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          else
            for z in Ymax downto Ymin loop
              for y in Ymin to Ymax loop
                for x in Xmax downto Xmin loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          end if;
        else
          if (xs>=0) then
            for z in Ymax downto Ymin loop
              for y in Ymax downto Ymin loop
                for x in Xmin to Xmax loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          else
            for z in Ymax downto Ymin loop
              for y in Ymax downto Ymin loop
                for x in Xmax downto Xmin loop
                  res(z+zs,y+ys,x+xs) := res(z,y,x);
                end loop;
              end loop;
            end loop;
          end if;
        end if;
      end if;
      if (n>0) then
        Zmin := Zmin + zs;
        Zmax := Zmax + zs;
        Ymin := Ymin + ys;
        Ymax := Ymax + ys;
        Xmin := Xmin + xs;
        Xmax := Xmax + xs;
      else
        Zmin := Zmin - zs;
        Zmax := Zmax - zs;
        Ymin := Ymin - ys;
        Ymax := Ymax - ys;
        Xmin := Xmin - xs;
        Xmax := Xmax - xs;
      end if;
    end loop;
    return(res);
  end function;

  -------------------------------------------------------------------

  function  TSLCmovX(c :TSLC; zl, zr, yl, yr :TN; zs, ys, n :TI) return TSLC is
  begin
    return(TSLCmov(c,zl,zr,yl,yr,c'left(3),c'right(3),zs,ys,0,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovX(c :TSLC; z, y :TN; zs, ys, n :TI) return TSLC is
  begin
    return(TSLCmovX(c,z,z,y,y,zs,ys,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovX(c :TSLC; zs, ys :TI) return TSLC is
    constant Zmin :TN := minimum(c'left(1),c'right(1));
    constant Zmax :TN := maximum(c'left(1),c'right(1));
    constant Ymin :TN := minimum(c'left(2),c'right(2));
    constant Ymax :TN := maximum(c'left(2),c'right(2));
    constant num  :TN := minimum(c'length(1)-abs(zs),c'length(2)-abs(ys));
  begin
    if (zs>0) then
      if(ys>0) then
        return(TSLCmovX(c,Zmax-zs,Ymax-ys,zs,ys,-num));
      else
        return(TSLCmovX(c,Zmax-zs,Ymax-ys,zs,ys,-num));
      end if;
    else
      if(ys>0) then
        return(TSLCmovX(c,Zmax-zs,Ymax-ys,zs,ys,-num));
      else
        return(TSLCmovX(c,Zmax-zs,Ymax-ys,zs,ys,-num));
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCmovY(c :TSLC; zl, zr, xl, xr :TN; zs, xs, n :TI) return TSLC is
  begin
    return(TSLCmov(c,zl,zr,c'left(2),c'right(2),xl,xr,zs,xs,0,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovY(c :TSLC; z, x :TN; zs, xs, n :TI) return TSLC is
  begin
    return(TSLCmovX(c,z,z,x,x,zs,xs,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovY(c :TSLC; zs, xs :TI) return TSLC is
    constant Zmin :TN := minimum(c'left(1),c'right(1));
    constant Zmax :TN := maximum(c'left(1),c'right(1));
    constant Xmin :TN := minimum(c'left(3),c'right(3));
    constant Xmax :TN := maximum(c'left(3),c'right(3));
    constant num  :TN := minimum(c'length(1)-abs(zs),c'length(3)-abs(xs));
  begin
    if (zs>0) then
      if(xs>0) then
        return(TSLCmovX(c,Zmax-zs,Xmax-xs,zs,xs,-num));
      else
        return(TSLCmovX(c,Zmax-zs,Xmin-xs,zs,xs,-num));
      end if;
    else
      if(xs>0) then
        return(TSLCmovX(c,Zmin-zs,Xmax-xs,zs,xs,-num));
      else
        return(TSLCmovX(c,Zmin-zs,Xmin-xs,zs,xs,-num));
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZ(c :TSLC; yl, yr, xl, xr :TN; ys, xs, n :TI) return TSLC is
  begin
    return(TSLCmov(c,c'left(3),c'right(3),yl,yr,xl,xr,ys,xs,0,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZ(c :TSLC; y, x :TN; ys, xs, n :TI) return TSLC is
  begin
    return(TSLCmovX(c,y,y,x,x,ys,xs,n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZ(c :TSLC; ys, xs :TI) return TSLC is
    constant Ymin :TN := minimum(c'left(2),c'right(2));
    constant Ymax :TN := maximum(c'left(2),c'right(2));
    constant Xmin :TN := minimum(c'left(3),c'right(3));
    constant Xmax :TN := maximum(c'left(3),c'right(3));
    constant num  :TN := minimum(c'length(2)-abs(ys),c'length(3)-abs(xs));
  begin
    if (ys>0) then
      if(xs>0) then
        return(TSLCmovX(c,Ymax-ys,Xmax-xs,ys,xs,-num));
      else
        return(TSLCmovX(c,Ymax-ys,Xmin-xs,ys,xs,-num));
      end if;
    else
      if(xs>0) then
        return(TSLCmovX(c,Ymin-ys,Xmax-xs,ys,xs,-num));
      else
        return(TSLCmovX(c,Ymin-ys,Xmin-xs,ys,xs,-num));
      end if;
    end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCmovYX(c :TSLC; zl, zr :TN; zs, n :TI) return TSLC is
  begin
    return(TSLCmov(c, zl, zr, c'left(2), c'right(2), c'left(3), c'right(3), zs, 0, 0, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovYX(c :TSLC; z :TN; zs,  n :TI) return TSLC is
  begin
    return(TSLCmovYX(c, z, z, zs, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovYX(c :TSLC; zs :TI) return TSLC is
    constant Zmin :TN := minimum(c'left(1),c'right(1));
    constant Zmax :TN := maximum(c'left(1),c'right(1));
    constant num  :TN := c'length(1)-abs(zs);
  begin
    if (zs>0) then
      return(TSLCmovYX(c,Zmax-zs,zs,-num));
    else
      return(TSLCmovYX(c,Zmin-zs,zs,-num));
   end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZX(c :TSLC; yl, yr :TN; ys, n :TI) return TSLC is
  begin
    return(TSLCmov(c, c'left(1), c'right(1), yl, yr, c'left(3), c'right(3), 0, ys, 0, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZX(c :TSLC; y :TN; ys,  n :TI) return TSLC is
  begin
    return(TSLCmovZX(c, y, y, ys, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZX(c :TSLC; ys :TI) return TSLC is
    constant Ymin :TN := minimum(c'left(2),c'right(2));
    constant Ymax :TN := maximum(c'left(2),c'right(2));
    constant num  :TN := c'length(2)-abs(ys);
  begin
    if (ys>0) then
      return(TSLCmovZX(c,Ymax-ys,ys,-num));
    else
      return(TSLCmovZX(c,Ymin-ys,ys,-num));
   end if;
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZY(c :TSLC; xl, xr :TN; xs, n :TI) return TSLC is
  begin
    return(TSLCmov(c, c'left(1), c'right(1), c'left(2), c'right(2), xl, xr, 0, 0, xs, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZY(c :TSLC; x :TN; xs,  n :TI) return TSLC is
  begin
    return(TSLCmovZY(c, x, x, xs, n));
  end function;

  -------------------------------------------------------------------

  function  TSLCmovZY(c :TSLC; xs :TI) return TSLC is
    constant Xmin :TN := minimum(c'left(3),c'right(3));
    constant Xmax :TN := maximum(c'left(3),c'right(3));
    constant num  :TN := c'length(3)-abs(xs);
  begin
    if (xs>0) then
      return(TSLCmovZX(c,Xmax-xs,xs,-num));
    else
      return(TSLCmovZX(c,Xmin-xs,xs,-num));
   end if;
  end function;


  -------------------------------------------------------------------
  -- debug
  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS) is
  begin
    assert not(ena) report "[USER INFO] "+msg severity level;--warning;
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val :TIV; idx:TL) is
    function NextVal (val :TIV; index :TVI) return TS is
      constant CIDX :TS := "("+TSconv(index,0,TRUE)+")=";
      constant CVAL :TS := TSconv(val(minimum(index,val'length-1)),0,TRUE);
    begin
      if (index+1<val'length) then
        if (idx=TRUE) then
          return(CIDX+CVAL+", "+NextVal(val,index+1));
        else
          return(CVAL+", "+NextVal(val,index+1));
        end if;
      else
        if (idx=TRUE) then
          return(CIDX+CVAL);
        else
          return(CVAL);
        end if;
      end if;
    end function;
  begin
    DebugMsg(ena,level,msg+": "+NextVal(val,0));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0 :TI; idx:TL) is
    variable vec :TIV(0 to 0);
  begin
    vec(0) := val0;
    DebugMsg(ena,level,msg,vec,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0 :TI) is
  begin
    DebugMsg(ena,level,msg,val0,FALSE);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1 :TI; idx:TL) is
    variable vec :TIV(0 to 1);
  begin
    vec(0) := val0;
    vec(1) := val1;
    DebugMsg(ena,level,msg,vec,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1 :TI) is
  begin
    DebugMsg(ena,level,msg,val0,val1,FALSE);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2 :TI; idx:TL) is
    variable vec :TIV(0 to 2);
  begin
    vec(0) := val0;
    vec(1) := val1;
    vec(2) := val2;
    DebugMsg(ena,level,msg,vec,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2 :TI) is
  begin
    DebugMsg(ena,level,msg,val0,val1,val2,FALSE);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3 :TI; idx:TL) is
    variable vec :TIV(0 to 3);
  begin
    vec(0) := val0;
    vec(1) := val1;
    vec(2) := val2;
    vec(3) := val3;
    DebugMsg(ena,level,msg,vec,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3 :TI) is
  begin
    DebugMsg(ena,level,msg,val0,val1,val2,val3,FALSE);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI; idx:TL) is
    variable vec :TIV(0 to 4);
  begin
    vec(0) := val0;
    vec(1) := val1;
    vec(2) := val2;
    vec(3) := val3;
    vec(4) := val4;
    DebugMsg(ena,level,msg,vec,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI) is
  begin
    DebugMsg(ena,level,msg,val0,val1,val2,val3,FALSE);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE)+", "+des1+"="+TSconv(val1,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE)+", "+des1+"="+TSconv(val1,0,TRUE)+", "+des2+"="+TSconv(val2,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE)+", "+des1+"="+TSconv(val1,0,TRUE) -->
                +", "+des2+"="+TSconv(val2,0,TRUE)+", "+des3+"="+TSconv(val3,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE)+", "+des1+"="+TSconv(val1,0,TRUE) -->
                +", "+des2+"="+TSconv(val2,0,TRUE)+", "+des3+"="+TSconv(val3,0,TRUE)+", "+des4+"="+TSconv(val4,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI; des5 :TS; val5 :TI) is
  begin
    DebugMsg(ena,level,msg+": "+des0+"="+TSconv(val0,0,TRUE)+", "+des1+"="+TSconv(val1,0,TRUE) -->
                +", "+des2+"="+TSconv(val2,0,TRUE)+", "+des3+"="+TSconv(val3,0,TRUE)+", "+des4+"="+TSconv(val4,0,TRUE)+", "+des5+"="+TSconv(val5,0,TRUE));
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(ena :TL; level :severity_level; msg :TS; val :TS) is
  begin
    DebugMsg(ena,level,msg+": "+val);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS) is
  begin
    DebugMsg(TRUE,level,msg);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val :TIV; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0 :TI; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val0,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0 :TI) is
  begin
    DebugMsg(TRUE,level,msg,val0);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1 :TI; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1 :TI) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2 :TI; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2 :TI) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3 :TI; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2,val3,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3 :TI) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2,val3);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI; idx :TL) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2,val3,val4,idx);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val0, val1, val2, val3, val4 :TI) is
  begin
    DebugMsg(TRUE,level,msg,val0,val1,val2,val3,val4);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI) is
  begin
    DebugMsg(TRUE,level,msg,des0,val0);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI) is
  begin
    DebugMsg(TRUE,level,msg,des0,val0,des1,val1);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI) is
  begin
    DebugMsg(TRUE,level,msg,des0,val0,des1,val1,des2,val2);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI) is
  begin
    DebugMsg(TRUE,level,msg ,des0,val0,des1,val1,des2,val2,des3,val3);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI) is
  begin
    DebugMsg(TRUE,level,msg ,des0,val0,des1,val1,des2,val2,des3,val3,des4,val4);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; des0 :TS; val0 :TI; des1 :TS; val1 :TI; des2 :TS; val2 :TI; des3 :TS; val3 :TI; des4 :TS; val4 :TI; des5 :TS; val5 :TI) is
  begin
    DebugMsg(TRUE,level,msg ,des0,val0,des1,val1,des2,val2,des3,val3,des4,val4,des5,val5);
  end procedure;

  -------------------------------------------------------------------

  procedure DebugMsg(level :severity_level; msg :TS; val :TS) is
  begin
    DebugMsg(TRUE,level,msg,val);
  end procedure;

end std_logic_1164_ktp;

