library IEEE;
use IEEE.std_logic_1164.all;

entity RightShft is
    port( 
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    CTRL    :   in  std_logic_vector(3 downto 0);
    DATAWR  :   in  std_logic_vector(7 downto 0);
    Tx      :   out std_logic
    );
end RightShft;

architecture simple of RightShft is

signal  Txn, Txp: std_logic;

begin  
    
    MUX: process(CTRL,DATAWR)
    begin
        case CTRL is
            when "0000"=>   Txn<= '1';-- Hold
            when "0001"=>   Txn<= '0';-- Start
            when "0010"=>   Txn<= DATAWR(0);-- DATARD(0)
            when "0011"=>   Txn<= DATAWR(1);-- DATARD(1)
            when "0100"=>   Txn<= DATAWR(2);-- DATARD(2)
            when "0101"=>   Txn<= DATAWR(3);-- DATARD(3)
            when "0110"=>   Txn<= DATAWR(4);-- DATARD(4)
            when "0111"=>   Txn<= DATAWR(5);-- DATARD(5)
            when "1000"=>   Txn<= DATAWR(6);-- DATARD(6)
            when "1001"=>   Txn<= DATAWR(7);-- DATARD(7)
            when "1010"=>   Txn<= '1';-- Stop
            when others =>  Txn<= '1';
        end case;    
            
    end process MUX;
    
    FF: process(RST,CLK)
    begin
        
        if(RST='0')then
            Txp<= '0';
        elsif(CLK'event and CLK='1')then
            Txp<= Txn;
        end if;     
                
    end process FF;   
    
    
    Tx <= Txp;   
    
end simple;