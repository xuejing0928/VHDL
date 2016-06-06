library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity quadmultiplexer is
    Port ( S : in  STD_LOGIC_vector(1 downto 0);
           A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           C : in  STD_LOGIC_VECTOR (15 downto 0);
			  D : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end quadmultiplexer;

architecture Behavioral of quadmultiplexer is

begin
	quadmultiplexer: process(A,B,C,D,S)
	begin
			case S is
				when "00" => O <= A;
				when "01" => O <= B;
				when "10" => O <= C;
				when "11" => O <= D;
				when others => O <= "XXXXXXXXXXXXXXXX";
			end case;
	end process quadmultiplexer;

end Behavioral;