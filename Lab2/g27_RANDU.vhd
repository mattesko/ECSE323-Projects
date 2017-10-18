-- this circuit implements the IBM RANDU version of a linear congruential generator
--
-- entity name: g27_RAMDU
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 18/10/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity g27_RANDU is
	port ( seed			: in std_logic_vector(31 downto 0);
			 rand 		: out std_logic_vector(31 downto 0)
			 );
end g27_RANDU;

architecture first_adder of g27_RANDU
	signal adder1		: std_LOGIC_VECTOR(31 downto 0);
	signal adder2		: std_LOGIC_VECTOR(31 downto 0);

	begin
	
		u1: lpm_ADD_SUB
			generic map


	COMPONENT lpm_add_sub
   GENERIC (LPM_WIDTH: POSITIVE;
				LPM_DIRECTION: STRING := "UNUSED";
				LPM_REPRESENTATION: STRING := "SIGNED";
				LPM_PIPELINE: INTEGER := 0;
				LPM_TYPE: STRING := "LPM_ADD_SUB";
				LPM_HINT: STRING := "UNUSED"
				ONE_INPUT_IS_CONSTANT: STRING := "NO";
				MAXIMIZE_SPEED: INTEGER; 
				USE_WYS: STRING :=	"OFF");
   PORT (dataa, datab: IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
      aclr, clock, cin: IN STD_LOGIC := '0';
      clken, add_sub: IN STD_LOGIC := '1';
      result: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
      cout, overflow: OUT STD_LOGIC);
	END COMPONENT;
	