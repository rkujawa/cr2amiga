library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockport is
    Port(	-- clockport signals
			data :		inout STD_LOGIC_VECTOR (7 downto 0); -- data pins
			addressIn :	in STD_LOGIC_VECTOR (3 downto 0); -- address pins
			iord :		in STD_LOGIC; -- active low when read from device to CPU
			iowr :		in STD_LOGIC; -- active low when write from CPU to device
			cs :		in STD_LOGIC;
			-- debug signals
			addressOut : out STD_LOGIC_VECTOR (3 downto 0);
			-- registers used to exchange data
			--btnReg :	in STD_LOGIC_VECTOR (3 downto 0)
			testOut : 	out STD_LOGIC_VECTOR (7 downto 0)
			);
end clockport;

architecture Behavioral of clockport is

	signal address : STD_LOGIC_VECTOR (3 downto 0);

begin
	address <= addressIn when cs = '0' and (iord = '0' or iowr = '0');
	addressOut <= address;

	data <= "00000001" when (iord = '0' and cs = '0') AND address = "1111" else
			   -- somereg when (Wr = '1') AND address = "xxxxxxxx" else
			   "ZZZZZZZZ";

	process (iowr, cs)
	begin
		if iowr = '0' and cs = '0' then
			testOut <= data;
		end if;
	end process;

end Behavioral;
