library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MASTER is
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
end MASTER;

architecture Behavioral of MASTER is

-- SINAIS INTERNOS

SIGNAL w_SCLK	:	std_logic;
SIGNAL w_RISE	:  std_logic;
SIGNAL w_FALL	:  std_logic;
SIGNAL w_CLK	:  std_logic;
SIGNAL w_DATA	: 	std_logic_vector(7 downto 0); -- 8 BITS DATA TO CONCATENATE
SIGNAL w_EN		: std_logic; -- ENABLE TO SCLK

-- COMPONENTS

		-- DETECTOR DE BORDA -- 
component Detector_Borda is
	Port(
	
		i_RST			: in std_logic; -- RESET
		i_CLK			: in std_logic; -- Clock 100 MHz
		i_SIGNAL		: in std_logic; -- SIGNAL TO EDGE DETECT (SCLK)
		o_RISE		: out std_logic; -- RISE SIGNAL OUTPUT
		o_FALL		: out std_logic -- FALL SIGNAL OUTPUT
	
	);
end component;

		-- CONVERSOR PARALELO -> SERIAL --TEM Q TER ENTRADA DE SS?
		
component Conversor_par2ser is
	Generic (
		DATA_SIZE : integer := 8
	);
	Port (
		i_clk      : in  std_logic; -- CLOCK
		i_rst      : in  std_logic; -- RESET
		i_LOAD     : in  std_logic; -- mode (LOAD = 0, SHIFT = 1)
		i_ND		  : in  std_logic; -- NEW DATA (THIS DATA BRINGS INFO ABOUT SCLK EDGE)
		i_data  	  : in  std_logic_vector ((DATA_SIZE-1) downto 0); -- INPUT DATA (PARALLEL)
		o_DATA	  : out std_logic -- OUTPUT DATA (SERIAL)
		

	);
end component;

component Maquina_Master is	
	Generic(
		DATA_SIZE : integer := 8
	);
	Port (
		i_CLK		: in std_logic; -- 100MHz CLOCK INPUT (c0 PLL)
		i_RST		: in std_logic; -- RESET 
		i_DATA	: in std_logic_vector((DATA_SIZE-1) downto 0); --PARALLEL DATA INPUT (8 bits) 
		i_START	: in std_logic; -- TRANSMISSION START BUTTON
		i_RISE	: in std_logic; -- RISE EDGE SIGNAL
		i_FALL	: in std_logic; -- FALL EDGE SIGNAL
		
		o_EN		: out std_logic; -- ENABLE SCLK OUTPUT
		o_SS		: out std_logic -- SLAVE SELECT OUTPUT
	
	);
end component;

begin

w_DATA <= "0000" & i_DATA; -- TRANSFORM 4 BITS BCD ON 8 BITS DATA
o_SCLK <= w_EN and i_SCLK; -- LOGIC AND TO ENABLE SERIAL CLOCK JUST ON TX
o_CLK <= i_CLK; -- 100MHz clock to output

w_SCLK <= o_SCLK;

-- DETECTOR DE BORDA
Instancia_01	:	Detector_Borda
	port map(
		i_RST			=> i_RST,  -- RESET
		i_CLK			=> i_CLK,  -- 100MHz CLOCK 
		i_SIGNAL		=> w_SCLK, -- SIGNAL SCLK TO COUNT EDGES
		o_RISE		=> w_RISE, -- RISE OUTPUT
		o_FALL		=> w_FALL  -- FALL OUTPUT
	
	);

-- Conversor paralelo -> serial
Instancia_03 : Conversor_par2ser
	port map(
		i_clk     => i_CLK,   -- 100MHz CLOCK
		i_rst     => i_RST,   -- RESET
		i_LOAD    => i_START, -- START TX BUTTON
		i_ND		 => w_RISE,  -- IF RISE CONVERT
		i_data  	 => w_DATA,  -- 8 BITS INPUT DATA (0000 & i_DATA) 
		o_DATA	 => o_MOSI   -- SERIAL DATA OUTPUT
		
	);

-- FSM Master
Instancia_04 : Maquina_Master
	port map(
	
		i_CLK		=> i_CLK,	-- 100MHz CLOCK
		i_RST		=> i_RST,	-- RESET
		i_DATA	=> w_DATA,	-- 8 BITS INPUT DATA (VER SE PRECISA ENTRAR COM DADO NA MAQUINA, ACHO QUE NAO)
		i_RISE	=> w_RISE,  -- INPUT RISE EDGE
		i_FALL	=> w_FALL,  -- INPUT FALL EDGE (TX END)
		i_START	=> i_START, -- INPUT START TX BUTTON
		
		o_EN		=> w_EN, 	-- OUTPUT ENABLE SERIAL CLOCK
		o_SS		=> o_SS		-- OUTPUT SLAVE SELECT
		
	);

end Behavioral;