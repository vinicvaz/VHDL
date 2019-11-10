library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CLOCK_GENERATOR is
port(

	i_clk		:	in std_logic;
	o_clk		:	out std_logic_vector(1 downto 0)

);
end CLOCK_GENERATOR;

architecture bh of CLOCK_GENERATOR is

component pll is
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0				: OUT STD_LOGIC ;
		c1				: OUT STD_LOGIC 
	);
end component;

begin

pll1	: pll port map( 
	inclk0 => i_clk,
	c0 => o_clk (0), -- 100MHz
	c1 => o_clk(1)   -- 1MHz
);

end bh;