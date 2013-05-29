
-- VHDL Instantiation Created from source file nPC.vhd -- 22:56:09 11/14/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT nPC
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clkFPGA : IN std_logic;          
		nextInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	Inst_nPC: nPC PORT MAP(
		address => ,
		reset => ,
		clkFPGA => ,
		nextInstruction => 
	);


