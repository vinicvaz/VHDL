library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BCD is 
	Generic (
		DATA_SIZE : INTEGER := 8
	);
	Port (
		i_DATA	  : in std_logic_vector((DATA_SIZE-1) downto 0);
		o_SEG 	  : out std_logic_vector((DATA_SIZE-1) downto 0)
	);
end BCD;

architecture behavioral of BCD is


begin

	process(i_DATA)
	begin
		case i_DATA is
			when "00000000" =>
				o_SEG <= "00000011";
			when "00000001" =>
				o_SEG <= "10011111";
			when "00000010" =>
				o_SEG <= "00100101";
			when "00000011" =>
				o_SEG <= "00001101";
			when "00000100" =>
				o_SEG <= "10011001";
			when "00000101" =>
				o_SEG <= "01001001";
			when "00000110" =>
				o_SEG <= "01000001";
			when "00000111" =>
				o_SEG <= "00011111";
			when "00001000" =>
				o_SEG <= "00000001";
			when "00001001" =>
				o_SEG <= "00001001";
			when others =>
				o_SEG <= "11111111";
		end case;
	end process;

end behavioral;
