library IEEE;
use IEEE.std_logic_1164.all;
entity  register_of_displacement is
  port(
    RST      : in std_logic;
    CLK      : in std_logic;
    Rx       : in std_logic;
    CTRL     : in std_logic_vector(1 downto 0);
    DATARead : out std_logic_vector(8 downto 0)
   );
end register_of_displacement;

architecture simple of register_of_displacement is
signal Qn,Qp:std_logic_vector(8 downto 0);

begin
    combinacional: process(CTRL, Qp, Rx)
    begin
        case( CTRL ) is
              
            when "00" => Qn <= Qp;
            when "01" => Qn <= (others => '0');
            when others => Qn <= Rx & Qp(7 downto 1);

        end case ;     
        DATARead <= Qp;
    end process combinacional;  

    secuencial: process(RST,CLK)
    
    begin
        if (RST='0') then
        Qp<=(others=>'0');
        elsif (CLK'event and CLK='1') then
        Qp<=Qn;
        end if;
    end process secuencial;
  
end simple;



