library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity idea_single is
Port ( 
idea_single_start : in std_logic;
idea_single_ready : out std_logic;

idea_single_clk : in std_logic;

key : in STD_LOGIC_VECTOR (127 downto 0):=x"00010002000300040005000600070008";

idea_single_ix1 : in STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_ix2 : in STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_ix3 : in STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_ix4 : in STD_LOGIC_VECTOR (15 downto 0) := X"0000";

idea_single_o1 : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_o2 : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_o3 : out STD_LOGIC_VECTOR (15 downto 0) := X"0000";
idea_single_o4 : out STD_LOGIC_VECTOR (15 downto 0) := X"0000"

);
end idea_single;

architecture Behavioral of idea_single is

--signal idea_single_ready : std_logic := '1'; 
--signal sig_idea_single_start : std_logic;

signal idea_single_s : std_logic :='1';
signal idea_single_enable	: std_logic :='0';

signal idea_single_round : std_logic_vector (3 downto 0) := "1000"; 

signal idea_single_key1	 : std_logic_vector (15 downto 0);
signal idea_single_key2	 : std_logic_vector (15 downto 0);
signal idea_single_key3	 : std_logic_vector (15 downto 0);
signal idea_single_key4	 : std_logic_vector (15 downto 0);
signal idea_single_key5	 : std_logic_vector (15 downto 0);
signal idea_single_key6	 : std_logic_vector (15 downto 0);

signal idea_single_a1	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_a2	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_a3	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_a4	 : std_logic_vector (15 downto 0) :=X"0000";

signal idea_single_b1	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_b2	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_b3	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_b4	 : std_logic_vector (15 downto 0) :=X"0000";

signal idea_single_c1	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_c2	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_c3	 : std_logic_vector (15 downto 0) :=X"0000";
signal idea_single_c4	 : std_logic_vector (15 downto 0) :=X"0000";

--eingebundene komponenten: control, trafo, round, keygen, mux, reg
COMPONENT control
PORT(
Clock : IN std_logic;
Start : IN std_logic; 
Round : inOUT std_logic_vector(3 downto 0);
Ready : OUT std_logic;
Enable : OUT std_logic;
S : OUT std_logic
);
END COMPONENT;

COMPONENT trafo
PORT(
z1 : IN std_logic_vector(15 downto 0);
z2 : IN std_logic_vector(15 downto 0);
z3 : IN std_logic_vector(15 downto 0);
z4 : IN std_logic_vector(15 downto 0); 
x1 : IN std_logic_vector(15 downto 0);
x2 : IN std_logic_vector(15 downto 0);
x3 : IN std_logic_vector(15 downto 0);
x4 : IN std_logic_vector(15 downto 0);
y1 : OUT std_logic_vector(15 downto 0);
y2 : OUT std_logic_vector(15 downto 0);
y3 : OUT std_logic_vector(15 downto 0);
y4 : OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

COMPONENT round
PORT(
z1 : IN std_logic_vector(15 downto 0);
z2 : IN std_logic_vector(15 downto 0);
z3 : IN std_logic_vector(15 downto 0);
z4 : IN std_logic_vector(15 downto 0);
z5 : IN std_logic_vector(15 downto 0);
z6 : IN std_logic_vector(15 downto 0); 
x1 : IN std_logic_vector(15 downto 0);
x2 : IN std_logic_vector(15 downto 0);
x3 : IN std_logic_vector(15 downto 0);
x4 : IN std_logic_vector(15 downto 0);
y1 : OUT std_logic_vector(15 downto 0);
y2 : OUT std_logic_vector(15 downto 0);
y3 : OUT std_logic_vector(15 downto 0);
y4 : OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

	component keygenerator
	Port ( inputkey : in  STD_LOGIC_VECTOR;
          round : in  STD_LOGIC_VECTOR;
          z1, z2, z3, z4, z5, z6 : out  STD_LOGIC_VECTOR);
	end component;

COMPONENT multiplexer
PORT(
S: IN std_logic;
A: IN std_logic_vector(15 downto 0);
B: IN std_logic_vector(15 downto 0); 
O: OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

COMPONENT bit_register
PORT(
clock : IN std_logic;
enable : IN std_logic;
D: IN std_logic_vector(15 downto 0); 
Q: OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

begin

kontrolleinheit : control port map(	idea_single_clk, 
idea_single_start, 
idea_single_round, 
idea_single_ready, 
idea_single_enable, 
idea_single_s);

generator : keygenerator port map(key, idea_single_round, 
idea_single_key1, 
idea_single_key2, 
idea_single_key3, 
idea_single_key4, 
idea_single_key5, 
idea_single_key6);

multiplex1	 : multiplexer port map(idea_single_s, idea_single_ix1, idea_single_c1, idea_single_a1);
multiplex2	 : multiplexer port map(idea_single_s, idea_single_ix2, idea_single_c2, idea_single_a2);
multiplex3	 : multiplexer port map(idea_single_s, idea_single_ix3, idea_single_c3, idea_single_a3);
multiplex4	 : multiplexer port map(idea_single_s, idea_single_ix4, idea_single_c4, idea_single_a4);

Rundenmodul	 : round port map(idea_single_key1, idea_single_key2, idea_single_key3, idea_single_key4, idea_single_key5, idea_single_key6, idea_single_a1, idea_single_a2, idea_single_a3, idea_single_a4
,idea_single_b1, idea_single_b2, idea_single_b3, idea_single_b4);

reg1	 : bit_register port map (idea_single_clk, idea_single_enable, idea_single_b1, idea_single_c1);
reg2	 : bit_register port map (idea_single_clk, idea_single_enable, idea_single_b2, idea_single_c2);
reg3	 : bit_register port map (idea_single_clk, idea_single_enable, idea_single_b3, idea_single_c3);
reg4	 : bit_register port map (idea_single_clk, idea_single_enable, idea_single_b4, idea_single_c4);

Ausgabetransformation	: trafo port map(	idea_single_key1, idea_single_key2, idea_single_key3, idea_single_key4, idea_single_c1, idea_single_c2, idea_single_c3, idea_single_c4, 
idea_single_o1, idea_single_o2, idea_single_o3, idea_single_o4);

end Behavioral;