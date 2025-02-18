----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:01:28 06/08/2024 
-- Design Name: 
-- Module Name:    tamrin6 - Behavioral 
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

entity tamrin6 is
		port (
				x : in signed (7 downto 0);
				y : in signed (3 downto 0);
				clock : in std_logic ;
				output_Q : out signed (7 downto 0);
				output_R : out signed (3 downto 0)
				); 
end tamrin6;

architecture Behavioral of tamrin6 is

component divi
		port(
		clk: in std_logic;
		ref: out std_logic;
		dividend: in std_logic_vector(7 downto 0);
		divisor: in std_logic_vector(3 downto 0);
		quotient: out std_logic_vector(7 downto 0);
		fractional: out std_logic_vector(3 downto 0));
end component;

signal Qou_int : std_logic_vector (7 downto 0) := (others=>'0');
signal Rem_int : std_logic_vector (3 downto 0) := (others=>'0');

begin

	output_Q <= signed(Qou_int);
	output_R <= signed(Rem_int);

	divi_Inst : divi
		port map(
						clk			=> clock,
						ref			=>	open,
						dividend		=>	std_logic_vector(x),
						divisor		=>	std_logic_vector(y),
						quotient		=>	Qou_int,
						fractional	=>	Rem_int
					);
end Behavioral;

