library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity RS232Read is
  port(

    RST     :   in  std_logic;
    CLK     :   in  std_logic;
    Rx      :   in  std_logic;

    S       :   out std_logic_vector(13 downto 0)
   );
end RS232Read;

architecture moore of RS232Read is
signal FBaud   :   std_logic;
signal ENC     :   std_logic;
signal LDx     :   std_logic;
signal EOR     :   std_logic;
signal Q       :   std_logic_vector(7 downto 0);
signal NBaud   :   std_logic_vector(3 downto 0);



component BaudRateRD is
	port(
	RST		:	in	std_logic;
	CLK		:	in	std_logic;
	ENC		:	in	std_logic;
	NBaud	:	in	std_logic_vector(3 downto 0);	-- Number of Bauds by second
	FBaud	:	out	std_logic						-- Base frecuency
	);
end component;

component FSMRead is
	port(
	RST		:	in	std_logic;
	CLK		:	in 	std_logic;
	Rx		:	in	std_logic;
	FBaud	:	in	std_logic;
	ENC		:	out	std_logic;
	EOR		:	out	std_logic;
	LDx		:	out std_logic
	);
end component;

component RegSerPar is
	port(
	RST		:	in	std_logic;
	CLK		:	in	std_logic;
	Rx		:	in	std_logic;
	LDx		:	in	std_logic;
	Q		:	out	std_logic_vector(7 downto 0)
	);
end component;

component hex_7seg is
    port(
    RST		:	in	std_logic;
	CLK		:	in 	std_logic;
    EOR		:	in	std_logic;
	Q       :   in std_logic_vector(3 downto 0);

    S       :   out std_logic_vector(6 downto 0)
    );
end component;

begin

    U00     :   FSMRead port map(RST,CLK,Rx,FBaud,ENC,EOR,LDx);
    U01     :   RegSerPar port map(RST,CLK,Rx,LDx,Q);
    U02     :   BaudRateRD port map(RST,CLK,ENC,NBaud,FBaud);
    U03     :   hex_7seg port map(RST,CLK,EOR,Q(3 downto 0),S(6 downto 0));
    U04     :   hex_7seg port map(RST,CLK,EOR,Q(7 downto 4),S(13 downto 7));

end moore;
