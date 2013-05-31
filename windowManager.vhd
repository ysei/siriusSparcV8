----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:56 10/28/2012 
-- Design Name: 
-- Module Name:    windowManager - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity windowManager is
    Port ( --clk : in STD_LOGIC;
			  op : in STD_LOGIC_VECTOR (1 downto 0);
			  op3 : in STD_LOGIC_VECTOR (5 downto 0);
			  cwp : in STD_LOGIC_VECTOR (1 downto 0);
			  registerSource1 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (4 downto 0);
			  ncwp : out STD_LOGIC_VECTOR (1 downto 0):="00";
           newRegisterSource1 : out  STD_LOGIC_VECTOR (5 downto 0);
           newRegisterSource2 : out  STD_LOGIC_VECTOR (5 downto 0);
           newRegisterDestination : out  STD_LOGIC_VECTOR (5 downto 0);
			  registroO7 : out STD_LOGIC_VECTOR(5 downto 0));
end windowManager;

architecture Behavioral of windowManager is
	signal registerSource1Integer,registerSource2Integer,registerDestinationInteger: integer range 0 to 39:=0;
	signal auxRegistroO7 : std_logic_vector(6 downto 0);
begin	
	auxRegistroO7 <= cwp * "10000";--OJO en lugar de "00" debe ir cwp
	registroO7 <= auxRegistroO7(5 downto 0) + "001111";
	process(registerSource1,registerSource2,registerDestination,cwp,op,op3)
	begin
		--if(rising_edge(clk))then
			if(op = "10" and op3 = "111100")then--SAVE
				ncwp <= conv_std_logic_vector(conv_integer(cwp) - 1,2);
			else
				if(op = "10" and op3 = "111101")then--RESTORE
					ncwp <= conv_std_logic_vector(conv_integer(cwp) + 1,2);
					--else
						--ncwp <= cwp;
				end if;
			end if;
		
		if(registerSource1>="00000" and registerSource1<="00111") then
			registerSource1Integer <= conv_integer(registerSource1);
		else
			if(registerSource1>="11000" and registerSource1<="11111") then
				registerSource1Integer <= conv_integer(registerSource1)-(conv_integer(cwp)*16);
			else
				if(registerSource1>="10000" and registerSource1<="10111") then
					registerSource1Integer <= conv_integer(registerSource1)+(conv_integer(cwp)*16);
				else
						if(registerSource1>="01000" and registerSource1<="01111") then
							registerSource1Integer <= conv_integer(registerSource1)+ (conv_integer(cwp)*16);
						end if;
				end if;
			end if;
		end if;
		
		
	
		if(registerSource2>="00000" and registerSource2<="00111") then
			registerSource2Integer <= conv_integer(registerSource2);
		else
			if(registerSource2>="11000" and registerSource2<="11111") then
				registerSource2Integer <= conv_integer(registerSource2) - (conv_integer(cwp)*16);
			else
				if(registerSource2>="11000" and registerSource2<="11111") then
					registerSource2Integer <= conv_integer(registerSource2) - (conv_integer(cwp)*16);
				else
					if(registerSource2>="10000" and registerSource2<="10111") then
						registerSource2Integer <= conv_integer(registerSource2)+ (conv_integer(cwp)*16);
					else
						if(registerSource2>="01000" and registerSource1<="01111") then
							registerSource2Integer <= conv_integer(registerSource2)+ (conv_integer(cwp)*16);
						end if;
					end if;
				end if;
			end if;
		end if;
		
		if(registerDestination>="00000" and registerDestination<="00111") then
			registerDestinationInteger <= conv_integer(registerDestination);
		else
			if(registerDestination>="11000" and registerDestination<="11111") then
				registerDestinationInteger <= conv_integer(registerDestination)  - (conv_integer(cwp)*16);
			else
				if(registerDestination>="10000" and registerSource1<="10111") then
					registerDestinationInteger <= conv_integer(registerDestination)+ (conv_integer(cwp)*16);
				else
					if(registerDestination>="01000" and registerDestination<="01111") then
						registerDestinationInteger <= conv_integer(registerDestination)+ (conv_integer(cwp)*16);
					end if;
				end if;
			end if;
		end if;
		--end if; --- process del clk ojo
	end process;
	newRegisterSource1 <= conv_std_logic_vector(registerSource1Integer, 6);
	newRegisterSource2 <= conv_std_logic_vector(registerSource2Integer, 6);
	newRegisterDestination <= conv_std_logic_vector(registerDestinationInteger, 6);
end Behavioral;

