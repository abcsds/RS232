library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity RS232Write_16 is
  port(

    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    START   :   in  std_logic;

    Tx      :   out  std_logic;
    RDY     :   out  std_logic
   );
end RS232Write_16;

architecture moore of RS232Write_16 is
signal DATAWR_USB, DATAWR_MSB, DATAWR    :   std_logic_vector(7 downto 0);
signal NBaud                             :   std_logic_vector(3 downto 0);
signal EOT, STR, SEL                     :   std_logic;

component RS232Write
    port(

      RST     :   in  std_logic;
      CLK     :   in  std_logic;
      STR     :   in  std_logic;
      DATAWR  :   in  std_logic_vector(7 downto 0);
      NBaud   :   in  std_logic_vector(3 downto 0);

      EOT     :   out std_logic;
      Tx      :   out std_logic
    );
end component;

component FSM16_control is
    port(
    RST		:	in	std_logic;
    CLK		:	in	std_logic;
    START	:	in	std_logic;
    EOT 	:	in	std_logic;
    RDY 	:	out	std_logic;
    SEL 	:	out	std_logic;
    STR 	:	out	std_logic
    );
end component;

component mux_2_1 is
    port(
    I0		:	in	std_logic_vector(7 downto 0);
    I1		:	in	std_logic_vector(7 downto 0);
    SEL		:	in	std_logic;
    Y		:	in	std_logic_vector(7 downto 0)
    );
end component;

begin

    DATAWR_USB <= "1010101010";
    DATAWR_MSB <= "1010101010";
    NBAUD <= "0110";


    U00 : RS232Write port map(RST,CLK,STR,DATAWR,NBaud,EOT,Tx);
    U01 : FSM16_control port map(RST,CLK,START,EOT,SEL,STR,RDY);
    U02 : mux_2_1 port map(DATAWR_USB,DATAWR_MSB,SEL,DATAWR);

end moore;
