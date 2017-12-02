-- this vhdl description extracts and outputs the suit and face value of a card input
--
-- entity name: g27_face_value_extract.vhd
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 01/12/17

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g27_value_suit_extract IS
    PORT
    (
    	card_input : in std_logic_vector (5 DOWNTO 0);
		suit : out std_logic_vector (3 DOWNTO 0);
		face_value : out std_logic_vector (4 DOWNTO 0);
		ace_11 : out std_logic
    );
END g27_value_suit_extract;

ARCHITECTURE architecture_value_suit_extract OF g27_value_suit_extract IS
    
	-- ===============================
	-- ARCHITECTURE SIGNALS/COMPONENTS
	-- ===============================
	 
	-- UNSIGNED signals
   SIGNAL face_value_buffer : UNSIGNED(3 DOWNTO 0);

	-- STD_LOGIC signals
	SIGNAL modulo_input : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL modulo_output : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ace_11_buffer : STD_LOGIC;
	 
    -- MODULO13 component
    COMPONENT g27_modulo_13
	    PORT
        (
          A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		    FLOOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		    O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;
    
    BEGIN 
	-- ===========================
	 -- BEGIN ARCHITECTURE BEHAVIOR
	 -- ===========================
	
	-- Subtract one from face_value and pass result through modulo13
	modulo_input <= ("00" & STD_LOGIC_VECTOR( UNSIGNED(card_input(3 DOWNTO 0)) - 1 ));
	 
	-- Conversion of STD_LOGIC_VECTOR to UNSIGNED
    face_value_buffer <= UNSIGNED(modulo_output) + 1;
	
    modulo_inst : g27_modulo_13
    PORT MAP
    (
      	A => modulo_input, 
		FLOOR => suit, -- out floor to suit port
		O => modulo_output
    );
					 
	-- All additions and legal_play checking are done under here
	ADDITIONS_AND_COMPARISONS: PROCESS (face_value_buffer)
	BEGIN
		-- If face_value >= 11, then make it 10
		IF (face_value_buffer >= 11) then
			face_value_buffer <= to_unsigned(10, 4);
		END IF;
		
		IF (card_input(5) = '1') then
			ace_11_buffer <= '1';
		END IF;
		
	END PROCESS;
	
	-- Output face_value and ace_11 std_logic
	ace_11 <= ace_11_buffer;
	face_value <= std_logic_vector(face_value_buffer);
	
END architecture_value_suit_extract;