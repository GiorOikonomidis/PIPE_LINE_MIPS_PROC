----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:53 03/06/2025 
-- Design Name: 
-- Module Name:    MUX_2x1_5Bit - Behavioral 
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

entity MUX_2x1_5Bit is
    Port ( In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           In2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Sel : in  STD_LOGIC;
           Res : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX_2x1_5Bit;

architecture Behavioral of MUX_2x1_5Bit is

begin
	Process (In1,In2 ,Sel)
	begin
		If Sel = '0' then 
			Res <= In1;
		else 
			Res <= In2; 
		end if ;
	End Process;
end Behavioral;

