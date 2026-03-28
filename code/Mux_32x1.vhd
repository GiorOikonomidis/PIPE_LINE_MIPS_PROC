----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:53:44 02/28/2025 
-- Design Name: 
-- Module Name:    Mux_32x1 - Behavioral 
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

entity Mux_32x1 is
    Port ( Slct : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
			  Reg_0 , Reg_1 , Reg_2 , Reg_3 , Reg_4 ,
			  Reg_5 , Reg_6 , Reg_7 , Reg_8 , Reg_9 ,
			  Reg_10 , Reg_11 , Reg_12 , Reg_13 , Reg_14 ,
			  Reg_15 , Reg_16 , Reg_17 , Reg_18 , Reg_19 ,
			  Reg_20 , Reg_21 , Reg_22 , Reg_23 , Reg_24 ,
			  Reg_25 , Reg_26 , Reg_27 , Reg_28 , Reg_29 ,
			  Reg_30 , Reg_31 : in  STD_LOGIC_VECTOR (31 downto 0));
end Mux_32x1;

architecture Behavioral of Mux_32x1 is

begin
    process (Slct, Reg_0, Reg_1, Reg_2, Reg_3, Reg_4, 
             Reg_5, Reg_6, Reg_7, Reg_8, Reg_9, 
             Reg_10, Reg_11, Reg_12, Reg_13, Reg_14, 
             Reg_15, Reg_16, Reg_17, Reg_18, Reg_19, 
             Reg_20, Reg_21, Reg_22, Reg_23, Reg_24, 
             Reg_25, Reg_26, Reg_27, Reg_28, Reg_29, 
             Reg_30, Reg_31)
    begin
        case Slct is
            when "00000" => Dout <= Reg_0;
            when "00001" => Dout <= Reg_1;
            when "00010" => Dout <= Reg_2;
            when "00011" => Dout <= Reg_3;
            when "00100" => Dout <= Reg_4;
            when "00101" => Dout <= Reg_5;
            when "00110" => Dout <= Reg_6;
            when "00111" => Dout <= Reg_7;
            when "01000" => Dout <= Reg_8;
            when "01001" => Dout <= Reg_9;
            when "01010" => Dout <= Reg_10;
            when "01011" => Dout <= Reg_11;
            when "01100" => Dout <= Reg_12;
            when "01101" => Dout <= Reg_13;
            when "01110" => Dout <= Reg_14;
            when "01111" => Dout <= Reg_15;
            when "10000" => Dout <= Reg_16;
            when "10001" => Dout <= Reg_17;
            when "10010" => Dout <= Reg_18;
            when "10011" => Dout <= Reg_19;
            when "10100" => Dout <= Reg_20;
            when "10101" => Dout <= Reg_21;
            when "10110" => Dout <= Reg_22;
            when "10111" => Dout <= Reg_23;
            when "11000" => Dout <= Reg_24;
            when "11001" => Dout <= Reg_25;
            when "11010" => Dout <= Reg_26;
            when "11011" => Dout <= Reg_27;
            when "11100" => Dout <= Reg_28;
            when "11101" => Dout <= Reg_29;
            when "11110" => Dout <= Reg_30;
            when "11111" => Dout <= Reg_31;
            when others => Dout <= (others => '0'); 
        end case;
    end process;
end Behavioral;


