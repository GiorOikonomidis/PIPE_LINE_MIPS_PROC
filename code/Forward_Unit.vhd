----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:12 05/11/2025 
-- Design Name: 
-- Module Name:    Forward_Unit - Behavioral 
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

entity Forward_Unit is
   Port (  
			  -- For the Hazards --
			  Rd_Ex : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rd_Mem : in STD_LOGIC_VECTOR (4 downto 0);
			  
			  Rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  Op : in  STD_LOGIC_VECTOR (5 downto 0);
			  
			  -- ctrl sig forward unit --
			  FwA_sel : out  STD_LOGIC_VECTOR (1 downto 0);
			  FwB_sel : out STD_LOGIC_VECTOR (1 downto 0)
		);
end Forward_Unit;

architecture Behavioral of Forward_Unit is

begin
	
   process (Rd_Ex,Rd_Mem,Rs,Rt,Rd,Op) begin 

        if (Op="100000") then
            -- check Rs
            if (Rs = "00000") then
                FwA_sel <= "00";
            elsif ( (not(Rs = Rd_Ex)) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "00";
            elsif ( (Rs = Rd_Ex) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "10";
            elsif ( (Rs = Rd_Mem) and (not(Rs = Rd_Ex)) ) then
                FwA_sel <= "01";
            elsif ( (Rs = Rd_Mem) and (Rs = Rd_Ex)) then
                FwA_sel <= "10";
            else
                FwA_sel <= "00";
            end if;

            -- check Rt
            if (Rt = "00000") then
                FwB_sel <= "00";
            elsif ( (not(Rt = Rd_Ex)) and (not(Rt = Rd_Mem)) ) then
                FwB_sel <= "00";
            elsif ( (Rt = Rd_Ex) and (not(Rt = Rd_Mem)) ) then
                FwB_sel <= "10";
            elsif ( (Rt = Rd_Mem) and (not(Rt = Rd_Ex)) ) then
                FwB_sel <= "01";
            elsif ( (Rt = Rd_Mem) and (Rt = Rd_Ex)) then
                FwB_sel <= "10";
            else
                FwB_sel <= "00";
            end if;

        elsif (Op="001111") then
            FwB_sel <= "00";
            -- check Rs
            if (Rs = "00000") then
                FwA_sel <= "00";
            elsif ( (not(Rs = Rd_Ex)) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "00";
            elsif ( (Rs = Rd_Ex) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "10";
            elsif ( (Rs = Rd_Mem) and (not(Rs = Rd_Ex)) ) then
                FwA_sel <= "01";
				elsif ( (Rs = Rd_Mem) and (Rs = Rd_Ex)) then
                FwA_sel <= "10";
            else
                FwA_sel <= "00";
            end if;

        -- sw
        elsif (Op = "011111") then
            -- check Rs
            if (Rs = "00000") then
                FwA_sel <= "00";
            elsif ( (not(Rs = Rd_Ex)) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "00";
            elsif ( (Rs = Rd_Ex) and (not(Rs = Rd_Mem)) ) then
                FwA_sel <= "10";
            elsif ( (Rs = Rd_Mem) and (not(Rs = Rd_Ex)) ) then
                FwA_sel <= "01";
				elsif ( (Rs = Rd_Mem) and (Rs = Rd_Ex)) then
                FwA_sel <= "10";
            else
                FwA_sel <= "00";
            end if;

            -- check if B needs forward with Rd
            if ( (not(Rd = Rd_Ex)) and (not(Rd = Rd_Mem)) ) then
                FwB_sel <= "00";
            elsif ( (Rd = Rd_Ex) and (not(Rd = Rd_Mem)) ) then
                FwB_sel <= "10";
            elsif ( (Rd = Rd_Mem) and (not(Rd = Rd_Ex)) ) then
                FwB_sel <= "01";
				elsif ( (Rs = Rd_Mem) and (Rs = Rd_Ex)) then
                FwA_sel <= "10";
            else
                FwB_sel <= "00";
            end if;

        else 
            FwA_sel <= "00";
            FwB_sel <= "00";
        end if;

			
   end process;

end Behavioral;

