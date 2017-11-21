-- this vhdl description implements the Card Dealer circuit for a 21 card game
--
-- entity name: g27_dealer
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 21/11/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all
library lpm;
use lpm.lpm_components.all;


ENTITY g27_dealer IS
    PORT
    (
        request_deal    : in  std_logic;
        rand_lt_num     : in  std_logic;
        reset           : in  std_logic;
        clk             : in  std_logic;
        rand_enable     : out std_logic;
        stack_enable    : out std_logic
    );
    END g27_dealer;

ARCHITECTURE architecture_dealer OF g27_dealer IS 
TYPE state_type is (s0, s1, s2);    -- State declaration
    SIGNAL state : state_type;      -- Init signal that uses the different states
    
BEGIN 

    g27_dealer_process : PROCESS(clk, reset) -- Clock process
        BEGIN 
            IF (reset = '1') THEN   -- Triggered when reset is high
                state <= s0;

            ELSIF rising_edge(clk) THEN -- Triggered at rising edge of clock

                CASE state IS 
                
                    WHEN s0 =>        -- Initial/Reset state
                        -- IF request_deal is high
                        IF (request_deal = '1') THEN
                            state       <= s1;
                        ELSE
                            state       <= s0;
                        END IF;
                    
                    WHEN s1 =>        -- Sends out RAND_ENABLE
                        -- IF output of RANDU is greater or equal to NUM
                        IF (rand_lt_num = '1') THEN
                            state       <= s2;
                        ELSE
                            state       <= s1;
                        END IF;

                    WHEN s2 =>        -- Sends out STACK_ENABLE
                        state <= s0;  -- Go back to state s0 when done

                    WHEN others =>
                        state <= s0;

                END CASE;

            END IF;

        END PROCESS;

    output_process : PROCESS(state)
        BEGIN

            CASE state is

                WHEN s0 => 
                    rand_enable     <= '0';
                    stack_enable    <= '0';

                WHEN s1 =>                        
                    rand_enable     <= '1';
                    stack_enable    <= '0';

                WHEN s2 =>
                    rand_enable     <= '0';
                    stack_enable    <= '1';

                WHEN others =>
                    rand_enable     <= '0';
                    stack_enable    <= '0';

            END CASE;
        
        END PROCESS;

END architecture_dealer;