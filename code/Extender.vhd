----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:38 03/06/2025 
-- Design Name: 
-- Module Name:    Form_IM - Behavioral 
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

entity Form_IM is
    Port ( Im : in  STD_LOGIC_VECTOR (15 downto 0);
           Slct : in  STD_LOGIC_VECTOR (1 downto 0);
           Im_Formed : out  STD_LOGIC_VECTOR (31 downto 0));
end Form_IM;

architecture Behavioral of Form_IM is

begin
	-- check array in page 6 column Praji
	Process (Im,Slct)
	begin
	-- 0 extend in msb
		If Slct = "00" then 
			Im_Formed <= "0000000000000000" & Im;
	-- 0 extend in lsb
		elsif Slct = "01" then
			Im_Formed <= Im & "0000000000000000"; 
	-- sign extend in msb and multiply of 4 , thats for branches (bne,beq,B)
		elsif Slct = "10" then
			Im_Formed <= (31 DownTo 18 => Im(15)) & Im & "00";
	-- sign extend in msb
		else 
			Im_Formed <= (31 DownTo 16 => Im(15)) & Im ;
		end if ;
		
	End Process;

end Behavioral;

