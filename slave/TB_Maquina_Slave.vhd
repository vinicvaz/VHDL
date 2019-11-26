library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity TB_Maquina_Slave is
end TB_Maquina_Slave;

architecture Behavioral of TB_Maquina_Slave is

component Maquina_Slave is	
	Port (
		i_CLK     		: in  std_logic;		-- CLOCK 100MHz (c0 PLL)
		i_RST		 		: in  std_logic;		-- RESET
		i_SS      	   : in  std_logic;		-- INPUT SLAVE SELECT (ENABLED WITH LOW)
		i_FALL			: in std_logic;		-- FALL EDGE DETECTION INPUT
		o_FREE			: out std_logic
	);
end component;
		
	SIGNAL w_CLK			: STD_LOGIC;
	SIGNAL w_RST			: STD_LOGIC;
	SIGNAL w_FALL			: STD_LOGIC;
	SIGNAL w_SS				: STD_LOGIC;
	SIGNAL w_FREE			: STD_LOGIC;
	
begin

	UUT: Maquina_Slave 
   Port Map( 
		i_CLK      		  => w_CLK,
		i_RST     	 	  => w_RST,
		i_FALL           => w_FALL,
		i_SS				  => w_SS,
		o_FREE			  => w_FREE
	
	 );

	-- CLOCK PROCESS -- 100MHz
	 process
		 begin
			 w_CLK <= '1';
			 wait for 5 ns;
			 w_CLK <= '0';
			 wait for 5 ns;
	 end process;
	 
	-- RESET PROCESS - 10 us
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;
	
	-- FALL EDGE PROCESS
	process
	begin
		wait for 0.5 us;
		w_FALL<='1';
		wait for 10 ns;
		w_FALL<='0';
		wait for 0.5 us;
	end process;
	
	--FSM PROCESS
	PROCESS
	BEGIN
	wait for 11 us;
	w_SS <= '0';
	wait for 8 us;
	w_SS <= '1';
	
	END PROCESS;
	
end Behavioral;
 