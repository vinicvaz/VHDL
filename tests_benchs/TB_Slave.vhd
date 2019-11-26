library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_Slave is
	Generic(
		DATA_SIZE : integer := 8
	);
end TB_Slave;


architecture Behavioral of TB_Slave is

Component Slave is
	Port (
		i_CLK			: in std_logic; -- INPUT CLOCK (100MHz)
		i_SCLK 		: in std_logic; -- INPUT SERIAL CLOCK (1MHz)
		i_RST			: in std_logic; -- INPUT RESET
		i_MOSI		: in std_logic; -- INPUT FROM MOSI
		i_SS			: in std_logic; -- INPUT SLAVE SELECT
		o_DATA		: out std_logic_vector((DATA_SIZE-1) downto 0) -- OUTPUT PARALLEL DATA
	
	);
end Component Slave;

SIGNAL w_CLK		: std_logic;
SIGNAL w_SCLK		: std_logic;
SIGNAL w_RST		: std_logic;
SIGNAL w_MOSI		: std_logic;
SIGNAL w_SS			: std_logic;
SIGNAL w_DATA		: std_logic_vector((DATA_SIZE-1) downto 0);

begin

UUT : Slave
Port Map(
		i_CLK			=> w_CLK,
		i_SCLK 		=> w_SCLK,
		i_RST			=> w_RST,
		i_MOSI		=> w_MOSI,
		i_SS			=> w_SS,
		o_DATA		=> w_DATA
);

-- CLOCK PROCESS -- 100MHz
	 process
		 begin
			 w_CLK <= '1';
			 wait for 5 ns;
			 w_CLK <= '0';
			 wait for 5 ns;
	 end process;
	 
-- CLOCK SERIAL SCLK
	process
		begin
			w_SCLK <= '1';
			wait for 1 us;
			w_SCLK <= '0';
			wait for 1 us;
	end process;
	
-- RESET PROCESS - 10 us
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;
	
-- DATA PROCESS
	process
	begin
		w_MOSI<='0';
		wait for 11 us;
		wait for 5 ns;
		w_MOSI<='0';
		wait for 8 us;
		w_MOSI<='1';
		wait for 2 us;
		w_MOSI<='0';
		wait for 2 us;
		w_MOSI<='1';
		wait for 2 us;
		w_MOSI<='1';
		wait for 2 us;
		wait for 5 ns;
		wait;		
	end process;
-- SS PROCESS
	process
	begin
		w_SS<='1';
		wait for 11 us;
		w_SS<='0';
		wait for 16 us;
		w_SS<='1';
		wait;
	end process;
	

end behavioral;