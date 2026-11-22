----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:48 05/01/2024 
-- Design Name: 
-- Module Name:    OR_2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OR_2 is
    Port ( A_1 : in  STD_LOGIC;
           B_1 : in  STD_LOGIC;
           F_1 : out  STD_LOGIC);
end OR_2;

architecture Behavioral of OR_2 is

begin

	F_1 <= A_1 OR B_1;

end Behavioral;

