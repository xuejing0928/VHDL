library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.ALL;
use IEEE.Numeric_std.all;

entity mulop is
	Port ( a : in STD_LOGIC_vector(15 downto 0);
			 b : in STD_LOGIC_vector(15 downto 0);
			 o : out STD_LOGIC_vector(15 downto 0));

end mulop;

architecture Behavioral of mulop is
begin
	mulop_process: process(a,b)
	variable x : STD_LOGIC_vector(16 downto 0);
	variable y : STD_LOGIC_vector(16 downto 0);
	variable z : STD_LOGIC_vector(33 downto 0);
	variable modulo : std_logic_vector (15 downto 0); --ab mod(2^n)
	variable div : std_logic_vector (17 downto 0);    --ab div(2^n)
	variable sub : std_logic_vector (17 downto 0);    --temporary result
	variable erg : std_logic_vector (15 downto 0);    --end variable
	begin
	x := ('0'&a);
	y := ('0'&b);	
	
	if (a="0000000000000000") then
		x:="10000000000000000";
	end if;
	if (b="0000000000000000") then
		y:="10000000000000000";
	end if;	
	
	z:=x*y;
	modulo:=z(15 downto 0);
	div:=z(33 downto 16);
	if modulo<div then
		sub:=modulo-div+("01"&X"0001");
	   erg:=sub(15 downto 0);
		o<=erg;
	else
		sub:=("00"&modulo)-div;
		erg:=sub(15 downto 0);
		o<=erg;
	end if;
	end process;
end Behavioral;