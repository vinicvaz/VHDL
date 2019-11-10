library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_SER2PAR is
	 Generic(
	 		DATA_SIZE   : INTEGER := 8
	 );
end TB_SER2PAR;

architecture Behavioral of TB_SER2PAR is
	component SER2PAR is
		Generic (
			DATA_SIZE : integer := 8
		);
		Port (
			i_clk   : in  std_logic;
			i_ND    : in  std_logic;
			i_DATA  : in  std_logic;
			o_data  : out std_logic_vector ((DATA_SIZE-1) downto 0)
		);
	end component;
	
	SIGNAL w_CLK	: STD_LOGIC;
	SIGNAL w_ND 	: STD_LOGIC;
	SIGNAL w_DATA  : STD_LOGIC;
	SIGNAL w_ODATA  : STD_LOGIC_VECTOR ((DATA_SIZE-1) downto 0);
	signal w_SCLK	: std_logic;
	
begin

	UUT: SER2PAR 
	Generic Map(
	 	DATA_SIZE    => DATA_SIZE         
	)
   Port Map( 
		i_clk 	=> w_CLK,
		i_ND 		=> w_ND,
		i_DATA  	=> w_DATA,
		o_data  	=> w_ODATA
	 );

	-- processo SCLK pra controle (T = 1 us)
	process
	begin
		w_SCLK<='1';
		wait for 0.5 us;
		w_SCLK<='0';
		wait for 0.5 us;
	end process;
	 
	 
	-- PROCESSO DO CLOCK
	PROCESS
	BEGin	
		w_CLK <= '1';
		WAIT FOR 10 ns;
		w_CLK <= '0';
		WAIT FOR 10 ns;
	END PROCESS;

	
	-- PROCESSO DO SINAL (DADOS COM PERIODO DE 1 CICLO DE SCLK)
	--(COMO FAZER COM QUE O SINAL SEJA LENTO E O CLOCK RAPIDO E PASSE O DADO CERTO USANDO ND)

	PROCESS
	BEGin
	
		
		w_DATA    <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		WAIT FOR 1 us;
		
		
		w_DATA   <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		
		WAIT FOR 1 us;

		w_DATA   <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		WAIT FOR 1 uS;
		
		w_DATA   <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		
		WAIT FOR 1 uS;
		
		w_DATA   <= '1';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		WAIT FOR 1 uS;
		
		w_DATA   <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		
		WAIT FOR 1 uS;
		
		w_DATA   <= '1';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
		WAIT FOR 1 us;

		w_DATA   <= '0';
		w_ND <= '1';
		wait for 20 ns;
		w_ND <='0';
	
		WAIT;
	END PROCESS;
	
	-- ENABLE PROCESS
	
end Behavioral;
 