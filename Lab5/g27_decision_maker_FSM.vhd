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
		enable_decision 	: in std_logic;
		computer_legal_play : in std_logic;
		player_legal_play	: in std_logic;
		end_game_in			: in std_logic;
		player_wins_in		: in std_logic_vector(1 DOWNTO 0);
		computer_wins_in	: in std_logic_vector(1 DOWNTO 0);
		player_hand 		: in std_logic_vector(4 DOWNTO 0);
		computer_hand 		: in std_logic_vector(4 DOWNTO 0);
		player_wins_out		: out std_logic_vector(1 DOWNTO 0);
		computer_wins_out	: out std_logic_vector(1 DOWNTO 0);
		score_update		: out std_logic;
		end_game_out		: out std_logic
	);
   END g27_decision_maker_FSM;

ARCHITECTURE architecture_g27_decision_maker_FSM OF g27_decision_maker_FSM IS 
TYPE state_type is (s0, s1, s2, s3, s4, s5);   		-- State declaration
    SIGNAL state : state_type;          -- Init signal that uses the different states
	SIGNAL player_hand_buffer 		: unsigned(4 downto 0);
	SIGNAL computer_hand_buffer 	: unsigned(4 downto 0);
	SIGNAL p_wins 		: unsigned(1 downto 0);
	SIGNAL c_wins 		: unsigned(1 downto 0);

    
BEGIN 
	g27_decision_maker_FSM_process : PROCESS(clk, reset) -- Clock process
		
        BEGIN 
            IF (reset = '1') THEN 
					state <= s0;
				
				ELSIF rising_edge(clk) THEN
					
					CASE state is
					
						WHEN s0 => -- Init/Reset State 
							state <= s1;

						WHEN s1 => -- Idle State
							IF (enable_decision = '1') THEN

								IF (player_legal_play = '0') THEN 		-- Player goes bust
									state <= s2;
								ELSIF (computer_legal_play = '0') THEN 	-- Computer goes bust
									state <= s3;
								ELSE									-- Compares scores
									state <= s4;
								END IF;

							ELSE
								state <= s1;
							END IF;
						
						WHEN s2 => -- Player goes bust, Computer wins
							state <= s5;
							
						WHEN s3 => -- Computer goes bust, Player wins
							state <= s5;
							
						WHEN s4 => -- Compares hands
							state <= s5;

						WHEN s5 => -- Checks score, Stays in this state if game is over
							IF (end_game_in = '1') THEN
								state <= s5;
							ELSE
								state <= s1;
							END IF;	

					END CASE;
				END IF;
        END PROCESS;

    output_process : PROCESS(state)
			variable p_wins : unsigned(1 downto 0);
			variable c_wins : unsigned(1 downto 0);
        BEGIN
			p_wins	:= UNSIGNED(player_wins_in);
			c_wins	:= UNSIGNED(computer_wins_in);

            CASE state is

					WHEN s0 => -- Resets all signals
						p_wins := to_unsigned(0, 2);
						c_wins := to_unsigned(0, 2);
						player_wins_out		<= "00";
						computer_wins_out	<= "00";
						end_game_out 		<= '0';
						score_update		<= '0';

					WHEN s2 => -- Computer wins
						p_wins 				:= p_wins;
						c_wins 				:= c_wins + 1;
						score_update		<= '1';
						
						-- Checks for endgame
						IF (c_wins >= 3 or p_wins >= 3) THEN
							end_game_out <= '1';
						ELSE
							end_game_out <= '0';
						END IF;

					WHEN s3 => -- Player wins
						p_wins 				:= p_wins + 1;
						c_wins 				:= c_wins;
						score_update		<= '1';

						-- Checks for endgame
						IF (c_wins >= 3 or p_wins >= 3) THEN
							end_game_out <= '1';
						ELSE
							end_game_out <= '0';
						END IF;

              		WHEN s4 => -- Compares hands
						player_hand_buffer   <= unsigned(player_hand);
						computer_hand_buffer <= unsigned(computer_hand);
							
						IF (player_hand_buffer <= computer_hand_buffer) THEN
							c_wins := c_wins + 1;
						ELSIF (player_hand_buffer > computer_hand_buffer) THEN
							p_wins := p_wins + 1;
						END IF;
						score_update		<= '1';

						-- Checks for endgame
						IF (c_wins >= 3 or p_wins >= 3) THEN
							end_game_out <= '1';
						ELSE
							end_game_out <= '0';
						END IF;
					
					WHEN OTHERS =>
						score_update		<= '0';

					END CASE;
					
				player_wins_out <= std_logic_vector(p_wins);
				computer_wins_out <= std_logic_vector(c_wins);
				
        END PROCESS;
END architecture_g27_decision_maker_FSM;