----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:37 05/23/2013 
-- Design Name: 
-- Module Name:    muxRFDest - arqMuxRFDest 
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

entity muxRFDest is
    Port ( nrd : in  STD_LOGIC_VECTOR (5 downto 0);
           registroO7 : in  STD_LOGIC_VECTOR (5 downto 0);
           RFDestSel : in  STD_LOGIC;
           RFDest : out  STD_LOGIC_VECTOR (5 downto 0));
end muxRFDest;

architecture arqMuxRFDest of muxRFDest is

begin
	process(nrd,registroO7,RFDestSel)
	begin
		if(RFDestSel = '0')then
			RFDest <= nrd;
		else
			if(RFDestSel = '1')then
				RFDest <= registroO7;
			end if;
		end if;
	end process;
end arqMuxRFDest;

