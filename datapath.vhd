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

entity datapath is
    Port ( datapathz1: in STD_LOGIC_vector(15 downto 0);
           datapathz2: in STD_LOGIC_vector(15 downto 0);
			  datapathz3: in STD_LOGIC_vector(15 downto 0);
           datapathz4: in STD_LOGIC_vector(15 downto 0);
           datapathz5: in STD_LOGIC_vector(15 downto 0);
           datapathz6: in STD_LOGIC_vector(15 downto 0);
			  datapathx1: in STD_LOGIC_vector(15 downto 0);
			  datapathx2: in STD_LOGIC_vector(15 downto 0);
			  datapathx3: in STD_LOGIC_vector(15 downto 0);
			  datapathx4: in STD_LOGIC_vector(15 downto 0);
			  datapathy1: out STD_LOGIC_vector(15 downto 0);
			  datapathy2: out STD_LOGIC_vector(15 downto 0);
			  datapathy3: out STD_LOGIC_vector(15 downto 0);
			  datapathy4: out STD_LOGIC_vector(15 downto 0);
	        datapathClock: in STD_LOGIC;
           datapathInit: in STD_LOGIC;
			  datapathenable125: in STD_LOGIC;
			  datapathenable346: in STD_LOGIC;
			  datapathenable78: in STD_LOGIC;
			  datapathResult: in STD_LOGIC;
			  datapathS: in STD_LOGIC_vector(1 downto 0);
			  datapathS_t: in STD_LOGIC_vector(1 downto 0);
			  datapathy1_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy2_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy3_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy4_t: out STD_LOGIC_vector(15 downto 0));
   end datapath;

architecture Behavioral of datapath is

signal datapathvar1	 : std_logic_vector (15 downto 0);
signal datapathvar2	 : std_logic_vector (15 downto 0);
signal datapathvar3	 : std_logic_vector (15 downto 0);
signal datapathvar4	 : std_logic_vector (15 downto 0);
signal datapathvar5	 : std_logic_vector (15 downto 0);
signal datapathvar6	 : std_logic_vector (15 downto 0);
signal datapathvar7	 : std_logic_vector (15 downto 0);
signal datapathvar8	 : std_logic_vector (15 downto 0);

signal r1	 : std_logic_vector (15 downto 0);
signal r2	 : std_logic_vector (15 downto 0);
signal r3	 : std_logic_vector (15 downto 0);
signal r4	 : std_logic_vector (15 downto 0);
signal r5	 : std_logic_vector (15 downto 0);
signal r6	 : std_logic_vector (15 downto 0);
signal r7	 : std_logic_vector (15 downto 0);
signal r8	 : std_logic_vector (15 downto 0);

   component quadmultiplexer
   port(   S : in  STD_LOGIC_vector(1 downto 0);
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           C : in  STD_LOGIC_VECTOR (15 downto 0);
			  D : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
   end component;

	component mulop
   Port (a,b: in std_logic_vector;
           o: out std_logic_vector);
	end component;
	
	component addop
   Port (a,b: in std_logic_vector;
	         o: out std_logic_vector);
	end component;

	component xorop
   Port (first,second: in std_logic_vector;
	         output: out std_logic_vector);
	end component;

   component bit_register
	port(	clock : IN std_logic;
	enable : IN std_logic;
	D: IN std_logic_vector(15 downto 0); 
	Q: OUT std_logic_vector(15 downto 0));
   end component;
	
begin

reg1	 : bit_register port map (datapathClock, datapathenable125, datapathvar3, r1);
reg2	 : bit_register port map (datapathClock, datapathenable125, datapathvar6, r2);
reg5	 : bit_register port map (datapathClock, datapathenable125, datapathvar7, r5);
reg3	 : bit_register port map (datapathClock, datapathenable346, datapathvar6, r3);
reg4	 : bit_register port map (datapathClock, datapathenable346, datapathvar3, r4);
reg6	 : bit_register port map (datapathClock, datapathenable346, datapathvar7, r6);
reg7	 : bit_register port map (datapathClock, datapathenable78, datapathvar3, r7);
reg8	 : bit_register port map (datapathClock, datapathenable78, datapathvar6, r8);

multiplex1: quadmultiplexer port map (datapathS, datapathx1, datapathx4, datapathz5, datapathz6, datapathvar1);
multiplex2: quadmultiplexer port map (datapathS, datapathz1, datapathz4, r5, r8, datapathvar2);		
multiplex3: quadmultiplexer port map (datapathS, datapathx3, datapathx2, r6, r7, datapathvar4);		
multiplex4: quadmultiplexer port map (datapathS_t, datapathz3, datapathz2, datapathvar3, datapathvar3, datapathvar5);		

mulop1: mulop port map (datapathvar1, datapathvar2, datapathvar3);
addop1: addop port map (datapathvar4, datapathvar5, datapathvar6);
	
xorop1: xorop port map (datapathvar6, datapathvar3, datapathvar7);
xorop2: xorop port map (r3, datapathvar6, datapathy3);
xorop3: xorop port map (r2, datapathvar3, datapathy2);
xorop4: xorop port map (r4, datapathvar6, datapathy4);
xorop5: xorop port map (r1, datapathvar3, datapathy1);

datapathy1_t <= r1;
datapathy2_t <= r2;
datapathy3_t <= r3;
datapathy4_t <= r4;

end Behavioral;
