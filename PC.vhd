----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:16:06 10/28/2012 
-- Design Name: 
-- Module Name:    PC - arqPC 
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

entity PC is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clkFPGA : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture arqPC of PC is

begin
	process(clkFPGA)
	begin
		if(rising_edge(clkFPGA))then
			if(reset = '1')then
				nextInstruction <= (others=>'0');
			else
				nextInstruction <= address;
			end if;
		end if;
	end process;
end arqPC;

