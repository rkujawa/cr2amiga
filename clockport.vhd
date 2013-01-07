library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockport is
    Port ( data :		inout STD_LOGIC_VECTOR (7 downto 0);
           address :	in STD_LOGIC_VECTOR (4 downto 0);
           iord :		in STD_LOGIC;
           iowr :		in STD_LOGIC;
			  cs :		in STD_LOGIC);
end clockport;

architecture Behavioral of clockport is
begin
	data <= "ZZZZZZZZ";

-- TODO implement	

end Behavioral;

