----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:11 05/06/2024 
-- Design Name: 
-- Module Name:    Full_Adder_4 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Full_Adder_4 is
		Port ( a : in  signed (3 downto 0);
             b : in  signed (3 downto 0);
             cin : in  signed (0 downto 0);
             s : out  signed (3 downto 0);
             cout : out  STD_LOGIC);
end Full_Adder_4;

architecture Behavioral of Full_Adder_4 is

signal s_int:signed (4 downto 0);

begin

	s_int<= resize(a,5)+b+signed('0' & cin);
	s<= s_int(3 downto 0);
	cout <= s_int(4) xor a(3) xor b(3);
 

end Behavioral;

