----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:35 05/06/2024 
-- Design Name: 
-- Module Name:    BCD_Adder - Behavioral 
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

entity BCD_Adder is
		Port ( X : in  signed (3 downto 0);
             Y : in  signed (3 downto 0);
             CIN : in  signed(0 downto 0);
             S : out  signed (3 downto 0);
             COUT : out  STD_LOGIC);
end BCD_Adder;

architecture Behavioral of BCD_Adder is

COMPONENT Full_Adder_4
	PORT(
			a : IN signed(3 downto 0);
			b : IN signed(3 downto 0);
			cin : IN signed(0 downto 0);          
			s : OUT signed(3 downto 0);
			cout : OUT std_logic
		);
END COMPONENT;
signal Q_1 : signed(3 downto 0);
signal  Q_2: signed(3 downto 0);
signal temp : signed(3 downto 0);

begin

	Adder_0: Full_Adder_4 PORT MAP(
			a => X(3 downto 0),
			b => Y(3 downto 0),
			cin => CIN,
			s => Q_1(3 downto 0),
			cout => Q_2(0)
		);
		
		
		Q_2(1) <= Q_2(0) or (Q_1(3) and Q_1(2)) or (Q_1(3) and Q_1(1));
		COUT <= Q_2(1);
		temp <= "0000" when Q_2(1) = '0' else
				  "0110" when Q_2(1) = '1';
	
		
	Adder_1: Full_Adder_4 PORT MAP(
			a => Q_1(3 downto 0),
			b => temp(3 downto 0),
			cin => "0",
			s => S(3 downto 0),
			cout => Q_2(2)
		);
		
end Behavioral;

