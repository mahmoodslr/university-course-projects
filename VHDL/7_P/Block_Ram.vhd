----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:34 07/09/2024 
-- Design Name: 
-- Module Name:    Block_Ram - Behavioral 
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

entity Block_Ram is

    generic (
	        AddW:integer:=7;
			  DataW:integer:=16
	         );
    Port ( ReadAddres 		: in  unsigned (AddW-1 downto 0);
           WriteAddres 		: in  unsigned (AddW-1 downto 0);
           DataIn 	 		: in  unsigned (DataW-1 downto 0);
           DataOut			: out  unsigned (DataW-1 downto 0);
           clock  			: in  STD_LOGIC;
           WriteEnable     : in  STD_LOGIC);
end Block_Ram;

architecture Behavioral of Block_Ram is

type RAMtype is array (0 to 2**AddW-1) of unsigned (DataW-1 downto 0);
signal RAMsignal:RAMtype := (others=>(others=>'0'));

attribute ram_style:string;
attribute ram_style of RAMsignal:signal is "Block";

begin
    process (clock)
	 begin
	     if rising_edge (clock) then
		  
		     if WriteEnable='1' then
			     RAMsignal(to_integer(WriteAddres))<= DataIn ; 
    		  end if;
			  
		     DataOut <= RAMsignal(to_integer(ReadAddres)); 


		  end if;
	 end process;
 
end Behavioral;
