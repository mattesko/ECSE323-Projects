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
    BEGIN
   crc_table : lpm_rom
       GENERIC MAP (
			  LPM_WIDTHAD => 6,
           LPM_NUMWORDS => 64, -- sets the number of words stored in the ROM
           LPM_OUTDATA => "UNREGISTERED", -- no register on the output
           LPM_ADDRESS_CONTROL => "REGISTERED", -- register on the input
           LPM_FILE => "crc_rom.mif", -- the ascii file containing the ROM data
           LPM_WIDTH => 52)
       PORT MAP (
           inclock => clk,
           address => N,
           q => P_EN);
	END architecture_pop_enable;