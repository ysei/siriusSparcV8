----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:10 05/23/2013 
-- Design Name: 
-- Module Name:    muxALU - arqMuxALU 
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

entity muxALU is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end muxALU;

architecture arqMuxALU of muxALU is

begin

	process(Crs2,SEUOperando,selImmediate)
	begin
		if(selImmediate = '1')then
			OperandoALU <= SEUOperando;
		else
			if(selImmediate = '0')then
				OperandoALU <= Crs2;
			end if;
		end if;
	end process;

end arqMuxALU;

