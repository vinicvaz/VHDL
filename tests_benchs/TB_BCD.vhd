library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TB_BCD is
	Generic (
		DATA_SIZE : INTEGER := 8
	);
end TB_BCD;


architecture behavioral of TB_BCD is

component BCD is 
	Generic (
		DATA_SIZE : INTEGER := 8
	);
	Port (
			i_DATA	  : in std_logic_vector((DATA_SIZE-1) downto 0);
			o_SEG 	  : out std_logic_vector((DATA_SIZE-1) downto 0)
		);
end component;

SIGNAL w_DATA	: std_logic_vector((DATA_SIZE-1) downto 0);
SIGNAL w_SEG	: std_logic_vector((DATA_SIZE-1) downto 0);


begin 

UUT : BCD

port map(
		i_DATA => w_DATA,
		o_SEG  => w_SEG
);

-- DATA PROCESS
	process
	begin
		wait for 11 us;
		w_DATA <= "00000000";
		wait for 20 ns;
		w_DATA <= "00000001";
		wait for 20 ns;
		w_DATA <= "00000010";
		wait for 20 ns;
		w_DATA <= "00000011";
		wait;
	end process;

end behavioral;