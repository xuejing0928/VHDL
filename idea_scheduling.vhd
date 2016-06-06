----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity idea_scheduling is
    Port ( start : in  STD_LOGIC;
			  ready : out  STD_LOGIC;
			  clock : in  STD_LOGIC;
           inputkey : in  STD_LOGIC_VECTOR (127 downto 0);
           clear1 : in  STD_LOGIC_VECTOR (15 downto 0);
           clear2 : in  STD_LOGIC_VECTOR (15 downto 0);
           clear3 : in  STD_LOGIC_VECTOR (15 downto 0);
           clear4 : in  STD_LOGIC_VECTOR (15 downto 0);
           encrypted1 : out  STD_LOGIC_VECTOR (15 downto 0);
           encrypted2 : out  STD_LOGIC_VECTOR (15 downto 0);
           encrypted3 : out  STD_LOGIC_VECTOR (15 downto 0);
           encrypted4 : out  STD_LOGIC_VECTOR (15 downto 0));
end idea_scheduling;

architecture structural of idea_scheduling is

COMPONENT multiplexer
PORT(
S: IN std_logic;
A: IN std_logic_vector(15 downto 0);
B: IN std_logic_vector(15 downto 0); 
O: OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

component clockedround
port(Clock: in STD_LOGIC;
			  RoundInit: in STD_LOGIC;
			  z1: in STD_LOGIC_vector(15 downto 0);
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
			  y4: out STD_LOGIC_vector(15 downto 0);
           RoundResult: inout std_logic;
           RoundInternalState: inout std_logic_vector (2 downto 0);
			  RoundTrafo: in std_logic;
			  y1_t: out STD_LOGIC_vector(15 downto 0);
			  y2_t: out STD_LOGIC_vector(15 downto 0);
			  y3_t: out STD_LOGIC_vector(15 downto 0);
			  y4_t: out STD_LOGIC_vector(15 downto 0));
	  
end component;

component roundcounter
port(c_clock : in STD_LOGIC;
	  c_Start : in  STD_LOGIC;
     c_Result : in  STD_LOGIC;
     c_S_i : out  STD_LOGIC_VECTOR;
     c_Trafo : out  STD_LOGIC;
     c_Init : out  STD_LOGIC;
     c_Ready : out  STD_LOGIC;
     c_Round : out  STD_LOGIC_VECTOR);
end component;

component keygenerator
Port ( inputkey : in  STD_LOGIC_VECTOR;
       round : in  STD_LOGIC_VECTOR;
       z1, z2, z3, z4, z5, z6 : out  STD_LOGIC_VECTOR);
end component;
	
component bit_register
Port ( clock : in  STD_LOGIC;
       enable : in  STD_LOGIC;
       D : in  STD_LOGIC_VECTOR;
       Q : out  STD_LOGIC_VECTOR);
end component;

signal S_i: std_logic_vector(1 downto 0);
signal Round: std_logic_vector(3 downto 0);
signal Trafo: std_logic;
signal Init: std_logic;
signal Result: std_logic; 

signal key1: std_logic_vector(15 downto 0);
signal key2: std_logic_vector(15 downto 0);
signal key3: std_logic_vector(15 downto 0);
signal key4: std_logic_vector(15 downto 0);
signal key5: std_logic_vector(15 downto 0);
signal key6: std_logic_vector(15 downto 0);

signal R1_out: std_logic_vector(15 downto 0); 
signal R2_out: std_logic_vector(15 downto 0);
signal R3_out: std_logic_vector(15 downto 0);
signal R4_out: std_logic_vector(15 downto 0);

signal rundenmodul_in1: std_logic_vector(15 downto 0);
signal rundenmodul_in2: std_logic_vector(15 downto 0);
signal rundenmodul_in3: std_logic_vector(15 downto 0);
signal rundenmodul_in4: std_logic_vector(15 downto 0);

signal rundenmodul_out1: std_logic_vector(15 downto 0);
signal rundenmodul_out2: std_logic_vector(15 downto 0);
signal rundenmodul_out3: std_logic_vector(15 downto 0);
signal rundenmodul_out4: std_logic_vector(15 downto 0);

signal internal_state: std_logic_vector(2 downto 0);--------????????????????????????????????????????????




begin

m1: multiplexer     port map(S_i(0),clear1,R1_out,rundenmodul_in1);
m2: multiplexer     port map(S_i(0),clear2,R2_out,rundenmodul_in2);
m3: multiplexer     port map(S_i(0),clear3,R3_out,rundenmodul_in3);
m4: multiplexer     port map(S_i(0),clear4,R4_out,rundenmodul_in4);

b1: bit_register     port map (clock,Result,rundenmodul_out1,R1_out);
b2: bit_register     port map (clock,Result,rundenmodul_out2,R2_out);
b3: bit_register     port map (clock,Result,rundenmodul_out3,R3_out);
b4: bit_register     port map (clock,Result,rundenmodul_out4,R4_out);

r1: roundcounter     port map (clock,start,Result,S_i,Trafo,Init,ready,Round);

r2: clockedround
port map (clock,Init,key1,key2,key3,key4,key5,key6,rundenmodul_in1,rundenmodul_in2,rundenmodul_in3,rundenmodul_in4,rundenmodul_out1,rundenmodul_out2,
			 rundenmodul_out3,rundenmodul_out4,Result,internal_state,Trafo,encrypted1,encrypted2,encrypted3,encrypted4);
    
k1: keygenerator
port map(inputkey,Round,key1,key2,key3,key4,key5,key6);


end structural;
