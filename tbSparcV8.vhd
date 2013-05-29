--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:18:31 05/24/2013
-- Design Name:   
-- Module Name:   /home/john/Dropbox/Arquitectura/sparcProcessorMonocycle/tbSparcV8.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sparcV8
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
 
ENTITY tbSparcV8 IS
END tbSparcV8;
 
ARCHITECTURE behavior OF tbSparcV8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sparcV8
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         dataOut : OUT  std_logic_vector(31 downto 0);
         ProgramCounter : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal dataOut : std_logic_vector(31 downto 0);
   signal ProgramCounter : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sparcV8 PORT MAP (
          clk => clk,
          reset => reset,
          dataOut => dataOut,
          ProgramCounter => ProgramCounter
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 40 ns;	
	    
		reset <= '0';
			
      wait;
   end process;

END;
