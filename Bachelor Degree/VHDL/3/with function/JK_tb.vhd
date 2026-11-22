--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:22:53 05/11/2024
-- Design Name:   
-- Module Name:   D:/ISE/tamrin3/JK_tb.vhd
-- Project Name:  tamrin3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: JK
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
 
ENTITY JK_tb IS
END JK_tb;
 
ARCHITECTURE behavior OF JK_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT JK
    PORT(
         J : IN  std_logic;
         K : IN  std_logic;
         Reset : IN  std_logic;
         Set : IN  std_logic;
         Clock : IN  std_logic;
         F : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal J : std_logic := '0';
   signal K : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Set : std_logic := '0';
   signal Clock : std_logic := '0';

 	--Outputs
   signal F : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: JK PORT MAP (
          J => J,
          K => K,
          Reset => Reset,
          Set => Set,
          Clock => Clock,
          F => F
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
      wait for 10 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 
		
		J <= '1' , '0' after 10 ns;
		K <= '0' , '1' after 20 ns;
		Reset <= '0' ;
		Set <= '0' , '1' after 30 ns;

      wait;
   end process;

END;
