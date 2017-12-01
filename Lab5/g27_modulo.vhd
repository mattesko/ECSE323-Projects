-- this vhdl description implements a modulo depending on the input for a 21 card game
--
-- entity name: g27_modulo
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 01/12/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g27_modulo IS
    PORT
    (
        input_num           : in  std_logic_vector (5 downto 0);
        input_modulo        : in  std_logic_vector (5 downto 0);
		  clk						 : in  std_logic;
        output_modulo       : out std_logic_vector (5 downto 0)
    );
    END g27_modulo;

ARCHITECTURE modulo_architecture OF g27_modulo IS 

    SIGNAL input_num_arith       : INTEGER;
    SIGNAL input_modulo_arith    : INTEGER;
    SIGNAL output_modulo_arith	: INTEGER;

    BEGIN
			input_num_arith <= to_integer(unsigned(input_num));
			input_modulo_arith <= to_integer(unsigned(input_modulo));
			
			g27_modulo_operator_process : PROCESS(clk) -- Clock process
				BEGIN
					IF rising_edge(clk) THEN						
						output_modulo_arith <= input_num_arith mod input_modulo_arith;
					END IF;
				END PROCESS;
				
			output_modulo <= std_logic_vector(to_unsigned(output_modulo_arith, output_modulo'length));
			
	 END modulo_architecture;