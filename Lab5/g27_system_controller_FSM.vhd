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
		reset : in std_logic;
		clk : in std_logic;
		player_start : in std_logic;
		hold : in std_logic;
		over_16 : in std_logic;
		enable_decision : out std_logic;
		computer_turn : out std_logic
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
					
						WHEN s0 => -- Idle state
							IF (player_start = '1') THEN
								state <= s1;
							ELSE
								state <= s0;
							END IF;
						
						WHEN s1 => 
							IF (hold = '1') THEN
								state <= s2;
							ELSIF (reset = '1') THEN
								state <= s0;
							ELSE 
								state <= s1;
							END IF;
						
						WHEN s2 =>
							IF (over_16 = '1') THEN
								state <= s3;
							ELSE
								state <= s2;
							END IF;
						
						WHEN s3 => 
							IF (player_start = '1') THEN
								state <= s1;
							ElSIF (reset = '1') THEN
								state <= s0;
							ELSE
								state <= s3;
							END IF;
					END CASE;
				END IF;
        END PROCESS;

    output_process : PROCESS(state)
        BEGIN

            CASE state is

					WHEN s2 =>                      -- Output computer is done                     
						computer_turn <= '1';
						enable_decision <= '0';

               WHEN s3 =>
						computer_turn <= '0';
                  enable_decision <= '1';
					
					WHEN others =>
						computer_turn <= '0';
						enable_decision <= '0';
					
            END CASE;
        
        END PROCESS;

END architecture_g27_system_controller_FSM;