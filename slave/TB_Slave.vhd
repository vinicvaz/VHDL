library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TB_Slave is

end TB_Slave;

architecture Behavioral of TB_Slave is

-- DECLARAÇÃO DE COMPONENTES E SINAIS INTEIROS

component Slave is
	
    Port ( 
				i_RST			: in std_logic;
				i_CLK			: in std_logic;
				i_TRIG		: in std_logic;
				i_DATA		: in std_logic_vector(3 downto 0);
			
				o_DATA		: out std_logic_vector(3 downto 0)
	 );
end component;

	signal w_RST 	: STD_LOGIC;
	signal w_CLK 	: STD_LOGIC;
	signal w_TRIG 	: STD_LOGIC;
	signal w_DATA 	: STD_LOGIC_VECTOR(3 downto 0);
	signal w_ODATA	: STD_LOGIC_VECTOR(3 downto 0);

begin

UUT : Slave 
    Port map( 
				i_RST			=> w_RST,
				i_CLK			=> w_CLK,
				i_TRIG   	=> w_TRIG,
				i_DATA		=> w_DATA,

				o_DATA		=> w_ODATA
	 );

	-- CLOCK PROCESS
	 process
		 begin
			 w_CLK <= '1';
			 wait for 10 ns;
			 w_CLK <= '0';
			 wait for 10 ns;
	 end process;
	 
	-- RESET PROCESS
	process 
		begin
			w_RST <= '0';
			wait for 10 us;
			w_RST<= '1';
			wait;
	end process;
	
	-- SIGNAL PROCESS
	process
		begin
		wait for 11 us;
		w_DATA <= "0001";
		w_TRIG<='0';
		wait for 20 ns;
		w_TRIG<='1';
		wait for 20 ns;
		w_DATA <= "0010";
		w_TRIG<='0';
		wait for 20 ns;
		w_TRIG<='1';
		wait for 20 ns;
		w_DATA <= "0011";
		w_TRIG<='0';
		wait for 20 ns;
		w_TRIG<='1';
		wait;
		
	end process;
	
end Behavioral;