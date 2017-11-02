-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Wed Nov 01 22:31:02 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
-- use the following when compiling in Quartus II
--LIBRARY lpm;
--USE lpm.lpm_components.all; 

-- use the following when compiling in third party tools --
-- add lpm_pack.vhd from the Quartus II library
LIBRARY work;
USE work.lpm_components.all;

ENTITY lpm_mux_6 IS 
PORT 
( 
	data	:	IN	 STD_LOGIC_2D(51 DOWNTO 0 , 5 DOWNTO 0);
	sel	:	IN	 STD_LOGIC_VECTOR(5 DOWNTO 0)
); 
END lpm_mux_6;

ARCHITECTURE bdf_type OF lpm_mux_6 IS 
BEGIN 

-- instantiate LPM macrofunction 

b2v_inst22 : lpm_mux
GENERIC MAP(LPM_SIZE => 52,
			LPM_WIDTH => 6,
			LPM_WIDTHS => 6)
PORT MAP(data => data,
		 sel => sel,
);

END bdf_type; 