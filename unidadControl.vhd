----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:07 11/12/2012 
-- Design Name: 
-- Module Name:    unidadControl - arqUnidadControl 
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

entity unidadControl is
    Port ( --clk : in STD_LOGIC;
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cond : in  STD_LOGIC_VECTOR (3 downto 0);
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  enableMem : out STD_LOGIC;
           rfDest : out  STD_LOGIC;
           rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end unidadControl;

architecture arqUnidadControl of unidadControl is

begin
	process(op, op2, op3, cond, icc)
	begin
		--if(rising_edge(clk))then
			if(op = "01")then --CALL
				pcSource <= "01"; -- PC + (4 x disp30)
				wrEnRF <= '1'; -- Permito guardar el valor actual de PC
				rfSource <= "10"; -- PC
				enableMem <= '1';
				rfDest <= '1'; -- r[15]
				wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
				ALUOP <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
			else
				if(op = "00")then
					if(op2 = "010")then -- Branch on Integer Condition Codes Instructions
						case cond is
							when "1000" => -- Branch Always
								pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
								wrEnRF <= '0';
								enableMem <= '1';
								rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "111111";
							when "1001" => -- Branch on Not Equal
								if(not(icc(2)) = '1') then -- not Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							when "0001" => -- Branch on Equal
								if(icc(2) = '1') then --  Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							when "1010" => -- Branch on Greater
								if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then -- not(Z or (N xor V))
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							
							when "0010" => -- Branch on Less or Equal
								if((icc(2) or (icc(3) xor icc(1))) = '1') then -- Z or (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							when "1011" => -- Branch on Greater or Equal
								if((not(icc(3) xor icc(1))) = '1') then -- not (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							when "0011" => -- Branch on Less
								if((icc(3) xor icc(1)) = '1') then -- (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;
							when others => -- Not Implemented
								pcSource <= "00";
								wrEnRF <= '0';
								enableMem <= '1';
								rfSource <= "00";
								rfDest <= '0'; -- r[15]
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
						end case;
					else
						if(op2 = "100")then -- NOP
							pcSource <= "11"; -- Se salta a PC + 4
							wrEnRF <= '0'; -- Se guarda en el Register File el valor de 
							rfSource <= "01"; -- Debe ser el resultado de la operacion
							rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
							wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
							ALUOP <= "111111";
							enableMem <= '1';
						end if;
					end if;
				else
					if(op = "10")then				
						case op3 is
							when "000000" => -- ADD
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000";
								enableMem <= '1';
							when "010000" => -- ADDCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000001";
								enableMem <= '1';
							when "000010" => -- OR
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001000";
								enableMem <= '1';

							when "000100" => -- SUB
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010000";
								enableMem <= '1';
							
							when "010100" => -- SUBCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000101";
								enableMem <= '1';
							
							when "111100" => -- SAVE
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- El save es igual a un add pero modifica CWP
								enableMem <= '1';
								
							when "111101" => -- RESTORE
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- El restore es igual a un add pero modifica CWP
								enableMem <= '1';
							
							when "111000" => -- JMPL
								pcSource <= "00"; -- Se salta a la dirección calculada.
								wrEnRF <= '1'; -- Se guarda en el Register File el valor del PC
								rfSource <= "10"; -- Debe ser el valor del PC
								rfDest <= '0'; -- Debe ser el valor de nRD
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- Se deben sumar los dos operandos que entren a la ALU que determinan la dirección del salto
								enableMem <= '1';
							
							when others => -- Implementar demas instrucciones
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01"; -- Debe ser el resultado de la operacion
								rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000";
								enableMem <= '1';
						end case;
						
					else
						if(op = "11")then
							case op3 is
								when "000100" => -- SW
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- No Se guarda en el Register File
									rfSource <= "01"; -- No importa porque no se va a guardar en el Register File
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '1'; -- El dato es escrito en Memoria de Datos
									ALUOP <= "000000";
									enableMem <= '1';
								
								when "000000" => -- LW
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '1'; -- Si se guarda en el Register File
									rfSource <= "00"; -- Se debe guardar lo que se carga de la Memoria de Datos
									rfDest <= '0'; -- Se debe permitir que el valor cargado desde la Memoria de datos se guarde en el RF donde diga rd
									wrEnMem <= '0'; -- El dato no es escrito en Memoria de Datos
									ALUOP <= "000000";
									enableMem <= '1';
								
								when others => -- Implementar demas instrucciones
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
									rfSource <= "01"; -- Debe ser el resultado de la operacion
									rfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "000000";
									enableMem <= '1';
							end case;
						end if;
					
					end if;
				end if;
			end if;
		--end if; -- if rising_edge
	end process;
end arqUnidadControl;
