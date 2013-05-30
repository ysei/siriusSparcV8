----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:34:34 05/24/2013 
-- Design Name: 
-- Module Name:    sparcV8 - arqSparcV8 
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

entity sparcV8 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           ProgramCounter : out  STD_LOGIC_VECTOR (31 downto 0));
end sparcV8;

architecture arqSparcV8 of sparcV8 is

	COMPONENT PC
	PORT(
		address : IN std_logic_vector(31 downto 0);
		clkFPGA : IN std_logic;
		reset : IN std_logic;          
		nextInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT adder
	PORT(
		operand1 : IN std_logic_vector(31 downto 0);
		operand2 : IN std_logic_vector(31 downto 0);          
		resultado : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		--clk : in STD_LOGIC;
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEUDisp22
	PORT(
		SEU22 : IN std_logic_vector(21 downto 0);          
		SEU32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxPCSource
	PORT(
		PCDisp30 : IN std_logic_vector(31 downto 0);
		PCDisp22 : IN std_logic_vector(31 downto 0);
		PC4 : IN std_logic_vector(31 downto 0);
		PCAddress : IN std_logic_vector(31 downto 0);
		PCSource : IN std_logic_vector(1 downto 0);          
		PCAddressOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT windowManager
	PORT(
		--clk : in STD_LOGIC;
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic_vector(1 downto 0);
		registerSource1 : IN std_logic_vector(4 downto 0);
		registerSource2 : IN std_logic_vector(4 downto 0);
		registerDestination : IN std_logic_vector(4 downto 0);          
		ncwp : OUT std_logic_vector(1 downto 0);
		newRegisterSource1 : OUT std_logic_vector(5 downto 0);
		newRegisterSource2 : OUT std_logic_vector(5 downto 0);
		newRegisterDestination : OUT std_logic_vector(5 downto 0);
		registroO7 : out STD_LOGIC_VECTOR(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT unidadControl
	PORT(
		--clk : in STD_LOGIC;
		op : IN std_logic_vector(1 downto 0);
		op2 : IN std_logic_vector(2 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cond : IN std_logic_vector(3 downto 0);
		icc : IN std_logic_vector(3 downto 0);  
		enableMem : out STD_LOGIC;
		rfDest : OUT std_logic;
		rfSource : OUT std_logic_vector(1 downto 0);
		pcSource : OUT std_logic_vector(1 downto 0);
		wrEnMem : OUT std_logic;
		wrEnRF : OUT std_logic;
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxRFDest
	PORT(
		nrd : IN std_logic_vector(5 downto 0);
		registroO7 : IN std_logic_vector(5 downto 0);
		RFDestSel : IN std_logic;          
		RFDest : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registerFile
	PORT(
		--clkFPGA : IN std_logic;
		reset : IN std_logic;
		registerSource1 : IN std_logic_vector(5 downto 0);
		registerSource2 : IN std_logic_vector(5 downto 0);
		registerDestination : IN std_logic_vector(5 downto 0);
		writeEnable : IN std_logic;
		dataToWrite : IN std_logic_vector(31 downto 0);          
		contentRegisterSource1 : OUT std_logic_vector(31 downto 0);
		contentRegisterSource2 : OUT std_logic_vector(31 downto 0);
		contentRegisterDestination : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT signExtensionUnit
	PORT(
		--clk : in STD_LOGIC;
		simm13 : IN std_logic_vector(12 downto 0);          
		simm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxALU
	PORT(
		Crs2 : IN std_logic_vector(31 downto 0);
		SEUOperando : IN std_logic_vector(31 downto 0);
		selImmediate : IN std_logic;          
		OperandoALU : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSRModifier
	PORT(
		aluResult : IN std_logic_vector(31 downto 0);
		operando1 : IN std_logic;
		operando2 : IN std_logic;
		aluOp : IN std_logic_vector(5 downto 0);          
		nzvc : out std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT PSR
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		nCWP : IN std_logic_vector(1 downto 0);          
		CWP : OUT std_logic_vector(1 downto 0);
		carry : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0)
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

	COMPONENT dataMemory
	PORT(
		clk : IN std_logic;
		enableMem : in  STD_LOGIC;
		reset : IN std_logic;
		cRD : IN std_logic_vector(31 downto 0);
		address : IN std_logic_vector(31 downto 0);
		wrEnMem : IN std_logic;          
		datoMem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxRFSource
	PORT(
		DatoFromMem : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		RFSource : IN std_logic_vector(1 downto 0);          
		RFData : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal outMuxBranchesToNextPC, outNextPCToPC, outPCToInstructionMemory : std_logic_vector(31 downto 0);
	signal pcPlus1, instruccion, SEU22ToAdder, adderDisp30Operand2,auxCRs1,auxCRs2,auxCRd : std_logic_vector(31 downto 0);
	signal adderDisp30ToMUX, adderDisp22ToMUX, auxResultadoALU, auxDataToWrite : std_logic_vector(31 downto 0);
	signal auxMUXALU, SEUToMuxALU, auxDatoMem : std_logic_vector(31 downto 0);
	signal pcSourceControlUnitToMUX, unidadControlRfSourceToMUX : std_logic_vector(1 downto 0);
	signal PSRCWPToWindowManager, windowManagerCWPToPSR : std_logic_vector(1 downto 0);
	signal winManagerNRs1ToRegisterFile,unidadControlALUOPToALU,winManagerNRs2ToRegisterFile : std_logic_vector(5 downto 0);
	signal winManagerNRdToMUXRFDest,winManagerRegO7ToMuxRfDest,muxRFDestToRF: std_logic_vector(5 downto 0);
	signal PSRIccToUnidadControl,auxNZVC : std_logic_vector(3 downto 0);
	signal auxEnableMem : std_logic;
	signal unidadControlRfDestToMUX,unidadControlWrEnMemToDataMemory,unidadControlWrEnRFToRegisterFile, auxCarry : std_logic;
begin

		Inst_nextPC: PC PORT MAP(
			address => outMuxBranchesToNextPC,
			clkFPGA => clk,
			reset => reset,
			nextInstruction => outNextPCToPC
		);	

		Inst_PC: PC PORT MAP(
			address => outNextPCToPC,
			clkFPGA => clk,
			reset => reset,
			nextInstruction => outPCToInstructionMemory
		);

		Inst_adder: adder PORT MAP(
			operand1 => outNextPCToPC,--outPCToInstructionMemory,
			operand2 => x"00000001",
			resultado => pcPlus1
		);
	
		Inst_SEUDisp22: SEUDisp22 PORT MAP(
			SEU22 => instruccion(21 downto 0),
			SEU32 => SEU22ToAdder
		);

		adderDisp30Operand2 <= "00"&instruccion(29 downto 0);--OJO CON EL SIGNO
		Inst_adderDisp30: adder PORT MAP(
			operand1 => outPCToInstructionMemory,
			operand2 => adderDisp30Operand2,
			resultado => adderDisp30ToMUX
		);
		
		Inst_adderDisp22: adder PORT MAP(
			operand1 => outPCToInstructionMemory,
			operand2 => SEU22ToAdder,
			resultado => adderDisp22ToMUX
		);

		Inst_muxPCSource: muxPCSource PORT MAP(
			PCDisp30 => adderDisp30ToMUX,
			PCDisp22 => adderDisp22ToMUX,
			PC4 => pcPlus1,
			PCAddress => auxResultadoALU,
			PCSource => pcSourceControlUnitToMUX,
			PCAddressOut => outMuxBranchesToNextPC
		);

	
		Inst_instructionMemory: instructionMemory PORT MAP(
			--clk => clk,
			address => outPCToInstructionMemory,
			reset => reset,
			outInstruction => instruccion
		);

		Inst_windowManager: windowManager PORT MAP(
			--clk => clk,
			op => instruccion(31 downto 30),
			op3 => instruccion(24 downto 19),
			cwp => PSRCWPToWindowManager,
			registerSource1 => instruccion(18 downto 14),
			registerSource2 => instruccion(4 downto 0),
			registerDestination => instruccion(29 downto 25),
			ncwp => windowManagerCWPToPSR,
			newRegisterSource1 => winManagerNRs1ToRegisterFile,
			newRegisterSource2 => winManagerNRs2ToRegisterFile,
			newRegisterDestination => winManagerNRdToMUXRFDest,
			registroO7 => winManagerRegO7ToMuxRfDest
		);
	
		Inst_unidadControl: unidadControl PORT MAP(
			--clk => clk,
			op => instruccion(31 downto 30),
			op2 => instruccion(24 downto 22),
			op3 => instruccion(24 downto 19),
			cond => instruccion(28 downto 25),
			icc => auxNZVC,--PSRIccToUnidadControl,
			enableMem => auxEnableMem,
			rfDest => unidadControlRfDestToMUX,
			rfSource => unidadControlRfSourceToMUX,
			pcSource => pcSourceControlUnitToMUX,
			wrEnMem => unidadControlWrEnMemToDataMemory,
			wrEnRF => unidadControlWrEnRFToRegisterFile,
			ALUOP =>  unidadControlALUOPToALU
		);

		Inst_muxRFDest: muxRFDest PORT MAP(
			nrd => winManagerNRdToMUXRFDest,
			registroO7 => winManagerRegO7ToMuxRfDest,
			RFDestSel => unidadControlRfDestToMUX,
			RFDest => muxRFDestToRF
		);

		Inst_registerFile: registerFile PORT MAP(
			--clkFPGA => clk,
			reset => reset,
			registerSource1 => winManagerNRs1ToRegisterFile,
			registerSource2 => winManagerNRs2ToRegisterFile,
			registerDestination => muxRFDestToRF,
			writeEnable => unidadControlWrEnRFToRegisterFile,
			dataToWrite => auxDataToWrite,
			contentRegisterSource1 => auxCRs1,
			contentRegisterSource2 => auxCRs2,
			contentRegisterDestination => auxCRd
		);
		
		Inst_signExtensionUnit: signExtensionUnit PORT MAP(
			--clk => clk,
			simm13 => instruccion (12 downto 0),
			simm32 => SEUToMuxALU
		);
		
		Inst_muxALU: muxALU PORT MAP(
			Crs2 => auxCRs2,
			SEUOperando => SEUToMuxALU,
			selImmediate => instruccion(13),
			OperandoALU => auxMUXALU
		);

		Inst_PSRModifier: PSRModifier PORT MAP(
			aluResult => auxResultadoALU,
			operando1 => auxCRs1(31),
			operando2 => auxMUXALU(31),
			aluOp => unidadControlALUOPToALU,
			nzvc => auxNZVC
		);
		
		Inst_PSR: PSR PORT MAP(
			clk => clk,
			reset => reset,
			nzvc => auxNZVC,
			nCWP => windowManagerCWPToPSR,
			CWP => PSRCWPToWindowManager,
			carry => auxCarry,
			icc => PSRIccToUnidadControl
		);
		
		Inst_ALU: ALU PORT MAP(
			operando1 => auxCRs1,
			operando2 => auxMUXALU,
			aluOP => unidadControlALUOPToALU,
			carry => auxCarry,
			AluResult => auxResultadoALU
		);
		
		Inst_dataMemory: dataMemory PORT MAP(
			clk => clk,
			enableMem => auxEnableMem,
			reset => reset,
			cRD => auxCRd,
			address => auxResultadoALU,
			wrEnMem => unidadControlWrEnMemToDataMemory,
			datoMem => auxDatoMem
		);
		
		Inst_muxRFSource: muxRFSource PORT MAP(
			DatoFromMem => auxDatoMem,
			AluResult => auxResultadoALU,
			PC => outPCToInstructionMemory,
			RFSource => unidadControlRfSourceToMUX,
			RFData => auxDataToWrite
		);
		
		dataOut <= auxDataToWrite;
		ProgramCounter <= outPCToInstructionMemory;

end arqSparcV8;

