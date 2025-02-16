--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:23:42 05/17/2024
-- Design Name:   
-- Module Name:   D:/ISE/tamrin4/Barrel_Shifter_tb.vhd
-- Project Name:  tamrin4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Barrel_Shifter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Barrel_Shifter_tb IS
END Barrel_Shifter_tb;
 
ARCHITECTURE behavior OF Barrel_Shifter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Barrel_Shifter
    PORT(
         data_in : IN  std_logic_vector(5 downto 0);
         load : IN  std_logic_vector(5 downto 0);
         shift : IN  std_logic_vector(2 downto 0);
         Clock : IN  std_logic;
         data_o : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(5 downto 0) := (others => '0');
   signal load : std_logic_vector(5 downto 0) := (others => '0');
   signal shift : std_logic_vector(2 downto 0) := (others => '0');
   signal Clock : std_logic := '0';

 	--Outputs
   signal data_o : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Barrel_Shifter PORT MAP (
          data_in => data_in,
          load => load,
          shift => shift,
          Clock => Clock,
          data_o => data_o
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 
		
		data_in <= "001111";
		load <= "000101";
		shift <= "010";

      wait;
   end process;

END;
