library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
	Port (LEDS : out STD_LOGIC_VECTOR (3 downto 0);
			D_AN : out STD_LOGIC_VECTOR (3 downto 0);
			D_C : out STD_LOGIC_VECTOR (7 downto 0);
			BTN0 : in  STD_LOGIC;
			BTN1 : in  STD_LOGIC;
			SW0 : in STD_LOGIC;
			SW1 : in STD_LOGIC; 
			MCLK : in STD_LOGIC;
			USB_D : inout STD_LOGIC_VECTOR (7 downto 0);
			USB_WAIT : out STD_LOGIC;
			USB_WRITE : in STD_LOGIC;
			USB_ASTB : in STD_LOGIC;
			USB_DSTB : in STD_LOGIC);
end main;

architecture Behavioral of main is

component clk_gen
	Port (Clk : 	in STD_LOGIC;
			Clk_mod :out STD_LOGIC;
			divide_value : in integer
			);
end component;

component EppModule
	Port (Astb :	in STD_LOGIC;
			Dstb :	in STD_LOGIC;
			Wr :		in STD_LOGIC;
			Wt :		out STD_LOGIC;
			DataBus :inout STD_LOGIC_VECTOR (7 downto 0);
			Number :	out STD_LOGIC_VECTOR (7 downto 0));
end component;

component sseg
	Port (clock :	in STD_LOGIC;
			segA :	in STD_LOGIC_VECTOR (7 downto 0);
			segB :	in STD_LOGIC_VECTOR (7 downto 0);
			segC :	in STD_LOGIC_VECTOR (7 downto 0);
			segD :	in STD_LOGIC_VECTOR (7 downto 0);
			segout :	out STD_LOGIC_VECTOR (7 downto 0);
			segan :	out STD_LOGIC_VECTOR (3 downto 0));
end component;

component hextoseg
	Port (hex : in  STD_LOGIC_VECTOR (3 downto 0);
			seg : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
			
signal sA, sB, sC, sD : STD_LOGIC_VECTOR (7 downto 0);
signal sHex : STD_LOGIC_VECTOR (7 downto 0);
signal sHexLo : STD_LOGIC_VECTOR (3 downto 0);
signal sHexHi : STD_LOGIC_VECTOR (3 downto 0);
signal fullclk1 : STD_LOGIC;

signal pushableReg : STD_LOGIC_VECTOR (7 downto 0);

begin

--	CLK_DIV16_inst1 : CLK_DIV16
--	port map (
--		CLKDV => fullclk1,
--		CLKIN => CLK
--	);

	clk_gen_inst1 : clk_gen
	port map (
		Clk => MCLK,
		Clk_mod => fullclk1,
		divide_value => 500 -- 8MHz / 500 = circa 16kHz
	);

	EppModule1 : EppModule 
	port map (
		Astb => USB_ASTB,
		Dstb => USB_DSTB,
		Wr => USB_WRITE,
		Wt => USB_WAIT,
		DataBus => USB_D,
		Number => sHex
	);
	
	sseg1 : sseg
	port map (
		clock => fullclk1,
		segA => sA,
		segB => sB,
		segC => sC,
		segD => sD,
		segout => D_C,
		segan => D_AN
	);

	hextoseglo : hextoseg
	port map (
		hex => sHexLo,
		seg => sA
		
	);
	
	hextoseghi : hextoseg
	port map (
		hex => sHexHi,
		seg => sB
		
	);

	-- LEDS <= "1101";
	sHexLo <= sHex(0) & sHex(1) & sHex(2) & sHex(3);
	sHexHi <= sHex(4) & sHex(5) & sHex(6) & sHex(7);
	
	pushableReg(0) <= BTN0;
	pushableReg(1) <= BTN1;
	pushableReg(2) <= SW0;
	pushableReg(3) <= SW1;

end Behavioral;

