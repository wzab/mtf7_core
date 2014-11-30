----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2014 21:26:27
-- Design Name: 
-- Module Name: links_pkg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package links_pkg is

type t_1b_array is array(natural range <>) of std_logic_vector(0 downto 0);
type t_2b_array is array(natural range <>) of std_logic_vector(1 downto 0);
type t_3b_array is array(natural range <>) of std_logic_vector(2 downto 0);
type t_4b_array is array(natural range <>) of std_logic_vector(3 downto 0);
type t_5b_array is array(natural range <>) of std_logic_vector(4 downto 0);
type t_6b_array is array(natural range <>) of std_logic_vector(5 downto 0);
type t_7b_array is array(natural range <>) of std_logic_vector(6 downto 0);
type t_8b_array is array(natural range <>) of std_logic_vector(7 downto 0);
type t_9b_array is array(natural range <>) of std_logic_vector(8 downto 0);
type t_15b_array is array(natural range <>) of std_logic_vector(14 downto 0);
type t_16b_array is array(natural range <>) of std_logic_vector(15 downto 0);
type t_32b_array is array(natural range <>) of std_logic_vector(31 downto 0);

end package;
