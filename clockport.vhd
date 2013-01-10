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
			--addressOut : out STD_LOGIC_VECTOR (3 downto 0);
			-- registers used to exchange data
			btnReg :	in STD_LOGIC_VECTOR (7 downto 0);
			ledReg :	out STD_LOGIC_VECTOR (3 downto 0);
			testOut : 	out STD_LOGIC_VECTOR (7 downto 0);
			commDataInReg : in STD_LOGIC_VECTOR (7 downto 0);
			commDataOutReg : out STD_LOGIC_VECTOR (7 downto 0)
			);
end clockport;

architecture Behavioral of clockport is

	signal address : STD_LOGIC_VECTOR (3 downto 0);
	
--	signal lastID : STD_LOGIC_VECTOR (7 downto 0) := "11000000";
--	signal currID : STD_LOGIC_VECTOR (7 downto 0);

begin
	address <= addressIn when cs = '0' and (iord = '0' or iowr = '0');
	
	--addressOut <= address;
	--data <= "ZZZZZZZZ";
--	data <= btnReg & "0000" when (iord = '0' and cs = '0') and address = "0001" else
--			"00000001" when (iord = '0' and cs = '0') and address = "1111" else
--			   -- somereg when (iord = '0' and cs = '0') AND address = "xxxxxxxx" else
--			"ZZZZZZZZ";

	process (iord, cs, address, data)
	begin
		if iord = '0' and cs = '0' and address = "0000" then		-- reg 0, 0xD80001
			data <= "11100111";
		elsif iord = '0' and cs = '0' and address = "0001" then		-- reg 1, 0xD80005
			data <= commDataInReg;
		elsif iord = '0' and cs = '0' and address = "0010" then		-- reg 2, 0xD80009
			data <= "00000010";
		elsif iord = '0' and cs = '0' and address = "0100" then		-- reg 4, 0xD80011
			data <= "00000100";
		elsif iord = '0' and cs = '0' and address = "1101" then
			data <= btnReg;
		else
			data <= "ZZZZZZZZ";
		end if;
	end process;

	process (iowr, cs, address, data)
	begin
		if iowr = '0' and cs = '0' and address = "0001" then
			commDataOutReg <= data;
--			testOut <= data;
		elsif iowr = '0' and cs = '0' and address = "1111" then
			ledReg(0) <= data(0);
			ledReg(1) <= data(1);
			ledReg(2) <= data(2);
			ledReg(3) <= data(3);
		end if;
	end process;

end Behavioral;
