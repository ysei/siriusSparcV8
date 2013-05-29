----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:46:40 11/04/2012 
-- Design Name: 
-- Module Name:    signExtensionUnit - arqSignExtensionUnit 
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

entity signExtensionUnit is
    Port ( --clk : in STD_LOGIC;
			  simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end signExtensionUnit;

architecture arqSignExtensionUnit of signExtensionUnit is

begin
	process(simm13)
	begin
		--if(rising_edge(clk))then
			if(simm13(12) = '1')then
				simm32(12 downto 0) <= simm13;
				simm32(31 downto 13) <= (others=>'1');
			else
				simm32(12 downto 0) <= simm13;
				simm32(31 downto 13) <= (others=>'0');
			end if;
		--end if;
	end process;

end arqSignExtensionUnit;

