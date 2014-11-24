----------------------------------------------------------------------------------
-- Company: Warsaw University of Technology
-- Engineer: Adrian Byszuk
-- 
-- Create Date: 21.11.2014 13:49:35
-- Design Name: 
-- Module Name: ipb_cii_bridge - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This is a bridge from IPbus slave to CII master
-- 
-- Dependencies: IPbus package declarations
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ipbus.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity ipb_cii_bridge is
    Generic ( constant g_addr_width : positive := 16
    );
    Port ( ipb_rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           ipb_out: out ipb_rbus := IPB_RBUS_NULL; -- IPbus bus signals
           ipb_in: in ipb_wbus;
           ii_resetn : out STD_LOGIC := '0';
           ii_opern : out STD_LOGIC;
           ii_writen : out STD_LOGIC;
           ii_stroben : out STD_LOGIC;
           ii_addr : out STD_LOGIC_VECTOR (g_addr_width-1 downto 0);
           ii_dout : out STD_LOGIC_VECTOR (31 downto 0);
           ii_din : in STD_LOGIC_VECTOR (31 downto 0));
end ipb_cii_bridge;

architecture Behavioral of ipb_cii_bridge is

attribute mark_debug: string;

type bus_state_t is (IDLE, WR, WR_ACK, RD, RD_ACK);
signal bus_state : bus_state_t := IDLE;
attribute mark_debug of bus_state: signal is "true";

signal ii_opern_i : std_logic := '1';
attribute mark_debug of ii_opern_i: signal is "true";
signal ii_writen_i : std_logic := '1';
attribute mark_debug of ii_writen_i: signal is "true";
signal ii_stroben_i : std_logic := '1';
attribute mark_debug of ii_stroben_i: signal is "true";
signal ii_addr_i : std_logic_vector(g_addr_width-1 downto 0);
attribute mark_debug of ii_addr_i: signal is "true";
signal ii_dout_i : std_logic_vector(31 downto 0);
attribute mark_debug of ii_dout_i: signal is "true";
signal ii_din_i : std_logic_vector(31 downto 0);
attribute mark_debug of ii_din_i: signal is "true";

begin

process(clk)
begin
    if rising_edge(clk) then
        ii_resetn <= not(ipb_rst);
    end if;
end process;

--This whole bridge could be done as a simple glue logic,
--but we add register to ease routing & timing constraints
process(clk)
begin
    if rising_edge(clk) then
        if ipb_rst = '1' then
            ii_opern_i <= '1';
            ii_writen_i <= '1';
            ii_stroben_i <= '1';
            bus_state <= IDLE;
        else
            case bus_state is
            when IDLE =>
                ii_opern_i <= '1';
                ii_writen_i <= '1';
                ii_stroben_i <= '1';
                ipb_out.ipb_ack <= '0';
                ipb_out.ipb_err <= '0';
                
                if (ipb_in.ipb_strobe = '1' and ipb_in.ipb_write = '1') then
                    ii_addr_i <= ipb_in.ipb_addr(g_addr_width-1 downto 0);
                    ii_dout_i <= ipb_in.ipb_wdata;
                    ii_writen_i <= '0';
                    ii_opern_i <= '0';
                    bus_state <= WR;
                elsif (ipb_in.ipb_strobe = '1' and ipb_in.ipb_write = '0') then
                    ii_addr_i <= ipb_in.ipb_addr(g_addr_width-1 downto 0);
                    ii_writen_i <= '1';
                    ii_opern_i <= '0';
                    bus_state <= RD;
                end if;
            when WR =>
                ii_stroben_i <= not(ii_stroben_i);
                --latch new data after write (rising edge of stroben signal)
                if ii_stroben_i = '0' then
                    bus_state <= WR_ACK;
                end if;
            when WR_ACK => 
                ipb_out.ipb_ack <= '1';
                ii_opern_i <= '1';
                bus_state <= IDLE;
            when RD =>
                ii_stroben_i <= '0';
                if ii_stroben_i = '0' then
                    ii_din_i <= ii_din;
                    ii_stroben_i <= '1';
                    bus_state <= RD_ACK;
                end if;
            when RD_ACK =>
                ipb_out.ipb_ack <= '1';
                ii_opern_i <= '1';
                --in fact it's more logical to check ipb_ack, but it's equivalent in practice 
                if ii_opern_i = '1' then
                    ipb_out.ipb_ack <= '0';
                    bus_state <= IDLE;
                end if;
            end case;
        end if;
    end if;
end process;

ii_opern <= ii_opern_i;
ii_writen <= ii_writen_i;
ii_stroben <= ii_stroben_i;
ii_addr <= ii_addr_i;
ii_dout <= ii_dout_i;

ipb_out.ipb_rdata <= ii_din_i;

end Behavioral;
