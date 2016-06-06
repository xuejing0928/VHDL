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
 
ENTITY tb_roundcounter IS
END tb_roundcounter;
 
ARCHITECTURE behavior OF tb_roundcounter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT roundcounter
    PORT(
         c_clock : IN  std_logic;
         c_Start : IN  std_logic;
         c_Result : IN  std_logic;
         c_S_i : OUT  std_logic_vector(1 downto 0);
         c_Trafo : OUT  std_logic;
         c_Init : OUT  std_logic;
         c_Ready : OUT  std_logic;
         c_Round : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal c_clock : std_logic := '0';
   signal c_Start : std_logic := '0';
   signal c_Result : std_logic := '0';

 	--Outputs
   signal c_S_i : std_logic_vector(1 downto 0):="00";
   signal c_Trafo : std_logic:='0';
   signal c_Init : std_logic:='0';
   signal c_Ready : std_logic:='1';
   signal c_Round : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant c_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: roundcounter PORT MAP (
          c_clock => c_clock,
          c_Start => c_Start,
          c_Result => c_Result,
          c_S_i => c_S_i,
          c_Trafo => c_Trafo,
          c_Init => c_Init,
          c_Ready => c_Ready,
          c_Round => c_Round
        );

   -- Clock process definitions
   c_clock_process :process
   begin
		c_clock <= '0';
		wait for c_clock_period/2;
		c_clock <= '1';
		wait for c_clock_period/2;
   end process;

	   Result_process :process
   begin
		c_Result <= '0';
		wait for 7*c_clock_period;
		c_Result <= '1';
		wait for c_clock_period;
   end process;
	
	
	-- Stimulus process
   stim_proc: process
   begin		
      c_Start <= '1';
		wait for c_clock_period;
		c_Start <= '0'; 
		wait for 80*c_clock_period;
	end process;
END;
