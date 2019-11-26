library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Slave is
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
end Slave;

architecture Behavioral of Slave is
-- ############################### --
-- ####### INTERN SIGNALS ######## --
-- ############################### --
SIGNAL w_FALL		: std_logic;
SIGNAL w_FREE		: std_logic;



-- ############################### --
-- ######### COMPONENTS ########## --
-- ############################### --

-- EDGE DETECTOR
Component Detector_Borda is
	Port(
	
		i_RST			: in std_logic; -- Reset assincrono
		i_CLK			: in std_logic; -- Clock 100 MHz
		i_SIGNAL		: in std_logic; -- SCLK a contar borda
		o_RISE		: out std_logic; -- saida de sinal de subida
		o_FALL		: out std_logic -- saida de sinal de descida
	);
end Component;


-- CONVERSOR SERIAL -> PARALLEL
Component SER2PAR is
	Generic (
		DATA_SIZE : integer := 8
	);
	Port (
		i_clk      : in  std_logic; -- sinal de clock
		i_rst      : in  std_logic; -- sinal de reset
		i_ND       : in  std_logic; -- NEW DATA - converte quando ND = 1
		i_DATA  	  : in  std_logic; -- dados de entrada (serial)
		o_DATA	  : out std_logic_vector((DATA_SIZE-1) downto 0); -- dados de saida (paralelo) (buffer)
		i_FREE	  : in std_logic

	);
end component;

-- SLAVE FSM
Component Maquina_Slave is
	
	Port (
		i_CLK     		: in  std_logic;		-- CLOCK 100MHz (c0 PLL)
		i_RST		 		: in  std_logic;		-- RESET
		i_SS      	   : in  std_logic;		-- INPUT SLAVE SELECT (ENABLED WITH LOW)
		i_FALL			: in std_logic;			-- FALL EDGE DETECTION INPUT
		o_FREE			: out std_logic
	);
end Component;


begin

-- ############################### --
-- ######### INSTANCES ########### --
-- ############################### --

-- EDGE DETECTOR --
Instancia_01	:	Detector_Borda
	port map(
		i_RST			=> i_RST,  -- RESET
		i_CLK			=> i_CLK,  -- 100MHz CLOCK 
		i_SIGNAL		=> i_SCLK, -- SIGNAL SCLK TO COUNT EDGES
		o_RISE		=> open,   -- RISE OUTPUT
		o_FALL		=> w_FALL  -- FALL OUTPUT
	);

Instancia_02	: SER2PAR
	Port Map (
		i_clk      => i_CLK,
		i_rst      => i_RST,
		i_ND       => w_FALL,
		i_DATA  	  => i_MOSI,
		o_DATA	  => o_DATA,
		i_FREE	  => w_FREE 
	);

Instancia_03	: Maquina_Slave
	Port Map (
		i_CLK      => i_CLK,
		i_RST		  => i_RST,
		i_SS       => i_SS,	   
		i_FALL	  => w_FALL,		
		o_FREE	  => w_FREE				
	);

end Behavioral;

