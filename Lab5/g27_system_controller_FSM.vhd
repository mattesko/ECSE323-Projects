-- this vhdl description implements the System Controller FSM Circuit for a 21 card game
--
-- entity name: g27_system_controller_FSM
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


ENTITY g27_system_controller_FSM IS
   PORT
	(
		reset 			: in std_logic;
		clk 			: in std_logic;
		player_play 	: in std_logic;
		player_end		: in std_logic;
		computer_end	: in std_logic;
		round_reset		: in std_logic;
		deck_init   	: out std_logic;
		hands_reset		: out std_logic; 
		player_start 	: out std_logic;
		computer_start 	: out std_logic
	);
   END g27_system_controller_FSM;

ARCHITECTURE architecture_g27_system_controller_FSM OF g27_system_controller_FSM IS 
TYPE state_type is (s0, s1, s2, s3);    -- State declaration
    SIGNAL state : state_type;          -- Init signal that uses the different states
    
BEGIN 
	g27_system_controller_FSM_process : PROCESS(clk, reset) -- Clock process
        BEGIN 
            IF (reset = '1') THEN 
					state <= s0;
				
				ELSIF rising_edge(clk) THEN
					
					CASE state is
					
						WHEN s0 => -- Init state init at the beginning of rounds
							IF (player_play = '1') THEN
								state <= s1;
							ELSE
								state <= s0;
							END IF;
						
						WHEN s1 => -- Player's turn
							IF (player_end = '1') THEN -- Player turn's end
								state <= s2; 
							ELSE
								state <= s1;
							END IF;

						WHEN s2 => -- Computer's turn
							IF (computer_end = '1') THEN
								state <= s3;
							ELSE
								state <= s2;
							END IF;

						WHEN s3 =>	-- Round ends, waiting for player input to reset round
							IF (round_reset = '1') THEN  -- Player busts
								state <= s0;
							ELSE
								state <= s3;
							END IF;

					END CASE;
				END IF;
        END PROCESS;

    output_process : PROCESS(clk)
        BEGIN

            CASE state is

					WHEN s0 =>                      -- Init State        
						deck_init   	<= '1';
						hands_reset		<= '1';
						player_start 	<= '0';
						computer_start 	<= '0';

					WHEN s1 =>						-- Player's turn
						deck_init   	<= '0';
						hands_reset		<= '0';
						player_start 	<= '1';
						computer_start 	<= '0';
					
					WHEN s2 =>                      -- Computer's turn
						deck_init   	<= '0';
						hands_reset		<= '0';
						player_start 	<= '0';
						computer_start 	<= '1';

					WHEN s3 =>						-- Round ends
						deck_init   	<= '0';
						hands_reset		<= '0';
						player_start 	<= '0';
						computer_start <= '0';

					
					WHEN others =>
						deck_init   	<= '0';
						hands_reset		<= '0';
						player_start 	<= '0';
						computer_start 	<= '0';
					
            END CASE;
        
        END PROCESS;

END architecture_g27_system_controller_FSM;