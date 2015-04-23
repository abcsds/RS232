-- This module controls reading process

library	IEEE;
use IEEE.std_logic_1164.all;

entity FSMRead is
	port(
	RST		:	in	std_logic;
	CLK		:	in 	std_logic;
	Rx		:	in	std_logic;
	FBaud	:	in	std_logic;
	KI		:	in	std_logic;
	
	ENC		:	out	std_logic;
	EOR		:	out	std_logic;
	LDx		:	out std_logic
	);
end FSMRead;

architecture simple of FSMRead is

signal Qp, Qn	:	std_logic_vector(4 downto 0);

begin

	COMB: process(Qp,Rx,FBaud, KI)
	begin
		case Qp is
			when "00000"=>
			if(Rx= '1')then
				Qn<= Qp;
			else
				Qn<= "00001";
			end if;
			ENC<= '0';
			EOR<= '1';
			LDx<= '0';

			when "00001"=>		-- Start
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "00010";
			end if;
			ENC<= '1';	-- Enable FBaud
			EOR<= '0';
			LDx<= '0';

			when "00010"=>
			Qn<= "00011";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 0

			when "00011"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "00100";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "00100"=>
			Qn<= "00101";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 1

			when "00101"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "00110";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "00110"=>
			Qn<= "00111";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 2

			when "00111"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "01000";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "01000"=>
			Qn<= "01001";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 3

			when "01001"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "01010";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "01010"=>
			Qn<= "01011";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 4

			when "01011"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "01100";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "01100"=>
			Qn<= "01101";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 5


			when "01101"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "01110";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "01110"=>
			Qn<= "01111";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 6


			when "01111"=>
			if(FBaud= '0')then
				Qn<= Qp;
			else
				Qn<= "10000";
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when "10000"=>
			Qn<= "10001";
			ENC<= '1';
			EOR<= '0';
			LDx<= '1';	-- Load Bit 7


			when "10001"=>
			if(FBaud= '1' and KI='0')then
				Qn<= "00000";
			else
				Qn<= Qp;
			end if;
			ENC<= '1';
			EOR<= '0';
			LDx<= '0';

			when others=>
			Qn<= "00000";
			ENC<= '0';
			EOR<= '0';
			LDx<= '0';

			end case;


	end process COMB;

	SEC: process(RST,CLK,Qn)
	begin
		if(RST= '1')then
			Qp<= (others=>'0');
		elsif(CLK'event and CLK='1')then
			Qp<= Qn;
		end if;
	end process SEC;

end simple;
