library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_Master is
	Generic(
		DATA_SIZE : integer := 4
	);
end TB_Master;

architecture Behavioral of TB_Master is

component Master is
	Port (
		i_CLK     		: in  std_logic;		-- EXTERNAL CLOCK 100MHz
		i_SCLK			: in std_logic;
		i_RST		 		: in  std_logic;		-- RESET
		i_START      	: in  std_logic;		-- ENABLE TRANSMISSION BUTTON
		i_DATA	 		: in std_logic_vector((DATA_SIZE-1) downto 0); -- 4 BITS BCD INPUT
		
		o_SS				: out std_logic;		-- SLAVE SELECT OUTPUT
		o_MOSI    		: out std_logic;		-- SERIAL DATA OUTPUT 
		o_SCLK	 		: inout std_logic;   -- SERIAL CLOCK OUTPUT
		o_CLK				: out std_logic		-- 100MHz output (PLL)?
	);
end component;
		
	SIGNAL w_CLK			: STD_LOGIC;
	SIGNAL w_SCLK			: STD_LOGIC;
	SIGNAL w_RST			: STD_LOGIC;
	SIGNAL w_START			: STD_LOGIC;
	SIGNAL w_DATA	 		: STD_LOGIC_VECTOR((DATA_SIZE-1) downto 0);
	SIGNAL w_SS			  	: STD_LOGIC;
	SIGNAL w_MOSI			: STD_LOGIC;
	SIGNAL w_OSCLK			: STD_LOGIC;
	SIGNAL w_OCLK			: STD_LOGIC;
	
begin

	UUT: Master 
   Port Map( 

		i_CLK     		=> w_CLK,
		i_SCLK			=> w_SCLK,
		i_RST		 		=>	w_RST,
		i_START      	=> w_START,
		i_DATA	 		=> w_DATA,
		
		o_SS				=> w_SS,
		o_MOSI    		=> w_MOSI,
		o_SCLK	 		=> w_OSCLK,
		o_CLK				=> w_OCLK
	
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
		wait for 11 us;
		w_DATA <= "1010";
		wait for 20 ns;
		w_START<= '1';
		wait for 20 ns;
		w_START<='0';
		wait;
	end process;
	
	
-- PROBLEMAS NO TB --
-- COMO MEXER NOS SINAIS INTERNOS? (ENABLE)
-- CLOCK DO PLL NAO TA INDO PRA SAIDA
-- SEM O CLOCK E SCLK RODANDO NUNCA QUE VAI TER DADO NO MOSI

	
end Behavioral;
 