library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Maquina_Slave is
	
	Port (
		i_CLK     		: in  std_logic;		-- CLOCK 100MHz (c0 PLL)
		i_RST		 		: in  std_logic;		-- RESET
		i_SS      	   : in  std_logic;		-- INPUT SLAVE SELECT (ENABLED WITH LOW)
		i_FALL			: in std_logic;			-- FALL EDGE DETECTION INPUT
		o_FREE			: out std_logic
		
		
	);
end Maquina_Slave;

architecture behavioral of Maquina_Slave is


-- SINAIS INTERNOS

type state_type is (st_IDLE, st_TRANSMISSION, st_END);

SIGNAL state			: state_type;
SIGNAL w_count_FALL	: std_logic_vector(3 downto 0);

begin 

p_FSM_Slave : process(i_RST, i_CLK)
begin

	if(i_RST = '0') then
		w_count_FALL <= (others=> '0');
		o_FREE <= '0';
		state<= st_IDLE;
	elsif RISING_EDGE(i_CLK) then
		case state is
			when st_IDLE =>
				if(i_SS = '0') then
					state <= st_TRANSMISSION;
				else
					state<= st_IDLE;
				end if;
			when st_TRANSMISSION =>
				if(i_FALL = '1') then
					w_count_FALL <= w_count_FALL + 1;
				end if;
				if(w_count_FALL >= "1000" and i_SS = '1') then
					o_FREE <='1';
					state<= st_END;
				end if;
			when st_END =>
				w_count_FALL <= (others=> '0');
				o_FREE <='0';
				state<= st_IDLE;
		end case;
	end if;
end process;

end behavioral;