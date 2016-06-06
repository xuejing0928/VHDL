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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trafo is
     Port (z1: in STD_LOGIC_vector(15 downto 0);
           z2: in STD_LOGIC_vector(15 downto 0);
			  z3: in STD_LOGIC_vector(15 downto 0);
           z4: in STD_LOGIC_vector(15 downto 0);
			  x1: in STD_LOGIC_vector(15 downto 0);
			  x2: in STD_LOGIC_vector(15 downto 0);
			  x3: in STD_LOGIC_vector(15 downto 0);
			  x4: in STD_LOGIC_vector(15 downto 0);
			  y1: out STD_LOGIC_vector(15 downto 0);
			  y2: out STD_LOGIC_vector(15 downto 0);
			  y3: out STD_LOGIC_vector(15 downto 0);
			  y4: out STD_LOGIC_vector(15 downto 0));
end trafo;

architecture Structural of trafo is

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
	
begin
  n1: mulop
    port map (x1,z1,y1);
  n2: addop
    port map (x2,z3,y3);
  n3: addop
    port map (x3,z2,y2);
  n4: mulop
    port map (x4,z4,y4);

end Structural;
