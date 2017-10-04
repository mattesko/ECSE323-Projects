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
-- CREATED		"Tue Sep 26 14:06:33 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY g27_lab1 IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		AeqB :  OUT  STD_LOGIC
	);
END g27_lab1;

ARCHITECTURE bdf_type OF g27_lab1 IS 

COMPONENT g27_comp7
	PORT(A : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 AeqB : OUT STD_LOGIC
	);
END COMPONENT;



BEGIN 



b2v_inst : g27_comp7
PORT MAP(A => A,
		 B => B,
		 AeqB => AeqB);


END bdf_type;