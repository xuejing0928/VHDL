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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity idea_com_inner is
    Port ( Clk : in  STD_LOGIC;
		     CLK_HIGH : in STD_LOGIC;
           Reset : in  STD_LOGIC;
           RxD : in  STD_LOGIC;
           TxD : out  STD_LOGIC;
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0));
end idea_com_inner;

architecture Behavioral of idea_com_inner is

-- The UART for the communication with the PC:
component uart
	port ( mclkx16 	: in STD_LOGIC;
          reset 		: in STD_LOGIC;
          read 		: in STD_LOGIC;
          write 		: in STD_LOGIC;
          data 		: inout STD_LOGIC_VECTOR (7 downto 0);
          sin 		: in STD_LOGIC;
          sout 		: out STD_LOGIC;
          rxrdy 		: out STD_LOGIC;
          txrdy 		: out STD_LOGIC;
          parity_error 	: out STD_LOGIC;
          framing_error 	: out STD_LOGIC;
          overrun 	: out STD_LOGIC );
end component;


-- The IDEA algorithm in hardware - here the real magic happens
component idea_single
	port ( idea_single_start : in  STD_LOGIC;
          idea_single_ready : out  STD_LOGIC;
		    idea_single_clk : in STD_LOGIC;
			 key : in  STD_LOGIC_VECTOR (127 downto 0);
          idea_single_ix1 : in  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_ix2 : in  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_ix3 : in  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_ix4 : in  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_o1 : out  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_o2 : out  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_o3 : out  STD_LOGIC_VECTOR (15 downto 0);
          idea_single_o4 : out  STD_LOGIC_VECTOR (15 downto 0)
			);
end component;

-- All used signals for the top level are defined here:

signal read : STD_LOGIC := '1';
signal write : STD_LOGIC := '1';
signal rxrdy, txrdy : STD_LOGIC := '1';
signal parity_error, framing_error, overrun : STD_LOGIC := '0';
signal data : STD_LOGIC_VECTOR(7 downto 0) := "00000000";

signal start_idea, ready_idea : STD_LOGIC := '0';

signal x1, x2, x3, x4 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal y1, y2, y3, y4 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";

type STATE_TYPE is ( IDLE, WAIT_FOR_DATA, RECEIVED_BYTE, READ_BYTE,
						   WAIT_FOR_RXRDY_0, WAIT_FOR_IDEA_TO_DEACTIVATE_READY,
							WAIT_FOR_IDEA_TO_COMPLETE,
							WRITE_BYTE, WRITE_BYTE_NOW, WRITE_BYTE_ACK,
							WAIT_FOR_TXRDY_1 );


signal state : STATE_TYPE := IDLE;
signal byte_cntr : std_logic_vector(3 downto 0) := "0000";

begin	
	-- The UART module
	uart1:   uart port map( Clk, Reset,
									read, write, data,
									RxD, TxD,
									rxrdy, txrdy,
									parity_error, framing_error, overrun );
	-- The encryption algorithm
	idea1:   idea_single port map( start_idea, ready_idea,
                              Clk, x"00010002000300040005000600070008", x1, x2, x3, x4,
							   		y1, y2, y3, y4 );
	-- The state machine for the communication:
	process ( Clk )
	begin
		if ( Clk'event and Clk='1' ) then
			if ( Reset = '1' ) then
				state <= IDLE;
				byte_cntr <= "0000";
				read <= '1';
				write <= '1';
				LEDs <= "00000000";
			else
				if ( state = IDLE ) then
					-- Initial state
					state <= WAIT_FOR_DATA;
					byte_cntr <= "0000";
				elsif ( state = WAIT_FOR_DATA ) then
					write <= '1';
					-- Waiting for incoming data.
					if ( rxrdy = '1' ) then
						-- There is a byte at the receiver!
						state <= RECEIVED_BYTE;
					end if;
				elsif ( state = RECEIVED_BYTE ) then
					-- The UART signalizes, that there
					-- is a new byte to be read!
					read <= '0';
					LEDs(3) <= '0';
					state <= READ_BYTE;
				elsif ( state = READ_BYTE ) then
					-- Read the byte and set the
					-- right input registers of the
					-- IDEA block.
					LEDs(0) <= framing_error;
					LEDs(1) <= parity_error;
					LEDs(2) <= overrun;
					byte_cntr <= byte_cntr+"0001";
					if ( byte_cntr = "0000" ) then
						x1(7 downto 0) <= data;
					elsif ( byte_cntr = "0001" ) then
						x1(15 downto 8) <= data;
					elsif ( byte_cntr = "0010" ) then
						x2(7 downto 0) <= data;
					elsif ( byte_cntr = "0011" ) then
						x2(15 downto 8) <= data;
					elsif ( byte_cntr = "0100" ) then
						x3(7 downto 0) <= data;
					elsif ( byte_cntr = "0101" ) then
						x3(15 downto 8) <= data;
					elsif ( byte_cntr = "0110" ) then
						x4(7 downto 0) <= data;
					elsif ( byte_cntr = "0111" ) then
						x4(15 downto 8) <= data;
					end if;
					read <= '1';
					state <= WAIT_FOR_RXRDY_0;
				elsif ( state = WAIT_FOR_RXRDY_0 ) then
					-- Wait until the UART has acknowledged
					-- that the data has been read.
					if ( rxrdy = '0' ) then
						if ( byte_cntr = "1000" ) then
							start_idea <= '1';
							state <= WAIT_FOR_IDEA_TO_DEACTIVATE_READY;
						else
							state <= WAIT_FOR_DATA;
						end if;
					end if;
				elsif ( state = WAIT_FOR_IDEA_TO_DEACTIVATE_READY ) then
					if ( ready_idea = '0' ) then
						state <= WAIT_FOR_IDEA_TO_COMPLETE;
					end if;
				elsif ( state = WAIT_FOR_IDEA_TO_COMPLETE ) then
					-- The IDEA algorithm has computed its results now.
					byte_cntr <= "0000";
					start_idea <= '0';
					if ( ready_idea = '1' ) then
						state <= WRITE_BYTE;
					end if;
				elsif ( state = WRITE_BYTE ) then
					-- Write back the computed data set
					byte_cntr <= byte_cntr + "0001";
					if ( byte_cntr = "0000" ) then
						data <= y1(7 downto 0);
					elsif ( byte_cntr = 1 ) then
						data <= y1(15 downto 8);
					elsif ( byte_cntr = 2 ) then
						data <= y2(7 downto 0);
					elsif ( byte_cntr = 3 ) then
						data <= y2(15 downto 8);
					elsif ( byte_cntr = 4 ) then
						data <= y3(7 downto 0);
					elsif ( byte_cntr = 5 ) then
						data <= y3(15 downto 8);
					elsif ( byte_cntr = 6 ) then
						data <= y4(7 downto 0);
					elsif ( byte_cntr = 7 ) then
						data <= y4(15 downto 8);
					end if;
					state <= WRITE_BYTE_NOW;
				elsif ( state = WRITE_BYTE_NOW ) then
					write <= '0';
					state <= WRITE_BYTE_ACK;
				elsif ( state = WRITE_BYTE_ACK ) then
					write <= '1';
					if ( txrdy = '0' ) then
						state <= WAIT_FOR_TXRDY_1;
					end if;
				elsif ( state = WAIT_FOR_TXRDY_1 ) then
					if ( txrdy = '1' ) then
						data <= "ZZZZZZZZ";
						if ( byte_cntr = "1000" ) then
							state <= WAIT_FOR_DATA;
							byte_cntr <= "0000";
							LEDs(3) <= '1';
						else
							state <= WRITE_BYTE;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

