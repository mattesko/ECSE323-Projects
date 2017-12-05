-- this vhdl description implements the Computer Dealer FSM Circuit for a 21 card game
--
-- entity name: g27_computer_player_FSM
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 30/11/17
-- Updated: 01/12/17 (Matthew), 

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY g27_computer_player_FSM IS
    PORT
    (
        current_sum                 : in  std_logic_vector (4 downto 0); -- sum will always be 32 or under 32 <= 2^5 = 32
        turn	                    : in  std_logic;
        new_hand                    : in  std_logic;
        clk                         : in  std_logic;
        reset                       : in  std_logic;
        request_deal                : out std_logic;
        computer_sum                : out std_logic_vector (4 downto 0); -- sum will always be 32 or under 32 <= 2^5 = 32;
        turn_finish                 : out std_logic
    );
    END g27_computer_player_FSM;

ARCHITECTURE architecture_computer_player_FSM OF g27_computer_player_FSM IS 
TYPE state_type is (s0, s1, s2, s3, s4);    -- State declaration
    SIGNAL current_sum_buffer       : unsigned (4 downto 0);
    SIGNAL state                    : state_type;          -- Init signal that uses the different states
    
BEGIN 

    g27_computer_FSM_process : PROCESS(clk, reset) -- Clock process
        BEGIN 
            IF (reset = '1') THEN   -- Triggered when reset is high
                state <= s0;

            ELSIF rising_edge(clk) THEN -- Triggered at rising edge of clock and it is the computer's turn

                CASE state IS 
                    
                    WHEN s0 =>        -- Initial/idle state, wait for computer turn
                    -- IF request_deal is low, making sure FSM is going into the right states at the beginning
                    IF (turn = '1') THEN
                        state       <= s1;
                    ELSE
                        state       <= s0;
                    END IF;

                    WHEN s1 =>        -- Sends a request_deal signal
                        -- Add new card value to current computer sum
                        current_sum_buffer <= unsigned(current_sum);

                        IF (current_sum_buffer <= 16) THEN
                            state       <= s1; -- continue drawing a card
                        ELSE
                            state       <= s2; -- stop drawing cards and advance to s2
                        END IF;
                
                    WHEN s2 =>        -- remains in this state if new_hand isn't high
                        IF (new_hand = '1') THEN
                            state       <= s0; -- start new hand
                        ELSE
                            state       <= s2; -- wait for new_hand 
                        END IF;

                    WHEN others =>
                        state <= s0;

                END CASE;

            END IF;

        END PROCESS;

    output_process : PROCESS(state)
        BEGIN

            CASE state is

                WHEN s0 =>                      -- Idle state
                    request_deal                    <= '0';
                    turn_finish                     <= '0';
                    computer_sum                    <= "00000";
                

                WHEN s1 =>                      -- Request deal
                    request_deal                    <= '1';
                    turn_finish                     <= '0';
                    computer_sum                    <= std_logic_vector(current_sum_buffer); -- outputs new computer sum

                WHEN s2 =>                      -- Output computer is done                     
                    request_deal                    <= '0';
                    turn_finish                     <= '1';

                WHEN others =>
                    request_deal                    <= '0';
                    turn_finish                     <= '0';
                    computer_sum                    <= "00000";

            END CASE;
        
        END PROCESS;

END architecture_computer_player_FSM;