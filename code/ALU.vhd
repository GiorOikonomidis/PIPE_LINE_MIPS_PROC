----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:22 02/25/2025 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
			  --In excersise is named Out but Out is a reserved word
           Res : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	-- we ll have here our signals extended
	Signal Res_33temp , A_temp , B_temp : STD_LOGIC_VECTOR(32 downto 0) :=(others => '0');
	
	Signal Res_temp : STD_LOGIC_VECTOR(31 downto 0) :=(others => '0');
	
	Signal tmp_Zero , tmp_Cout , tmp_Ovf : STD_LOGIC := '0'; 
	
	
begin
	
	process(A, B, Op ,Res_temp, A_temp, B_temp , tmp_Zero , tmp_Cout , tmp_Ovf , Res_33temp)
begin
	-- Default values to avoid latching
	tmp_Zero <= '0';
	tmp_Cout <= '0';
	tmp_Ovf <= '0';
	Res_33temp <= (others => '0');
	Res_temp <= (others => '0');

	case Op is
		-- Arithmetic Operetions --
		-- Addition
		when "0000" =>  
			-- Extend A and B properly for signed addition
			A_temp <= '0' & A; -- Sign-extend
			B_temp <= '0' & B; -- Sign-extend

			Res_33temp <= STD_LOGIC_VECTOR(signed(A_temp) + signed(B_temp));
			
			-- Carry-out is the MSB of Res_temp
			tmp_Cout <= Res_33temp(32);

			-- Overflow detection
			if A(31) = B(31) and Res_33temp(31) /= A(31) then
				tmp_Ovf <= '1';
			else
				tmp_Ovf <= '0';
			end if;
			
			Res_temp <= Res_33temp(31 downto 0);
		-- Sub
		when "0001" =>  
			-- Extend A and B properly for signed addition
			A_temp <= '0' & A; -- Sign-extend
			B_temp <= '0' & B; -- Sign-extend

			Res_33temp <= STD_LOGIC_VECTOR(signed(A_temp) - signed(B_temp));

			-- Carry-out is the MSB of Res_temp
			tmp_Cout <= Res_33temp(32);

			-- Overflow detection
			if A(31) /= B(31) and Res_33temp(31) = B(31) then
				tmp_Ovf <= '1';
			else
				tmp_Ovf <= '0';
			end if;
			
			Res_temp <= Res_33temp(31 downto 0);
		
		-- logic operations --
		-- AND
		when "0010" =>  
			Res_temp <= A AND B;
		-- OR
		when "0011" => 
			Res_temp <= A OR B;
		-- NOT
		when "0100" => 
			Res_temp <= NOT A ;
			
		-- SLides --
		when "1000" =>
			Res_temp <= A(31) & A(31 downto 1);
			
		when "1001" =>
			Res_temp <= '0' & A(31 downto 1);
		
		when "1010" =>
			Res_temp <= A(30 downto 0) & '0' ;
			
		when "1100" =>
			Res_temp <= A(30 downto 0) & A(31) ;
			
		when "1101" =>
			Res_temp <=  A(0) & A(31 downto 1) ;
			
		when others =>
			
	end case;
--
	
	if Res_temp = "00000000000000000000000000000000" then
			tmp_zero <= '1';
	else 
			tmp_zero <= '0';
	end if;

	-- Assign outputs
	Res  <= Res_temp;
	Cout <= tmp_Cout;
	Zero <= tmp_Zero;
	Ovf  <= tmp_Ovf;
end process;


end Behavioral;