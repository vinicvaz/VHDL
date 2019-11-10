library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_01Maquina_Master is
	Generic(
		DATA_SIZE : integer := 8
	);
end TB_01Maquina_Master;

architecture Behavioral of TB_01Maquina_Master is

component Maquina_Master is	
	Port (
		i_CLK		: in std_logic; -- 100MHz Clock input (c0 PLL)
		i_RST		: in std_logic; -- RESET INPUT
		i_DATA	: in std_logic_vector((DATA_SIZE-1) downto 0); --PARALLEL DATA INPUT (8 bits) 
		i_RISE	: in std_logic; -- RISE EDGE DETECTION INPUT
		i_FALL	: in std_logic; -- FALL EDGE DETECTION INPUT
		i_START	: in std_logic; -- TRANSMISSION START BUTTON
		
		o_EN		: out std_logic; -- ENABLE SCLK OUTPUT
		o_SS		: out std_logic -- SLAVE SELECT OUTPUT

	);
end component;
		
	SIGNAL w_CLK			: STD_LOGIC;
	SIGNAL w_RST			: STD_LOGIC;
	SIGNAL w_DATA	 		: STD_LOGIC_VECTOR((DATA_SIZE-1) downto 0);
	SIGNAL w_RISE		  	: STD_LOGIC;
	SIGNAL w_FALL			: STD_LOGIC;
	SIGNAL w_START			: STD_LOGIC;
	SIGNAL w_EN				: STD_LOGIC;
	SIGNAL w_SS				: STD_LOGIC;
	
begin

	UUT: Maquina_Master 
   Port Map( 
		i_CLK      		  => w_CLK,
		i_RST     	 	  => w_RST,
		i_START			  => w_START,
		i_RISE  		     => w_RISE,
		i_FALL           => w_FALL,
		i_DATA			  => w_DATA,
		
		o_EN				  => w_EN,
		o_SS				  => w_SS
	
	 );

	-- CLOCK PROCESS -- 100MHz
	 process
		 begin
			 w_CLK <= '1';
			 wait for 0.005 us;
			 w_CLK <= '0';
			 wait for 0.005 us;
	 end process;
	 
	-- RESET PROCESS - 10 us
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;
	
	-- RISE EDGE PROCESS
	process
	begin
		w_RISE <='1';
		wait for 10 ns;
		w_RISE<='0';
		wait for 1 us;
	end process;
	
	--FSM PROCESS
	PROCESS
	BEGIN
	w_FALL <= '1';
	w_RST <= '0';
	wait for 11 us;
	w_RST <= '1';
	wait for 0.01 us;
	w_START <= '1';
	wait for 20 ns;
	w_START <= '0';
	wait;
	
	END PROCESS;
	
end Behavioral;
 