----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:32 10/28/2012 
-- Design Name: 
-- Module Name:    ALU - arqALU 
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

entity ALU is
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           carry : in  STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture arqALU of ALU is

begin

	process(operando1,operando2,aluOP,carry)
	begin
	   case (aluOP) is 
			when "000000" => -- add
				AluResult <= operando1 + operando2;
			when "000001" => -- addcc
				AluResult <= operando1 + operando2;
			when "000010" => --addx
				AluResult <= operando1 + operando2 + carry;
			when "000100" => --and
				AluResult <= operando1 and operando2;
			when "001000" => -- or
				AluResult <= operando1 or operando2;
			when "010000" => -- sub
				AluResult <= operando1 - operando2;
			when "000101" => -- subcc
				AluResult <= operando1 - operando2;
			when others => -- Cae el nop
				AluResult <= (others=>'0');
		end case;
	end process;
end arqALU;

