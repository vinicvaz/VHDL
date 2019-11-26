library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TB_SER2PAR is
	Generic (
		DATA_SIZE : integer := 4
	);
end TB_SER2PAR;

architecture Behavioral of TB_SER2PAR is

---------------------------------------
Component SER2PAR is
	Port (
		i_clk      : in  std_logic; -- sinal de clock
		i_rst      : in  std_logic; -- sinal de reset
		i_ND       : in  std_logic; -- NEW DATA - converte quando ND = 1
		i_DATA  	  : in  std_logic; -- dados de entrada (serial)
		o_DATA	  : out std_logic_vector((DATA_SIZE-1) downto 0); -- dados de saida (paralelo) (buffer)
		i_FREE	  : in std_logic
	);
end component SER2PAR;
--------------------------------------
--------------------------------------
SIGNAL w_CLK	: std_logic;
SIGNAL w_RST	: std_logic;
SIGNAL w_ND		: std_logic;
SIGNAL w_DATA	: std_logic;
SIGNAL w_ODATA	: std_logic_vector((DATA_SIZE-1) downto 0);
SIGNAL w_FREE	: std_logic;
SIGNAL w_SCLK  : std_logic; -- controle do sclk
---------------------------------------
---------------------------------------

begin

UUT	:	 SER2PAR
	Port Map (
		i_clk      => w_CLK,
		i_rst      => w_RST,
		i_ND       => w_ND,
		i_DATA  	  => w_DATA,
		o_DATA	  => w_ODATA,
		i_FREE	  => w_FREE
	);


-- RESET PROCESS
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;

-- CLOCK PROCESS
	 process
		 begin
			 w_CLK <= '1';
			 wait for 10 ns;
			 w_CLK <= '0';
			 wait for 10 ns;
	 end process;
	 
-- SCLK PROCESS (PRA CONTROLE)
	process
		begin
			w_SCLK <= '0';
			wait for 1 us;
			w_SCLK <= '1';
			wait for 1 us;
	end process;

-- DATA PROCESS
	process
		begin
			w_DATA<='0';
			wait for 11 us;
			w_DATA<='1';
			wait for 2 us;
			w_DATA<='0';
			wait for 2 us;
			w_DATA <='1';
			wait for 2 us;
			w_DATA<='1';
			wait for 2 us;
			w_FREE<='1';
			wait for 20 ns;
			w_FREE<='0';
			wait;
	end process;
	
	-- SCLK SIGNAL PULSE ND (1MHz, 0.5 MHz cada borda)
	process
		begin
		w_nd <= '0';
		wait for 20 ns;
		w_nd <= '1';
		wait for 20 ns;
		w_nd <= '0';
		wait for 2 us; 
	end process;
	
end behavioral;
