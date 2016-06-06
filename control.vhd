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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
    Port ( Clock: in STD_LOGIC;
           Start: in STD_LOGIC;
			  Round: inout STD_LOGIC_vector(3 downto 0);
			  Ready: out STD_LOGIC;
			  Enable: out STD_LOGIC;
			  S: out STD_LOGIC);
end control;

architecture Behavioral of control is
signal flag: std_logic := '0';
begin
	control_process: process(Clock)
	variable buff : STD_LOGIC_vector(3 downto 0);
	begin
		if(Clock='1' and Clock'EVENT) then
		if(Start='1') then
			Ready<='0'; --encrpytion starts here
			S<='0';
			Round<="0000";
			buff:="0000";
			Enable<='1';
			flag<='1';
		elsif(buff="0000") then
			S<='1';
			Round<="0001";
		   buff:="0001";
		elsif(buff="0001") then
			Round<="0010";
			buff:="0010";
		elsif(buff="0010") then
			Round<="0011";
			buff:="0011";
		elsif(buff="0011") then
			Round<="0100";
			buff:="0100";
		elsif(buff="0100") then
			Round<="0101";
			buff:="0101";
		elsif(buff="0101") then
			Round<="0110";
			buff:="0110";
		elsif(buff="0110") then
			Round<="0111";
			buff:="0111";
		elsif(buff="0111") then
			Round<="1000";
			buff:="1000";
			Ready<='1';
		   Enable<='0';
		end if;
		end if;
	end process;
end Behavioral;
