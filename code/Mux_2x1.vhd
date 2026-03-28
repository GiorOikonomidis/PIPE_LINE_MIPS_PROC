----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:46:37 02/28/2025 
-- Design Name: 
-- Module Name:    Mux_2x1 - Behavioral 
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

-- slct == 0 --> Reg_Out
-- slct == 1 --> Din
entity Mux_2x1 is
    Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Slct : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_2x1;

architecture Behavioral of Mux_2x1 is

begin
	Process (Reg_out,Din,Slct)
	begin
		If Slct = '0' then 
			Dout <= Reg_out;
		else 
			Dout <= Din; 
		end if ;
	End Process;

end Behavioral;

