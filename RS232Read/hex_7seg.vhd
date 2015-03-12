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
signal Qp, Qn	:	std_logic_vector(6 downto 0);

begin

    SEC: process(RST,CLK,Qn)
    begin
        if(RST= '1')then
            Qp<= (others=>'0');
        elsif(CLK'event and CLK='1')then
            Qp<= Qn;
        end if;
    end process SEC;

    COMB: process(Q,EOR)
	begin
        if(EOR= '1')then
            Qn<= Qp;
        else
            case Q is
        		when "0000" => Qn <= NOT("1111110");
        		when "0001" => Qn <= NOT("0110000");
        		when "0010" => Qn <= NOT("1101101");
        		when "0011" => Qn <= NOT("1111001");
        		when "0100" => Qn <= NOT("0110011");
        		when "0101" => Qn <= NOT("1011011");
        		when "0110" => Qn <= NOT("1011111");
        		when "0111" => Qn <= NOT("1110010");
        		when "1000" => Qn <= NOT("1111111");
        		when "1001" => Qn <= NOT("1111011");
                when "1010" => Qn <= NOT("1110111");
        		when "1011" => Qn <= NOT("0011111");
        		when "1100" => Qn <= NOT("1001110");
        		when "1101" => Qn <= NOT("0111101");
        		when "1110" => Qn <= NOT("0111101");
        		when "1111" => Qn <= NOT("1001111");
        		when others => Qn <= NOT("1000111");
    		end case;
        end if;
	end process COMB;
end tabla;
