----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:14 05/01/2024 
-- Design Name: 
-- Module Name:    MUX_2TO1 - Behavioral 
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

entity MUX_2TO1 is
    Port ( I : in  STD_LOGIC_VECTOR (1 downto 0);
           S : in  STD_LOGIC;
           F : out  STD_LOGIC);
end MUX_2TO1;

architecture Behavioral of MUX_2TO1 is

	COMPONENT AND_2
	PORT(
		A_2 : IN std_logic;
		B_2 : IN std_logic;          
		F_2 : OUT std_logic
		);
	END COMPONENT;

	COMPONENT OR_2
	PORT(
		A_1 : IN std_logic;
		B_1 : IN std_logic;          
		F_1 : OUT std_logic
		);
	END COMPONENT;

signal E : STD_LOGIC_VECTOR (1 downto 0);

begin

	AND0: AND_2 PORT MAP(
		A_2 => I(0),
		B_2 => not(S),
		F_2 => E(0)
	);

	AND1: AND_2 PORT MAP(
		A_2 => I(1),
		B_2 => S,
		F_2 => E(1)
	);
	
	OR0: OR_2 PORT MAP(
		A_1 => E(0),
		B_1 => E(1),
		F_1 => F
	);


end Behavioral;

