library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux_2_1 is
    port(
    I0		:	in	std_logic_vector(7 downto 0);
    I1		:	in	std_logic_vector(7 downto 0);
    SEL		:	in	std_logic;
    Y		:	in	std_logic_vector(7 downto 0)
    );
end mux_2_1;

architecture simple of mux_2_1 is
begin

    mux: process(SEL, I0, I1)
    begin
        if(SEL='0')then
            Y <= I0;
        else
            y <= I1;
        end if;
    end process mux;

end simple;
