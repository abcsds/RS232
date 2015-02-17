library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity FSM16_control is
    port(
    RST		:	in	std_logic;
    CLK		:	in	std_logic;
    START	:	in	std_logic;
    EOT 	:	in	std_logic;
    
    RDY 	:	out	std_logic;
    SEL 	:	out	std_logic;
    STR 	:	out	std_logic
    );
end FSM16_control;

architecture simple of FSM16_control is

signal Qp,Qn 	:	std_logic_vector(2 downto 0);

begin

    combinacional: process(EOT,START,Qp)
    begin

        case Qp is
            when "000"=>
                if(START = '0') then
                    Qn <= Qp;
                else
                    Qn <= "001";
                end if;
                SEL <= '0';
                STR <= '0';
                RDY <= '1';
            when "001"=>
                Qn <= "010";
                SEL <= '0';
                STR <= '1';
                RDY <= '0';
            when "010"=>
                if(EOT = '0') then
                    Qn <= Qp;
                else
                    Qn <= "011";
                end if;
                SEL <= '0';
                STR <= '0';
                RDY <= '0';
            when "011"=>
                Qn <= "100";
                SEL <= '1';
                STR <= '0';
                RDY <= '0';
            when "100"=>
                Qn <= "101";
                SEL <= '1';
                STR <= '1';
                RDY <= '0';
            when "101"=>
                if(EOT = '0') then
                    Qn <= Qp;
                else
                    Qn <= "110";
                end if;
                SEL <= '1';
                STR <= '0';
                RDY <= '0';
            when "110"=>
                if(START = '0') then
                    Qn <= Qp;
                else
                    Qn <= "000";
                end if;
                SEL <= '1';
                STR <= '0';
                RDY <= '0';
            when others=>
                Qn <= "000";
                SEL <= '0';
                STR <= '0';
                RDY <= '1';
        end case;

    end process combinacional;

    secuencial: process(RST,CLK)
    begin
        if(RST='0')then
            Qp <= (others=>"000");
        elsif(CLK'event and CLK='1') then
            Qp <= Qn;
        end if;
    end process secuencial;

end simple;
