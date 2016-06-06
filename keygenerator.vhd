----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity keygenerator is
    Port ( inputkey : in  STD_LOGIC_VECTOR (127 downto 0) := x"00010002000300040005000600070008";
           round : in  STD_LOGIC_VECTOR (3 downto 0);
           z1 : out  STD_LOGIC_VECTOR (15 downto 0);
           z2 : out  STD_LOGIC_VECTOR (15 downto 0);
           z3 : out  STD_LOGIC_VECTOR (15 downto 0);
           z4 : out  STD_LOGIC_VECTOR (15 downto 0);
           z5 : out  STD_LOGIC_VECTOR (15 downto 0);
           z6 : out  STD_LOGIC_VECTOR (15 downto 0));
end keygenerator;

architecture Behavioral of keygenerator is

begin
	keygenerator_process: process(round)
	begin
	 case round is
		when "0000" => z1<= inputkey(127 downto 112);
							z2<= inputkey(111 downto 96);
							z3<= inputkey(95 downto 80);
							z4<= inputkey(79 downto 64);
							z5<= inputkey(63 downto 48);
							z6<= inputkey(47 downto 32);
	   
	   when "0001" => z1<= inputkey(31 downto 16);
							z2<= inputkey(15 downto 0);
							z3<= inputkey(102 downto 87);
							z4<= inputkey(86 downto 71);
							z5<= inputkey(70 downto 55);
							z6<= inputkey(54 downto 39);
							
	   when "0010" => z1<= inputkey(38 downto 23);
							z2<= inputkey(22 downto 7);
							z3<= inputkey(6 downto 0) & inputkey(127 downto 119);
							z4<= inputkey(118 downto 103);
							z5<= inputkey(77 downto 62);
							z6<= inputkey(61 downto 46);
							
		when "0011" =>	z1<= inputkey(45 downto 30);
							z2<= inputkey(29 downto 14);
							z3<= inputkey(13 downto 0) & inputkey(127 downto 126);
							z4<= inputkey(125 downto 110);
							z5<= inputkey(109 downto 94);
							z6<= inputkey(93 downto 78);
				
		when "0100" =>	z1<= inputkey(52 downto 37);
							z2<= inputkey(36 downto 21);
							z3<= inputkey(20 downto 5);
							z4<= inputkey(4 downto 0) & inputkey(127 downto 117);
							z5<= inputkey(116 downto 101);
							z6<= inputkey(100 downto 85);
				
		when "0101" =>	z1<= inputkey(84 downto 69);
							z2<= inputkey(68 downto 53);
							z3<= inputkey(27 downto 12);
							z4<= inputkey(11 downto 0) & inputkey(127 downto 124);
							z5<= inputkey(123 downto 108);
							z6<= inputkey(107 downto 92);
				
      when "0110" => z1<= inputkey(91 downto 76);
						   z2<= inputkey(75 downto 60);
						   z3<= inputkey(59 downto 44);
						   z4<= inputkey(43 downto 28);
							z5<= inputkey(2 downto 0) & inputkey(127 downto 115);
							z6<= inputkey(114 downto 99);

		when "0111" => z1<= inputkey(98 downto 83);
							z2<= inputkey(82 downto 67);
							z3<= inputkey(66 downto 51);
							z4<= inputkey(50 downto 35);
							z5<= inputkey(34 downto 19);
							z6<= inputkey(18 downto 3);

      when "1000" =>	z1<= inputkey(105 downto 90);
							z2<= inputkey(89 downto 74);
							z3<= inputkey(73 downto 58);
							z4<= inputkey(57 downto 42);
	
					
		when others => z1<= "XXXXXXXXXXXXXXXX";			
							z2<= "XXXXXXXXXXXXXXXX";
							z3<= "XXXXXXXXXXXXXXXX";
							z4<= "XXXXXXXXXXXXXXXX";
							z5<= "XXXXXXXXXXXXXXXX";
							z6<= "XXXXXXXXXXXXXXXX";
		end case;
	end process keygenerator_process;	
		
end Behavioral;




