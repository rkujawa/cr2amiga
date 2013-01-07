-- Module implementing access to 7-segment 4-digit display present on
-- CoolRunner II started board by Digilent.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sseg is

	Port (clock :	in STD_LOGIC;
			segA :	in STD_LOGIC_VECTOR (7 downto 0);
			segB :	in STD_LOGIC_VECTOR (7 downto 0);
			segC :	in STD_LOGIC_VECTOR (7 downto 0);
			segD :	in STD_LOGIC_VECTOR (7 downto 0);
			segout :out STD_LOGIC_VECTOR (7 downto 0);
			segan :	out STD_LOGIC_VECTOR (3 downto 0));

end sseg;

architecture Behavioral of sseg is

	signal cycle_reg : STD_LOGIC_VECTOR (3 downto 0) := "1110";

begin

--	process (A1, B1, C1, D1)
--	begin 
--		if (BTN0='1') then
--			A1 <= "10001000";
--			B1 <= "11111001";
--			C1 <= "11001000";
--			D1 <= "10001000";
--		else
--			A1 <= "10000110";
--			B1 <= "11000001";
--			C1 <= "11000000";
--			D1 <= "11000111";
--		end if;
--	end process;

	cycle : process (clock, cycle_reg)
	begin
		if (rising_edge(clock)) then
			cycle_reg <= cycle_reg(0) & cycle_reg(3 downto 1);
		end if;
	end process;
	
	segan <= cycle_reg;
	
	process (cycle_reg, segA, segB, segC, segD)
	begin
		case cycle_reg is
			when "0111" => segout <= segA;
			when "1011" => segout <= segB;
			when "1101" => segout <= segC;
			when "1110" => segout <= segD;
			when others => segout <= "11111111";
		end case;
	end process;

end Behavioral;

