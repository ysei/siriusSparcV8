--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:56:51 11/12/2012
-- Design Name:   
-- Module Name:   /home/john/Dropbox/Arquitectura/sparcProcessorMonocycle/tbUnidadControl.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: unidadControl
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tbUnidadControl IS
END tbUnidadControl;
 
ARCHITECTURE behavior OF tbUnidadControl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unidadControl
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op2 : IN  std_logic_vector(2 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cond : IN  std_logic_vector(3 downto 0);
         icc : IN  std_logic_vector(3 downto 0);
         rfDest : OUT  std_logic;
         rfSource : OUT  std_logic_vector(1 downto 0);
         pcSource : OUT  std_logic_vector(1 downto 0);
         wrEnMem : OUT  std_logic;
         wrEnRF : OUT  std_logic;
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op2 : std_logic_vector(2 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal cond : std_logic_vector(3 downto 0) := (others => '0');
   signal icc : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal rfDest : std_logic;
   signal rfSource : std_logic_vector(1 downto 0);
   signal pcSource : std_logic_vector(1 downto 0);
   signal wrEnMem : std_logic;
   signal wrEnRF : std_logic;
   signal ALUOP : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unidadControl PORT MAP (
          op => op,
          op2 => op2,
          op3 => op3,
          cond => cond,
          icc => icc,
          rfDest => rfDest,
          rfSource => rfSource,
          pcSource => pcSource,
          wrEnMem => wrEnMem,
          wrEnRF => wrEnRF,
          ALUOP => ALUOP
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      op <= "10";
		op2 <= "000";
		op3 <= "000000" ;
		cond <= "0000";
		icc <= "0000";		
      wait for 100 ns;
		op <= "10";
		op2 <= "000";
		op3 <= "010000" ;
		cond <= "0000";
		icc <= "0000";		
      wait for 100 ns;
		op <= "00";
		op2 <= "010";
		op3 <= "000000" ;
		cond <= "1000";
		icc <= "0000";		
      wait;
   end process;

END;
