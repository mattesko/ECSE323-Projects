-- this vhdl description implements the rules circuit for a 21 card game
--
-- entity name: g27_rules
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 21/11/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all
library lpm;
use lpm.lpm_components.all;


ENTITY g27_rules IS
    PORT
    (
        play_pile_top_card : in std_logic_vector(5 DOWNTO 0);
        card_to_play : in std_logic_vector(5 DOWNTO 0);
        legal_play : out std_logic
    );
    END g27_rules;

ARCHITECTURE architecture_rules OF g27_rules IS
    
    -- 2 bits for suit, 4 for face_value
    SIGNAL face_value : UNSIGNED(3 DOWNTO 0);
    SIGNAL x : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- convert output x to unsigned
    face_value <= UNSIGNED(x);

    COMPONENT g27_modulo_13
	    PORT
        (
            A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		    FLOOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		    O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;
    
    BEGIN

    modulo_inst : g27_modulo_13
    PORT MAP
    (
        A => card_to_play, 
		FLOOR => ,
		O => x
    );


    

	END architecture_rules;