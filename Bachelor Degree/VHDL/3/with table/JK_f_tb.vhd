--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:05:58 05/06/2024
-- Design Name:   
-- Module Name:   D:/ISE/tamrin3/JK_f_tb.vhd
-- Project Name:  tamrin3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: JK_f
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
 
ENTITY JK_f_tb IS
END JK_f_tb;
 
ARCHITECTURE behavior OF JK_f_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT JK_f
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
   uut: JK_f PORT MAP (
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
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 
		
		J <='0', '1' after 10 ns , '0' after 30 ns;
		K <='0', '1' after 25 ns , '0' after 50 ns;
		Set <='0', '1' after 100 ns, '0' after 150 ns ;
		Reset <='0', '1' after 200 ns ;
		
		
      wait;
   end process;

END;
