library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_gen is
port(	clk :		in STD_LOGIC;
		clkmod :	out STD_LOGIC;
		divval :	in integer);
end clk_gen;

architecture Behavioral of clk_gen is

	signal counter,divide : integer := 0;

begin

	divide <= divval;

	process(clk) 
	begin
		if( rising_edge(clk) ) then
			if(counter < divide/2-1) then
				counter <= counter + 1;
				clkmod <= '0';
			elsif(counter < divide-1) then
				counter <= counter + 1;
				clkmod <= '1';
			else
				clkmod <= '0';
				counter <= 0;
			end if; 
		end if;
	end process;    

end Behavioral;