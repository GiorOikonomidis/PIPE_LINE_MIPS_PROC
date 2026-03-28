----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:54 02/28/2025 
-- Design Name: 
-- Module Name:    Compare_Module - Behavioral 
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

entity Compare_Module is
    Port ( Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           We : in  STD_LOGIC;
           Cm_Out : out  STD_LOGIC);
end Compare_Module;

architecture Behavioral of Compare_Module is
begin
	Process(Awr,We,Ard) 
	begin
		If We = '1' and Ard = Awr then 
			Cm_Out <= '1';
		else 
			Cm_Out <= '0';
		end if ;
	End Process;
end Behavioral;

