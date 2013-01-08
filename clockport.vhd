library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockport is
    Port(	-- clockport signals
			--data :		inout STD_LOGIC_VECTOR (7 downto 0);
			addressIn :	in STD_LOGIC_VECTOR (3 downto 0);
			iord :		in STD_LOGIC;
			iowr :		in STD_LOGIC;
			--cs :		in STD_LOGIC;
			-- registers used to exchange data
			--btnReg :	in STD_LOGIC_VECTOR (3 downto 0)
			addressOut : out STD_LOGIC_VECTOR (3 downto 0)
			);
end clockport;

architecture Behavioral of clockport is

	--signal address : STD_LOGIC_VECTOR (3 downto 0);

begin
--	data <= "ZZZZZZZZ";
	addressOut <= addressIn;

--	process (iord, iowr)
--	begin
--		if rising_edge(iord) then
--			address <= addressIn;
--		end if;
--	end process;

end Behavioral;
