----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2014 16:58:03
-- Design Name: 
-- Module Name: mtf7_core_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ipbus.all;
use work.links_pkg.all;

library UNISIM;
use UNISIM.VComponents.all;

entity mtf7_core_top is
Port (
--General signals
    m_aresetn : in std_logic;
    clk_125M : in std_logic;
--Chip2Chip interface
    ext_clk_in : in std_logic;
    ext_data_in : in std_logic_vector(8 downto 0);
    ext_clk_out : out std_logic;
    ext_data_out : out std_logic_vector(8 downto 0);
--TTC
    ttc_data_p : in std_logic;
    ttc_data_n : in std_logic;
    lhc_clk_p : in std_logic;
    lhc_clk_n : in std_logic;
--GTH
    gth_refclk_sync_p : in std_logic_vector(5 downto 0);
    gth_refclk_sync_n : in std_logic_vector(5 downto 0);
    gth_rxp : in std_logic_vector(23 downto 0);
    gth_rxn : in std_logic_vector(23 downto 0);
--LEDs
    led : out std_logic_vector(3 downto 0);

    clk40_in : in std_logic;
--test signals
    clk40_out : out std_logic;
    clk200_out : out std_logic
);
end mtf7_core_top;

architecture Behavioral of mtf7_core_top is

constant NSLV: positive := 3;
constant CII_ADDR_WIDTH : positive := 16;
constant GOL_QUADS_NUMBER : natural := 6;

attribute mark_debug : string;

signal clk_125M_buf : std_logic;
signal idelay_ref_clk : std_logic;
signal clk40_aligned : std_logic;
signal lhc_clk : std_logic;
signal gt_refclk_sync : std_logic_vector(5 downto 0);

signal omtf_clk160 : std_logic;
signal omtf_clk320 : std_logic;

signal m_aclk : std_logic;
signal m_axi_awid : std_logic_vector(0 downto 0);
signal m_axi_awaddr : std_logic_vector(31 downto 0);
signal m_axi_awlen : std_logic_vector(7 downto 0);
signal m_axi_awsize : std_logic_vector(2 downto 0);
signal m_axi_awburst : std_logic_vector(1 downto 0);
signal m_axi_awvalid : std_logic;
signal m_axi_awready : std_logic;
signal m_axi_wuser : std_logic_vector(0 downto 0);
signal m_axi_wdata : std_logic_vector(31 downto 0);
signal m_axi_wstrb : std_logic_vector(3 downto 0);
signal m_axi_wlast : std_logic;
signal m_axi_wvalid : std_logic;
signal m_axi_wready : std_logic;
signal m_axi_bid : std_logic_vector(0 downto 0) := "0";
signal m_axi_bresp : std_logic_vector(1 downto 0);
signal m_axi_bvalid : std_logic;
signal m_axi_bready : std_logic;
signal m_axi_arid : std_logic_vector(0 downto 0);
signal m_axi_araddr : std_logic_vector(31 downto 0);
signal m_axi_arlen : std_logic_vector(7 downto 0);
signal m_axi_arsize : std_logic_vector(2 downto 0);
signal m_axi_arburst : std_logic_vector(1 downto 0);
signal m_axi_arvalid : std_logic;
signal m_axi_arready : std_logic;
signal m_axi_rid : std_logic_vector(0 downto 0) := "0";
signal m_axi_rdata : std_logic_vector(31 downto 0);
signal m_axi_rresp : std_logic_vector(1 downto 0);
signal m_axi_rlast : std_logic;
signal m_axi_rvalid : std_logic;
signal m_axi_rready : std_logic;
signal axi_c2c_s2m_intr_in : std_logic_vector(3 downto 0) := "0000";
signal axi_c2c_m2s_intr_out : std_logic_vector(3 downto 0);
signal axi_c2c_link_status : std_logic;
attribute mark_debug of axi_c2c_link_status: signal is "true";
signal axi_c2c_multi_bit_error : std_logic;
attribute mark_debug of axi_c2c_multi_bit_error: signal is "true";

signal ipb_rst : std_logic;
signal ipb_clk : std_logic;
signal ipb_master_in : ipb_rbus;
attribute mark_debug of ipb_master_in: signal is "true";
signal ipb_master_out : ipb_wbus;
attribute mark_debug of ipb_master_out: signal is "true";
signal ipbw: ipb_wbus_array(NSLV-1 downto 0);
signal ipbr, ipbr_d: ipb_rbus_array(NSLV-1 downto 0);

signal cii_resetn : std_logic;
signal cii_opern : std_logic;
signal cii_writen : std_logic;
signal cii_stroben : std_logic;
signal cii_addr : std_logic_vector(CII_ADDR_WIDTH-1 downto 0);
signal cii_din : std_logic_vector(31 downto 0);
signal cii_dout : std_logic_vector(31 downto 0);

signal gol_data : t_32b_array(4*GOL_QUADS_NUMBER-1 downto 0);
signal usrclk_gol : std_logic;

begin

clk40_out <= lhc_clk;
clk200_out <= idelay_ref_clk;
m_aclk <= lhc_clk;
ipb_rst <= not(m_aresetn);

clk125_ibuf: IBUFG port map(
    I => clk_125M,
    O => clk_125M_buf
);

ctoc: entity work.control_to_core_slave_axi
PORT MAP (
    m_aclk => m_aclk,
    m_aresetn => m_aresetn,
--    m_axi_awid => m_axi_awid,
    m_axi_awaddr => m_axi_awaddr,
    m_axi_awlen => m_axi_awlen,
    m_axi_awsize => m_axi_awsize,
    m_axi_awburst => m_axi_awburst,
    m_axi_awvalid => m_axi_awvalid,
    m_axi_awready => m_axi_awready,
    m_axi_wuser => m_axi_wuser,
    m_axi_wdata => m_axi_wdata,
    m_axi_wstrb => m_axi_wstrb,
    m_axi_wlast => m_axi_wlast,
    m_axi_wvalid => m_axi_wvalid,
    m_axi_wready => m_axi_wready,
--    m_axi_bid => m_axi_bid,
    m_axi_bresp => m_axi_bresp,
    m_axi_bvalid => m_axi_bvalid,
    m_axi_bready => m_axi_bready,
--    m_axi_arid => m_axi_arid,
    m_axi_araddr => m_axi_araddr,
    m_axi_arlen => m_axi_arlen,
    m_axi_arsize => m_axi_arsize,
    m_axi_arburst => m_axi_arburst,
    m_axi_arvalid => m_axi_arvalid,
    m_axi_arready => m_axi_arready,
--    m_axi_rid => m_axi_rid,
    m_axi_rdata => m_axi_rdata,
    m_axi_rresp => m_axi_rresp,
    m_axi_rlast => m_axi_rlast,
    m_axi_rvalid => m_axi_rvalid,
    m_axi_rready => m_axi_rready,
    axi_c2c_s2m_intr_in => axi_c2c_s2m_intr_in,
    axi_c2c_m2s_intr_out => axi_c2c_m2s_intr_out,
    idelay_ref_clk => idelay_ref_clk,
    axi_c2c_link_status_out => axi_c2c_link_status,
    axi_c2c_multi_bit_error_out => axi_c2c_multi_bit_error,
--    m_aclk_out => m_aclk,
    
    axi_c2c_selio_tx_clk_out => ext_clk_out,
    axi_c2c_selio_tx_data_out => ext_data_out,
    axi_c2c_selio_rx_clk_in => ext_clk_in,
    axi_c2c_selio_rx_data_in => ext_data_in
  );

axi_ipbus_bridge: entity work.axi_to_ipbus
port map(
    s_aclk => m_aclk,
    s_aresetn => m_aresetn,
    s_axi_awaddr => m_axi_awaddr,
    s_axi_awlen => m_axi_awlen,
    s_axi_awvalid => m_axi_awvalid,
    s_axi_awready => m_axi_awready,
    s_axi_wdata => m_axi_wdata,
    s_axi_wstrb => m_axi_wstrb,
    s_axi_wlast => m_axi_wlast,
    s_axi_wvalid => m_axi_wvalid,
    s_axi_wready => m_axi_wready,
    s_axi_bresp => m_axi_bresp,
    s_axi_bvalid => m_axi_bvalid,
    s_axi_bready => m_axi_bready,
    s_axi_araddr => m_axi_araddr,
    s_axi_arlen => m_axi_arlen,
    s_axi_arvalid => m_axi_arvalid,
    s_axi_arready => m_axi_arready,
    s_axi_rdata => m_axi_rdata,
    s_axi_rresp => m_axi_rresp,
    s_axi_rlast => m_axi_rlast,
    s_axi_rvalid => m_axi_rvalid,
    s_axi_rready => m_axi_rready,
    -- Master IPbus ports
    ipb_clk => ipb_clk,
    rst_ipb => ipb_rst,
    ipb_out => ipb_master_out,
    ipb_in => ipb_master_in
);

ipb_fabric: entity work.ipbus_fabric
	generic map(NSLV => NSLV)
	port map(
	ipb_in => ipb_master_out,
	ipb_out => ipb_master_in,
	ipb_to_slaves => ipbw,
	ipb_from_slaves => ipbr
);

-- Slave 1: 1kword RAM
ipb_sl1: entity work.ipbus_ram
generic map(addr_width => 10)
port map(
    clk => ipb_clk,
    reset => ipb_rst,
    ipbus_in => ipbw(0),
    ipbus_out => ipbr(0)
);

ipb_sl2: entity work.ipb_cii_bridge
generic map(g_addr_width => 16)
port map(
    clk => ipb_clk,
    ipb_rst => ipb_rst,
    ipb_in => ipbw(1),
    ipb_out => ipbr(1),
    ii_resetn => cii_resetn,
    ii_opern => cii_opern,
    ii_writen => cii_writen,
    ii_stroben => cii_stroben,
    ii_addr => cii_addr,
    ii_dout => cii_din,
    ii_din => cii_dout
);

cii_master: entity work.ktp_mtf7_top
port map(
    TTC_CLK_p => lhc_clk_p,
    TTC_CLK_n => lhc_clk_n,
    TTC_data_p => ttc_data_p,
    TTC_data_n => ttc_data_n,
    lhc_clk => lhc_clk,
    --RPC link
    link_data => gol_data(0),
    --CII
    ii_resetn => cii_resetn,
    ii_opern => cii_opern,
    ii_writen => cii_writen,
    ii_stroben => cii_stroben,
    ii_addr => cii_addr,
    ii_in_data => cii_din,
    ii_out_data => cii_dout
);

gol_receiver: entity work.gol_controller
generic map(
    g_quads_number => GOL_QUADS_NUMBER
)
port map(
    ipb_rst => ipb_rst,
    ipb_clk => ipb_clk,
    ipb_in => ipbw(2),
    ipb_out => ipbr(2),
    
    gt_refclk => gt_refclk_sync(GOL_QUADS_NUMBER-1 downto 0),
    gt_rxp => gth_rxp,
    gt_rxn => gth_rxn,
    usrclk_out => usrclk_gol,
    data_out => gol_data
);

omtf_processor: entity work.omtf_processor_v1
port map(
    ipb_rst => ipb_rst,
    ipb_clk => ipb_clk,
    ipb_in => ipbw(3),
    ipb_out => ipbr(3),

    clk_160 => omtf_clk160,
    clk_320 => omtf_clk320
    );

m_pll: entity work.main_pll
port map ( 
    -- Clock in ports
    clk_in1 => clk40_in,
    -- Clock out ports  
    clk40_aligned => clk40_aligned,
    clk_200 => idelay_ref_clk,              
    clk_160 => omtf_clk160,             
    clk_320 => omtf_clk320              
);

gth_refclk_fanout: entity work.gth_refclk_fanout
port map(
    gt_refclk_sync_p => gth_refclk_sync_p,
    gt_refclk_sync_n => gth_refclk_sync_n,
    
    gt_refclk_sync => gt_refclk_sync
);

led(0) <= axi_c2c_link_status and not(axi_c2c_multi_bit_error);
led(3 downto 1) <= "000";

end Behavioral;
