library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Conversor_par2ser is
	Generic (
		DATA_SIZE : integer := 8
	);
	Port (
		i_clk      : in  std_logic; -- sinal de clock
		i_rst      : in  std_logic; -- sinal de reset
		i_LOAD     : in  std_logic; -- mode (LOAD = 0, SHIFT = 1)
		i_ND		  : in  std_logic; -- New data (dado que traz informaçao de borda de subida serial)
		i_data  	  : in  std_logic_vector ((DATA_SIZE-1) downto 0); -- dados de entrada (paralelo)
		o_DATA	  : out std_logic -- dados de saida (serial)
		

	);
end Conversor_par2ser;

architecture behavioral of Conversor_par2ser is

	signal w_DATA 	  : std_logic_vector ((DATA_SIZE-1) downto 0);
	SIGNAL w_FREE    : std_logic;
	
begin

p_1	: process(i_CLK)
begin
	if RISING_EDGE(i_CLK) then
		if(i_LOAD = '1') then
			w_DATA <= i_DATA;
		elsif(w_FREE = '1') then
			w_DATA<= w_DATA((DATA_SIZE-2) downto 0) & '0';
		end if;
	end if;
end process;

p_2	: process(i_CLK, i_RST)
begin
	if (i_RST = '0') then
		w_FREE <= '0';
	elsif FALLING_EDGE(i_CLK) then
		if(i_ND = '1') then
			o_DATA <= w_DATA(DATA_SIZE-1);
			w_FREE <= '1';
		else
			w_FREE <= '0';
		end if;
	end if;
end process;
		




	
end behavioral;