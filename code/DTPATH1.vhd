----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:12:08 03/08/2025 
-- Design Name: 
-- Module Name:    DTPATH1 - Behavioral 
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

entity DTPATH1 is
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
end DTPATH1;

architecture Behavioral of DTPATH1 is

component Mux_3x1_32 is
    Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           Slct : in  STD_LOGIC_VECTOR (1 downto 0));
end component;

component Mux_2x1 is
		 Port ( Reg_out : in  STD_LOGIC_VECTOR (31 downto 0);
				  Din : in  STD_LOGIC_VECTOR (31 downto 0);
				  Slct : in  STD_LOGIC;
				  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE is
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
end component;

component EXCECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out STD_LOGIC
			 );
end component;

component MEMSTAGE is
    Port ( Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  Clk : in  STD_LOGIC
			  );
end component;

component Register_Module is
    Port ( CLK : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0):=(others => '0');
           We : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end component;

	signal immed , immed_reg : std_logic_vector(31 downto 0);
	signal instruction , instruction_reg : std_logic_vector(31 downto 0);
	
	signal alu_outpout , alu_outpout_reg , add_delay_reged: std_logic_vector(31 downto 0);
	signal Rfa_outpout , Rfa_outpout_reg : std_logic_vector(31 downto 0);
	signal Rfb_outpout , Rfb_outpout_reg: std_logic_vector(31 downto 0);
	
	signal mem_din , mem_din_reged: std_logic_vector(31 downto 0);
	signal mem_outpout , mem_outpout_reg : std_logic_vector(31 downto 0);
	
	signal Reg_File_Din , Fw_RFa , Fw_RFb: std_logic_vector(31 downto 0);
	
	signal Ctrl_sigs , Dec_sig , Ex_sig , Mem_sig , WrBack_sig: std_logic_vector(31 downto 0);

begin

	if_stage : IFSTAGE PORT MAP(
			immed_reg,
			'0',
			'1',
			Reset,
			Clk,
			instruction
	);

	dec_stage : DECSTAGE PORT MAP(
			instruction_reg ,
			WrBack_sig(4),
			add_delay_reged,
			mem_outpout_reg,
			WrBack_sig(3),
			RF_B_sel,
			Clk,
			Reset,
			immed,
			Rfa_outpout,
			Rfb_outpout,
			"11",
			Ctrl_sigs(9 downto 5),
			WrBack_sig(9 downto 5)
	);
	
	exec_stage : EXCECSTAGE PORT MAP(
			Fw_RFa,
			Fw_RFb,
			immed_reg,
			Ex_sig(1),
			"0000",
			alu_outpout,
			Open
	);
	
	
	
	mem_stage : MEMSTAGE PORT MAP(
			Mem_sig(2),
			alu_outpout_reg,
			mem_din_reged,
			mem_outpout,
			Clk
	);
	
	
	
	
	--- Internal results regs ---
	instr_reg : Register_Module PORT MAP(
			Clk,
			instruction,
			instruction_reg,
			'1',
			Reset
	);
	
	im_reg : Register_Module PORT MAP(
			Clk,
			immed,
			immed_reg,
			'1',
			Reset
	);
	
	rfa_reg : Register_Module PORT MAP(
			Clk,
			Rfa_outpout,
			Rfa_outpout_reg,
			'1',
			Reset
	);
	
	rfb_reg : Register_Module PORT MAP(
			Clk,
			Rfb_outpout,
			Rfb_outpout_reg,
			'1',
			Reset
	);
	
	Alu_reg : Register_Module PORT MAP(
			Clk,
			alu_outpout,
			alu_outpout_reg,
			'1',
			Reset
	);
		
	mem_reg : Register_Module PORT MAP(
			Clk,
			mem_outpout,
			mem_outpout_reg,
			'1',
			Reset
	);
	
	
	--- Internal results regs ---
	--  Ex_sig , Mem_sig , WrBack_sig
	

	Excec_reg_sig : Register_Module PORT MAP(
			Clk,
			Ctrl_sigs,
			Ex_sig,
			'1',
			Reset
	);
	
	Mem_reg_sig : Register_Module PORT MAP(
			Clk,
			Ex_sig,
			Mem_sig,
			'1',
			Reset
	);
	
	WrBack_reg_sig : Register_Module PORT MAP(
			Clk,
			Mem_sig,
			WrBack_sig,
			'1',
			Reset
	);
	
	--- Delay Regs --- 
	-- For add
	add_delay_reg : Register_Module PORT MAP(
			Clk,
			alu_outpout_reg,
			add_delay_reged,
			'1',
			Reset
	);
	
	mem_delay_reg : Register_Module PORT MAP(
			Clk,
			Fw_RFb,
			mem_din_reged,
			'1',
			Reset
	);
	
	
	
	Mux_RegFile_Din : Mux_2x1 PORT MAP(
			add_delay_reged,
			mem_outpout_reg,
			WrBack_sig(3),
			Reg_File_Din
	);
	
	Mux_Fw_A : Mux_3x1_32 PORT MAP(
		Rfa_outpout_reg ,
		Reg_File_Din ,
		alu_outpout_reg ,
		Fw_RFa,
		FwA_sel
	);
	
	Mux_Fw_B : Mux_3x1_32 PORT MAP(
		Rfb_outpout_reg ,
		Reg_File_Din ,
		alu_outpout_reg ,
		Fw_RFb,
		FwB_sel
	);
	
	-------------------------------------------
	
		Instr <= instruction_reg;
	
		Ctrl_sigs(0) <=  RF_B_sel;
		--- Dest reg for reg file in Ctrl_sigs (9 downto 5)
		Ctrl_sigs(1) <=  ALU_Bin_sel;
		Ctrl_sigs(2) <=  MEM_WrEn;
	
		Ctrl_sigs(3) <=  RF_WrData_sel;
		Ctrl_sigs(4) <=  RF_WrEn;
		-- Rs
		Ctrl_sigs(14 downto 10) <=instruction_reg(25 DownTo 21);
		-- Rt
		Ctrl_sigs(19 downto 15) <=instruction_reg(15 DownTo 11);
		-- Rd
		Ctrl_sigs(24 downto 20) <=instruction_reg(20 DownTo 16);
		-- Op
		Ctrl_sigs(30 downto 25) <=instruction_reg(31 downTo 26);
		
		
		Rd_Ex	<= Mem_sig(9 downto 5);
		Rd_Mem <= WrBack_sig(9 downto 5);
		
		Rs	<= Ex_sig(14 downto 10);
		Rt <= Ex_sig(19 downto 15);
		Rd <= Ex_sig(24 downto 20);
		
		Op <= Ex_sig(30 downto 25);
	
end Behavioral;

