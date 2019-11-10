library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

Entity TB_Conversor_par2ser is
	Generic (
		DATA_SIZE : integer := 8
	);

end TB_Conversor_par2ser;

architecture Behavioral of TB_Conversor_par2ser is

Component Conversor_par2ser is
	Port (
		i_clk      : in  std_logic; -- sinal de clock
		i_rst      : in  std_logic; -- sinal de reset
		i_LOAD     : in  std_logic; -- mode (LOAD = 0, SHIFT = 1)
		i_ND		  : in  std_logic; -- New data (dado que traz informaçao de borda de subida serial)
		i_data  	  : in  std_logic_vector ((DATA_SIZE-1) downto 0); -- dados de entrada (paralelo)
		o_DATA	  : out std_logic -- dados de saida (serial)
		

	);
end Component;
----------------------------------------------------------------------------------------
	SIGNAL w_CLK	: STD_LOGIC;
	SIGNAL w_RST	: STD_LOGIC;
	SIGNAL w_LOAD 	: STD_LOGIC;
	SIGNAL w_ND  	: STD_LOGIC;
	SIGNAL w_DATA  : STD_LOGIC_VECTOR ((DATA_SIZE-1) downto 0);
	SIGNAL w_ODATA  : STD_LOGIC;
	
----------------------------------------------------------------------------------------	
begin

	UUT: Conversor_par2ser 
--	Generic Map(
--	 	DATA_SIZE    => DATA_SIZE         
--	)
   Port Map( 
		i_clk 	=> w_CLK,
		i_rst   	=> w_RST,
		i_LOAD   => w_LOAD,
		i_ND  	=> w_ND,
		i_data  	=> w_DATA,
		o_data  	=> w_ODATA
	 );

	-- CLOCK PROCESS
	 process
		 begin
			 w_CLK <= '1';
			 wait for 10 ns;
			 w_CLK <= '0';
			 wait for 10 ns;
	 end process;
	 
	-- RESET PROCESS
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;
	
	-- SIGNAL PROCESS
	process
		begin
		wait for 11 us;
		w_DATA<="00001101";
		w_LOAD<='1';
		w_ND<='0';
		wait for 20 ns;
		w_LOAD <= '0';
		w_ND<='1';
		wait;
			
		
	end process;
	
end Behavioral;
 