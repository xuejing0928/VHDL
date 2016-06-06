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
 
ENTITY tb_clockedround IS
END tb_clockedround;
 
ARCHITECTURE behavior OF tb_clockedround IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clockedround
    PORT(
         Clock : IN  std_logic;
         RoundInit : IN  std_logic;
         z1 : IN  std_logic_vector;
         z2 : IN  std_logic_vector(15 downto 0);
         z3 : IN  std_logic_vector(15 downto 0);
         z4 : IN  std_logic_vector(15 downto 0);
         z5 : IN  std_logic_vector(15 downto 0);
         z6 : IN  std_logic_vector(15 downto 0);
         x1 : IN  std_logic_vector(15 downto 0);
         x2 : IN  std_logic_vector(15 downto 0);
         x3 : IN  std_logic_vector(15 downto 0);
         x4 : IN  std_logic_vector(15 downto 0);
         y1 : OUT  std_logic_vector(15 downto 0);
         y2 : OUT  std_logic_vector(15 downto 0);
         y3 : OUT  std_logic_vector(15 downto 0);
         y4 : OUT  std_logic_vector(15 downto 0);
         RoundResult : INOUT  std_logic;
         RoundInternalState : INOUT  std_logic_vector(2 downto 0);
         RoundTrafo : IN  std_logic;
         y1_t : OUT  std_logic_vector(15 downto 0);
         y2_t : OUT  std_logic_vector(15 downto 0);
         y3_t : OUT  std_logic_vector(15 downto 0);
         y4_t : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal RoundInit : std_logic := '1';
   signal z1 : std_logic_vector(15 downto 0) := x"0001";
   signal z2 : std_logic_vector(15 downto 0) := x"0001";
   signal z3 : std_logic_vector(15 downto 0) := x"0001";
   signal z4 : std_logic_vector(15 downto 0) := x"0001";
   signal z5 : std_logic_vector(15 downto 0) := x"0001";
   signal z6 : std_logic_vector(15 downto 0) := x"0001";
   signal x1 : std_logic_vector(15 downto 0) := x"0001";
   signal x2 : std_logic_vector(15 downto 0) := x"0001";
   signal x3 : std_logic_vector(15 downto 0) := x"0001";
   signal x4 : std_logic_vector(15 downto 0) := x"0001";
   signal RoundTrafo : std_logic := '0';

	--BiDirs
   signal RoundResult : std_logic;
   signal RoundInternalState : std_logic_vector(2 downto 0);

 	--Outputs
   signal y1 : std_logic_vector(15 downto 0);
   signal y2 : std_logic_vector(15 downto 0);
   signal y3 : std_logic_vector(15 downto 0);
   signal y4tb : std_logic_vector(15 downto 0);
   signal y1_t : std_logic_vector(15 downto 0);
   signal y2_t : std_logic_vector(15 downto 0);
   signal y3_t : std_logic_vector(15 downto 0);
   signal y4_t : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clockedround PORT MAP (
          Clock => Clock,
          RoundInit => RoundInit,
          z1 => z1,
          z2 => z2,
          z3 => z3,
          z4 => z4,
          z5 => z5,
          z6 => z6,
          x1 => x1,
          x2 => x2,
          x3 => x3,
          x4 => x4,
          y1 => y1,
          y2 => y2,
          y3 => y3,
          y4 => y4tb,
          RoundResult => RoundResult,
          RoundInternalState => RoundInternalState,
          RoundTrafo => RoundTrafo,
          y1_t => y1_t,
          y2_t => y2_t,
          y3_t => y3_t,
          y4_t => y4_t
        );

   -- Clock process definitions
   Clock_process :process
   begin
	    Clock <= '0';
		wait for Clock_period/2;
		 Clock <= '1';
		wait for Clock_period/2;
		 RoundInit <= '0';
   end process;

END;
