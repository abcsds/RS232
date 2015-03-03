library	IEEE;
use IEEE.std_logic_1164.all;

entity RegSerPar is
	port( 
	RST		:	in	std_logic;
	CLK		:	in	std_logic;
	Rx		:	in	std_logic;
	LDx		:	in	std_logic;
	Q		:	out	std_logic_vector(7 downto 0)
	);
end RegSerPar;

architecture simple of RegSerPar is

signal Qp, Qn: std_logic_vector(7 downto 0);
begin				  
	
	COMB: process(Rx,LDx,Qp)
	begin		
		
		if(LDx='0')then
			Qn<= Qp;
		else
			Qn(7)<= Rx;
			for i in 6 downto 0 loop
				Qn(i)<= Qp(i+1);
			end loop;
		end if;
		
		Q<= Qp;
		
	end process COMB;
	
	
	SEC: process(RST,CLK,Qn)
	begin
		if(RST='1')then
			Qp<= (others=>'0');
		elsif(CLK'event and CLK='1')then
			Qp<= Qn;		   
		end if;
	end process SEC;
				
	
end simple;

