library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--0010 1111 1010 1111 0000 1000 0000‬

entity Slave is
	
    Port ( 
				i_RST			: in std_logic;
				i_CLK			: in std_logic;
				i_TRIG		: in std_logic;
				i_DATA		: in std_logic_vector(3 downto 0);
							
				o_DATA		: out std_logic_vector(3 downto 0)
	 );
end Slave;

architecture Behavioral of Slave is

type state_type is (st_IDLE, st_WRITE);
SIGNAL state	: state_type;


begin


p_Slave	:	process(i_RST, i_CLK)
	begin
		if (i_RST = '0') then
			o_DATA <= (others => '0');
			state<= st_IDLE;
		elsif FALLING_EDGE(i_CLK) then
			--case state is
			-- IDLE
				--when st_IDLE =>
					if (i_TRIG = '0') then -- ATIVA COM TRIGER ZERO
						o_DATA<= i_DATA;
						state <= st_WRITE;
					else
						state <= st_IDLE;
					end if;
			-- WRITE BCD
				--when st_WRITE =>
					--o_DATA <= i_DATA;
				--end case;
		end if;	

	end process;
end Behavioral;