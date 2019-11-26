library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SER2PAR is
	Generic (
		DATA_SIZE : integer := 4
	);
	Port (
		i_clk      : in  std_logic; -- sinal de clock
		i_rst      : in  std_logic; -- sinal de reset
		i_ND       : in  std_logic; -- NEW DATA - converte quando ND = 1
		i_DATA  	  : in  std_logic; -- dados de entrada (serial)
		o_DATA	  : out std_logic_vector((DATA_SIZE-1) downto 0); -- dados de saida (paralelo) (buffer)
		i_FREE	  : in std_logic

	);
end SER2PAR;

architecture behavioral of SER2PAR is

	signal w_DATA 	 : std_logic_vector ((DATA_SIZE-1) downto 0);
	signal w_FREE	 : std_logic;
	
begin


process (i_RST, i_CLK, i_FREE)
begin

	if (i_RST = '0') then
		w_DATA <= (others=>'0');
	elsif RISING_EDGE(i_CLK) then
		if(i_ND = '1') then
			w_DATA <= w_DATA((DATA_SIZE-2) downto 0) & i_DATA;
		end if;
	end if;
end process;

process(i_FREE)
begin
	if (i_FREE = '1') then -- w_FREE recebe 1 quando contador de bordas = 8, sinal chegou completo entao pode enviar para saida
		o_DATA<= w_DATA;
	end if;
end process;

end behavioral;