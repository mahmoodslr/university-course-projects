----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:32:21 07/17/2024 
-- Design Name: 
-- Module Name:    project - Behavioral 
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

entity project is
		 Port ( 
					int 	 : in  STD_LOGIC;
					data 	 : in  unsigned (15 downto 0);
					start  : in  STD_LOGIC;
					clock  : in  STD_LOGIC;
					R 		 : out STD_LOGIC;
					DR 	 : out unsigned (15 downto 0);
					AC		 : out unsigned (15 downto 0);
					IR		 : out unsigned (15 downto 0);
					OUTR	 : out unsigned (7 downto 0);
					AR		 : out unsigned (6 downto 0);
					PC 	 : out unsigned (6 downto 0);
					SP		 : out unsigned (6 downto 0);
					IEN	 : out STD_LOGIC;
					S  	 : out STD_LOGIC :='1';
					E      : out STD_LOGIC;
					SC  	 : out integer
				);
end project;

architecture Behavioral of project is

	signal DR_signal			: unsigned (15 downto 0):= (others=>'0');
	signal IR_signal			: unsigned (15 downto 0):= (others=>'0');
	signal AC_signal			: unsigned (15 downto 0):= "0111000101011111";
	signal OUTR_signal 		: unsigned (7 downto 0):= (others=>'0');
	signal PC_signal      	: unsigned (6 downto 0):= to_unsigned(70,7); -- 70
	signal AR_signal      	: unsigned (6 downto 0):= (others=>'0');
	signal SP_signal 	  		: unsigned (6 downto 0):= to_unsigned(91,7); -- 91
	signal IEN_signal 		: STD_LOGIC := '1';
	signal E_signal 		   : STD_LOGIC := '1';
	signal S_signal 			: std_logic :='1';
	signal R_signal         : std_logic :='0';
	signal SC_signal			: INTEGER := 0;
	
	signal WA_signal	: unsigned (6 downto 0):= "1000101"; -- 69
	signal Din_signal : unsigned (15 downto 0):=(others=>'0');
	signal Dout_signal: unsigned (15 downto 0):=(others=>'0');
	signal WE_signal	: std_logic := '1';

	signal save_AC   : unsigned (16 downto 0):=(others=>'0');
	
	signal check_start_signal : STD_LOGIC := '0'; 

begin

U_Block_Ram : entity work.Block_Ram

	generic map (
		AddW => 7,
		DataW => 16
	)
	
	PORT MAP(
		ReadAddres  => AR_signal,
		WriteAddres => WA_signal,
		DataIn   	=> Din_signal,
		DataOut 		=> Dout_signal,  
		clock 		=> clock ,
		WriteEnable => WE_signal
	);
	
	DR 	<=	DR_signal  ;
	AC		<= AC_signal  ;
	AR		<= AR_signal  ;
	IR		<= IR_signal  ;
	PC 	<=	PC_signal  ;
	SP		<= SP_signal  ;
	OUTR	<= OUTR_signal;
	IEN	<= IEN_signal ;
	E		<= E_signal   ;
	R		<= R_signal   ;
	S		<= S_signal   ;
	SC		<= SC_signal  ;
	
	process ( clock , int , SC_signal , S_signal , IEN_signal)
	 begin
		
		
		if	(SC_signal/=0 AND SC_signal/=1 AND SC_signal/=2 AND SC_signal/=3 AND SC_signal/=4 AND S_signal = '1' AND IEN_signal = '1' AND int = '1') then
					
				R_signal <= '1';
					
		end if;
	 
			
		if rising_edge(clock) then
			
			if (S_signal = '1') then
			
				-----		1		-----
				
				if (R_signal = '1') then -- intrrupt
				
					if (SC_signal = 0) then -- SC 0
						IEN_signal <= '0';
						SP_signal  <= SP_signal - 1;
						SC_signal  <= SC_signal + 1;
					end if;
					
					if (SC_signal = 1) then -- SC 1
						WE_signal  <= '1';
						WA_signal  <= SP_signal;
						Din_signal <= AC_signal;
						SC_signal  <= SC_signal + 1;
					end if;
					
					if (SC_signal = 2) then -- SC 2
						WE_signal  <= '0';
						SP_signal  <= SP_signal - 1;
						SC_signal  <= SC_signal + 1;
					end if;
					
					if (SC_signal = 3) then -- SC 3
						WE_signal  <= '1';
						WA_signal  <= SP_signal;
						Din_signal(6 downto 0)  <= PC_signal;
						SC_signal  <= SC_signal + 1;
					end if;
					
					if (SC_signal = 4) then -- SC 4
						WE_signal  <= '0';
						PC_signal  <= to_unsigned(77,7);
						R_signal   <= '0';
						SC_signal  <= 0 ;
					end if;
				
				end if; -- intrrupt
				
				-----		2		-----
			
				if (start = '1') then	-- write data
					
					WA_signal  <= WA_signal + 1;
					Din_signal <= data ;
					if (WA_signal = to_unsigned(80,7)) then
						 WE_signal	<= '0';
						 check_start_signal <= '1'; -- for the time we first waited and did not run ( if=>start='0' )
					end if ;
				
				end if; -- start = '1'
				
				-----		3		-----
				
				if (start = '0' AND check_start_signal = '1' AND R_signal = '0') then
					
					if (SC_signal = 0) then	--	SC 0
						AR_signal <= PC_signal;
						SC_signal <= SC_signal + 1 ;
					end if;
					
					if (SC_signal = 1) then	--	SC 1 -- for Dout_signal
						SC_signal <= SC_signal + 1 ;
					end if;
					
					if (SC_signal = 2) then	--	SC 2
						IR_signal  <= Dout_signal;
						PC_signal  <= PC_signal + 1;
						SC_signal <= SC_signal + 1 ;
					end if;
					
					if (SC_signal = 3) then	--	SC 3
						 AR_signal <= IR_signal(6 downto 0);
						 SC_signal <= SC_signal + 1 ;
					end if;
					
					if (SC_signal = 4) then	--	SC 4 -- for intrrupt
						 SC_signal <= SC_signal + 1 ;
					end if;
					
				end if; -- start = '0' AND check_start_signal = '1' AND R_signal = '0'
				
				-----		4		=> 1-register   2-I/O   3-memory
				 
				 --		register instructions -- IR_signal(15 downto 12)="0111"
				 
				if (IR_signal(15 downto 0) = "0111100000000000" AND SC_signal = 5) then	-- CLA -- SC 5
					AC_signal <= (others=>'0');
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111010000000000" AND SC_signal = 5) then	-- CLE -- SC 5
					E_signal <= '0';
					SC_signal<= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111001000000000" AND SC_signal = 5) then	-- CMA -- SC 5
					AC_signal <= not(AC_signal);
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000100000000" AND SC_signal = 5) then	-- CME -- SC 5
					E_signal <= not(E_signal);
					SC_signal<= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000010000000" AND SC_signal = 5) then	-- CIR -- SC 5
					AC_signal <= E_signal & AC_signal(15 downto 1);
					E_signal  <= AC_signal(0);
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000001000000" AND SC_signal = 5) then	-- CIL -- SC 5
					AC_signal <= AC_signal(14 downto 0) & E_signal;
					E_signal  <= AC_signal(15);
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000100000" AND SC_signal = 5) then	-- INC -- SC 5
					AC_signal <= AC_signal + 1 ;
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000010000" AND SC_signal = 5) then	-- SPA -- SC 5
					if (AC_signal(15) = '0') then
						PC_signal  <= PC_signal + 1;
					end if;
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000001000" AND SC_signal = 5) then	-- SNA -- SC 5
					if (AC_signal(15) = '1') then
						PC_signal  <= PC_signal + 1;
					end if;
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000000100" AND SC_signal = 5) then	-- SZA -- SC 5
					if (AC_signal = "0000000000000000" ) then
						PC_signal  <= PC_signal + 1;
					end if;
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000000010" AND SC_signal = 5) then	-- SZE -- SC 5
					if (E_signal = '0') then
						PC_signal  <= PC_signal + 1;
					end if;
					SC_signal <= 0 ;
				end if;
						
						
				if (IR_signal(15 downto 0) = "0111000000000001" AND SC_signal = 5) then	-- HLT -- SC 5
					S_signal  <= '0';
					SC_signal <= 0 ;
				end if;
					
						
				 --	I/O instructions -- IR_signal(15 downto 12)="1111"
						
				if(IR_signal(15 downto 0) = "1111010000000000" AND SC_signal = 5)then --	OUT -- SC 5
					OUTR_signal <= AC_signal(7 downto 0);
					SC_signal   <= 0;
				end if ;	--	OUT
						
				if(IR_signal(15 downto 0) = "1111000010000000" AND SC_signal = 5)then -- ION -- SC 5
					IEN_signal <= '1';
					SC_signal  <= 0 ;		
				end if ;	-- ION
							
				 --	memory instructions -- IR_signal(14 downto 12) /= "111"
				
				if (IR_signal(14 downto 12) = "010") then -- LDA
						
						if	(SC_signal = 5)	then -- SC 5
							DR_signal <= Dout_signal;
							SC_signal <= SC_signal+ 1;
						end if ;
							
						if(SC_signal = 6)then -- SC 6
							AC_signal <= DR_signal;
							SC_signal <= 0;
						end if;
						
				end if; -- LDA
					
					
				if (IR_signal(14 downto 12) = "001") then -- ADD
						
						if	(SC_signal = 5)	then -- SC 5
							DR_signal <= Dout_signal;
							SC_signal <= SC_signal+ 1;
						end if ;
							
						if(SC_signal = 6)then -- SC 6
							save_AC <= AC_signal + resize(DR_signal,17);
							SC_signal <= SC_signal+ 1;
						end if ;
							
						if(SC_signal = 7)then -- SC 7
							AC_signal <= save_AC(15 downto 0);
							E_signal  <= save_AC(16);
							SC_signal <= 0 ;
						end if ;
							
				end if; -- ADD
					
					
				if (IR_signal(14 downto 12) = "100") then -- BUN
						
					if	(SC_signal = 5) then -- SC 5
						PC_signal <= AR_signal;
						SC_signal <= 0 ;
					end if ;
							
				end if; -- BUN
					
					
				if (IR_signal(14 downto 12) = "000") then -- RET => 0
						
					if	(SC_signal = 5) then -- SC 5
						AR_signal <= SP_signal;
						SP_signal <= SP_signal + 1;
						SC_signal <= SC_signal+ 1;
					end if ;
						
					if	(SC_signal = 6) then -- SC 6
						AR_signal <= SP_signal;
						SP_signal <= SP_signal + 1;
						SC_signal <= SC_signal+ 1;
					end if ;
						
					if	(SC_signal = 7) then -- SC 7
						PC_signal <= Dout_signal(6 downto 0);
						SC_signal <= SC_signal+ 1;
					end if ;
						
					if	(SC_signal = 8) then -- SC 8
						AC_signal <= Dout_signal;
						SC_signal <= 0;
					end if ;
							
				end if; -- RET
				
					
			end if; -- S_signal = '1'
			   
		end if; -- clock		
		
	end process;
	 
end Behavioral;

