----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:54:42 03/06/2025 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  EXTEND_sel : STD_LOGIC_VECTOR (1 downto 0);
			  Wr_add_Out : out  STD_LOGIC_VECTOR (4 downto 0);
			  Wr_add : in  STD_LOGIC_VECTOR (4 downto 0)
			  );
end DECSTAGE;

architecture Behavioral of DECSTAGE is
	
	component Register_File is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
	end component;
	
	-- slct == 0 --> Reg_Out
	-- slct == 1 --> Din
	component Mux_2x1 is
		 Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				  Din : in  STD_LOGIC_VECTOR (31 downto 0);
				  Slct : in  STD_LOGIC;
				  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MUX_2x1_5Bit is
    Port ( In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           In2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Sel : in  STD_LOGIC;
           Res : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component Form_IM is
    Port ( Im : in  STD_LOGIC_VECTOR (15 downto 0);
           Slct : in  STD_LOGIC_VECTOR (1 downto 0);
           Im_Formed : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal mux_A_out : std_logic_vector(4 downto 0);
	signal mux_B_out : std_logic_vector(31 downto 0);
	
begin


	Mux_A : MUX_2x1_5Bit PORT MAP(
						Instr(15 DownTo 11)	,
						Instr(20 DownTo 16)	,
						RF_B_sel	,
						mux_A_out
				);
				
	Mux_B : Mux_2x1 PORT MAP(
						ALU_out	,
						MEM_out	,
						RF_WrData_sel	,
						mux_B_out
				);
				
	Reg_File : Register_File PORT MAP (
					Instr(25 DownTo 21)	,
					mux_A_out ,
					Wr_add,
					RF_A	,
					RF_B	,
					mux_B_out	,
					RF_WrEn	,
					Clk	,
					Reset
	);
	
	Former : Form_IM PORT MAP(
			Instr(15 DownTo 0) ,
			EXTEND_sel,
			Immed
		);
	
	Wr_add_Out <= Instr(20 DownTo 16) ;
end Behavioral;

