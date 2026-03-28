----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:53 03/05/2025 
-- Design Name: 
-- Module Name:    EXCECSTAGE - Behavioral 
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

entity EXCECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  -- Extra , dont know if need it ? --
			  Zero : out STD_LOGIC
			 );
end EXCECSTAGE;

architecture Behavioral of EXCECSTAGE is

	component ALU is
		 Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
				  B : in  STD_LOGIC_VECTOR (31 downto 0);
				  Op : in  STD_LOGIC_VECTOR (3 downto 0);
				  --In excersise is named Out but Out is a reserved word
				  Res : out  STD_LOGIC_VECTOR (31 downto 0);
				  Zero : out  STD_LOGIC;
				  Cout : out  STD_LOGIC;
				  Ovf : out  STD_LOGIC);
	end component;
	
	-- slct == 0 --> Reg_Out
	-- slct == 1 --> Din
	component Mux_2x1 is
		 Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				  Din : in  STD_LOGIC_VECTOR (31 downto 0);
				  Slct : in  STD_LOGIC;
				  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal mux_out : std_logic_vector(31 downto 0);

begin
	
	Mux : Mux_2x1 PORT MAP(
						RF_B,
						Immed,
						ALU_Bin_sel,
						mux_out
					);
	Alu_comp : ALU PORT MAP(
				RF_A,
				mux_out,
				ALU_func,
				ALU_out,
				Zero,
				open,
				open
			);
end Behavioral;

