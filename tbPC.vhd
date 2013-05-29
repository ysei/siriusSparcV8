--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:50:46 05/25/2013
-- Design Name:   
-- Module Name:   /home/john/Dropbox/Arquitectura/sparcProcessorMonocycle/tbPC.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY tbPC IS
END tbPC;
 
ARCHITECTURE behavior OF tbPC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         clkFPGA : IN  std_logic;
         reset : IN  std_logic;
         nextInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal clkFPGA : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal nextInstruction : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clkFPGA_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          address => address,
          clkFPGA => clkFPGA,
          reset => reset,
          nextInstruction => nextInstruction
        );

   -- Clock process definitions
   clkFPGA_process :process
   begin
		clkFPGA <= '0';
		wait for clkFPGA_period/2;
		clkFPGA <= '1';
		wait for clkFPGA_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 100 ns;	
		address <= x"00000000"; 
      reset <= '0'; 
		wait for 20 ns;
		address <= x"00000001";
		wait for 20 ns;
		address <= x"00000002";
		wait for 20 ns;
		address <= x"00000003";
      wait;
   end process;

END;
