library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.std_logic_1164_ktp.all;

use work.ComponentII.all;
use work.CII_SYS_def.all,   work.CII_SYS_prv.all,   work.CII_SYS_dec.all;

use work.CII_MTF7_opto_def.all;
use work.CII_MTF7_opto_prv.all;

entity CII_MTF7_opto is
  generic (
    constant IICPAR				:TCII := MTF7_OPTO_tab;
    constant IICPOS				:TVI := 0
  );
  port(
    -- internal bus interface
    II_resetN					:in  TSL;
    II_operN					:in  TSL;
    II_writeN					:in  TSL;
    II_strobeN					:in  TSL;
    II_addr					:in  TSLV(CIICompAddrWidthGet(IICPAR(IICPOS))-1 downto 0);
    ii_in_data					:in  TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0);
    II_out_data					:out TSLV(CIICompDataWidthGet(IICPAR(IICPOS))-1 downto 0)
);
end CII_MTF7_opto;    

architecture behaviour of CII_MTF7_opto is

  --#CII# declaration insert start for 'MTF7_OPTO' - don't edit below !
  type TCIIpar                                            is record
    CHECK_SUM                                             :TI;
    COMP_ID                                               :TCII(0 to maximum(CIICompRepeatGet(IICPAR(CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)))))-1,0));
  end record;

  function CIIpar_get return TCIIpar is
    variable res: TCIIpar;
    variable pos, idx, len: TN;
  begin
    pos := CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.CHECK_SUM);
    res.CHECK_SUM := IICPAR(pos).ItemAddrPos*IICPAR(pos).ItemAddrLen;
    pos := CIICompPtrGet(IICPAR(CIIItemPosGet(IICPAR(IICPOS),MTF7_OPTO.COMP_ID)));
    for num in res.COMP_ID'range loop
      res.COMP_ID(num) := IICPAR(pos+num);
    end loop;
    return(res);
  end function;

  constant CIIPar                                         :TCIIpar := CIIpar_get;

  type     TCIIcpd_COMP_ID                                is array(0 to maximum(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat,1)-1) of TSLV(maximum(IICPAR(CIICompPtrGet(IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID))).ItemWidth,1)-1 downto 0);
  signal   CIIcpd_COMP_ID                                 :TCIIcpd_COMP_ID := (TCIIcpd_COMP_ID'range => (others =>'0'));
  signal   CIIcpdv_COMP_ID                                :TSLV(maximum(CIICompDataWidthGet(IICPAR(IICPOS))*IICPAR(IICPAR(IICPOS).ItemWrPos+MTF7_OPTO.COMP_ID).ItemRepeat-1,0) downto 0);
  function CIIcpdv_COMP_ID_get(d :TCIIcpd_COMP_ID) return TSLV is constant L :TN := d(0)'length; variable r :TSLV(TCIIcpd_COMP_ID'length*L-1 downto 0); begin for i in TCIIcpd_COMP_ID'range loop r(L*(i+1)-1 downto L*i) := d(i); end loop; return(r); end function;
  --#CII# declaration insert end for 'MTF7_OPTO' - don't edit above !

begin

  --#CII# instantation insert start for 'MTF7_OPTO' - don't edit below !
  CIIinterf :MTF7_OPTO_cii_interface
    generic map (
      IICPAR                                    => IICPAR,
      IICPOS                                    => IICPOS
    )
    port map (
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
