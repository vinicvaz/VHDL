library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_SPI is
	Generic(
		DATA_SIZE : integer := 4
	);
end TB_SPI;

architecture Behavioral of TB_SPI is

Component SPI is
	Port (
		i_CLK     		: in  std_logic;												-- FPGA CLOCK 50MHz
		i_RST				: in std_logic;												-- RESET
		i_DATA			: in std_logic_vector((DATA_SIZE-1) downto 0);		-- 4 BITS INPUT DATA
		i_START			: in std_logic;												-- START TX 
		o_DATA			: out std_logic_vector(7 downto 0)		            -- OUTPUT PARALLEL DATA FROM SLAVE (TO BCD)

	);
end Component SPI;

SIGNAL w_CLK		:	std_logic;
SIGNAL w_RST		:	std_logic;
SIGNAL w_DATA		:	std_logic_vector((DATA_SIZE-1) downto 0);
SIGNAL w_START		:  std_logic;
SIGNAL w_ODATA		:  std_logic_vector(7 downto 0);

begin

UUT : SPI

port map(

		i_CLK     		=>	w_CLK,
		i_RST				=> w_RST,
		i_DATA			=> w_DATA,
		i_START			=> w_START,
		o_DATA			=> w_ODATA
);

-- CLOCK PROCESS -- 50MHz
	 process
		 begin
			 w_CLK <= '1';
			 wait for 10 ns;
			 w_CLK <= '0';
			 wait for 10 ns;
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
		wait for 11 us;
		w_DATA <= "1010";
		wait for 20 ns;
		w_START <= '1';
		wait for 20 ns;
		w_START <= '0';
		wait;
	end process;
	 
end behavioral;