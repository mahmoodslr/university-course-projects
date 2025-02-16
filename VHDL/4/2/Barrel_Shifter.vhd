----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:09 05/17/2024 
-- Design Name: 
-- Module Name:    Barrel_Shifter - Behavioral 
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

entity Barrel_Shifter is
	port(
			data_in : in STD_LOGIC_VECTOR (5 downto 0);
			serial_in : in  STD_LOGIC_VECTOR (5 downto 0);
			load : in  STD_LOGIC;
			shift : in  STD_LOGIC_VECTOR (2 downto 0);
			Clock : in  STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR (5 downto 0)
		);
end Barrel_Shifter;

architecture Behavioral of Barrel_Shifter is
signal data_out_in : STD_LOGIC_VECTOR (5 downto 0) :="000000";
begin

	data_out <= data_out_in ;
	process(Clock)
	begin
			if rising_edge(Clock) then
				if load = '1' then 
					data_out_in <= data_in;
				 end if;
				 if shift = "001" then
						data_out_in <= serial_in(0) & data_out_in(5 downto 1);
					elsif shift = "010" then
						data_out_in <= serial_in(1 downto 0) & data_out_in(5 downto 2);
					elsif shift = "011" then
						data_out_in <= serial_in(2 downto 0) & data_out_in(5 downto 3);
					elsif shift = "100" then
						data_out_in <= serial_in(3 downto 0) & data_out_in(5 downto 4);
					elsif shift = "101" then
						data_out_in <= serial_in(4 downto 0) & data_out_in(5);
					elsif shift = "110" then 
						data_out_in <= serial_in(5 downto 0);
				 end if;
			end if;
	end process;

end Behavioral;

