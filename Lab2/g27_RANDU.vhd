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

entity g27_RANDU is
	port ( seed			: in std_logic_vector(31 downto 0);
			 rand 		: out std_logic_vector(31 downto 0);
end g27_RANDU;