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
 
 
ENTITY tb_keygenerator IS
END tb_keygenerator;
 
ARCHITECTURE behavior OF tb_keygenerator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keygenerator
    PORT(
         inputkey : IN  std_logic_vector(127 downto 0);
         round : IN  std_logic_vector(3 downto 0);
         z1 : OUT  std_logic_vector(15 downto 0);
         z2 : OUT  std_logic_vector(15 downto 0);
         z3 : OUT  std_logic_vector(15 downto 0);
         z4 : OUT  std_logic_vector(15 downto 0);
         z5 : OUT  std_logic_vector(15 downto 0);
         z6 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inputkey : std_logic_vector(127 downto 0) := (others => '0');
   signal round : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal z1 : std_logic_vector(15 downto 0);
   signal z2 : std_logic_vector(15 downto 0);
   signal z3 : std_logic_vector(15 downto 0);
   signal z4 : std_logic_vector(15 downto 0);
   signal z5 : std_logic_vector(15 downto 0);
   signal z6 : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 500 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keygenerator PORT MAP (
          inputkey => inputkey,
          round => round,
          z1 => z1,
          z2 => z2,
          z3 => z3,
          z4 => z4,
          z5 => z5,
          z6 => z6
        );

   -- Clock process definitions
   clock_process :process
   begin
		inputkey <= x"000f000f000f000f000f000f000f000f";
		round <= "0001";
		wait for clock_period/2;
		round <= "0000";
		wait for clock_period/2;
   end process;
 
END;
