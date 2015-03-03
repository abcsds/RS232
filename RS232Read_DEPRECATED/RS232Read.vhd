library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity RS232Read is
  port(

    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    DATARead:   in  std_logic_vector(7 downto 0);
    NBaud   :   in  std_logic_vector(3 downto 0);

    EOR     :   out std_logic;
    Tx      :   out std_logic
   );
end RS232Read;

architecture moore of RS232Read is
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

component register_of_displacement
  port(
    RST      : in std_logic;
    CLK      : in std_logic;
    Rx       : in std_logic;
    CTRL     : in std_logic_vector(1 downto 0);
    DATARead : out std_logic_vector(8 downto 0)
  );
end component;

component FsmRead is  
    port(
    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    STR     :   in  std_logic;
    FBaud   :   in  std_logic;
    EOR     :   out std_logic;
    CTRL    :   out std_logic_vector(3 downto 0)
    );
end component;

begin

    U00 : BaudRate port map(RST,CLK,NBaud,FBaud);
    U01 : register_of_displacement port map(RST,CLK,Rx,CTRL,DATARead);
    U02 : FsmRead port map(RST,CLK,STR,FBaud,EOR,CTRL);
 
end moore;



