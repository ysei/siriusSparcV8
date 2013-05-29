----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:59 11/14/2012 
-- Design Name: 
-- Module Name:    firstProcessor - arqFirstProcessor 
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

entity firstProcessor is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           aluResult : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end firstProcessor;

architecture arqFirstProcessor of firstProcessor is

	COMPONENT nPC
	PORT(
		address : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		clkFPGA : IN std_logic;          
		nextInstruction : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT adder
	PORT(
		operand1 : IN std_logic_vector(3 downto 0);
		operand2 : IN std_logic_vector(3 downto 0);          
		resultado : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		clkFPGA : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registerFile
	PORT(
		clkFPGA : IN std_logic;
		reset : IN std_logic;
		registerSource1 : IN std_logic_vector(4 downto 0);
		registerSource2 : IN std_logic_vector(4 downto 0);
		registerDestination : IN std_logic_vector(4 downto 0);
		writeEnable : IN std_logic;
		dataToWrite : IN std_logic_vector(31 downto 0);          
		contentRegisterSource1 : OUT std_logic_vector(31 downto 0);
		contentRegisterSource2 : OUT std_logic_vector(31 downto 0);
		contentRegisterDestination : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT unidadControl
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op2 : IN std_logic_vector(2 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cond : IN std_logic_vector(3 downto 0);
		icc : IN std_logic_vector(3 downto 0);          
		rfDest : OUT std_logic;
		rfSource : OUT std_logic_vector(1 downto 0);
		pcSource : OUT std_logic_vector(1 downto 0);
		wrEnMem : OUT std_logic;
		wrEnRF : OUT std_logic;
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		operando1 : IN std_logic_vector(31 downto 0);
		operando2 : IN std_logic_vector(31 downto 0);
		aluOP : IN std_logic_vector(5 downto 0);
		carry : IN std_logic;          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal addressToNPC, PCToAdderToInstruccionMemory,auxNextInstruction : std_logic_vector(3 downto 0);
	signal auxInstruccion,auxDataToWrite,auxContentRegisterSource1,auxContentRegisterDestination,auxContentRegisterSource2: std_logic_vector(31 downto 0);
	signal auxWriteEnable: std_logic;
	signal auxAluOP: std_logic_vector(5 downto 0);
	signal rfDest,wrEnMem,carry : std_logic:='0';
	signal rfSource,pcSource: std_logic_vector(1 downto 0):="00";

begin
	Inst_nPC: nPC PORT MAP(
		address => addressToNPC,
		reset => reset,
		clkFPGA => clk,
		nextInstruction => auxNextInstruction
	);

	Inst_PC: nPC PORT MAP(
		address => auxNextInstruction,
		reset => reset,
		clkFPGA => clk,
		nextInstruction => PCToAdderToInstruccionMemory 
	);

	Inst_adder: adder PORT MAP(
		operand1 => "0001",
		operand2 => PCToAdderToInstruccionMemory,
		resultado => addressToNPC
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => PCToAdderToInstruccionMemory,
		reset => reset,
		clkFPGA => clk,
		outInstruction => auxInstruccion
	);

	Inst_registerFile: registerFile PORT MAP(
		clkFPGA => clk,
		reset => reset,
		registerSource1 => auxInstruccion(18 downto 14),
		registerSource2 => auxInstruccion(4 downto 0),
		registerDestination => auxInstruccion(29 downto 25),
		writeEnable => auxWriteEnable,
		dataToWrite => auxDataToWrite,
		contentRegisterSource1 => auxContentRegisterSource1,
		contentRegisterSource2 => auxContentRegisterSource2,
		contentRegisterDestination => auxContentRegisterDestination 
	);
	
	Inst_unidadControl: unidadControl PORT MAP(
		op => auxInstruccion(31 downto 30),
		op2 => auxInstruccion(24 downto 22),
		op3 => auxInstruccion(24 downto 19),
		cond => auxInstruccion(28 downto 25),
		icc => "0000",
		rfDest => rfDest,
		rfSource => rfSource,
		pcSource => pcSource,
		wrEnMem => wrEnMem,
		wrEnRF => auxWriteEnable,
		ALUOP => auxAluOP
	);

	Inst_ALU: ALU PORT MAP(
		operando1 => auxContentRegisterSource1,
		operando2 => auxContentRegisterSource2,
		aluOP => auxAluOP,
		carry => carry,
		AluResult => auxDataToWrite
	);

	aluResult <= auxDataToWrite;

end arqFirstProcessor;

