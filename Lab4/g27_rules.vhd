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

entity g27_rules is

    port (  play_pile_top_card  : in std_logic_vector(5 downto 0);
            card_to_play        : in std_logic_vector(5 downto 0);
            legal_play          : out std_logic);

end g27_rules;

