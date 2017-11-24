-- this circuit implements a 7 segment LED display decoder/driver
--
-- entity name: g27_7_segment_decoder
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 18/10/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;

ENTITY g27_7_segment_decoder IS

    PORT ( 
        code            : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        mode            : IN STD_LOGIC;
        segments_out    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));

END g27_7_segment_decoder;

ARCHITECTURE architecture_7_segment_decoder OF g27_7_segment_decoder IS

    SIGNAL xcode : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
        xcode(4 DOWNTO 1)   <= code;
        xcode(0)            <= mode;

        WITH xcode SELECT
            segments_out <=
                "1000000" when "00000", -- code = 0, mode = 0
		"0001000" when "00001", -- code = 0, mode = 1
		"1111001" WHEN "00010", -- code = 1, mode = 0
		"0100100" WHEN "00011", -- code = 1, mode = 1
		"0100100" WHEN "00100", -- code = 2, mode = 0
		"0110000" WHEN "00101", -- code = 2, mode = 1
		"0110000" WHEN "00110", -- code = 3, mode = 0
		"0011001" WHEN "00111", -- code = 3, mode = 1
		"0011001" WHEN "01000", -- code = 4, mode = 0 
		"0010010" WHEN "01001", -- code = 4, mode = 1
		"0010010" WHEN "01010", -- code = 5, mode = 0
		"0000010" WHEN "01011", -- code = 5, mode = 1
		"0000010" WHEN "01100", -- code = 6, mode = 0
		"1111000" WHEN "01101", -- code = 6, mode = 1
		"1111000" WHEN "01110", -- code = 7, mode = 0
		"0000000" WHEN "01111", -- code = 7, mode = 1
		"0000000" WHEN "10000", -- code = 8, mode = 0
		"0010000" WHEN "10001", -- code = 8, mode = 1
		"0010000" WHEN "10010", -- code = 9, mode = 0
		"1000000" WHEN "10011", -- code = 9, mode = 1
		"0001000" WHEN "10100", -- code = 10, mode = 0
		"1100001" WHEN "10101", -- code = 10, mode = 1
		"0000011" WHEN "10110", -- code = 11, mode = 0
		"0100011" WHEN "10111", -- code = 11, mode = 1
		"1000110" WHEN "11000", -- code = 12, mode = 0
		"0001001" WHEN "11001", -- code = 12, mode = 1
		"0100001" WHEN "11010", -- code = 13, mode = 0
		"0111111" WHEN "11011", -- code = 13, mode = 1
		"0000110" WHEN "11100", -- code = 14, mode = 0
		"0111111" WHEN "11101", -- code = 14, mode = 1
		"0001110" WHEN "11110", -- code = 15, mode = 0
		"0111111" WHEN "11111", -- code = 15, mode = 1
		"1111111" WHEN OTHERS;
            
END architecture_7_segment_decoder;