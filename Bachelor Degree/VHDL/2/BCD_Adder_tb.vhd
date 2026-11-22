--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:02:58 05/06/2024
-- Design Name:   
-- Module Name:   D:/ISE/tamrin_2/BCD_Adder_tb.vhd
-- Project Name:  tamrin_2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BCD_Adder
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
 
ENTITY BCD_Adder_tb IS
END BCD_Adder_tb;
 
ARCHITECTURE behavior OF BCD_Adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCD_Adder
    PORT(
         X : IN  std_logic_vector(3 downto 0);
         Y : IN  std_logic_vector(3 downto 0);
         CIN : IN  std_logic_vector(0 downto 0);
         S : OUT  std_logic_vector(3 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(3 downto 0) := (others => '0');
   signal Y : std_logic_vector(3 downto 0) := (others => '0');
   signal CIN : std_logic_vector(0 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCD_Adder PORT MAP (
          X => X,
          Y => Y,
          CIN => CIN,
          S => S,
          COUT => COUT
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for <clock>_period*10;

      -- insert stimulus here 
		X<= "0110";
		Y <= "1110";
		CIN <= "1";

      wait;
   end process;

END;
