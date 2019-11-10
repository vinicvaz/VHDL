library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_DETECTOR_BORDA is
end TB_DETECTOR_BORDA;

architecture Behavioral of TB_DETECTOR_BORDA is

component DETECTOR_BORDA is
		Port (
			i_RST      : in  std_logic;
			i_CLK      : in  std_logic;
			i_SIGNAL   : in  std_logic;
			o_RISE  	  : out std_logic;
			o_FALL	  : out std_logic
		);
	end component;
		
	SIGNAL w_CLK			: STD_LOGIC;
	SIGNAL w_RST			: STD_LOGIC;
	SIGNAL w_SIGNAL 		: STD_LOGIC;
	SIGNAL w_RISE		  	: STD_LOGIC;
	SIGNAL w_FALL			: STD_LOGIC;
	
begin

	UUT: DETECTOR_BORDA 
   Port Map( 
		i_CLK      		  => w_CLK,
		i_RST     	 	  => w_RST,
		i_SIGNAL    	  => w_SIGNAL,
		o_RISE  		     => w_RISE,
		o_FALL           => w_FALL
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
	
	--Gera sinal de 1MHz (frequencia do SCLK)
	PROCESS
	BEGIN
		w_SIGNAL 	  <= '1';
		WAIT FOR 1 us;
		w_SIGNAL  	  <= '0';
		WAIT FOR 1 us;
		
	END PROCESS;
	
end Behavioral;
 