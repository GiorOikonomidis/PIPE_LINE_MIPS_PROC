----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:58 03/08/2025 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
	
	component CONTROLPATH is
	Port ( 
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
           Reset : in  STD_LOGIC
    );
	end component;
	
	component DTPATH1 is
   Port (  
           Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
			  
			  -- For the Hazards --
			  Rd_Ex : out  STD_LOGIC_VECTOR (4 downto 0);
			  Rd_Mem : out  STD_LOGIC_VECTOR (4 downto 0);
			  
			  Rs : out  STD_LOGIC_VECTOR (4 downto 0);
			  Rt : out  STD_LOGIC_VECTOR (4 downto 0);
			  Rd : out  STD_LOGIC_VECTOR (4 downto 0);
			  Op : out  STD_LOGIC_VECTOR (5 downto 0);
			  
			  -- ctrl sig forward unit --
			  FwA_sel : in  STD_LOGIC_VECTOR (1 downto 0);
			  FwB_sel : in  STD_LOGIC_VECTOR (1 downto 0);
			  
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
	end component;
	
	component Forward_Unit is
   Port (  
			  Rd_Ex : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rd_Mem : in STD_LOGIC_VECTOR (4 downto 0);
			  
			  Rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  Rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  Op : in  STD_LOGIC_VECTOR (5 downto 0);
			  
			  FwA_sel : out  STD_LOGIC_VECTOR (1 downto 0);
			  FwB_sel : out STD_LOGIC_VECTOR (1 downto 0)
		);
	end component;
	
	signal sig_Instr  : std_logic_vector(31 downto 0);
	
	signal sig_RF_B_sel  : STD_LOGIC ;
	signal sig_RF_WrData_sel  : STD_LOGIC ;
	
	signal sig_RF_WrEn  : STD_LOGIC ;
	signal sig_ALU_Bin_sel  : STD_LOGIC ;
	
	
	signal sig_MEM_WrEn  : STD_LOGIC ;
	
	signal sig_Rd_Ex :  STD_LOGIC_VECTOR (4 downto 0);
	signal sig_Rd_Mem :  STD_LOGIC_VECTOR (4 downto 0);
			  
	signal sig_Rs :   STD_LOGIC_VECTOR (4 downto 0);
	signal sig_Rt :   STD_LOGIC_VECTOR (4 downto 0);
	signal sig_Rd :   STD_LOGIC_VECTOR (4 downto 0);
	signal sig_Op :   STD_LOGIC_VECTOR (5 downto 0);
			  
	signal sig_FwA_sel :   STD_LOGIC_VECTOR (1 downto 0);
	signal sig_FwB_sel :   STD_LOGIC_VECTOR (1 downto 0);
	
begin

	
	DP : DTPATH1 PORT MAP(
			sig_Instr,
			sig_RF_B_sel,
			sig_RF_WrData_sel,
			sig_RF_WrEn,
			sig_ALU_Bin_sel,
			sig_MEM_WrEn,
			sig_Rd_Ex,
			sig_Rd_Mem,
			sig_Rs,
			sig_Rt,
			sig_Rd,
			sig_Op,
			sig_FwA_sel,
			sig_FwB_sel,
			Clk,
			Rst
	);
	
	CP : CONTROLPATH PORT MAP(
			sig_Instr,
			sig_RF_B_sel,
			sig_RF_WrData_sel,
			sig_RF_WrEn,
			sig_ALU_Bin_sel,
			sig_MEM_WrEn,
			Rst
	);
	
	FW : Forward_Unit PORT MAP(
			sig_Rd_Ex,
			sig_Rd_Mem,
			sig_Rs,
			sig_Rt,
			sig_Rd,
			sig_Op,
			sig_FwA_sel,
			sig_FwB_sel
	);
	

end Behavioral;

