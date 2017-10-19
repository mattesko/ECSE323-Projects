-- this vhdl description implements the pop-enable circuit for a card game
--
-- entity name: g27_pop_enable
--
-- Copyright (C) 2017 Matthew Lesko-Krleza and Romain Nith
-- Version 1.0
-- Author: Matthew Lesko-Krleza 260692352, matthew.lesko-krleza@mail.mcgill.ca 
--         Romain Nith 260571471, romain.nith@mail.mcgill.ca
-- Date: 18/10/17

library ieee; -- allows use of the std_logic_vectory type
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

ENTITY g27_pop_enable IS 
    PORT ( 
        clk : IN STD_LOGIC;
        N : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        P_EN : OUT STD_LOGIC_VECTOR(51 DOWNTO 0));
    END g27_pop_enable;

ARCHITECTURE architecture_pop_enable OF g27_pop_enable IS
	-- lpm_add_sub component paramter and port declarations
	COMPONENT lpm_rom
		PORT (
			inclock : IN STD_LOGIC;
			address : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			q : IN STD_LOGIC_VECTOR(51 DOWNTO 0));
	END COMPONENT;
	
    BEGIN
	
   crc_table : lpm_rom
       GENERIC MAP (
           lpm_widthad => 7, -- sets width of the ROM address bus
           lpm_numwords => 128, -- sets the number of words stored in the ROM
           lpm_outdata => "UNREGISTERED", -- no register on the output
           lpm_address_control => "REGISTERED", -- register on the input
           lpm_file => "crc_rom.mif", -- the ascii file containing the ROM data
           lpm_width => 8) -- the width of the word stored in each ROM location
       PORT MAP (
           inclock => clk,
           address => N,
           q => P_EN);
	END architecture_pop_enable;