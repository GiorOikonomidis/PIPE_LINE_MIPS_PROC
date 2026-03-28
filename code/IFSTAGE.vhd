----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:16 03/04/2025 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
	-- Reg_out is going to be our +4
	-- Din is going to be our +Imidiate
	component Mux_2x1 is
		 Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				  Din : in  STD_LOGIC_VECTOR (31 downto 0);
				  Slct : in  STD_LOGIC;
				  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	-- Our PC reg
	component Register_Module is
		 Port ( CLK : in  STD_LOGIC;
				  Data : in  STD_LOGIC_VECTOR (31 downto 0);
              Dout : out  STD_LOGIC_VECTOR (31 downto 0):=(others => '0');
              We : in  STD_LOGIC;
              RST : in  STD_LOGIC);
	end component;
	--Our Rom
	
	-- Our +4 adder and our imidiate adder
	component Im_Adder is
   Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Im : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal adder_4_res , adder_Im_res , mux_out , PC_out : std_logic_vector(31 downto 0);
	
	-- Thats a Test ROM -- we use TEST_ROM_7 for exam
	-- Dont forget to remove it and put the main one -- 
	component Pipe_10 IS
	PORT (
		 a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	  );
	END component;
	-------------------
	-------------------
	component PROF_TEST2 IS
	PORT (
		 a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	  );
	END component;
	
begin

	PC : Register_Module PORT MAP(Clk,
											mux_out,
											PC_out,
											PC_LdEn,
											Reset);
											
	Mux : Mux_2x1 PORT MAP (adder_4_res,
									adder_Im_res,
									PC_sel,
									mux_out);
									
	Adder_4 : Im_Adder PORT MAP ( PC_out,
											"00000000000000000000000000000100",
											adder_4_res
	);
	
	Adder_Im : Im_Adder PORT MAP (adder_4_res,
											PC_Immed,
											adder_Im_res
	);
	
	-- this i sbasicly divide by 4 to land each time in the correct memmory addres
	-- the consept is (PC + 4)/4 to get next command from rom
	
	-- I have put the test rom -- 
	Rom : Pipe_10 PORT MAP (PC_out(11 downto 2),
								Instr
									
	);


end Behavioral;

