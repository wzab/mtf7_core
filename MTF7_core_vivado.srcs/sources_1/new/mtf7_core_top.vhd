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
library UNISIM;
use UNISIM.VComponents.all;

entity mtf7_core_top is
Port (
    m_aresetn : in std_logic;
    clk_125M : in std_logic;

    ext_clk_in : in std_logic;
    ext_data_in : in std_logic_vector(8 downto 0);
    ext_clk_out : out std_logic;
    ext_data_out : out std_logic_vector(8 downto 0);

    led : out std_logic_vector(3 downto 0);

    clk40_in : in std_logic;

    clk40_out : out std_logic;
    clk200_out : out std_logic
);
end mtf7_core_top;

architecture Behavioral of mtf7_core_top is

constant NSLV: positive := 1;

attribute mark_debug : string;

signal clk_125M_buf : std_logic;
signal idelay_ref_clk : std_logic;
signal clk40_aligned : std_logic;

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

begin

clk40_out <= clk40_aligned;
clk200_out <= idelay_ref_clk;
m_aclk <= clk40_aligned;
ipb_clk <= m_aclk;
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
	
m_pll: entity work.main_pll
port map ( 
    -- Clock in ports
    clk_in1 => clk40_in,
    -- Clock out ports  
    clk40_aligned => clk40_aligned,
    clk_200 => idelay_ref_clk              
);

led(0) <= axi_c2c_link_status and not(axi_c2c_multi_bit_error);
led(3 downto 1) <= "000";

end Behavioral;
