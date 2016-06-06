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
 
ENTITY tb_roundcontroller IS
END tb_roundcontroller;
 
ARCHITECTURE behavior OF tb_roundcontroller IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT roundcontrol
    PORT(
         Clock : IN  std_logic;
         Init : IN  std_logic;
         Enable125 : INOUT  std_logic;
         Enable346 : INOUT  std_logic;
         Enable78 : INOUT  std_logic;
         Result : INOUT  std_logic;
         S : INOUT  std_logic_vector(1 downto 0);
         InternalState : INOUT  std_logic_vector(2 downto 0);
         trafo : IN  std_logic;
         S_t : INOUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Init : std_logic := '1';
   signal trafo : std_logic := '1';

	--BiDirs
   signal Enable125 : std_logic;
   signal Enable346 : std_logic;
   signal Enable78 : std_logic;
   signal Result : std_logic;
   signal S : std_logic_vector(1 downto 0);
   signal InternalState : std_logic_vector(2 downto 0);
   signal S_t : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: roundcontrol PORT MAP (
          Clock => Clock,
          Init => Init,
          Enable125 => Enable125,
          Enable346 => Enable346,
          Enable78 => Enable78,
          Result => Result,
          S => S,
          InternalState => InternalState,
          trafo => trafo,
          S_t => S_t
        );

   -- Clock process definitions
   Clock_process :process
   begin
		 Clock <= '0';
		wait for Clock_period/2;
		 Clock <= '1';
		wait for Clock_period/2;
     	 Init <= '0';
   end process;

END;
