--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:52:25 11/04/2012
-- Design Name:   
-- Module Name:   /home/john/Documents/sparcProcessorMonocycle/tbSignExtensionUnit.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: signExtensionUnit
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
 
ENTITY tbSignExtensionUnit IS
END tbSignExtensionUnit;
 
ARCHITECTURE behavior OF tbSignExtensionUnit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT signExtensionUnit
    PORT(
         simm13 : IN  std_logic_vector(12 downto 0);
         simm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal simm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal simm32 : std_logic_vector(31 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: signExtensionUnit PORT MAP (
          simm13 => simm13,
          simm32 => simm32
        );

   -- Stimulus process
   stim_proc: process
   begin		
      simm13 <= "0111111111111";
      wait for 100 ns;	
		simm13 <= "1000000000000";
      wait;
   end process;

END;
