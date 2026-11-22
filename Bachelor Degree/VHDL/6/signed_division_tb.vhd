--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:02:34 06/10/2024
-- Design Name:   
-- Module Name:   D:/tamrin/tamrin6_tb.vhd
-- Project Name:  tamrin
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tamrin6
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
 
ENTITY tamrin6_tb IS
END tamrin6_tb;
 
ARCHITECTURE behavior OF tamrin6_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tamrin6
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         y : IN  std_logic_vector(3 downto 0);
         clock : IN  std_logic;
         output_Q : OUT  std_logic_vector(7 downto 0);
         output_R : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');
   signal y : std_logic_vector(3 downto 0) := (others => '0');
   signal clock : std_logic := '0';

 	--Outputs
   signal output_Q : std_logic_vector(7 downto 0);
   signal output_R : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tamrin6 PORT MAP (
          x => x,
          y => y,
          clock => clock,
          output_Q => output_Q,
          output_R => output_R
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		
		x <= "00001100";
		y <= "0010";

      wait;
   end process;

END;
