----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:23:43 02/28/2025 
-- Design Name: 
-- Module Name:    Dec_5x32 - Behavioral 
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


entity Dec_5x32 is
    Port ( Adr_In : in  STD_LOGIC_VECTOR (4 downto 0);
           Dec_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Dec_5x32;

architecture Behavioral of Dec_5x32 is
begin
process(Adr_In)
begin
	case Adr_In is
		 when "00000" =>
          Dec_out <= "00000000000000000000000000000001";
       when "00001" =>
          Dec_out <= "00000000000000000000000000000010";
       when "00010" =>
          Dec_out <= "00000000000000000000000000000100";
       when "00011" =>
          Dec_out <= "00000000000000000000000000001000";
       when "00100" =>
          Dec_out <= "00000000000000000000000000010000";
       when "00101" =>
          Dec_out <= "00000000000000000000000000100000";
       when "00110" =>
          Dec_out <= "00000000000000000000000001000000";
       when "00111" =>
          Dec_out <= "00000000000000000000000010000000";
       when "01000" =>
          Dec_out <= "00000000000000000000000100000000";
       when "01001" =>
          Dec_out <= "00000000000000000000001000000000";
       when "01010" =>
          Dec_out <= "00000000000000000000010000000000";
       when "01011" =>
          Dec_out <= "00000000000000000000100000000000";
       when "01100" =>
          Dec_out <= "00000000000000000001000000000000";
       when "01101" =>
          Dec_out <= "00000000000000000010000000000000";
		 when "01110" =>
			 Dec_out <= "00000000000000000100000000000000";
		 when "01111" =>
			 Dec_out <= "00000000000000001000000000000000";
		 when "10000" =>
			 Dec_out <= "00000000000000010000000000000000";
	  	 when "10001" =>
			 Dec_out <= "00000000000000100000000000000000";
		 when "10010" =>
			 Dec_out <= "00000000000001000000000000000000";
		 when "10011" =>
			 Dec_out <= "00000000000010000000000000000000";
		 when "10100" =>
			 Dec_out <= "00000000000100000000000000000000";
		 when "10101" =>
			 Dec_out <= "00000000001000000000000000000000";
	  	 when "10110" =>
			 Dec_out <= "00000000010000000000000000000000";
		 when "10111" =>
			 Dec_out <= "00000000100000000000000000000000";
		 when "11000" =>
			 Dec_out <= "00000001000000000000000000000000";
		 when "11001" =>
			 Dec_out <= "00000010000000000000000000000000";
		 when "11010" =>
			 Dec_out <= "00000100000000000000000000000000";
		 when "11011" =>
			 Dec_out <= "00001000000000000000000000000000";
		 when "11100" =>
			 Dec_out <= "00010000000000000000000000000000";
		 when "11101" =>
			 Dec_out <= "00100000000000000000000000000000";
		 when "11110" =>
			 Dec_out <= "01000000000000000000000000000000";
		 when "11111" =>
			 Dec_out <= "10000000000000000000000000000000";
		 when others =>
			 Dec_out <= (others => '0');
	
	end case;
end process;
end Behavioral;



