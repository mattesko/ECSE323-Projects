-- this vhdl description implements the rules circuit for a 21 card game
--
-- entity name: g27_rules
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 21/11/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g27_rules IS
    PORT
    (
	-- MSB used to store if an ace is 11 in current_sum, 1: if ace=11, 0 if ace=1, 5 bits used for current_sum
      	play_pile_top_card 	: in std_logic_vector (5 DOWNTO 0);
    	card_to_play 		: in std_logic_vector (5 DOWNTO 0);
		clk 				: in std_logic;
     	legal_play 			: out std_logic;
		sum_output 			: out std_logic_vector (5 DOWNTO 0) -- IF MSB is high, there is an ace, only consider 1 ace
    );
    END g27_rules;

ARCHITECTURE architecture_rules OF g27_rules IS
    
	 -- ===============================
	 -- ARCHITECTURE SIGNALS/COMPONENTS
	 -- ===============================
	 
	 -- UNSIGNED signals
    SIGNAL face_value : UNSIGNED(3 DOWNTO 0);
    SIGNAL face_value_buffer : UNSIGNED(3 DOWNTO 0);
    SIGNAL current_sum : UNSIGNED(4 DOWNTO 0);
    SIGNAL new_sum : UNSIGNED(4 DOWNTO 0);

	 -- STD_LOGIC signals
    SIGNAL modulo_input : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL suit : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL modulo_output : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL legal_play_signal : STD_LOGIC; -- used as buffer for legal_play port
	SIGNAL ace_11_signal : STD_LOGIC;
	 
    -- MODULO13 component
    COMPONENT g27_modulo_13
	    PORT
        (
          	A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		    FLOOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		    O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;
    
    -- ===========================
	 -- BEGIN ARCHITECTURE BEHAVIOR
	 -- ===========================
    BEGIN 
	 
	 -- Subtract one from face_value and pass result through modulo13
	 modulo_input <= ("00" & STD_LOGIC_VECTOR( UNSIGNED(card_to_play(3 DOWNTO 0)) - 1 ));
	 
	 -- Conversion of STD_LOGIC_VECTOR to UNSIGNED
    face_value  	<= UNSIGNED(modulo_output) + 1;
	current_sum 	<= UNSIGNED(play_pile_top_card(4 DOWNTO 0));

    modulo_inst : g27_modulo_13
    PORT MAP
    (
      	A => modulo_input, 
		FLOOR => suit,
		O => modulo_output
    );
					 
	-- All additions and legal_play checking are done under here
	ADDITIONS_AND_COMPARISONS: PROCESS (current_sum)
	BEGIN
		IF rising_edge(clk) THEN
			-- If face_value >= 11, then make it 10
			IF (face_value >= 11) then
				face_value_buffer <= to_unsigned(10, 4);
			ELSIF (face_value = 1) then -- If it is an Ace, output a signal and set it as worst case scenario aka 11
				face_value_buffer <= to_unsigned(11, 4);
				ace_11_signal <= '1';
			ELSE -- The normal cards take their face value
				face_value_buffer <= face_value;
			END IF;
		
			-- If we bust but we have an ace in our hand, decrease hand by 10
			IF (play_pile_top_card(5) = '1' and ((current_sum + face_value_buffer) > 21)) then 	-- If ace was in previous hand
				new_sum <= current_sum + face_value_buffer - 10; -- If bust, change Ace value to 1
				ace_11_signal <= '0';
			ELSIF (ace_11_signal = '1' and ((current_sum + face_value_buffer) > 21)) then		-- If ace is new card
				new_sum <= current_sum + face_value_buffer - 10; -- If bust, change Ace value to 1
				ace_11_signal <= '0';
			ELSE
				new_sum <= current_sum + face_value_buffer;
			END IF;
		
			IF (new_sum <= 21) then
				legal_play_signal <= '1';
			ELSE 
				legal_play_signal <= '0';
			END IF;
		END IF;
	END PROCESS;
	
	-- Output legal_play_signal and ace_11
	legal_play <= legal_play_signal;
	sum_output <= ace_11_signal & std_logic_vector(new_sum);
	
END architecture_rules;