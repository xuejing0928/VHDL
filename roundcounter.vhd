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


entity roundcounter is
    Port ( c_clock : in STD_LOGIC;
			  c_Start : in  STD_LOGIC;
           c_Result : in  STD_LOGIC;--------------------von Steuerlogik/Rundenmodul generiert
           c_S_i : out  STD_LOGIC_VECTOR (1 downto 0);
           c_Trafo : out  STD_LOGIC;---------------------------------an Rundenmodul
           c_Init : out  STD_LOGIC;---------------------------------an Rundenmodul
           c_Ready : out  STD_LOGIC;
           c_Round : out  STD_LOGIC_VECTOR (3 downto 0));-----------an Keygenerator
end roundcounter;

architecture Behavioral of roundcounter is

signal Round_buff : std_logic_vector(3 downto 0);
signal Init_buff : std_logic;
signal Ready_buff : std_logic;

begin

	clock_process: process(c_clock)
	begin		
		if (c_clock='1' and c_clock'EVENT) then
			if(c_Start='1') then
				c_Round<="0000";
				Round_buff<="0000";
				c_S_i<="00";--'0';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0000")then
				c_Round<="0001";
				Round_buff<="0001";
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0001")then
				c_Round<="0010";
				Round_buff<="0010";
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0010")then
				c_Round<="0011";
				Round_buff<="0011";
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0011")then
				c_Round<="0100";
				Round_buff<="0100";			
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0100")then
				c_Round<="0101";
				Round_buff<="0101";
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0101")then
				c_Round<="0110";
				Round_buff<="0110";
				c_S_i<="01";--'1';				
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0110")then
				c_Round<="0111";
				Round_buff<="0111";	
				c_S_i<="01";--'1';
				c_Trafo<='0';
			elsif(c_Result='1' and Round_buff="0111")then
				c_Round<="1000";
				Round_buff<="1000";	
				c_S_i<="01";--'1';
				c_Trafo<='1';
				
			end if;
		end if;	

	end process;	
	
	
	second_process: process(c_clock)
	begin
	
		if (c_clock='1' and c_clock'EVENT) then
			
			if(c_Start='1') then
				c_Init <= '1';
				c_Ready <= '0';
				Init_buff <= '1';
				Ready_buff <= '0';

			elsif(Init_buff='1' and Ready_buff='0') then
				c_Init <= '0';
				Init_buff <= '0';
			
			elsif(Init_buff='0' and c_Result='0') then
				c_Init <= '0';
				Init_buff <= '0';
			
			elsif(Init_buff='0' and c_Result='1' and Round_buff/="1000")then
				c_Init <= '1';
				c_Ready <= '0';
				Init_buff <= '1';
				Ready_buff <= '0';
				
			elsif(Init_buff='0' and c_Result='1' and Round_buff="1000") then
				c_Init <= '0';
				c_Ready <= '1';
				Init_buff <= '0';
				Ready_buff <= '1';
				
			end if;
		end if;
			
	end process;	

end Behavioral;
