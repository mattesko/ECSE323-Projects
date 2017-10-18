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
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"
-- CREATED		"Wed Oct 18 18:01:50 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY g27_Modulo_13 IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		O :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END g27_Modulo_13;

ARCHITECTURE bdf_type OF g27_Modulo_13 IS 

COMPONENT g27_8bit_adder
	PORT(Cin : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Cout : OUT STD_LOGIC;
		 S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	0 :  STD_LOGIC;
SIGNAL	1 :  STD_LOGIC;
SIGNAL	C :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	D :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	E :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	O_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	zero :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_3 <= (zero(2 DOWNTO 0) & C(8 DOWNTO 6) & zero(1 DOWNTO 0));
GDFX_TEMP_SIGNAL_2 <= (zero(1 DOWNTO 0) & C(8 DOWNTO 6) & zero(2 DOWNTO 0));
GDFX_TEMP_SIGNAL_4 <= (zero(4 DOWNTO 0) & C(8 DOWNTO 6));
GDFX_TEMP_SIGNAL_1 <= (zero(1 DOWNTO 0) & A(5 DOWNTO 0));
GDFX_TEMP_SIGNAL_5 <= (zero(1 DOWNTO 0) & A(5 DOWNTO 0));
GDFX_TEMP_SIGNAL_0 <= (A(5 DOWNTO 0) & zero(1 DOWNTO 0));



b2v_inst1 : g27_8bit_adder
PORT MAP(Cin => 0,
		 A => GDFX_TEMP_SIGNAL_0,
		 B => GDFX_TEMP_SIGNAL_1,
		 Cout => C(8),
		 S => C(7 DOWNTO 0));


b2v_inst2 : g27_8bit_adder
PORT MAP(Cin => 0,
		 A => GDFX_TEMP_SIGNAL_2,
		 B => GDFX_TEMP_SIGNAL_3,
		 S => D);


b2v_inst3 : g27_8bit_adder
PORT MAP(Cin => 0,
		 A => D,
		 B => GDFX_TEMP_SIGNAL_4,
		 S => E);


b2v_inst4 : g27_8bit_adder
PORT MAP(Cin => 1,
		 A => SYNTHESIZED_WIRE_0,
		 B => GDFX_TEMP_SIGNAL_5,
		 S => O_ALTERA_SYNTHESIZED);



SYNTHESIZED_WIRE_0 <= NOT(E);



O(3 DOWNTO 0) <= O_ALTERA_SYNTHESIZED(3 DOWNTO 0);

0 <= '0';
1 <= '1';
END bdf_type;