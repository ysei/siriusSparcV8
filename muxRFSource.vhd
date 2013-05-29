----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:10:38 05/23/2013 
-- Design Name: 
-- Module Name:    muxRFSource - arqMuxRFSource 
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

entity muxRFSource is
    Port ( DatoFromMem : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           RFData : out  STD_LOGIC_VECTOR (31 downto 0));
end muxRFSource;

architecture arqMuxRFSource of muxRFSource is

begin
process(DatoFromMem,AluResult,PC,RFSource)
begin
	case RFSource is
		when "00" =>
			RFData <= DatoFromMem;
		when "01" =>
			RFData <= AluResult;
		when "10" =>
			RFData <= PC;
		when others =>
			RFData <= (others =>'0');
	end case;
end process;

end arqMuxRFSource;

