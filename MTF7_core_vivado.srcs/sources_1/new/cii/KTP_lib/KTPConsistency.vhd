-- *********************************************************************
-- *								       *
-- * This file was created by Krzysztof Pozniak(pozniak@ise.pw.edu.pl) *
-- * 	           Copyright (c) by Krzysztof Pozniak		       *
-- * 	       	          All Rights Reserved.			       *
-- *								       *
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.std_logic_1164_ktp.all;

package ktp_consistency is

  constant tabS :TBV :=
   ("01100011", "01111100", "01110111", "01111011", "11110010", "01101011", "01101111", "11000101",
    "00110000", "00000001", "01100111", "00101011", "11111110", "11010111", "10101011", "01110110",
    "11001010", "10000010", "11001001", "01111101", "11111010", "01011001", "01000111", "11110000",
    "10101101", "11010100", "10100010", "10101111", "10011100", "10100100", "01110010", "11000000",
    "10110111", "11111101", "10010011", "00100110", "00110110", "00111111", "11110111", "11001100",
    "00110100", "10100101", "11100101", "11110001", "01110001", "11011000", "00110001", "00010101",
    "00000100", "11000111", "00100011", "11000011", "00011000", "10010110", "00000101", "10011010",
    "00000111", "00010010", "10000000", "11100010", "11101011", "00100111", "10110010", "01110101",
    "00001001", "10000011", "00101100", "00011010", "00011011", "01101110", "01011010", "10100000",
    "01010010", "00111011", "11010110", "10110011", "00101001", "11100011", "00101111", "10000100",
    "01010011", "11010001", "00000000", "11101101", "00100000", "11111100", "10110001", "01011011",
    "01101010", "11001011", "10111110", "00111001", "01001010", "01001100", "01011000", "11001111",
    "11010000", "11101111", "10101010", "11111011", "01000011", "01001101", "00110011", "10000101",
    "01000101", "11111001", "00000010", "01111111", "01010000", "00111100", "10011111", "10101000",
    "01010001", "10100011", "01000000", "10001111", "10010010", "10011101", "00111000", "11110101",
    "10111100", "10110110", "11011010", "00100001", "00010000", "11111111", "11110011", "11010010",
    "11001101", "00001100", "00010011", "11101100", "01011111", "10010111", "01000100", "00010111",
    "11000100", "10100111", "01111110", "00111101", "01100100", "01011101", "00011001", "01110011",
    "01100000", "10000001", "01001111", "11011100", "00100010", "00101010", "10010000", "10001000",
    "01000110", "11101110", "10111000", "00010100", "11011110", "01011110", "00001011", "11011011",
    "11100000", "00110010", "00111010", "00001010", "01001001", "00000110", "00100100", "01011100",
    "11000010", "11010011", "10101100", "01100010", "10010001", "10010101", "11100100", "01111001",
    "11100111", "11001000", "00110111", "01101101", "10001101", "11010101", "01001110", "10101001",
    "01101100", "01010110", "11110100", "11101010", "01100101", "01111010", "10101110", "00001000",
    "10111010", "01111000", "00100101", "00101110", "00011100", "10100110", "10110100", "11000110",
    "11101000", "11011101", "01110100", "00011111", "01001011", "10111101", "10001011", "10001010",
    "01110000", "00111110", "10110101", "01100110", "01001000", "00000011", "11110110", "00001110",
    "01100001", "00110101", "01010111", "10111001", "10000110", "11000001", "00011101", "10011110",
    "11100001", "11111000", "10011000", "00010001", "01101001", "11011001", "10001110", "10010100",
    "10011011", "00011110", "10000111", "11101001", "11001110", "01010101", "00101000", "11011111",
    "10001100", "10100001", "10001001", "00001101", "10111111", "11100110", "01000010", "01101000",
    "01000001", "10011001", "00101101", "00001111", "10110000", "01010100", "10111011", "00010110"
   );
  constant tabinvS :TBV :=
   ("01010010", "00001001", "01101010", "11010101", "00110000", "00110110", "10100101", "00111000",
    "10111111", "01000000", "10100011", "10011110", "10000001", "11110011", "11010111", "11111011",
    "01111100", "11100011", "00111001", "10000010", "10011011", "00101111", "11111111", "10000111",
    "00110100", "10001110", "01000011", "01000100", "11000100", "11011110", "11101001", "11001011",
    "01010100", "01111011", "10010100", "00110010", "10100110", "11000010", "00100011", "00111101",
    "11101110", "01001100", "10010101", "00001011", "01000010", "11111010", "11000011", "01001110",
    "00001000", "00101110", "10100001", "01100110", "00101000", "11011001", "00100100", "10110010",
    "01110110", "01011011", "10100010", "01001001", "01101101", "10001011", "11010001", "00100101",
    "01110010", "11111000", "11110110", "01100100", "10000110", "01101000", "10011000", "00010110",
    "11010100", "10100100", "01011100", "11001100", "01011101", "01100101", "10110110", "10010010",
    "01101100", "01110000", "01001000", "01010000", "11111101", "11101101", "10111001", "11011010",
    "01011110", "00010101", "01000110", "01010111", "10100111", "10001101", "10011101", "10000100",
    "10010000", "11011000", "10101011", "00000000", "10001100", "10111100", "11010011", "00001010",
    "11110111", "11100100", "01011000", "00000101", "10111000", "10110011", "01000101", "00000110",
    "11010000", "00101100", "00011110", "10001111", "11001010", "00111111", "00001111", "00000010",
    "11000001", "10101111", "10111101", "00000011", "00000001", "00010011", "10001010", "01101011",
    "00111010", "10010001", "00010001", "01000001", "01001111", "01100111", "11011100", "11101010",
    "10010111", "11110010", "11001111", "11001110", "11110000", "10110100", "11100110", "01110011",
    "10010110", "10101100", "01110100", "00100010", "11100111", "10101101", "00110101", "10000101",
    "11100010", "11111001", "00110111", "11101000", "00011100", "01110101", "11011111", "01101110",
    "01000111", "11110001", "00011010", "01110001", "00011101", "00101001", "11000101", "10001001",
    "01101111", "10110111", "01100010", "00001110", "10101010", "00011000", "10111110", "00011011",
    "11111100", "01010110", "00111110", "01001011", "11000110", "11010010", "01111001", "00100000",
    "10011010", "11011011", "11000000", "11111110", "01111000", "11001101", "01011010", "11110100",
    "00011111", "11011101", "10101000", "00110011", "10001000", "00000111", "11000111", "00110001",
    "10110001", "00010010", "00010000", "01011001", "00100111", "10000000", "11101100", "01011111",
    "01100000", "01010001", "01111111", "10101001", "00011001", "10110101", "01001010", "00001101",
    "00101101", "11100101", "01111010", "10011111", "10010011", "11001001", "10011100", "11101111",
    "10100000", "11100000", "00111011", "01001101", "10101110", "00101010", "11110101", "10110000",
    "11001000", "11101011", "10111011", "00111100", "10000011", "01010011", "10011001", "01100001",
    "00010111", "00101011", "00000100", "01111110", "10111010", "01110111", "11010110", "00100110",
    "11100001", "01101001", "00010100", "01100011", "01010101", "00100001", "00001100", "01111101"
   ); 
  constant tabpowX :TBV :=
   ("00000001", "00000010", "00000100", "00001000", "00010000", "00100000", "01000000", "10000000",
    "00011011", "00110110", "01101100", "11011000", "10101011", "01001101", "10011010"
  );

  pure function Consistency(constant inp, key, stamp :TBV; constant keyadd, shift :TN) return TBV;
  pure function Consistency(constant inp :THV; constant key :TBV; constant stamp :TBV; constant index :TN) return THV;
  pure function ConsistencyKey(constant key :TBV) return TBV;
	
end ktp_consistency;

package body ktp_consistency is

  constant Nb          : TI := 4;
  constant Nk          : TI := 4;
  constant Nr          : TI := Nk + 6;
  --
  pure function ConsistencyKey(constant key :TBV) return TBV is
    variable res      :TBV(0 to 4*Nb*(Nr+1)-1); 
    variable temp     :TBV(0 to 3); 
    variable i        :TN; 
    variable ttemp    :TB;
    variable tRcon    :TB;
    variable oldtemp0 :TB;
  begin
   
    for j in 0 to 4*Nk-1 loop
      assert key(j)/=0 report "key zero" severity note;
      res(j) := key(j);
    end loop;
    
    for j in Nk to Nb*(Nr+1)-1 loop
      i := j; 
      for iTemp in 0 to 3 loop
        temp(iTemp) := res(4*j-4+iTemp);
      end loop;
      if ((i rem Nk) = 0) then
        oldtemp0 := temp(0);
        for iTemp in 0 to 3 loop
          if (iTemp = 3) then
            ttemp := oldtemp0;
          else
            ttemp := temp(iTemp+1);
          end if;
          if (iTemp = 0) then
            tRcon := tabpowX(i/Nk-1);
          else
            tRcon := (others => '0');
          end if;
          temp(iTemp) := tabS(TNconv(ttemp)) xor tRcon;
        end loop;
      elsif (Nk > 6 and (i rem Nk) = 4) then
        for iTemp in 0 to 3 loop
          temp(iTemp) := tabS(TNconv(temp(iTemp)));
        end loop;
      end if;
      for iTemp in 0 to 3 loop
        res(4*j+iTemp) := TB(TB(res(4*j - 4*Nk + iTemp)) xor TB(temp(iTemp)));
      end loop;
    end loop;
    return (res);
  end function;
 
  pure function ConsistencyPart(constant inp, key :TBV) return TBV is
    type     Tstate is array (0 to 3) of TBV(0 to Nb-1);
    --
    pure function copy(constant inp :TBV) return TState is
      variable res   :TState; 
    begin
      for c in 0 to Nb-1 loop
        for r in 0 to 3 loop
          res(r)(c) := inp(4*c+r);
        end loop;
      end loop;
      return(res);
    end function;
              
    pure function copy(constant state :TState) return TBV is
      variable res    :TBV(0 to state'length*state(0)'length-1); 
    begin
      for c in 0 to Nb-1 loop
        for r in 0 to 3 loop
          res(4*c+r) := state(r)(c);
        end loop;
      end loop;
      return(res);
    end function;
     
    pure function InvShiftRows(constant state :Tstate) return Tstate is
      variable t   :TBV(0 to 3);
      variable res :Tstate;
    begin
      res := state;
      t := (t'range => (others => '0'));
      for r in 1 to 3 loop
        for c in 0 to Nb-1 loop
          t((c + r) mod Nb) := state(r)(c);
        end loop;
        for c in 0 to Nb-1 loop
          res(r)(c) := t(c);
        end loop;
      end loop;
      return(res);
    end function;
    --
    pure function InvSubBytes(constant state :Tstate) return Tstate is
      variable res :Tstate;
    begin
      for r in 0 to 3 loop
        for c in 0 to Nb-1 loop
          res(r)(c) := tabinvS(TNconv(state(r)(c)));
        end loop;
      end loop;
      return(res);
    end function;
    --
    pure function InvAddRoundKey(constant state :Tstate; constant wCount :TN) return Tstate is
      variable res :Tstate; 
    begin
      for c in 0 to Nb - 1  loop
        for r in 0 to 3 loop
          res(3-r)(Nb - 1-c) := state(3-r)(Nb - 1-c) xor key(wCount-4*c-r-1);
        end loop;
      end loop;
      return(res);
    end function;
    --
    constant wCount :TI := 4*Nb*(Nr+1); 
    variable state  :Tstate; 
  begin
    state := copy(inp); 
    state := InvAddRoundKey(state,wCount);
    state := InvShiftRows(state); 
    state := InvSubBytes(state); 
    return(Copy(state));
  end function;

  pure function Consistency(constant inp, key, stamp :TBV; constant keyadd, shift :TN) return TBV is
    variable dat :TBV(0 to 15);
    variable res :TBV(0 to 15);
    variable den :TBV(inp'range);
    variable stc :TN;
  begin
    stc := modulo(16*shift,stamp'length-1);
    for cnt in 0 to inp'length/16-1 loop
      dat := inp(16*cnt to 16*cnt+15);
      res := ConsistencyPart(dat, key);
      den(16*cnt to 16*cnt+15) := res;
      if (stamp'length>0) then
        for i in 0 to 15 loop
          den(16*cnt+i) := den(16*cnt+i) xor stamp(stc+i);
        end loop;
        stc := modulo(stc+16,stamp'length-1);
      end if;
    end loop;
    return(den);
  end function;

  pure function Consistency(constant inp :THV; constant key :TBV; constant stamp :TBV; constant index :TN) return THV is
    variable ivec :TBV(0 to inp'length/2-1);
    variable dvec :TBV(0 to inp'length/2-1);
    variable kvec :TBV(key'range);
    variable rvec :THV(inp'range);
  begin
    ivec := THV2TBV(inp);
    rvec := TBV2THV(Consistency(ivec,kvec,stamp,index,index));
    return(rvec);
  end function;

end ktp_consistency;
