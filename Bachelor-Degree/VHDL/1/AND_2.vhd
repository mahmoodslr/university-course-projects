----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:35 05/01/2024 
-- Design Name: 
-- Module Name:    AND_2 - Behavioral 
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

entity AND_2 is
    Port ( A_2 : in  STD_LOGIC;
           B_2 : in  STD_LOGIC;
           F_2 : out  STD_LOGIC);
end AND_2;

architecture Behavioral of AND_2 is

begin

	F_2 <= A_2 AND B_2;

end Behavioral;

