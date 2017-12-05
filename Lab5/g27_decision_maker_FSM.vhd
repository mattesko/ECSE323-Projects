-- this vhdl description implements the decision maker for the 21 card game
--
-- entity name: g27_decision_maker_FSM
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 01/12/17
-- Updated:

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY g27_decision_maker_FSM IS
   PORT
	(
		reset 				: in std_logic;
		clk 				: in std_logic;
		player_start 		: in std_logic;
		enable_decision 	: in std_logic;
		computer_legal_play : in std_logic;
		player_legal_play	: in std_logic;
		player_hand 		: in std_logic_vector(4 DOWNTO 0);
		computer_hand 		: in std_logic_vector(4 DOWNTO 0);
		player_wins 		: out std_logic_vector(1 DOWNTO 0);
		computer_wins 		: out std_logic_vector(1 DOWNTO 0)
	);
   END g27_decision_maker_FSM;

ARCHITECTURE architecture_g27_decision_maker_FSM OF g27_decision_maker_FSM IS 
TYPE state_type is (s0, s1, s2);   		-- State declaration
    SIGNAL state : state_type;          -- Init signal that uses the different states
	SIGNAL player_hand_buffer 		: unsigned(4 downto 0);
	SIGNAL computer_hand_buffer 	: unsigned(4 downto 0);
	SIGNAL updated 					: std_logic;

    
BEGIN 
	g27_decision_maker_FSM_process : PROCESS(clk, reset) -- Clock process
		
        BEGIN 
            IF (reset = '1') THEN 
					state <= s0;
				
				ELSIF rising_edge(clk) THEN
					
					CASE state is
					
						WHEN s0 => -- Idle state
							IF (enable_decision = '1') THEN
								state <= s1;
							ELSE
								state <= s0;
							END IF;
						
						WHEN s1 => -- player has a legal hand state
							IF (reset = '1') THEN
								state <= s0;
							ELSIF (updated = '1') THEN
								state <= s2;
							ELSE
								state <= s1;
							END IF;
							
						WHEN s2 => 
							IF (reset = '1') THEN
								state <= s0;
							ELSIF (enable_decision = '1') THEN
								state <= s1;
								
							ELSE 
								state <= s2;
							END IF;
							
					END CASE;
				END IF;
        END PROCESS;

    output_process : PROCESS(state)
			variable p_wins : unsigned(1 downto 0);
			variable c_wins : unsigned(1 downto 0);
        BEGIN
			

            CASE state is

					WHEN s0 =>
						p_wins := to_unsigned(0, 2);
						c_wins := to_unsigned(0, 2);

              		WHEN s1 =>
						IF (computer_legal_play = '1' and player_legal_play = '1') THEN
							player_hand_buffer   <= unsigned(player_hand);
							computer_hand_buffer <= unsigned(computer_hand);
							
							IF (player_hand_buffer <= computer_hand_buffer) THEN
								c_wins := c_wins + to_unsigned(0, 1);
							ELSIF (player_hand_buffer > computer_hand_buffer) THEN
								p_wins := p_wins + to_unsigned(0, 1);
							END IF;
						
						ELSIF (player_legal_play = '0') THEN
							c_wins := c_wins + to_unsigned(0, 1);
						
						ELSIF (computer_legal_play = '0') THEN
							p_wins := p_wins + to_unsigned(0, 1);
						END IF;
						updated <= '1';
						
					WHEN s2 =>
						IF (p_wins >= 3 or c_wins >= 3) THEN
							p_wins := to_unsigned(0, 2);
							c_wins := to_unsigned(0, 2);
						ELSE
							updated <= '0';
						END IF;	
					END CASE;
					
				player_wins <= std_logic_vector(p_wins);
				computer_wins <= std_logic_vector(c_wins);
        END PROCESS;
END architecture_g27_decision_maker_FSM;