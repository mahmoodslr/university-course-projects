----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:55 06/07/2024 
-- Design Name: 
-- Module Name:    tamrin5 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity moore_mealy is
   Port ( x : in  STD_LOGIC := '0' ;
          clock : in std_logic;
        y  : out  STD_LOGIC := '0';
        y3  : out  STD_LOGIC := '0'
        );
end moore_mealy;

architecture Behavioral of moore_mealy is

signal p_s , n_s , p_s3 , n_s3 :STD_LOGIC_vector(1 downto 0):="00";
signal y_int3 :  STD_LOGIC := '0';

begin
---- moore ----
  process (x,p_s)
   begin
       case p_s is
             when "00" => 
						if x= '1' then 
                         n_s <= "01";
							else
								 n_s <= "00";
                  end if;
                  
         when "01" =>  
						if x= '1' then 
                         n_s <= "10";
							else
								 n_s <= "01";
                  end if;
						
         when "10" => 
						if x= '1' then 
                         n_s <= "10";
							else
								 n_s <= "01";
                  end if;  
                  
         when others =>
								n_s<= "00";
      end case;
		
      if (p_s /= "01")  then 
         y <='0';
      else  
         y <= '1';
      end if;
  end process;  
  process (clock)
  begin
       if rising_edge (clock) then
         p_s <= n_s;
      end if;      
  end process;

---- mealy 3 ----
  process ( x, p_s3)
   begin
       case p_s3 is
             when "00"	=>  
                   if x= '1' then 
                        n_s3 <= "01";
							else
								n_s3 <= "00";
                   end if;
						 
             when "01"	=>  
                          n_s3 <= "10";
						  
             when "10"	=> 
								  n_s3 <= "10";
                
         when others =>
                       n_s3 <= "00";
        end case;
		  
  end process;
  
  process ( x, n_s3)
   begin
       case n_s3 is
             when "00"	=>	y_int3 <='0';
				 when "01"	=>	y_int3 <='1';
				 when "10"	=>	
						if x='0' then 
								y_int3 <= '1';
							else
								y_int3 <= '0';
						end if;
				 when others =>
									y_int3 <= '0';                     
         end case;
  end process;
  
  process (clock)
	begin
       if rising_edge (clock) then
          p_s3 <= n_s3;
			 y3 <= y_int3;
      end if;
  end process;

end Behavioral;