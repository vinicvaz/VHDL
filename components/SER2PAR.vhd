library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SER2PAR is
	Generic (
		DATA_SIZE : integer := 8
	);
	Port (
		i_clk   : in  std_logic; -- CLOCK
		i_ND    : in  std_logic; -- BORDA DETECTADA
		i_DATA  : in  std_logic; -- DADO DE ENTRADA SERIAL
		o_data  : out std_logic_vector ((DATA_SIZE-1) downto 0) -- dado de saida paralelo
	);
end SER2PAR;

architecture behavioral of SER2PAR is

	signal w_DATA 	 : std_logic_vector (o_data'range);
	
begin

	process(i_clk) 
	begin 
		if falling_edge (i_clk) then 
			if (i_ND = '1') then 
				w_DATA <= w_DATA((DATA_SIZE-2) downto 0) & i_DATA;
			end if; 
      end if; 
	end process;
	
	o_data <=w_DATA;
	
end behavioral;