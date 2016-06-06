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
 
ENTITY tb_idea_single IS
END tb_idea_single;
 
ARCHITECTURE behavior OF tb_idea_single IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT idea_single
    PORT(
         idea_single_start : IN  std_logic:='1';
         idea_single_ready : INOUT  std_logic;
         idea_single_clk : IN  std_logic:='0';
         key : IN  std_logic_vector(127 downto 0);
         idea_single_ix1 : IN  std_logic_vector(15 downto 0):=x"0000";
         idea_single_ix2 : IN  std_logic_vector(15 downto 0):=x"0000";
         idea_single_ix3 : IN  std_logic_vector(15 downto 0):=x"0000";
         idea_single_ix4 : IN  std_logic_vector(15 downto 0):=x"0000";
         idea_single_o1 : OUT  std_logic_vector(15 downto 0);
         idea_single_o2 : OUT  std_logic_vector(15 downto 0);
         idea_single_o3 : OUT  std_logic_vector(15 downto 0);
         idea_single_o4 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal idea_single_start : std_logic := '1';
   signal idea_single_clk : std_logic := '0';
   signal key : std_logic_vector(127 downto 0):=x"00010002000300040005000600070008";
   signal idea_single_ix1 : std_logic_vector(15 downto 0):=x"0000";
   signal idea_single_ix2 : std_logic_vector(15 downto 0):=x"0001";
   signal idea_single_ix3 : std_logic_vector(15 downto 0):=x"0002";
   signal idea_single_ix4 : std_logic_vector(15 downto 0):=x"0003";

 	--Outputs
   signal idea_single_ready : std_logic;
   signal idea_single_o1 : std_logic_vector(15 downto 0);
   signal idea_single_o2 : std_logic_vector(15 downto 0);
   signal idea_single_o3 : std_logic_vector(15 downto 0);
   signal idea_single_o4 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant idea_single_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: idea_single PORT MAP (
          idea_single_start => idea_single_start,
          idea_single_ready => idea_single_ready,
          idea_single_clk => idea_single_clk,
          key => key,
          idea_single_ix1 => idea_single_ix1,
          idea_single_ix2 => idea_single_ix2,
          idea_single_ix3 => idea_single_ix3,
          idea_single_ix4 => idea_single_ix4,
          idea_single_o1 => idea_single_o1,
          idea_single_o2 => idea_single_o2,
          idea_single_o3 => idea_single_o3,
          idea_single_o4 => idea_single_o4
        );

   -- Clock process definitions
   idea_single_clk_process :process
   begin
		idea_single_clk <= '0';
		wait for idea_single_clk_period/2;
		idea_single_clk <= '1';
		wait for idea_single_clk_period/2;
		idea_single_start <='0';
   end process;

END;
