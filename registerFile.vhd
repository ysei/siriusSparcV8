----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:26 10/28/2012 
-- Design Name: 
-- Module Name:    registerFile - arqRegisterFile 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerFile is
    Port ( --clkFPGA : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (5 downto 0);
           writeEnable : in  STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterDestination : out  STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture arqRegisterFile of registerFile is

	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal registers : ram_type :=(others => x"00000000");

begin
--,reset,registerSource1,registerSource2,registerDestination,writeEnable,dataToWrite
	process(reset,registerSource1,registerSource2,registerDestination,writeEnable,dataToWrite)--clkFPGA)
	begin
		--if(rising_edge(clkFPGA))then
			if(reset = '1')then
				contentRegisterSource1 <= (others=>'0');
				contentRegisterSource2 <= (others=>'0');
				contentRegisterDestination <= (others=>'0');
				registers <= (others => x"00000000");
			else
				contentRegisterSource1 <= registers(conv_integer(registerSource1));
				contentRegisterSource2 <= registers(conv_integer(registerSource2));
				contentRegisterDestination <= registers(conv_integer(registerDestination));
				if(writeEnable = '1' and registerDestination /= "000000")then
					registers(conv_integer(registerDestination)) <= dataToWrite;
				end if;
			end if;
		--end if;
	end process;
end arqRegisterFile;

