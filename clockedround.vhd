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

entity clockedround is
     Port (Clock: in STD_LOGIC;
			  RoundInit: in STD_LOGIC;
			  z1: in STD_LOGIC_vector(15 downto 0);
           z2: in STD_LOGIC_vector(15 downto 0);
			  z3: in STD_LOGIC_vector(15 downto 0);
           z4: in STD_LOGIC_vector(15 downto 0);
           z5: in STD_LOGIC_vector(15 downto 0);
           z6: in STD_LOGIC_vector(15 downto 0);
			  x1: in STD_LOGIC_vector(15 downto 0);
			  x2: in STD_LOGIC_vector(15 downto 0);
			  x3: in STD_LOGIC_vector(15 downto 0);
			  x4: in STD_LOGIC_vector(15 downto 0);
			  y1: out STD_LOGIC_vector(15 downto 0);
			  y2: out STD_LOGIC_vector(15 downto 0);
			  y3: out STD_LOGIC_vector(15 downto 0);
			  y4: out STD_LOGIC_vector(15 downto 0);
           RoundResult: inout std_logic;
           RoundInternalState: inout std_logic_vector (2 downto 0);
			  RoundTrafo: in std_logic;
			  y1_t: out STD_LOGIC_vector(15 downto 0);
			  y2_t: out STD_LOGIC_vector(15 downto 0);
			  y3_t: out STD_LOGIC_vector(15 downto 0);
			  y4_t: out STD_LOGIC_vector(15 downto 0)
);
end clockedround;

architecture Behavioral of clockedround is

signal RoundS_t: std_logic_vector (1 downto 0);
signal RoundS: std_logic_vector (1 downto 0);
signal RoundEnable125: std_logic;
signal RoundEnable346: std_logic;
signal RoundEnable78:  std_logic;

component roundcontrol
   Port(Clock: in STD_LOGIC;
     Init: in STD_LOGIC;
	  Enable125: inout STD_LOGIC;
	  Enable346: inout STD_LOGIC;
	  Enable78: inout STD_LOGIC;
	  Result: inout STD_LOGIC;
	  S: inout STD_LOGIC_vector(1 downto 0);
	  InternalState: inout STD_LOGIC_vector(2 downto 0);
	  trafo: in std_logic;
	  S_t: inout STD_LOGIC_vector(1 downto 0));
end component;

component datapath
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
			  datapathEnable125: inout STD_LOGIC;
			  datapathEnable346: inout STD_LOGIC;
			  datapathEnable78: inout STD_LOGIC;
			  datapathResult: inout STD_LOGIC;
			  datapathS: inout STD_LOGIC_vector(1 downto 0);
			  datapathS_t: in STD_LOGIC_vector(1 downto 0);
			  datapathy1_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy2_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy3_t: out STD_LOGIC_vector(15 downto 0);
			  datapathy4_t: out STD_LOGIC_vector(15 downto 0));
end component;

begin

r1 : roundcontrol port map(Clock,RoundInit,
               RoundEnable125,RoundEnable346, 
					RoundEnable78,RoundResult,
					RoundS,RoundInternalState, RoundTrafo, RoundS_t);
d1: datapath port map(z1,z2,z3,z4,z5,z6,x1,x2,x3,x4,y1,y2,y3,y4,Clock,RoundInit,RoundEnable125,
               RoundEnable346,RoundEnable78,RoundResult,RoundS, RoundS_t,y1_t,y2_t,y3_t,y4_t );
				
end Behavioral;

