library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Maquina_Master is	
	Generic(
		DATA_SIZE : integer := 8
	);
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
end Maquina_Master;

architecture behavioral of Maquina_Master is

type state_type is (st_IDLE, st_TRANSMISSION, st_END);

SIGNAL state				: state_type;
SIGNAL w_count_CLOCK		: std_logic_vector(3 downto 0); -- count 8 edges
	
begin

p_FSM_Master : process(i_CLK, i_RST)
begin

	if (i_RST = '0') then
		w_count_CLOCK <= (others=>'0');
		o_EN <= '0';
		o_SS <= '1';
		state<= st_IDLE;
	elsif FALLING_EDGE(i_CLK) then
		case state is
			when st_IDLE =>
				if(i_START = '1') then
					o_SS <= '0'; -- ENABLE SLAVE SELECT
					o_EN <= '1'; -- ENABLE TO SERIAL CLOCK
					state<= st_TRANSMISSION;
				else 
					state<= st_IDLE;
				end if;
			when st_TRANSMISSION =>
				if(i_RISE = '1') then -- IF RISE EDGE DETECTION, COUNT 
					w_count_CLOCK <= w_count_CLOCK + 1;
				end if;
				if (w_count_CLOCK = "1000") then -- if edge count = 8 then TX DONE
					if(i_FALL = '1') then
						state<= st_END;
					end if;
				end if;
			when st_END =>
				o_SS <= '1'; -- SET SLAVE SELECT HIGH
				o_EN <= '0'; -- SET ENABLE SERIAL CLOCK LOW
				w_count_CLOCK <= (others=>'0'); -- CLEAN COUNTER
				state <= st_IDLE;
			when others =>
				state <= st_IDLE;
		end case;
	end if;
end process;
				
				



end behavioral;