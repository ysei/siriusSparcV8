--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:05 10/28/2012
-- Design Name:   
-- Module Name:   /home/john/Documents/sparcProcessorMonocycle/tbWindowManager.vhd
-- Project Name:  sparcProcessorMonocycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: windowManager
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
 
ENTITY tbWindowManager IS
END tbWindowManager;
 
ARCHITECTURE behavior OF tbWindowManager IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windowManager
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cwp : IN  std_logic_vector(1 downto 0);
         registerSource1 : IN  std_logic_vector(4 downto 0);
         registerSource2 : IN  std_logic_vector(4 downto 0);
         registerDestination : IN  std_logic_vector(4 downto 0);
         ncwp : OUT  std_logic_vector(1 downto 0);
         newRegisterSource1 : OUT  std_logic_vector(5 downto 0);
         newRegisterSource2 : OUT  std_logic_vector(5 downto 0);
         newRegisterDestination : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal cwp : std_logic_vector(1 downto 0) := (others => '0');
   signal registerSource1 : std_logic_vector(4 downto 0) := (others => '0');
   signal registerSource2 : std_logic_vector(4 downto 0) := (others => '0');
   signal registerDestination : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ncwp : std_logic_vector(1 downto 0);
   signal newRegisterSource1 : std_logic_vector(5 downto 0);
   signal newRegisterSource2 : std_logic_vector(5 downto 0);
   signal newRegisterDestination : std_logic_vector(5 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windowManager PORT MAP (
          op => op,
          op3 => op3,
          cwp => cwp,
          registerSource1 => registerSource1,
          registerSource2 => registerSource2,
          registerDestination => registerDestination,
          ncwp => ncwp,
          newRegisterSource1 => newRegisterSource1,
          newRegisterSource2 => newRegisterSource2,
          newRegisterDestination => newRegisterDestination
        );

   
   -- Stimulus process
   stim_proc: process
   begin		
		cwp <= "01";
		op <= "10";
		op3 <= "101101";
		registerSource1 <= "00011";
		registerSource2 <= "10001";
		registerDestination <= "10010";
      wait;
   end process;

END;
