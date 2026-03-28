----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:38:19 03/08/2025 
-- Design Name: 
-- Module Name:    CONTROLPATH - Behavioral 
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

entity CONTROLPATH is
	Port ( 

           Instr : in  STD_LOGIC_VECTOR (31 downto 0);

           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;

           RF_WrEn : out  STD_LOGIC;

           ALU_Bin_sel : out  STD_LOGIC;

           MEM_WrEn : out  STD_LOGIC;
			  
           Reset : in  STD_LOGIC
    );
end CONTROLPATH;

-- all R types , li , lui

architecture Behavioral of CONTROLPATH is
begin
	process(Instr,Reset)
	begin
		IF Reset = '1' then 

			-- Choose Rt 
			RF_B_sel <= '0' ;
			-- Get ALU out
			RF_WrData_sel <= '0' ;
			-- block write on RegFile
			RF_WrEn <= '0' ;
			-- choose RF_B
			ALU_Bin_sel <= '0';
			-- disable memory write
			MEM_WrEn <= '0' ;
			
		ELSE

			-- Take the opcaode 
			CASE Instr(31 downTo 26) is 
				-- simply R type instructions
				WHEN "100000" =>

					-- Choose Rt 
					RF_B_sel <= '0' ;
					-- Get ALU out
					RF_WrData_sel <= '0' ;
					
					-- we dont care about EXTEND_sel
					
					-- enable write on RegFile
					RF_WrEn <= '1' ;
					-- choose RF_B
					ALU_Bin_sel <= '0';
					-- disable memory write
					MEM_WrEn <= '0' ;
					
					
				-- li 
				WHEN "111000" =>

					-- Choose Rd 
					RF_B_sel <= '1' ;
					-- Get ALU out
					RF_WrData_sel <= '0' ;
					-- enable write on RegFile
					RF_WrEn <= '1' ;
					-- choose Immed
					ALU_Bin_sel <= '1';
					-- disable memory write
					MEM_WrEn <= '0' ;
					
					

				--lw
				WHEN "001111" =>
					-- Choose Rd 
					RF_B_sel <= '1' ;
					-- Get MEM out
					RF_WrData_sel <= '1' ;
					-- enable write on RegFile
					RF_WrEn <= '1' ;
					-- choose Immed
					ALU_Bin_sel <= '1';
					-- disable memory write
					MEM_WrEn <= '0' ;

					
				--sw
				WHEN "011111" =>
					-- Choose Rd 
					RF_B_sel <= '1' ;
					-- Get MEM out
					RF_WrData_sel <= '0' ;
					-- enable write on RegFile
					RF_WrEn <= '0' ;
					-- choose Immed
					ALU_Bin_sel <= '1';

					-- disable memory write
					MEM_WrEn <= '1' ;
					
					
					
					
				WHEN OTHERS =>
					-- Choose Rt 
					RF_B_sel <= '0' ;
					-- Get ALU out
					RF_WrData_sel <= '0' ;
					-- block write on RegFile
					RF_WrEn <= '0' ;
					-- choose RF_B
					ALU_Bin_sel <= '0';
					-- disable memory write
					MEM_WrEn <= '0' ;
					
			END CASE;
		END IF;
	END process;
	
end Behavioral;

