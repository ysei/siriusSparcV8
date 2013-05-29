----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:27:29 10/28/2012 
-- Design Name: 
-- Module Name:    nPC - arqNPC 
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

entity nPC is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           clkFPGA : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end nPC;

architecture arqNPC of nPC is

begin
process(clkFPGA, address, reset)
	begin
		if(reset = '0')then
			nextInstruction <= (others=>'0');
		else
			if(rising_edge(clkFPGA))then
				nextInstruction <= address;
			end if;
		end if;
	end process;
end arqNPC;

