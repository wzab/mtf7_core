----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2014 12:23:50
-- Design Name: 
-- Module Name: gth_refclk_fanout - Behavioral
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

library UNISIM;
use UNISIM.VComponents.all;

entity gth_refclk_fanout is
Port( 
    gt_refclk_sync_p : in STD_LOGIC_vector(5 downto 0);
    gt_refclk_sync_n : in STD_LOGIC_vector(5 downto 0);
    gt_refclk_sync : out std_logic_vector(5 downto 0)
);
end gth_refclk_fanout;

architecture Behavioral of gth_refclk_fanout is

attribute syn_noclockbuf : boolean;

signal gt_refclk_sync_i : std_logic_vector(5 downto 0);
--attribute syn_noclockbuf of gt_refclk_i : signal is true;

begin

--Unfortunately this whole clocking structure can't be made in a fully 'elegant' way
--because it's directly dependent on the physical connections on the PCB.
--Reference clocks on MTF7 are connected to every 2nd or every 3rd GTH quad, taking
--advantage of the fact that GTH/GTX can borrow clock from vertically neighbouring
--transceivers.
--Please note that sync/async clocks are inverted relative to schematics

--SYNC clock mapping:
--[ibufds_gte0] (GTH 110, port 0) -----> GTH 111 (channels 0-3)
--[ibufds_gte1] (GTH 113, port 1) -----> GTH 112 (channels 4-7)
--                         |---> GTH 113 (channels 8-11)
--[ibufds_gte2] (GTH 211, port 4) -----> GTH 211 (channels 12-15)
--                         |---> GTH 212 (channels 16-19)
--[ibufds_gte3] (GTH 213, port 5) -----> GTH 213 (channels 20-23)

ibufds_gt0 : IBUFDS_GTE2  
port map
(   O => gt_refclk_sync_i(0),
    ODIV2 => open,
    CEB => '0',
    I =>  gt_refclk_sync_p(0),
    IB => gt_refclk_sync_n(0));
    
ibufds_gt1 : IBUFDS_GTE2
port map
(   O => gt_refclk_sync_i(1),
    ODIV2 => open,
    CEB => '0',
    I =>  gt_refclk_sync_p(1),
    IB => gt_refclk_sync_n(1));
gt_refclk_sync_i(2) <= gt_refclk_sync_i(1);

ibufds_gt2 : IBUFDS_GTE2
port map
(   O => gt_refclk_sync_i(3),
    ODIV2 => open,
    CEB => '0',
    I =>  gt_refclk_sync_p(4),
    IB => gt_refclk_sync_n(4));
gt_refclk_sync_i(4) <= gt_refclk_sync_i(3);

ibufds_gt3 : IBUFDS_GTE2
port map
(   O => gt_refclk_sync_i(5),
    ODIV2 => open,
    CEB => '0',
    I =>  gt_refclk_sync_p(5),
    IB => gt_refclk_sync_n(5));
    
gt_refclk_sync <= gt_refclk_sync_i;

end Behavioral;
