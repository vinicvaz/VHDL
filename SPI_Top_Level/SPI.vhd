library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity SPI is
	Generic(	
		DATA_SIZE : integer := 4
	);
	
	Port (
		i_CLK     		: in  std_logic;												-- FPGA CLOCK 50MHz
		i_RST				: in std_logic;												-- RESET
		i_DATA			: in std_logic_vector((DATA_SIZE-1) downto 0);		-- 4 BITS INPUT DATA
		i_START			: in std_logic;												-- START TX 
		o_DATA			: out std_logic_vector(7 downto 0)		            -- OUTPUT PARALLEL DATA FROM SLAVE (TO BCD)

	);
end SPI;

architecture Behavioral of SPI is

-- PLL CLOCK SIGNALS
SIGNAL w_CLK		: std_logic;
SIGNAL w_SCLK		: std_logic;
-----------------------------
SIGNAL w_SS			: std_logic;
SIGNAL w_MOSI		: std_logic;
SIGNAL tx_SCLK		: std_logic;
SIGNAL tx_CLK		: std_logic;
SIGNAL w_DATA		: std_logic_vector(7 downto 0);
SIGNAL w_RST		: std_logic;


-- COMPONENTS
	-- PLL
component pll is
	PORT(
		inclk0		: IN STD_LOGIC  := '0';
		c0				: OUT STD_LOGIC ;
		c1				: OUT STD_LOGIC 
	);
end component;


	-- MASTER
component MASTER is
	Generic(	
		DATA_SIZE : integer := 4
	);
	Port (
		i_CLK     		: in  std_logic;		-- PLL CLOCK 100MHz 
		i_SCLK			: in std_logic;		-- PLL SERIAL CLOCK 1MHz
		
		i_RST		 		: in  std_logic;		-- RESET
		i_START      	: in  std_logic;		-- ENABLE TRANSMISSION BUTTON
		i_DATA	 		: in std_logic_vector((DATA_SIZE-1) downto 0); -- 4 BITS BCD INPUT
		
		o_SS				: out std_logic;		-- SLAVE SELECT OUTPUT
		o_MOSI    		: out std_logic;		-- SERIAL DATA OUTPUT 
		o_SCLK	 		: inout std_logic;   -- SERIAL CLOCK OUTPUT
		o_CLK				: out std_logic		-- 100MHz output (PLL)?
	);
end component;


	-- SLAVE
component Slave is
	Generic(
		DATA_SIZE : integer := 8
	);
	Port (
		i_CLK			: in std_logic; -- INPUT CLOCK (100MHz)
		i_SCLK 		: in std_logic; -- INPUT SERIAL CLOCK (1MHz)
		i_RST			: in std_logic; -- INPUT RESET
		i_MOSI		: in std_logic; -- INPUT FROM MOSI
		i_SS			: in std_logic; -- INPUT SLAVE SELECT
		o_DATA		: out std_logic_vector((DATA_SIZE-1) downto 0) -- OUTPUT PARALLEL DATA
	);
end component;

	-- DECODER BCD -> 7 SEG
component Decoder_7Seg is
	Port(
	
		i_DATA			: in std_logic_vector(7 downto 0);-- Input Data
		o_DATA			: out std_logic_vector(7 downto 0) -- Output Data
	
	);
end component;

begin

w_RST <= not i_RST;

-- INSTANCIAS

	-- PLL
Instancia_01	: PLL
	port map(
		inclk0	=> i_CLK,  -- 50 MHz INPUT CLOCK
		c0			=> w_CLK,  -- 100 MHz USED CLOCK
		c1			=> w_SCLK -- 1 MHz SERIAL CLOCK
	);
	-- MASTER
Instancia_02	: Master
	Generic Map(
		DATA_SIZE => 4
	)
	Port Map(
		i_CLK     		=> w_CLK,
		i_SCLK			=> w_SCLK,
		
		i_RST		 		=> w_RST,
		i_START      	=> i_START,
		i_DATA	 		=> i_DATA,
		
		o_SS				=> w_SS,
		o_MOSI    		=> w_MOSI,
		o_SCLK	 		=> tx_SCLK,
		o_CLK				=> tx_CLK 
	);
	-- SLAVE
Instancia_03	: Slave
	Generic Map(
		DATA_SIZE => 8
	)
	Port Map (
		i_CLK			=> tx_CLK,
		i_SCLK 		=> tx_SCLK,
		i_RST			=> w_RST,
		i_MOSI		=> w_MOSI,
		i_SS			=> w_SS,
		o_DATA		=> w_DATA
	);
	-- DECODER 7 SEG
Instancia_04	: Decoder_7Seg
	Port Map (
		i_DATA => w_DATA,
		o_DATA => o_DATA
	);
	
	
end behavioral;