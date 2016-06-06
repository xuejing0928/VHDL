library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity roundcontrol is
    Port ( Clock: in STD_LOGIC;
           Init: in STD_LOGIC;
			  Enable125: inout STD_LOGIC;
			  Enable346: inout STD_LOGIC;
			  Enable78: inout STD_LOGIC;
			  Result: inout STD_LOGIC;
			  S: inout STD_LOGIC_vector(1 downto 0);
			  InternalState: inout STD_LOGIC_vector(2 downto 0);
			  trafo: in std_logic;
			  S_t: inout STD_LOGIC_vector(1 downto 0));
end roundcontrol;

architecture Behavioral of roundcontrol is
begin
	set_internal_state: process(Clock)
   	begin
		if(trafo='0') then
		if(Clock='1' and Clock'EVENT) then
			if(Init='1') then
				InternalState<="000";
			elsif(InternalState="000") then
				InternalState<="001";
			elsif(InternalState="001") then
				InternalState<="010";
			elsif(InternalState="010") then
				InternalState<="011";
			elsif(InternalState="011") then
				InternalState<="100";
			elsif(InternalState="100") then
				InternalState<="101";
			elsif(InternalState="101") then
				InternalState<="110";
			elsif(InternalState="110") then
				InternalState<="111";
			end if;
		end if;
		elsif(trafo='1') then
		if(Clock='1' and Clock'EVENT) then
			if(Init='1') then
				InternalState<="000";
			elsif(InternalState="000") then
				InternalState<="001";
			elsif(InternalState="001") then
				InternalState<="010";
			elsif(InternalState="010") then
				InternalState<="011";
			elsif(InternalState="011") then
				InternalState<="110";
			elsif(InternalState="110") then
				InternalState<="111";
			end if;
		end if;
		end if;
	end process set_internal_state;

	set_enable_result: process(InternalState)
	begin
		if(trafo='0') then
			case InternalState is
			when "000" =>
				Enable125<='1';
			when "001" =>
				Enable125<='0';
			when "010" =>
				Enable346<='1';
			when "011" =>
				Enable346<='0';
			when "100" =>
				Enable78<='1';
			when "101" =>
				Enable78<='0';
			when "110" =>
				Result<='1';
			when "111" =>
				Result<='0';
			when others =>
				Enable125<='X';
				Enable346<='X';  
				Enable78<='X';
				Result<='X';
			end case;
		elsif(trafo='1') then
		case InternalState is
		when "000" =>
			Enable125<='1';
			Enable78<='0';
		when "001" =>
			Enable125<='0';
			Enable78<='0';
		when "010" =>
			Enable346<='1';
			Enable78<='0';
		when "011" =>
			Enable346<='0';
			Enable78<='0';
		when "110" =>
			Result<='1';
			Enable78<='0';
      when "111" =>
			Result<='0';
			Enable78<='0';
		when others =>	
		   Enable346<='X';  
			Enable78<='X';
		   Result<='X';
		end case;
		end if;
	end process set_enable_result;

	set_S: process(InternalState)
	begin
	   if(trafo='0') then
		case InternalState is
		when "000" =>
			S<="00";
			S_t<="00";
		when "010" =>
			S<="01";
			S_t<="01";
		when "100" =>
			S<="10";
		   S_t<="10";
		when "110" =>
			S<="11";			
			S_t<="11";
		when others =>	
		end case;
		elsif(trafo='1') then
		case InternalState is
		when "000" =>
			S<="00";
			S_t<="01";
		when "010" =>
			S<="01";
			S_t<="00";
		when "110" =>
			S<="11";
			S_t<="10";
		when others =>	
		end case;	
		end if;
	end process set_S;

end Behavioral;
