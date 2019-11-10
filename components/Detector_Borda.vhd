library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Detector_Borda is
	Port(
	
		i_RST			: in std_logic; -- Reset assincrono
		i_CLK			: in std_logic; -- Clock 100 MHz
		i_SIGNAL		: in std_logic; -- SCLK a contar borda
		o_RISE		: out std_logic; -- saida de sinal de subida
		o_FALL		: out std_logic -- saida de sinal de descida
	
	);
end Detector_Borda;

architecture behavioral of Detector_Borda is

SIGNAL w_R		: std_logic;
SIGNAL w_S		: std_logic;
signal w_T		: std_logic;
	
begin

p_DB : process(i_CLK, i_RST)
begin
	if(i_RST = '0') then
		w_R <= '0';
		w_S <= '0';
		w_T <= '0';
	elsif RISING_EDGE(i_CLK) then
		w_R <= i_SIGNAL;
		w_S <= w_R;
		w_T <= w_S;
	end if;
end process;

o_RISE <= w_S and (not w_T);
o_FALL <= (not w_S) and w_T;

end behavioral;