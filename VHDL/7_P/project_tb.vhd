--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:21:52 07/19/2024
-- Design Name:   
-- Module Name:   D:/tamrin/project_tb.vhd
-- Project Name:  tamrin
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: project
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
USE ieee.numeric_std.ALL;
 
ENTITY project_tb IS
END project_tb;
 
ARCHITECTURE behavior OF project_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT project
    PORT(
         int 	: IN   std_logic;
         data  : IN   unsigned(15 downto 0);
         start : IN   std_logic;
         clock : IN   std_logic;
         R     : OUT  std_logic;
         DR    : OUT  unsigned(15 downto 0);
         AC    : OUT  unsigned(15 downto 0);
         IR    : OUT  unsigned(15 downto 0);
         OUTR  : OUT  unsigned(7 downto 0);
         AR 	: OUT  unsigned(6 downto 0);
         PC 	: OUT  unsigned(6 downto 0);
         SP 	: OUT  unsigned(6 downto 0);
         IEN   : OUT  std_logic;
         S 		: OUT  std_logic;
         E 		: OUT  std_logic;
         SC 	: OUT  INTEGER
        );
    END COMPONENT;
    

   --Inputs
   signal int : std_logic := '0';
   signal data : unsigned(15 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal R 	: std_logic;
   signal DR	: unsigned(15 downto 0);
   signal AC   : unsigned(15 downto 0);
   signal IR   : unsigned(15 downto 0);
   signal OUTR : unsigned(7 downto 0);
   signal AR   : unsigned(6 downto 0);
   signal PC   : unsigned(6 downto 0);
   signal SP   : unsigned(6 downto 0);
   signal IEN  : std_logic;
   signal S    : std_logic;
   signal E    : std_logic;
   signal SC   : INTEGER;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: project PORT MAP (
          int => int,
          data => data,
          start => start,
          clock => clock,
          R => R,
          DR => DR,
          AC => AC,
          IR => IR,
          OUTR => OUTR,
          AR => AR,
          PC => PC,
          SP => SP,
          IEN => IEN,
          S => S,
          E => E,
          SC => SC
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
--      wait for 100 ns;	
--
--      wait for clock_period*10;

      -- insert stimulus here 
		
		data<= "0000000000000000","0111100000000000"after 5 ns ,"0010000001001010"after 15 ns, 
			    "0001000001001011" after 25 ns , "0100000001000110" after 35 ns , "0000000000000101" after 45 ns ,
				 "0000000000000111" after 55 ns , "1010101010101010" after 65 ns , "0010000001001100" after 75 ns ,
				 "1111010000000000" after 85 ns , "1111000010000000" after 95 ns , "0000000000000000" after 105 ns ;
		
		start<='1','0' after 116 ns ;
		
		int <= '0','1' after 126 ns ,'0' after 127 ns ,'1' after 166 ns ,'0' after 167 ns ,'1' after 526 ns ,'0' after 527 ns;

      wait;
   end process;

END;
