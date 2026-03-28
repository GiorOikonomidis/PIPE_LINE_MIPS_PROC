----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:11 02/28/2025 
-- Design Name: 
-- Module Name:    Register_File - Behavioral 
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

entity Register_File is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end Register_File;

architecture Behavioral of Register_File is
	
	component Mux_2x1 is
		 Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				  Din : in  STD_LOGIC_VECTOR (31 downto 0);
				  Slct : in  STD_LOGIC;
				  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Dec_5x32 is
		Port ( Adr_In : in  STD_LOGIC_VECTOR (4 downto 0);
				 Dec_out : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Mux_32x1 is
		Port ( Slct : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
			  Reg_0 , Reg_1 , Reg_2 , Reg_3 , Reg_4 ,
			  Reg_5 , Reg_6 , Reg_7 , Reg_8 , Reg_9 ,
			  Reg_10 , Reg_11 , Reg_12 , Reg_13 , Reg_14 ,
			  Reg_15 , Reg_16 , Reg_17 , Reg_18 , Reg_19 ,
			  Reg_20 , Reg_21 , Reg_22 , Reg_23 , Reg_24 ,
			  Reg_25 , Reg_26 , Reg_27 , Reg_28 , Reg_29 ,
			  Reg_30 , Reg_31 : in  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	
	component Compare_Module is
		 Port ( Ard : in  STD_LOGIC_VECTOR (4 downto 0);
				  Awr : in  STD_LOGIC_VECTOR (4 downto 0);
				  We : in  STD_LOGIC;
				  Cm_Out : out  STD_LOGIC);
	end component;
	
	component Register_Module is
		 Port ( CLK : in  STD_LOGIC;
				  Data : in  STD_LOGIC_VECTOR (31 downto 0);
              Dout : out  STD_LOGIC_VECTOR (31 downto 0):=(others => '0');
              We : in  STD_LOGIC;
              RST : in  STD_LOGIC);
	end component;
	
	signal dec_out : STD_LOGIC_VECTOR (31 downto 0);--Decoder out
	signal dec_and_we : STD_LOGIC_VECTOR (31 downto 0); -- Decoder out and WrEn
	
	signaL cmp_out_A ,cmp_out_B : STD_LOGIC ;
	signal mux_32x1_out_A , mux_32x1_out_B : STD_LOGIC_VECTOR(31 downto 0);
	
	-- Signal of the array of registers --> (32x32 Dout of Regs)
	type Regs_OutArray is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
   signal Rout : Regs_OutArray; 
	
begin
	
		-- WE treat reg0 different because it cant be written 
		Reg_0 : Register_Module PORT MAP(
				  Clk,
				  Din,
              Rout(0),
              '0',
              Rst
		);
		
		-- Now we ll make the other 31
	   Registers_Inst : for i in 1 to 31 generate
	 
		dec_and_we(i)<= WrEn AND dec_out(i);
		
        Register_Inst : Register_Module
            port map (
              Clk,
				  Din,
              Rout(i),
              dec_and_we(i),
              Rst
            );
		end generate Registers_Inst;
		
		
		
		Dec : Dec_5x32 PORT MAP(
			Awr,
			dec_out
		);
		
		
		-- Top Side --
		-- select , Dout , Routs
		M32x1_A : Mux_32x1 PORT MAP(
			Ard1,
			mux_32x1_out_A,
			Rout(0),Rout(1),Rout(2),Rout(3),Rout(4),Rout(5),
			Rout(6),Rout(7),Rout(8),Rout(9),Rout(10),
			Rout(11),Rout(12),Rout(13),Rout(14),Rout(15),
			Rout(16),Rout(17),Rout(18),Rout(19),Rout(20),
			Rout(21),Rout(22),Rout(23),Rout(24),Rout(25),
			Rout(26),Rout(27),Rout(28),Rout(29),Rout(30),
			Rout(31)
		);
		
	
		--In1 , In2 , Slct , Out
		M2x1_A : Mux_2x1 PORT MAP(
			mux_32x1_out_A,
			Din,
			cmp_out_A,
			Dout1
		);
		
		
		Cmp_A : Compare_Module PORT MAP(
			Awr,
			Ard1,
			WrEn,
			cmp_out_A
		);
		
		
		
		-- Bottom Side --
		M32x1_B : Mux_32x1 PORT MAP(
			Ard2,
			mux_32x1_out_B,
			Rout(0),Rout(1),Rout(2),Rout(3),Rout(4),Rout(5),
			Rout(6),Rout(7),Rout(8),Rout(9),Rout(10),
			Rout(11),Rout(12),Rout(13),Rout(14),Rout(15),
			Rout(16),Rout(17),Rout(18),Rout(19),Rout(20),
			Rout(21),Rout(22),Rout(23),Rout(24),Rout(25),
			Rout(26),Rout(27),Rout(28),Rout(29),Rout(30),
			Rout(31)
		);
		
	-- We dont need it in this phase
	
		--In1 , In2 , Slct , Out
		M2x1_B : Mux_2x1 PORT MAP(
			mux_32x1_out_B,
			Din,
			cmp_out_B,
			Dout2
		);
		
		
		Cmp_B : Compare_Module PORT MAP(
			Ard2,
			Awr,
			WrEn,
			cmp_out_B
		);
		


end Behavioral;

