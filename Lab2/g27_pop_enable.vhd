-- this vhdl description implements the pop-enable circuit for a card game
--
-- entity name: g27_pop_enable
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

ENTITY g27_pop_enable IS 
    PORT ( 
        N : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        P_EN : OUT STD_LOGIC_VECTOR(51 DOWNTO 0));
    END g27_pop_enable;

