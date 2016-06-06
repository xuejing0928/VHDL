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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.ALL;
use IEEE.Numeric_std.all;
entity idea is
	Port (  clear1: in STD_LOGIC_vector(15 downto 0);
			  clear2: in STD_LOGIC_vector(15 downto 0);
			  clear3: in STD_LOGIC_vector(15 downto 0);
			  clear4: in STD_LOGIC_vector(15 downto 0);
			  inputkey: in STD_LOGIC_vector(127 downto 0);
			  encrypted1: out STD_LOGIC_vector(15 downto 0);
			  encrypted2: out STD_LOGIC_vector(15 downto 0);
			  encrypted3: out STD_LOGIC_vector(15 downto 0);
			  encrypted4: out STD_LOGIC_vector(15 downto 0));
end idea;

architecture Structural of idea is
signal z11: STD_LOGIC_vector(15 downto 0);
signal z21: STD_LOGIC_vector(15 downto 0);
signal z31: STD_LOGIC_vector(15 downto 0);
signal z41: STD_LOGIC_vector(15 downto 0);
signal z51: STD_LOGIC_vector(15 downto 0);
signal z61: STD_LOGIC_vector(15 downto 0);
signal z12: STD_LOGIC_vector(15 downto 0);
signal z22: STD_LOGIC_vector(15 downto 0);
signal z32: STD_LOGIC_vector(15 downto 0);
signal z42: STD_LOGIC_vector(15 downto 0);
signal z52: STD_LOGIC_vector(15 downto 0);
signal z62: STD_LOGIC_vector(15 downto 0);
signal z13: STD_LOGIC_vector(15 downto 0);
signal z23: STD_LOGIC_vector(15 downto 0);
signal z33: STD_LOGIC_vector(15 downto 0);
signal z43: STD_LOGIC_vector(15 downto 0);
signal z53: STD_LOGIC_vector(15 downto 0);
signal z63: STD_LOGIC_vector(15 downto 0);
signal z14: STD_LOGIC_vector(15 downto 0);
signal z24: STD_LOGIC_vector(15 downto 0);
signal z34: STD_LOGIC_vector(15 downto 0);
signal z44: STD_LOGIC_vector(15 downto 0);
signal z54: STD_LOGIC_vector(15 downto 0);
signal z64: STD_LOGIC_vector(15 downto 0);
signal z15: STD_LOGIC_vector(15 downto 0);
signal z25: STD_LOGIC_vector(15 downto 0);
signal z35: STD_LOGIC_vector(15 downto 0);
signal z45: STD_LOGIC_vector(15 downto 0);
signal z55: STD_LOGIC_vector(15 downto 0);
signal z65: STD_LOGIC_vector(15 downto 0);
signal z16: STD_LOGIC_vector(15 downto 0);
signal z26: STD_LOGIC_vector(15 downto 0);
signal z36: STD_LOGIC_vector(15 downto 0);
signal z46: STD_LOGIC_vector(15 downto 0);
signal z56: STD_LOGIC_vector(15 downto 0);
signal z66: STD_LOGIC_vector(15 downto 0);
signal z17: STD_LOGIC_vector(15 downto 0);
signal z27: STD_LOGIC_vector(15 downto 0);
signal z37: STD_LOGIC_vector(15 downto 0);
signal z47: STD_LOGIC_vector(15 downto 0);
signal z57: STD_LOGIC_vector(15 downto 0);
signal z67: STD_LOGIC_vector(15 downto 0);
signal z18: STD_LOGIC_vector(15 downto 0);
signal z28: STD_LOGIC_vector(15 downto 0);
signal z38: STD_LOGIC_vector(15 downto 0);
signal z48: STD_LOGIC_vector(15 downto 0);
signal z58: STD_LOGIC_vector(15 downto 0);
signal z68: STD_LOGIC_vector(15 downto 0);
signal z1t: STD_LOGIC_vector(15 downto 0);
signal z2t: STD_LOGIC_vector(15 downto 0);
signal z3t: STD_LOGIC_vector(15 downto 0);
signal z4t: STD_LOGIC_vector(15 downto 0);
signal o1 : STD_LOGIC_vector(15 downto 0);
signal o2 : STD_LOGIC_vector(15 downto 0);
signal o3 : STD_LOGIC_vector(15 downto 0);
signal o4 : STD_LOGIC_vector(15 downto 0);
signal o5 : STD_LOGIC_vector(15 downto 0);
signal o6 : STD_LOGIC_vector(15 downto 0);
signal o7 : STD_LOGIC_vector(15 downto 0);
signal o8 : STD_LOGIC_vector(15 downto 0);
signal o9 : STD_LOGIC_vector(15 downto 0);
signal o10 : STD_LOGIC_vector(15 downto 0);
signal o11 : STD_LOGIC_vector(15 downto 0);
signal o12 : STD_LOGIC_vector(15 downto 0);
signal o13 : STD_LOGIC_vector(15 downto 0);
signal o14 : STD_LOGIC_vector(15 downto 0);
signal o15 : STD_LOGIC_vector(15 downto 0);
signal o16 : STD_LOGIC_vector(15 downto 0);
signal o17 : STD_LOGIC_vector(15 downto 0);
signal o18 : STD_LOGIC_vector(15 downto 0);
signal o19 : STD_LOGIC_vector(15 downto 0);
signal o20 : STD_LOGIC_vector(15 downto 0);
signal o21 : STD_LOGIC_vector(15 downto 0);
signal o22 : STD_LOGIC_vector(15 downto 0);
signal o23 : STD_LOGIC_vector(15 downto 0);
signal o24 : STD_LOGIC_vector(15 downto 0);
signal o25 : STD_LOGIC_vector(15 downto 0);
signal o26 : STD_LOGIC_vector(15 downto 0);
signal o27 : STD_LOGIC_vector(15 downto 0);
signal o28 : STD_LOGIC_vector(15 downto 0);
signal o29 : STD_LOGIC_vector(15 downto 0);
signal o30 : STD_LOGIC_vector(15 downto 0);
signal o31 : STD_LOGIC_vector(15 downto 0);
signal o32 : STD_LOGIC_vector(15 downto 0);

	component round
   Port (z1,z2,z3,z4,z5,z6,x1,x2,x3,x4: in std_logic_vector;
	         y1,y2,y3,y4: out std_logic_vector);
	end component;
	
	component trafo
   Port (z1,z2,z3,z4,x1,x2,x3,x4: in std_logic_vector;
	         y1,y2,y3,y4: out std_logic_vector);
	end component;

begin

z11<= inputkey(127 downto 112);
z21<= inputkey(111 downto 96);
z31<= inputkey(95 downto 80);
z41<= inputkey(79 downto 64);
z51<= inputkey(63 downto 48);
z61<= inputkey(47 downto 32);
z12<= inputkey(31 downto 16);
z22<= inputkey(15 downto 0);
z32<= inputkey(102 downto 87);
z42<= inputkey(86 downto 71);
z52<= inputkey(70 downto 55);
z62<= inputkey(54 downto 39);
z13<= inputkey(38 downto 23);
z23<= inputkey(22 downto 7);
z33<= inputkey(6 downto 0) & inputkey(127 downto 119);
z43<= inputkey(118 downto 103);
z53<= inputkey(77 downto 62);
z63<= inputkey(61 downto 46);
z14<= inputkey(45 downto 30);
z24<= inputkey(29 downto 14);
z34<= inputkey(13 downto 0) & inputkey(127 downto 126);
z44<= inputkey(125 downto 110);
z54<= inputkey(109 downto 94);
z64<= inputkey(93 downto 78);
z15<= inputkey(52 downto 37);
z25<= inputkey(36 downto 21);
z35<= inputkey(20 downto 5);
z45<= inputkey(4 downto 0) & inputkey(127 downto 117);
z55<= inputkey(116 downto 101);
z65<= inputkey(100 downto 85);
z16<= inputkey(84 downto 69);
z26<= inputkey(68 downto 53);
z36<= inputkey(27 downto 12);
z46<= inputkey(11 downto 0) & inputkey(127 downto 124);
z56<= inputkey(123 downto 108);
z66<= inputkey(107 downto 92);
z17<= inputkey(91 downto 76);
z27<= inputkey(75 downto 60);
z37<= inputkey(59 downto 44);
z47<= inputkey(43 downto 28);
z57<= inputkey(2 downto 0) & inputkey(127 downto 115);
z67<= inputkey(114 downto 99);
z18<= inputkey(98 downto 83);
z28<= inputkey(82 downto 67);
z38<= inputkey(66 downto 51);
z48<= inputkey(50 downto 35);
z58<= inputkey(34 downto 19);
z68<= inputkey(18 downto 3);
z1t<= inputkey(105 downto 90);
z2t<= inputkey(89 downto 74);
z3t<= inputkey(73 downto 58);
z4t<= inputkey(57 downto 42);

  n1: round
    port map (z11,z21,z31,z41,z51,z61,clear1,clear2,clear3,clear4,o1,o2,o3,o4);
  n2: round
    port map (z12,z22,z32,z42,z52,z62,o1,o2,o3,o4,o5,o6,o7,o8);
  n3: round
    port map (z13,z23,z33,z43,z53,z63,o5,o6,o7,o8,o9,o10,o11,o12);
  n4: round
    port map (z14,z24,z34,z44,z54,z64,o9,o10,o11,o12,o13,o14,o15,o16);
  n5: round
    port map (z15,z25,z35,z45,z55,z65,o13,o14,o15,o16,o17,o18,o19,o20);
  n6: round
    port map (z16,z26,z36,z46,z56,z66,o17,o18,o19,o20,o21,o22,o23,o24);
  n7: round
    port map (z17,z27,z37,z47,z57,z67,o21,o22,o23,o24,o25,o26,o27,o28);
  n8: round
    port map (z18,z28,z38,z48,z58,z68,o25,o26,o27,o28,o29,o30,o31,o32);
  n9: trafo
	 port map (z1t,z2t,z3t,z4t,o29,o30,o31,o32,encrypted1,encrypted2,encrypted3,encrypted4);
end Structural;
