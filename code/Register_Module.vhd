----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:03:26 02/27/2025 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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

entity Register_Module is
    Port ( CLK : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0):=(others => '0');
           We : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end Register_Module;

architecture Behavioral of Register_Module is

begin
	Process begin
		-- Only in possitve rise we change out to in 
		wait until CLK'event and CLK = '1' ;
			If RST = '1' then 
				Dout <= (others => '0');
			ElSE 
				IF We = '1' then 
					Dout <= Data ;
				END IF;
			END IF;
	End Process;
end Behavioral;

