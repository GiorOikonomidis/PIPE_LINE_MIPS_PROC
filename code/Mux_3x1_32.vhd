----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:33 05/11/2025 
-- Design Name: 
-- Module Name:    Mux_3x1_32 - Behavioral 
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

entity Mux_3x1_32 is
    Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           Slct : in  STD_LOGIC_VECTOR (1 downto 0));
end Mux_3x1_32;

architecture Behavioral of Mux_3x1_32 is

begin

	Process (Din_1,Din_2,Din_3,Slct)
	begin
		If Slct = "00" then 
			Dout <= Din_1;
		elsif Slct = "01" then 
			Dout <= Din_2;
		elsif Slct = "10" then 
			Dout <= Din_3; 
		end if ;
	End Process;

end Behavioral;

