library IEEE;

use IEEE.std_logic_1164.all;

entity hex_7seg is
    port(
    RST		:	in	std_logic;
	CLK		:	in 	std_logic;
    EOR		:	in	std_logic;
	Q       :   in std_logic_vector(3 downto 0);

    S       :   out std_logic_vector(6 downto 0)
    );

end hex_7seg;

architecture Tabla of Hex_7seg is

begin


    COMB: process(Q,EOR)
	begin

            case Q is
        		when "0000" => S <= NOT("1111110");
        		when "0001" => S <= NOT("0110000");
        		when "0010" => S <= NOT("1101101");
        		when "0011" => S <= NOT("1111001");
        		when "0100" => S <= NOT("0110011");
        		when "0101" => S <= NOT("1011011");
        		when "0110" => S <= NOT("1011111");
        		when "0111" => S <= NOT("1110010");
        		when "1000" => S <= NOT("1111111");
        		when "1001" => S <= NOT("1111011");
                when "1010" => S <= NOT("1110111");
        		when "1011" => S <= NOT("0011111");
        		when "1100" => S <= NOT("1001110");
        		when "1101" => S <= NOT("0111101");
        		when "1110" => S <= NOT("0111101");
        		when "1111" => S <= NOT("1001111");
        		when others => S <= NOT("1000111");
    		end case;

	end process COMB;
end tabla;
