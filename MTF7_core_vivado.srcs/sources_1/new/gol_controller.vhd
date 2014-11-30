----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 26.11.2014 13:55:14
-- Design Name:
-- Module Name: gol_controller - Behavioral
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
use IEEE.std_logic_misc.all;
use IEEE.NUMERIC_STD.ALL;
use work.ipbus.all;
use work.links_pkg.all;

library UNISIM;
use UNISIM.VComponents.all;

entity gol_controller is
generic(
    constant g_quads_number : natural := 6 --MIN:1, MAX:8
);
Port(
    ipb_rst : in STD_LOGIC;
    ipb_clk : in STD_LOGIC;
    ipb_out: out ipb_rbus := IPB_RBUS_NULL; -- IPbus bus signals
    ipb_in: in ipb_wbus;
    gt_refclk : in STD_LOGIC_vector(g_quads_number-1 downto 0);
    gt_rxp : in std_logic_vector(4*g_quads_number-1 downto 0);
    gt_rxn : in std_logic_vector(4*g_quads_number-1 downto 0);
    usrclk_out : out STD_LOGIC;
    data_out : out t_32b_array(4*g_quads_number-1 downto 0)
);
end gol_controller;

architecture Behavioral of gol_controller is

constant CTRL_REG_AWIDTH : positive := 2;
constant STAT_REG_AWIDTH : positive := 3;

signal mmcm_reset : std_logic;
signal mmcm_locked : std_logic;
signal gt_rxusrclk_i : std_logic;
signal gt_rxusrclk2_i : std_logic;
signal channel_reset_i : std_logic_vector(4*g_quads_number-1 downto 0);

--------------------------------- CPLL Ports -------------------------------
signal  gt_cpllfbclklost_i  : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_cplllock_i       : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_cpllpd_i         : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_cpllrefclklost_i : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_cpllreset_i      : std_logic_vector(4*g_quads_number-1 downto 0);
--------------------- RX Initialization and Reset Ports --------------------
signal  gt_eyescanreset_i : std_logic_vector(4*g_quads_number-1 downto 0);
-------------------------- RX Margin Analysis Ports ------------------------
signal  gt_eyescandataerror_i : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_eyescantrigger_i   : std_logic_vector(4*g_quads_number-1 downto 0);
------------------- Receive Ports - Digital Monitor Ports ------------------
signal  gt_dmonitorout_i : t_15b_array(4*g_quads_number-1 downto 0);
------------------ Receive Ports - FPGA RX interface Ports -----------------
signal  gt_rxdata_i : t_32b_array(4*g_quads_number-1 downto 0);
------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
signal  gt_rxdisperr_i    : t_4b_array(4*g_quads_number-1 downto 0);
signal  gt_rxnotintable_i : t_4b_array(4*g_quads_number-1 downto 0);
------------------- Receive Ports - RX Buffer Bypass Ports -----------------
signal  gt_rxbufstatus_i     : t_3b_array(4*g_quads_number-1 downto 0);
signal  gt_rxdlyen_i         : std_logic;
signal  gt_rxdlysreset_i     : std_logic;
signal  gt_rxdlysresetdone_i : std_logic;
signal  gt_rxphalign_i       : std_logic;
signal  gt_rxphaligndone_i   : std_logic;
signal  gt_rxphalignen_i     : std_logic;
signal  gt_rxphdlyreset_i    : std_logic;
signal  gt_rxphmonitor_i     : t_5b_array(4*g_quads_number-1 downto 0);
signal  gt_rxphslipmonitor_i : t_5b_array(4*g_quads_number-1 downto 0);
signal  gt_rxsyncallin_i     : std_logic;
signal  gt_rxsyncdone_i      : std_logic;
signal  gt_rxsyncin_i        : std_logic;
signal  gt_rxsyncmode_i      : std_logic;
signal  gt_rxsyncout_i       : std_logic;
-------------- Receive Ports - RX Byte and Word Alignment Ports ------------
signal  gt_rxbyteisaligned_i : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_rxbyterealign_i   : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_rxcommadet_i      : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_rxmcommaalignen_i : std_logic_vector(4*g_quads_number-1 downto 0) := (others => '0');
signal  gt_rxpcommaalignen_i : std_logic_vector(4*g_quads_number-1 downto 0) := (others => '1');
-------------------- Receive Ports - RX Equailizer Ports -------------------
signal  gt_rxlpmhfhold_i : std_logic_vector(4*g_quads_number-1 downto 0);
signal  gt_rxlpmlfhold_i : std_logic_vector(4*g_quads_number-1 downto 0);
--------------------- Receive Ports - RX Equalizer Ports -------------------
signal  gt_rxmonitorout_i : t_7b_array(4*g_quads_number-1 downto 0);
signal  gt_rxmonitorsel_i : t_2b_array(4*g_quads_number-1 downto 0);
------------- Receive Ports - RX Initialization and Reset Ports ------------
signal  gt_gtrxreset_i  : std_logic_vector(4*g_quads_number-1 downto 0) := (others => '0');
signal  gt_rxpcsreset_i : std_logic_vector(4*g_quads_number-1 downto 0) := (others => '0');
signal  gt_rxpmareset_i : std_logic_vector(4*g_quads_number-1 downto 0) := (others => '0');
----------------- Receive Ports - RX Polarity Control Ports ----------------
--please refer to the schematics and XDC pin mapping to understand this
signal  gt_rxpolarity_i : std_logic_vector(4*g_quads_number-1 downto 0) := "001010001110110011111011";
------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
signal  gt_rxchariscomma_i : t_4b_array(4*g_quads_number-1 downto 0);
signal  gt_rxcharisk_i     : t_4b_array(4*g_quads_number-1 downto 0);
-------------- Receive Ports -RX Initialization and Reset Ports ------------
signal  gt_rxresetdone_i : std_logic_vector(4*g_quads_number-1 downto 0);

signal ctrl_regs : std_logic_vector(2**CTRL_REG_AWIDTH*32-1 downto 0);
signal stat_regs : std_logic_vector(2**STAT_REG_AWIDTH*32-1 downto 0) := (others => '0');

signal rx_quad_mux : integer range 0 to g_quads_number-1;
signal rx_chan_mux : integer range 0 to 4*g_quads_number-1;
signal rx_disperr_cnt : unsigned(15 downto 0) := (others => '0');
signal rx_disperr_rst : std_logic;
signal rx_notintable_cnt : unsigned(15 downto 0) := (others => '0');
signal rx_notintable_rst : std_logic;

begin

--Registers map:
--CTRL:
--0x0: Misc signals: MMCM, counters
--0x1: CPLL reset
--0x2: Channel reset
--0x3: CPLL powerdown
--STAT:
--0x4: MMCM status
--0x5: CPLL locked
--0x6: Channel reset done
--0x7: disp_err, notintable counters
--0x8: rxdata lookup

registers: entity work.ipbus_ctrlreg_sync
generic map (
    ctrl_addr_width => CTRL_REG_AWIDTH,
    stat_addr_width => STAT_REG_AWIDTH
) port map (
    clk => ipb_clk,
    reset => ipb_rst,
    ipbus_in => ipb_in,
    ipbus_out => ipb_out,
    ctrl_clk => gt_rxusrclk2_i,
    d => stat_regs,
    q => ctrl_regs
);

mmcm_reset <= ctrl_regs(0);
rx_chan_mux <= to_integer(unsigned(ctrl_regs(12 downto 8)));
rx_quad_mux <= to_integer(unsigned(ctrl_regs(18 downto 16)));
rx_disperr_rst <= ctrl_regs(19);
rx_notintable_rst <= ctrl_regs(20);
gt_cpllreset_i <= ctrl_regs(4*g_quads_number+(32*1)-1 downto (32*1));
channel_reset_i <= ctrl_regs(4*g_quads_number+(32*2)-1 downto (32*2));
gt_cpllpd_i <= ctrl_regs(4*g_quads_number+(32*3)-1 downto (32*3));

stat_regs(0) <= mmcm_locked;
stat_regs(4*g_quads_number+(32*1)-1 downto (32*1)) <= gt_cplllock_i;
stat_regs(4*g_quads_number+(32*2)-1 downto (32*2)) <= gt_rxresetdone_i;
stat_regs(16+(32*3)-1 downto (32*3)) <= std_logic_vector(rx_disperr_cnt);
stat_regs(32+(32*3)-1 downto 16+(32*3)) <= std_logic_vector(rx_notintable_cnt);
stat_regs(32+(32*4)-1 downto (32*4)) <= gt_rxdata_i(rx_chan_mux);

process(gt_rxusrclk2_i)
begin
    if rising_edge(gt_rxusrclk2_i) then
        if rx_disperr_rst = '1' then
            rx_disperr_cnt <= (others => '0');
        elsif (or_reduce(gt_rxdisperr_i(rx_chan_mux)) = '1') and (rx_disperr_cnt < 2**16-1) then
            rx_disperr_cnt <= rx_disperr_cnt + 1;
        end if;
    end if;
end process;

process(gt_rxusrclk2_i)
begin
    if rising_edge(gt_rxusrclk2_i) then
        if rx_notintable_rst = '1' then
            rx_notintable_cnt <= (others => '0');
        elsif (or_reduce(gt_rxnotintable_i(rx_chan_mux)) = '1') and (rx_notintable_cnt < 2**16-1) then
            rx_notintable_cnt <= rx_notintable_cnt + 1;
        end if;
    end if;
end process;

--In the end we choose only one USRCLK to feed it to all transceivers,
--because we want to work synchrounously and all the logic has to be in one clock domain
gt_usrclk_source_1 : entity work.gol_quad_GT_USRCLK_SOURCE
port map
(   mmcm_reset => mmcm_reset,
    gt_refclk_in => gt_refclk(0),

    GT_RXUSRCLK_OUT  => gt_rxusrclk_i,
    GT_RXUSRCLK2_OUT => gt_rxusrclk2_i,
    mmcm_locked => mmcm_locked
);

quads_1g6: for i in 0 to g_quads_number-1 generate
begin
    gol_quad_i : entity work.gol_quad_wrapper
    port map(   --____________________________COMMON PORTS________________________________
        DRP_CLK_IN => ipb_clk,
        SOFT_RESET_IN => channel_reset_i(3+4*i downto 0+4*i),
        GT_REFCLK_IN => gt_refclk(i),
        GT_RXUSRCLK_IN => gt_rxusrclk_i,
        GT_RXUSRCLK2_IN => gt_rxusrclk2_i,
        --____________________________CHANNEL PORTS________________________________
        --------------------------------- CPLL Ports -------------------------------
        gt_cpllfbclklost_out => gt_cpllfbclklost_i(3+4*i downto 0+4*i),
        gt_cplllock_out => gt_cplllock_i(3+4*i downto 0+4*i),
        gt_cpllpd_in => gt_cpllpd_i(3+4*i downto 0+4*i),
        gt_cpllreset_in => gt_cpllreset_i(3+4*i downto 0+4*i),
        -------------------------- Channel - Clocking Ports ------------------------
        gt_gtgrefclk_in => "0000",
        gt_gtnorthrefclk0_in => "0000",
        gt_gtnorthrefclk1_in => "0000",
        gt_gtrefclk1_in => "0000",
        gt_gtsouthrefclk0_in => "0000",
        gt_gtsouthrefclk1_in => "0000",
        ---------------------------- Channel - DRP Ports  --------------------------
        gt_drpaddr_in => (others => x"00" & '0'),
        gt_drpdi_in => (others => x"0000"),
        gt_drpdo_out => open,
        gt_drpen_in => "0000",
        gt_drprdy_out => open,
        gt_drpwe_in => "0000",
        --------------------- RX Initialization and Reset Ports --------------------
        gt_eyescanreset_in => gt_eyescanreset_i(3+4*i downto 0+4*i),
        gt_rxuserrdy_in => "0000",
        -------------------------- RX Margin Analysis Ports ------------------------
        gt_eyescandataerror_out => gt_eyescandataerror_i(3+4*i downto 0+4*i),
        gt_eyescantrigger_in => gt_eyescantrigger_i(3+4*i downto 0+4*i),
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt_dmonitorout_out => gt_dmonitorout_i(3+4*i downto 0+4*i),
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt_rxdata_out => gt_rxdata_i(3+4*i downto 0+4*i),
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt_rxdisperr_out => gt_rxdisperr_i(3+4*i downto 0+4*i),
        gt_rxnotintable_out => gt_rxnotintable_i(3+4*i downto 0+4*i),
        gt_rxchariscomma_out => gt_rxchariscomma_i(3+4*i downto 0+4*i),
        gt_rxcharisk_out => gt_rxcharisk_i(3+4*i downto 0+4*i),
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt_gthrxp_in => gt_rxp(3+4*i downto 0+4*i),
        gt_gthrxn_in => gt_rxn(3+4*i downto 0+4*i),
        ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
        gt_rxbufstatus_out => gt_rxbufstatus_i(3+4*i downto 0+4*i),
        gt_rxphmonitor_out => gt_rxphmonitor_i(3+4*i downto 0+4*i),
        gt_rxphslipmonitor_out => gt_rxphslipmonitor_i(3+4*i downto 0+4*i),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt_rxbyteisaligned_out => gt_rxbyteisaligned_i(3+4*i downto 0+4*i),
        gt_rxbyterealign_out => gt_rxbyterealign_i(3+4*i downto 0+4*i),
        gt_rxcommadet_out => gt_rxcommadet_i(3+4*i downto 0+4*i),
        gt_rxmcommaalignen_in => gt_rxmcommaalignen_i(3+4*i downto 0+4*i),
        gt_rxpcommaalignen_in => gt_rxpcommaalignen_i(3+4*i downto 0+4*i),
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt_rxmonitorout_out => gt_rxmonitorout_i(3+4*i downto 0+4*i),
        gt_rxmonitorsel_in => gt_rxmonitorsel_i(3+4*i downto 0+4*i),
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        --by default transceivers generated by wizard can be reset only via SOFT_RESET_IN
        gt_gtrxreset_in => gt_gtrxreset_i(3+4*i downto 0+4*i),
        gt_rxpcsreset_in => gt_rxpcsreset_i(3+4*i downto 0+4*i),
        gt_rxpmareset_in => gt_rxpmareset_i(3+4*i downto 0+4*i),
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt_rxpolarity_in => gt_rxpolarity_i(3+4*i downto 0+4*i),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt_rxresetdone_out => gt_rxresetdone_i(3+4*i downto 0+4*i),
        --------------------- TX Initialization and Reset Ports --------------------
        gt_gttxreset_in => (others => '1')
    );

end generate;

data_out <= gt_rxdata_i;
usrclk_out <= gt_rxusrclk2_i;

end Behavioral;
