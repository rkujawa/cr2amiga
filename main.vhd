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
	Port(	LEDS : out STD_LOGIC_VECTOR (3 downto 0);
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
			USB_DSTB : in STD_LOGIC;
			-- clockport
			CP_A : in STD_LOGIC_VECTOR (3 downto 0);
			CP_IORD : in STD_LOGIC;
			CP_IOWR : in STD_LOGIC);
end main;

architecture Behavioral of main is

component clk_gen
	Port(	clk :	 in STD_LOGIC;
			clkmod : out STD_LOGIC;
			divval : in integer
			);
end component;

component eppmodule
	Port (	astb :	in STD_LOGIC;
			dstb :	in STD_LOGIC;
			wr :	in STD_LOGIC;
			wt :	out STD_LOGIC;
			databus :inout STD_LOGIC_VECTOR (7 downto 0);
			ssegReg :out STD_LOGIC_VECTOR (7 downto 0);
			ledReg : out STD_LOGIC_VECTOR (3 downto 0);
			btnReg : in STD_LOGIC_VECTOR (3 downto 0));
end component;

component sseg
	Port (	clock :	in STD_LOGIC;
			segA :	in STD_LOGIC_VECTOR (7 downto 0);
			segB :	in STD_LOGIC_VECTOR (7 downto 0);
			segC :	in STD_LOGIC_VECTOR (7 downto 0);
			segD :	in STD_LOGIC_VECTOR (7 downto 0);
			segout :out STD_LOGIC_VECTOR (7 downto 0);
			segan :	out STD_LOGIC_VECTOR (3 downto 0));
end component;

component hextoseg
	Port (	hex : in  STD_LOGIC_VECTOR (3 downto 0);
			seg : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component clockport
   Port(	-- clockport signals
		addressIn :	in STD_LOGIC_VECTOR (3 downto 0);
		iord :		in STD_LOGIC;
		iowr :		in STD_LOGIC;
		addressOut : out STD_LOGIC_VECTOR (3 downto 0));
end component;
			
signal sA, sB, sC, sD : STD_LOGIC_VECTOR (7 downto 0);
signal sHex : STD_LOGIC_VECTOR (7 downto 0);
signal sHexLo : STD_LOGIC_VECTOR (3 downto 0);
signal sHexHi : STD_LOGIC_VECTOR (3 downto 0);
signal slowclk : STD_LOGIC;

signal pushableReg : STD_LOGIC_VECTOR(3 downto 0);
signal ledReg : STD_LOGIC_VECTOR(3 downto 0);

-- only for debugging
signal cpAddress : STD_LOGIC_VECTOR (3 downto 0);

begin

--	CLK_DIV16_inst1 : CLK_DIV16
--	port map (
--		CLKDV => fullclk1,
--		CLKIN => CLK
--	);

	clk_gen_inst1 : clk_gen
	port map (
		clk => MCLK,
		clkmod => slowclk,
		divval => 500 -- 8MHz / 500 = circa 16kHz
	);

	deppusb : eppmodule 
	port map (
		astb => USB_ASTB,
		dstb => USB_DSTB,
		wr => USB_WRITE,
		wt => USB_WAIT,
		dataBus => USB_D,
		ssegReg => sHex,
		ledReg => ledReg,
		btnReg => pushableReg
	);
	
	sseg1 : sseg
	port map (
		clock => slowclk,
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

	amigacp : clockport
	port map (
		addressIn => CP_A,
		iord => CP_IORD,
		iowr => CP_IOWR,
		addressOut => cpAddress
	);

	--LEDS <= NOT ledReg;
	LEDS <= cpAddress;
	
	sHexLo <= sHex(0) & sHex(1) & sHex(2) & sHex(3);
	sHexHi <= sHex(4) & sHex(5) & sHex(6) & sHex(7);
	
	pushableReg(0) <= NOT BTN0;
	pushableReg(1) <= NOT BTN1;
	pushableReg(2) <= NOT SW0;
	pushableReg(3) <= NOT SW1;

end Behavioral;
