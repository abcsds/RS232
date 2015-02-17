library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity RS232Write is
  port(

    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    DATAWR  :   in  std_logic_vector(7 downto 0);
    NBaud   :   in  std_logic_vector(3 downto 0);

    EOT     :   out std_logic;
    Tx      :   out std_logic
   );
end RS232Write;

architecture moore of RS232Write is
signal CTRL    :   std_logic_vector(3 downto 0);
signal FBaud   :   std_logic;

component BaudRate
  port(
    RST   : in  std_logic;
    CLK   : in  std_logic;
    NBaud : in  std_logic_vector(3 downto 0); -- Number of Bauds by second
    FBaud : out std_logic           -- Base frecuency
  );
end component;

component RightShift
  port(
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    CTRL    :   in  std_logic_vector(3 downto 0);
    DATAWR  :   in  std_logic_vector(7 downto 0);
    Tx      :   out std_logic
  );
end component;

component FsmWrite
  port(
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    FBaud   :   in  std_logic;
    EOT     :   out std_logic;
    CTRL    :   out std_logic_vector(3 downto 0)
  );
end component;

begin

    U00 : BaudRate port map(RST,CLK,NBaud,FBaud);
    U01 : RightShift port map(RST,CLK,CTRL,DATAWR,Tx);
    U02 : FsmWrite port map(RST,CLK,STR,FBaud,EOT,CTRL);

end moore;
