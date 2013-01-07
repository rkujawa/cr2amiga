-- Module implementing communication through Digilent EPP interface
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EppModule is
	Port(	Astb : in  STD_LOGIC;
			Dstb : in  STD_LOGIC;
			Wr : in  STD_LOGIC;
			Wt : out  STD_LOGIC;
			DataBus : inout  STD_LOGIC_VECTOR (7 downto 0);
			Number : out STD_LOGIC_VECTOR (7 downto 0));
end EppModule;

architecture Behavioral of EppModule is

	signal addressReg : STD_LOGIC_VECTOR (7 downto 0);

begin

	-- Port signals
	Wt <= '1' when Astb = '0' or Dstb = '0' else '0';

	--DataBus <= Result when (Wr = '1') else "ZZZZZZZZ";
	DataBus <= "ZZZZZZZZ";

	-- EPP Address register
	process (Astb)
	begin
		if rising_edge(Astb) then  -- Astb end edge
			if Wr = '0' then -- Epp Addr write cycle
				addressReg <= DataBus; -- Update the address register
			end if;
		end if;
	end process;

	-- EPP Write registers register
	process (Dstb)
	begin
		if rising_edge(Dstb) then  -- Astb end edge
			if Wr = '0' then -- Epp Data write cycle
				if addressReg = "00000000" then
					Number <= DataBus;
--				elsif addressReg = "00000001" then
--					Number2 <= DataBus;
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;
