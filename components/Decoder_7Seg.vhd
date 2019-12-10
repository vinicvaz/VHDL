library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Decoder_7Seg is
	Port(
	
		i_DATA			: in std_logic_vector(7 downto 0);-- Input Data
		o_DATA			: out std_logic_vector(7 downto 0) -- Output Data
	
	);
end Decoder_7Seg;



architecture behavioral of Decoder_7Seg is

begin

process(i_DATA)
begin
	case i_DATA is
		when "00000000" => --
			o_DATA <= "00000011"; --
		when "00000001" =>		 --
			o_DATA <= "10011111"; --
		when "00000010" => 		 --
			o_DATA <= "00100101"; --
		when "00000011" =>		---
			o_DATA <= "00001101"; --
		when "00000100" =>		--
			o_DATA <= "10011001"; ---
		when "00000101" =>		---
			o_DATA <= "01001001"; ---
		when "00000110" =>		--
			o_DATA <= "01000001"; --
		when "00000111" =>		--
			o_DATA <= "00011111"; --
		when "00001000" =>		--
			o_DATA <= "00000001"; --
		when "00001001" =>
			o_DATA <= "00001001";
		when others =>
			o_DATA <= "11111111";
	end case;
end process;
		
end behavioral;