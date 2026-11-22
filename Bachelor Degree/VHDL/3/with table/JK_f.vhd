----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:57 05/06/2024 
-- Design Name: 
-- Module Name:    JK_f - Behavioral 
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

entity JK_f is
	port( J,K: in  std_logic;
         Reset: in std_logic;
			Set: in std_logic;
         Clock: in std_logic;
         F: out std_logic);
end JK_f;

architecture Behavioral of JK_f is

signal temp: std_logic;

begin

process(Clock) 
 begin
      if rising_edge(Clock) then                 
         if Reset='1' then   
            temp <= '0';
				elsif Set='1' then
					temp <= '1';
            elsif (J='0' and K='1') then
               temp <= '0';
            elsif (J='1' and K='0') then
               temp <= '1';
            elsif (J='1' and K='1') then
               temp <= not (temp);
			end if;
		end if;
end process;
   F <= temp;

end Behavioral;

