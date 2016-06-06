----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity multiplexer is
    Port ( S : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is

begin
	mux_process: process(A,B,S)
	begin
			case S is
				when'0' => O <= A;
				when'1' => O <= B;
				when others => O <= "XXXXXXXXXXXXXXXX";
			end case;
	end process mux_process;

end Behavioral;

