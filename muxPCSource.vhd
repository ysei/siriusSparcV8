----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:28 05/23/2013 
-- Design Name: 
-- Module Name:    muxPCSource - arqMuxPCSource 
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

entity muxPCSource is
    Port ( PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));
end muxPCSource;

architecture arqMuxPCSource of muxPCSource is

begin

process(PCDisp30,PCDisp22,PC4,PCAddress,PCAddress,PCSource)
begin
		case PCSource is
			when "00" =>
				PCAddressOut <= PCAddress;
			when "01" =>
				PCAddressOut <= PCDisp30;
			when "10" =>
				PCAddressOut <= PCDisp22;
			when "11" =>
				PCAddressOut <= PC4;
			when others =>
				PCAddressOut <= PC4;
		end case;
end process;

end arqMuxPCSource;

