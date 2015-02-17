library IEEE;
use IEEE.std_logic_1164.all;

entity FsmRead is  
    port(
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    FBaud   :   in  std_logic;
    EOR     :   out std_logic;
    CTRL    :   out std_logic_vector(3 downto 0)
    );
end FsmRead;

architecture simple of FsmRead is

signal Qp, Qn   : std_logic_vector(3 downto 0);

begin                                
    combinacional: process(Qp,STR,FBaud)
    begin
        case Qp is
            when "0000" =>          -- State 0
                if (STR='1') then
                    Qn <= Qp;
                else
                    Qn <= "0001";
                end if;
                CTRL <= "01";
                EOR <= "1";
            when "0001" =>          -- State 1
                Qn <= "0010"
                CTRL <= "10";
                EOR <= "0";
            when "0010" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "0011"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "0011" =>          -- State 2
                Qn <= "0100"
                CTRL <= "10";
                EOR <= "0";
            when "0100" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "0101"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "0101" =>          -- State 3
                Qn <= "0110"
                CTRL <= "10";
                EOR <= "0";
            when "0110" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "0111"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "0111" =>          -- State 4
                Qn <= "1000"
                CTRL <= "10";
                EOR <= "0";
            when "1000" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "1001"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "1001" =>          -- State 5
                Qn <= "1010"
                CTRL <= "10";
                EOR <= "0";
            when "1010" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "1011"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "1011" =>          -- State 6
                Qn <= "1100"
                CTRL <= "10";
                EOR <= "0";
            when "1100" =>          -- HOLD State 1
                if (FBaud = '0') then
                    Qn <= Qp;
                else
                    Qn <= "1101"
                end if;
                CTRL <= "00";
                EOR <= "0";
            when "1101" =>          -- State 7
                Qn <= "1110"
                CTRL <= "10";
                EOR <= "0";

            
            when others =>   
                CTRL<= "0000";
                EOR<= '1';
                Qn<= "0000";
            
            end case;
            
        end process combinacional;
        
        secuencial: process(RST,CLK)
        begin  
            if(RST='0')then
                Qp<= "0000";
            elsif(CLK'event and CLK='1')then
                Qp<= Qn;
            end if;         
            
        end process secuencial;
        
end simple;