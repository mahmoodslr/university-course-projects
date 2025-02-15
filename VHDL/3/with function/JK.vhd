----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:15:07 05/11/2024 
-- Design Name: 
-- Module Name:    JK - Behavioral 
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

entity JK is
	port( J: in  std_logic;
			K: in  std_logic;
			Reset: in  std_logic;
			Set: in  std_logic;
         Clock: in std_logic;
         F: out std_logic);
end JK;

architecture Behavioral of JK is

signal temp: std_logic:='0';

begin

		F <= temp;
		
process(Clock) 
 begin
      if rising_edge(Clock) then                 
         temp <= (J and not(temp)) or (not(K) and temp);
			if(Reset = '1') then 
				temp <= '0';
			elsif (Set = '1') then 
				temp <= '1';
			end if; 
		end if;
end process;

end Behavioral;

