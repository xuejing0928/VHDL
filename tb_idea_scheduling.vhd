--       A generic IDEA encryption algorithm implementation, originally
--       created for a Xilinx Spartan 3E family of FPGA devices during 
--       a laboratory course at Technical University Munich.
--
--       Author: Ermin Sakic
-- 
--       Licensed to the Apache Software Foundation (ASF) under one
--       or more contributor license agreements.  See the NOTICE file
--       distributed with this work for additional information
--       regarding copyright ownership.  The ASF licenses this file
--       to you under the Apache License, Version 2.0 (the
--       "License"); you may not use this file except in compliance
--       with the License.  You may obtain a copy of the License at
--
--         http://www.apache.org/licenses/LICENSE-2.0
--
--       Unless required by applicable law or agreed to in writing,
--       software distributed under the License is distributed on an
--       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
--       KIND, either express or implied.  See the License for the
--       specific language governing permissions and limitations
--       under the License.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.all;

entity addop is
    Port ( a : in STD_LOGIC_vector(15 downto 0);
           b : in STD_LOGIC_vector(15 downto 0);
			  o : out  STD_LOGIC_vector(15 downto 0));
end addop;

architecture Behavioral of addop is
begin
	addop_process: process(a,b)
	begin
	o <= a + b;
   end process;
end Behavioral;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_idea_scheduling IS
END tb_idea_scheduling;
 
ARCHITECTURE behavior OF tb_idea_scheduling IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT idea_scheduling
    PORT(
         start : IN  std_logic;
         ready : OUT  std_logic;
         clock : IN  std_logic;
         inputkey : IN  std_logic_vector(127 downto 0);
         clear1 : IN  std_logic_vector(15 downto 0);
         clear2 : IN  std_logic_vector(15 downto 0);
         clear3 : IN  std_logic_vector(15 downto 0);
         clear4 : IN  std_logic_vector(15 downto 0);
         encrypted1 : OUT  std_logic_vector(15 downto 0);
         encrypted2 : OUT  std_logic_vector(15 downto 0);
         encrypted3 : OUT  std_logic_vector(15 downto 0);
         encrypted4 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal start : std_logic := '0';
   signal clock : std_logic := '0';
   signal inputkey : std_logic_vector(127 downto 0) := X"00010001000100010001000100010001";
   signal clear1 : std_logic_vector(15 downto 0) := X"0000";       --(others => '0');
   signal clear2 : std_logic_vector(15 downto 0) := X"0000";
   signal clear3 : std_logic_vector(15 downto 0) := X"0000";       
   signal clear4 : std_logic_vector(15 downto 0) := X"0000"; 

 	--Outputs
   signal ready : std_logic;
   signal encrypted1 : std_logic_vector(15 downto 0);
   signal encrypted2 : std_logic_vector(15 downto 0);
   signal encrypted3 : std_logic_vector(15 downto 0);
   signal encrypted4 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: idea_scheduling PORT MAP (
          start => start,
          ready => ready,
          clock => clock,
          inputkey => inputkey,
          clear1 => clear1,
          clear2 => clear2,
          clear3 => clear3,
          clear4 => clear4,
          encrypted1 => encrypted1,
          encrypted2 => encrypted2,
          encrypted3 => encrypted3,
          encrypted4 => encrypted4
        );

 -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;

 -- Stimulus process
   stim_proc: process
   begin	
		start <= '1';
		wait for clock_period;
		start <= '0';
		wait for clock_period*100;
  
   end process;

END;
