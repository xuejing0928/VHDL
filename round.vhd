library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity round is
     Port (z1: in STD_LOGIC_vector(15 downto 0);
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
			  y4: out STD_LOGIC_vector(15 downto 0));
end round;

architecture Structural of round is
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
    port map (x1,z1,o1);
  n2: addop
    port map (x2,z2,o2);
  n3: addop
    port map (x3,z3,o3);
  n4: mulop
    port map (x4,z4,o4);
  n5: xorop
    port map (o1,o3,o5);
  n6: xorop
    port map (o2,o4,o6);
  n7: mulop
    port map (o5,z5,o7);
  n8: addop
    port map (o6,o7,o8);
  n9: mulop
    port map (o8,z6,o10);
  n10: addop
    port map (o7,o10,o9);
  n11: xorop
    port map (o1,o10,y1);
  n12: xorop
    port map (o3,o10,y2);
  n13: xorop
    port map (o2,o9,y3);
  n14: xorop
    port map (o4,o9,y4);
end Structural;	