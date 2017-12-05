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


ENTITY g27_player_controller_FSM IS
   PORT
	(
		reset 				: in std_logic;
		clk 					: in std_logic;
		play_pulse 			: in std_logic;
		player_start		: in std_logic;
		hold 					: in std_logic;
		player_bust			: in std_logic;
		request_deal    	: out std_logic;
		enable_decision 	: out std_logic;
		player_end 			: out std_logic
	);
   END g27_player_controller_FSM;

ARCHITECTURE architecture_g27_player_controller_FSM OF g27_player_controller_FSM IS 
TYPE state_type is (s0, s1, s2, s3, s4);    -- State declaration
    SIGNAL state : state_type;          -- Init signal that uses the different states
    
BEGIN 
	g27_player_controller_FSM_process : PROCESS(clk, reset) -- Clock process
        BEGIN 
            IF (reset = '1') THEN 
					state <= s0;
				
				ELSIF rising_edge(clk) THEN
					
					CASE state is
					
						WHEN s0 => -- Idle state, waiting for system controller signal
							IF (player_start = '1') THEN
								state <= s1;
							ELSE
								state <= s0;
							END IF;
							

						WHEN s1 => -- Player's turn, waiting for player input
							IF (play_pulse = '1') THEN
								state <= s2;  -- Request a card
							ELSIF (hold = '1') THEN
								state <= s3;  -- Holds his hand
							ELSIF (player_bust = '1') THEN
								state <= s4;  -- Player busts, in case of clk issues
							ELSE			  -- Wait for an input
								state <= s1;
							END IF;
						
						WHEN s2 =>	-- Player requests to draw a card							
							IF (player_bust = '1') THEN  -- Player busts
								state <= s4;
							ELSE
								state <= s1;
							END IF;

						WHEN s3 => -- Player holds its hand
							state <= s4;

						WHEN s4 => -- Player ends it turn, goes back to idle state until new game
							state <= s0;

					END CASE;
				END IF;
        END PROCESS;

    output_process : PROCESS(clk)
        BEGIN

            CASE state is

					WHEN s0 =>                      -- Idle State        
						request_deal    	<= '0';          
						player_end   	 	<= '0';
						enable_decision 	<= '0';

					WHEN s1 =>						-- Waiting for player input
					 	request_deal    	<= '0'; 
						player_end   	 	<= '0';
                 	enable_decision 	<= '0';
					
					WHEN s2 =>                      -- Player request deal    
						request_deal    	<= '1';                  
						player_end   		<= '0';
						enable_decision 	<= '1';

					WHEN s3 =>						-- Player holds his hand
					  	request_deal   	<= '0'; 
						player_end   		<= '0';
						enable_decision 	<= '0';
			
					WHEN s4 =>						-- Player ends his turn
						request_deal    	<= '0'; 
						player_end   		<= '1';
						enable_decision 	<= '0';
					
					WHEN others =>
						request_deal    	<= '0'; 
						player_end 			<= '0';
						enable_decision 	<= '0';
					
            END CASE;
        
        END PROCESS;

END architecture_g27_player_controller_FSM;