----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:23 05/23/2013 
-- Design Name: 
-- Module Name:    SEUDisp22 - arqSEUDisp22 
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

entity SEUDisp22 is
    Port ( SEU22 : in  STD_LOGIC_VECTOR (21 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEUDisp22;

architecture arqSEUDisp22 of SEUDisp22 is

begin
process(SEU22)
	begin
		if(SEU22(21) = '1')then
			SEU32(21 downto 0) <= SEU22;
			SEU32(31 downto 22) <= (others=>'1');
		else
			SEU32(21 downto 0) <= SEU22;
			SEU32(31 downto 22) <= (others=>'0');
		end if;
	end process;
end arqSEUDisp22;

