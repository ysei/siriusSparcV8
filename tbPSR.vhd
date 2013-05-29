--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:11:09 11/12/2012
-- Design Name:   
-- Module Name:   /home/john/Dropbox/Arquitectura/sparcProcessorMonocycle/tbPSR.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR
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
 
ENTITY tbPSR IS
END tbPSR;
 
ARCHITECTURE behavior OF tbPSR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         nzvc : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic_vector(4 downto 0);
         CWP : OUT  std_logic_vector(4 downto 0);
         carry : OUT  std_logic;
         icc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal CWP : std_logic_vector(4 downto 0);
   signal carry : std_logic;
   signal icc : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          clk => clk,
          reset => reset,
          nzvc => nzvc,
          nCWP => nCWP,
          CWP => CWP,
          carry => carry,
          icc => icc
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
      wait for 100 ns;		
		reset <= '0';
		nzvc <= "0101";
		nCWP <= "01101";
      wait for 100 ns;
		nzvc <= "1111";
		nCWP <= "11111";
      wait ;
   end process;

END;
