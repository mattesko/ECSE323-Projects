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

ENTITY g27_RANDU IS
	PORT ( 
		seed : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		rand : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END g27_RANDU;

ARCHITECTURE architecture_RANDU OF g27_RANDU IS
	-- lpm_add_sub component paramter and port declarations
	COMPONENT lpm_add_sub
		GENERIC (
			LPM_WIDTH : POSITIVE := 32;
			LPM_REPRESENTATION : STRING := "UNSIGNED";
			LPM_PIPELINE : INTEGER := 0;
			LPM_TYPE : STRING := "LPM_ADD_SUB");
		PORT (
			dataa, datab : IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
			cin : IN STD_LOGIC := '0';
			add_sub : IN STD_LOGIC := '1';
			result : OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0));
	END COMPONENT;
	
	SIGNAL adder_out_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL shift_left_16 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL shift_left_1	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL zero	: STD_LOGIC_VECTOR(31 DOWNTO 0); -- by default, all bits are set to 0, maybe?
	
	BEGIN
		shift_left_16 <= (seed(15 DOWNTO 0) & zero(15 DOWNTO 0));
		shift_left_1  <= (seed(30 DOWNTO 0) & zero(0));
		
		adder_inst1: lpm_add_sub
			PORT MAP (
				dataa => shift_left_16,
				datab => shift_left_1,
				result => adder_out_1);
							
		adder_inst2: lpm_add_sub
			PORT MAP (  
				dataa  => adder_out_1,
				datab  => seed,
				result => rand);
							
		zero <= (31 DOWNTO 0 => '0');
	END architecture_RANDU;