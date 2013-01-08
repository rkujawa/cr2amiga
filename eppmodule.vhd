-- Module implementing communication through USB with Digilent EPP interface.
-- This needs to be reimplemented as clocked state machine... Now it works more
-- by coincidence than by design.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eppmodule is
	Port(	-- uC-CPLD interface
			astb :		in STD_LOGIC;
			dstb :		in STD_LOGIC;
			wr :		in STD_LOGIC;
			wt :		out STD_LOGIC;
			databus :	inout STD_LOGIC_VECTOR (7 downto 0);
			-- internal registers used to exchange the data
			ssegReg :	out STD_LOGIC_VECTOR (7 downto 0);
			ledReg :	out STD_LOGIC_VECTOR (3 downto 0);
			btnReg :	in STD_LOGIC_VECTOR (3 downto 0));
end EppModule;

architecture Behavioral of eppmodule is

	signal address : STD_LOGIC_VECTOR (7 downto 0);

begin

	-- don't wait if address strobe or data strobe active
	wt <= '1' when astb = '0' or dstb = '0' else '0';

	databus <= "0000" & btnReg when (wr = '1') AND address = "00000010" else
			   -- somereg when (Wr = '1') AND address = "xxxxxxxx" else
			   "ZZZZZZZZ";

	process (astb)
	begin
		if rising_edge(astb) then
				address <= databus; -- read the address from data bus
		end if;
	end process;

	process (dstb)
	begin
		if rising_edge(dstb) then
			if wr = '0' then -- EPP data write cycle
				if address = "00000000" then
					ssegReg <= databus;
				elsif address = "00000001" then
					ledReg <= databus(0) & databus(1) & databus(2) & databus(3);
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;
