library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity BaudRate is
	port(
	RST		:	in	std_logic;
	CLK		:	in	std_logic;
	NBaud	:	in	std_logic_vector(3 downto 0);	-- Number of Bauds by second
	FBaud	:	out	std_logic						-- Base frecuency 
	); 
end BaudRate;

architecture simple of BaudRate is

signal Qp, Qn, NB	: std_logic_vector(18 downto 0);

begin
	
	COMB: process(NBaud,Qp)
	begin				   
		
		case NBaud is
			when "0000"=>
			NB<= "1101110111110010001";	-- 110 Bauds
			when "0001"=>		
			NB<= "0101000101100001010";	-- 300 Bauds
			when "0010"=>
			NB<= "0010100010110000101";	-- 600 Bauds
			when "0011"=>
			NB<= "0001010001011000010";	-- 1200 Bauds
			when "0100"=>					 
			NB<= "0000101000101100001";	-- 2400 Bauds
			when "0101"=>
			NB<= "0000010100010110000";	-- 4800 Bauds
			when "0110"=>
			NB<= "0000001010001011000";	-- 9600 Bauds
			when "0111"=>
			NB<= "0000000110110010000";	-- 14400 Bauds
			when "1000"=>
			NB<= "0000000101000101100";	-- 19200 Bauds
			when "1001"=>
			NB<= "0000000010100010110";	-- 38400 Bauds
			when "1010"=>
			NB<= "0000000001101100100";	-- 57600 Bauds
			when "1011"=>				  			
			NB<= "0000000000110110010";	-- 115200 Bauds
			when "1100"=>
			NB<= "0000000000110000110";	-- 128000 Bauds
			when "1101"=>
			NB<= "0000000000011000011";	-- 256000 Bauds
			when others=>
			NB<= "0000000000000000000";	-- 0 Bauds
			
		end case;		
			
		if(Qp= "0000000000000000000")then
			Qn<= NB;										 
			FBaud<= '1';
		else 
			Qn<= Qp-1;
			FBaud<= '0';
		end if;
		
	end process COMB;
	
	FF: process(RST,CLK)
	begin		
		if(RST='0')then
			Qp <= (others=>'0');		  		 
		elsif(CLK'event and CLK='1') then
			Qp <= Qn;				  
		end if;
	end process FF;
		
end simple;



	