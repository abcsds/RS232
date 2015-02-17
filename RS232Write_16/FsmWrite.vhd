library IEEE;
use IEEE.std_logic_1164.all;

entity FsmWrite is  
    port(
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    FBaud   :   in  std_logic;
    EOT     :   out std_logic;
    CTRL    :   out std_logic_vector(3 downto 0)
    );
end FsmWrite;

architecture simple of FsmWrite is

signal Qp, Qn   : std_logic_vector(3 downto 0);

begin                                
    COMB: process(Qp,STR,FBaud)
    begin
        case Qp is
            when "0000" =>
                CTRL<= "0000";  -- Hold
                EOT<= '1';
                if(STR= '0')then
                    Qn<= Qp;
                else 
                    Qn<= "0001";
                end if;
            
            when "0001" =>
                CTRL<= "0000";  -- Hold
                EOT<= '0';
                if(FBaud= '1')then
                    Qn<= "0010";
                else 
                    Qn<= Qp;
                end if;
            
            when "0010" =>
                CTRL<= "0001";  -- Start
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "0011";
                end if;
            
            when "0011" =>
                CTRL<= "0010";  -- Bit 0
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "0100";
                end if;

            when "0100" =>
                CTRL<= "0011";  -- Bit 1
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "0101";
                end if;
            
            when "0101" =>
                CTRL<= "0100";  -- Bit2
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "0110";
                end if;
            
            when "0110" =>
                CTRL<= "0101";  -- Bit 3 
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "0111";
                end if;
            
            when "0111" =>
                CTRL<= "0110";  -- Bit 4
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "1000";
                end if;
            
            when "1000" =>
                CTRL<= "0111";  -- Bit 5 
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "1001";
                end if;
            
            when "1001" =>
                CTRL<= "1000";  -- Bit 6
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "1010";
                end if;
            
            when "1010" =>
                CTRL<= "1001";  -- Bit 7 
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "1011";
                end if;
            
            when "1011" =>
                CTRL<= "1010";  -- Stop 
                EOT<= '0';
                if(FBaud= '0')then
                    Qn<= Qp;
                else
                    Qn<= "1100";
                end if;
                        
            when others =>   
                CTRL<= "0000";
                EOT<= '1';
                Qn<= "0000";
            
            end case;
            
        end process COMB;
        
        FF: process(RST,CLK)
        begin  
            if(RST='0')then
                Qp<= "0000";
            elsif(CLK'event and CLK='1')then
                Qp<= Qn;
            end if;         
            
        end process;
        
end simple;