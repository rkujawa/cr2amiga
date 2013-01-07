library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hextoseg is
    Port ( hex : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (7 downto 0));
end hextoseg;

architecture Behavioral of hextoseg is
begin
	with hex select
		seg <=   "11111001" when "1000", -- 1
				 "10100100" when "0100", -- 2
				 "10110000" when "1100", -- 3
				 "10011001" when "0010", -- 4
				 "10010010" when "1010", -- 5
				 "10000010" when "0110", -- 6
				 "11111000" when "1110", -- 7
				 "10000000" when "0001", -- 8
				 "10010000" when "1001", -- 9
				 "10001000" when "0101", -- A
				 "10000011" when "1101", -- B
				 "11000110" when "0011", -- C
				 "10100001" when "1011", -- D
				 "10000110" when "0111", -- E
				 "10001110" when "1111", -- F
				 "11000000" when others; -- 0
end Behavioral;

