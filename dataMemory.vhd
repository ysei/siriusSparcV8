----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:55 11/12/2012 
-- Design Name: 
-- Module Name:    dataMemory - arqDataMemory 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataMemory is
    Port ( clk : in  STD_LOGIC;
			  enableMem : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in STD_LOGIC_VECTOR (31 downto 0);				
           wrEnMem : in  STD_LOGIC;
           datoMem : out  STD_LOGIC_VECTOR (31 downto 0));
end dataMemory;

architecture arqDataMemory of dataMemory is
	type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
	signal ramMemory : ram_type:=(others => x"00000000");
begin
	--reset,cRD,address,wrEnMem)
	process(clk)
	begin
		if(rising_edge(clk))then
			if(enableMem = '1') then
				if(reset = '1')then
					datoMem <= (others => '0');
					ramMemory <= (others => x"00000000");
				else
					if(wrEnMem = '0')then
						datoMem <= ramMemory(conv_integer(address(5 downto 0)));
					else
						ramMemory(conv_integer(address(5 downto 0))) <= cRD;
					end if;
				end if;
			end if;
		end if;
	end process;
end arqDataMemory;
