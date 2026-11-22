--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:37:05 06/08/2024
-- Design Name:   
-- Module Name:   D:/tamrin/moore_mealy_tb.vhd
-- Project Name:  tamrin
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: moore_mealy
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
 
ENTITY moore_mealy_tb IS
END moore_mealy_tb;
 
ARCHITECTURE behavior OF moore_mealy_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT moore_mealy
    PORT(
         x : IN  std_logic;
         clock : IN  std_logic;
         y : OUT  std_logic;
         y3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal y : std_logic;
   signal y3 : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: moore_mealy PORT MAP (
          x => x,
          clock => clock,
          y => y,
          y3 => y3
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
		
		x <= '0', '1' after 14 ns,'0' after 34 ns, '1' after 45 ns, '0' after 55 ns, '1' after 68 ns, '0' after 75 ns, '1' after 80 ns, '0' after 90 ns;
		
		wait;
   end process;

END;
