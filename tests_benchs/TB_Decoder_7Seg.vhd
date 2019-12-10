library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity TB_Decoder_7Seg is
end TB_Decoder_7Seg;

architecture Behavioral of TB_Decoder_7Seg is

component Decoder_7Seg is
	Port(
	
		i_DATA			: in std_logic_vector(7 downto 0);-- Input Data
		o_DATA			: out std_logic_vector(7 downto 0) -- Output Data
	
	);
end component;

SIGNAL w_IDATA		: std_logic_vector(7 downto 0);
SIGNAL w_ODATA		: std_logic_vector(7 downto 0);

begin

UUT: Decoder_7Seg
	Port Map(
	
		i_DATA	=> w_IDATA,
		o_DATA	=> w_ODATA
	
	);
	
	
-- DATA PROCESS
	process
	begin
		wait for 11 us;
		w_IDATA <= "00000000";
		wait for 20 ns;
		w_IDATA <= "00000001";
		wait for 20 ns;
		w_IDATA <= "00000010";
		wait for 20 ns;
		w_IDATA <= "00000011";
		wait;
	end process;



end Behavioral;