-- this vhdl description implements the Computer Dealer FSM Circuit for a 21 card game
--
-- entity name: g27_computer_player_FSM
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 30/11/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY g27_computer_player_FSM IS
    PORT
    (
        computer_turn               : in  std_logic;
        computer_illegal_play       : in  std_logic;
        value_over_16	            : in  std_logic;
        player_higher_dealer_hand   : in  std_logic;
	     over_3_wins				      : in  std_logic;
        clk                         : in  std_logic;
        reset                       : in  std_logic;
        request_deal                : out std_logic;
        computer_win_and_new_round  : out std_logic_vector (1 downto 0);
        computer_init               : out std_logic;
        end_game                    : out std_logic
    );
    END g27_computer_player_FSM;

ARCHITECTURE architecture_computer_player_FSM OF g27_computer_player_FSM IS 
TYPE state_type is (s0, s1, s2, s3, s4);    -- State declaration
    SIGNAL state : state_type;          -- Init signal that uses the different states
    
BEGIN 

    g27_computer_FSM_process : PROCESS(clk, reset) -- Clock process
        BEGIN 
            IF (reset = '1') THEN   -- Triggered when reset is high
                state <= s0;

            ELSIF rising_edge(clk) THEN -- Triggered at rising edge of clock

                CASE state IS 
                    
                    WHEN s0 =>        -- Initial/idle state, wait for computer turn
                    -- IF request_deal is low, making sure FSM is going into the right states at the beginning
                    IF (computer_turn = '1') THEN
                        state       <= s1;
                    ELSE
                        state       <= s0;
                    END IF;

                    WHEN s1 =>        -- Sends a request_deal signal
                        -- IF request_deal is high
                        IF (computer_illegal_play = '1') AND (value_over_16 = '1') THEN
                            state       <= s2;  -- player wins
                        ELSIF (computer_illegal_play = '0') AND (value_over_16 = '1') AND (player_higher_dealer_hand = '1') THEN
                            state       <= s2;  -- player wins
                        ELSIF (computer_illegal_play = '0') AND (value_over_16 = '1') AND (player_higher_dealer_hand = '0') THEN
                            state       <= s3;  -- dealer wins
                        ELSE
                            state       <= s1;
                        END IF;
                    
                    WHEN s2 =>        -- Computer loses, sends also a new game signal to record the win/lose status
                            IF (over_3_wins = '1') THEN     -- check score, if player or computer has 3 wins, ends game
                                state       <= s4; -- ends game
                            ELSE
                                state       <= s0; -- start new round
                            END IF;

                    WHEN s3 =>        -- Computer wins, sends also a new game signal to record the win/lose status
                        IF (over_3_wins = '1') THEN     -- check score, if player or computer has 3 wins, ends game
                            state       <= s4; -- ends game
                        ELSE
                            state       <= s0; -- start new round
                        END IF;

                    WHEN s4 =>        -- remains in this state if reset hasn't been pressed after the end a game (best of 5 with 3 wins)
                        IF (reset = '1') THEN
                            state       <= s0; -- start new game
                        ELSE
                            state       <= s4; -- wait for reset 
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
                    computer_win_and_new_round      <= "00";
                    computer_init                   <= '0';
                    end_game                        <= '0';
                

                WHEN s1 =>                      -- Request deal
                    request_deal                    <= '1';
                    computer_win_and_new_round      <= "00";
                    computer_init                   <= '0';
                    end_game                        <= '0';

                WHEN s2 =>                      -- Computer loses                      
                    request_deal                    <= '0';
                    computer_win_and_new_round      <= "01";
                    computer_init                   <= '1';
                    end_game                        <= '0';

                WHEN s3 =>                      -- Computer wins
                    request_deal                    <= '0';
                    computer_win_and_new_round      <= "11";
                    computer_init                   <= '1';
                    end_game                        <= '0';
                
                WHEN s4 =>                      -- End of game
                    request_deal                    <= '0';
                    computer_win_and_new_round      <= "00";
                    computer_init                   <= '0';
                    end_game                        <= '1';

                WHEN others =>
                    request_deal                    <= '0';
                    computer_win_and_new_round      <= "00";
                    computer_init                   <= '0';
                    end_game                        <= '0';

            END CASE;
        
        END PROCESS;

END architecture_computer_player_FSM;