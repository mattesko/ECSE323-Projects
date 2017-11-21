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
use ieee.numeric_std.all;


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

    SIGNAL suit : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL modulo_output : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL current_total : UNSIGNED(3 DOWNTO 0);
    SIGNAL sum : UNSIGNED(3 DOWNTO 0);

    -- convert output modulo_output to unsigned number
    face_value <= UNSIGNED(modulo_output) + 1;

    -- convert current amount to unsigned
    current_total <= UNSIGNED(play_pile_top_card)
    sum <= current_total + face_value

    -- rule 'if-statement'
    rule : PROCESS(legal_play, sum)
    BEGIN

        IF sum > 21 THEN
            legal_play <= 1;
        ELSE THEN
            legal_play <= 0;
        END IF;

    END PROCESS;

    -- modulo component for architecture
    COMPONENT g27_modulo_13
	    PORT
        (
            A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		    FLOOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		    O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;
    
    -- begin architecture
    BEGIN

    modulo_inst : g27_modulo_13
    PORT MAP
    (
        A => card_to_play, 
		FLOOR => suit,
		O => modulo_output
    );

END architecture_rules;