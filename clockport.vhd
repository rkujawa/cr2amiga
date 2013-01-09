library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockport is
    Port(	-- clockport signals
			data :		inout STD_LOGIC_VECTOR (7 downto 0); -- data pins
			addressIn :	in STD_LOGIC_VECTOR (3 downto 0); -- address pins
			iord :		in STD_LOGIC; -- active low when read from device to CPU
			iowr :		in STD_LOGIC; -- active low when write from CPU to device
			--cs :		in STD_LOGIC;
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
	address <= addressIn when iord = '0' or iowr = '0';
	addressOut <= address;

	process (iord)
	begin
		if rising_edge(iord) then
			testOut <= data;
		end if;
	end process;
--	process (iowr)
--	begin
--		if falling_edge(iowr) then
--			data <= "00000001";
--		end if;
--	end process;

end Behavioral;
