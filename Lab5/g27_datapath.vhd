-- entity name: gA6_datapath
--
-- Copyright (C) 2017 Abbas Yadollahi - He Qian Wang
-- Version 1.0
-- Author: Abbas Yadollahi (abbas.yadollahi@mail.mcgill.ca)
--         He Qian Wang (he.q.wang@mail.mcgill.ca)
-- Date: Nov/29/2017

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity g27_datapath is
	port(
		clk				: in std_logic;
		rst				: in std_logic;
		p_win				: in std_logic;
		d_win				: in std_logic;
		new_game			: in std_logic;
		player_hit		: in std_logic;
		player_stay		: in std_logic;
		player_stack	: in std_logic;
		dealer_stack	: in std_logic;
		player_sum		: in std_logic_vector(5 downto 0);

		d_setup			: out std_logic;
		player_draw		: out std_logic;
		computer_turn	: out std_logic;
		stack_mode		: out std_logic_vector(1 downto 0);
		p_win_streak	: out std_logic_vector(1 downto 0);
		d_win_streak	: out std_logic_vector(1 downto 0);
		game_score		: out std_logic_vector(3 downto 0);
		p_sum_out		: out std_logic_vector(5 downto 0)
		--state_out		: out std_logic_vector(3 downto 0)
	);
end g27_datapath;

architecture behavior of g27_datapath is
	begin
		datapath: process(clk, rst, p_win, d_win, new_game, player_hit, player_stay, player_stack, dealer_stack, player_sum)

		variable p_setup		: std_logic;
		variable p_win_count	: unsigned(1 downto 0);
		variable d_win_count	: unsigned(1 downto 0);
		variable game_count	: unsigned(3 downto 0);
		variable state			: std_logic_vector(3 downto 0);

		begin
			-- Reset is on
			if rst = '1' then
				d_setup <= '0';
				stack_mode <= "11";
				player_draw <= '0';
				computer_turn <= '0';
				p_sum_out <= "000000";

				state := "0000";
				p_setup := '0';
				p_win_count := to_unsigned(0, 2);
				d_win_count := to_unsigned(0, 2);
				game_count := to_unsigned(0, 4);
			elsif rising_edge(clk) then
				stack_mode <= "10";

				case state is
					-- State A/0000
					-- Wait for new game
					when "0000" =>
						stack_mode <= "11";
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= "000000";

						if new_game = '1' then
							player_draw <= '1';
							state := "0001";
						end if;

					-- State B/0001
					-- Setup player's hand
					when "0001" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						if player_stack = '1' then
							if p_setup = '0' then
								player_draw <= '1';
								p_setup := '1';
							else
								d_setup <= '1';
								state := "0010";
							end if;
						end if;

					-- State C/0010
					-- Setup computer
					when "0010" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						if dealer_stack = '1' then
							state := "0011";
						end if;

					-- State D/0011
					-- Player's turn to hit/stay/bust
					when "0011" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						if unsigned(player_sum) > 21 or player_stay = '1' then
							player_draw <= '0';
							state := "0100";
						elsif player_hit = '1' then
							player_draw <= '1';
						end if;

					-- State E/0100
					-- Computer's turn
					when "0100" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '1';
						p_sum_out <= player_sum;

						state := "0101";

					-- State F/0101
					-- Receive winner
					when "0101" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						if p_win = '1' or d_win = '1' then
							if p_win = '1' and d_win = '0' then
								p_win_count := p_win_count + 1;
							elsif p_win = '0' and d_win = '1' then
								d_win_count := d_win_count + 1;
							end if;

							state := "0110";
						end if;

					-- State G/0110
					-- Update score and prepare for new game
					when "0110" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						game_count := game_count + 1;
						if p_win_count > 2 or d_win_count > 2 then
							state := "0111";
						else
							state := "0000";
						end if;

					-- State H/0111
					-- Wait for rst (Fresh game)
					when "0111" =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= player_sum;

						if rst = '1' then
							state := "0000";
							p_win_count := to_unsigned(0, 2);
							d_win_count := to_unsigned(0, 2);
							game_count := to_unsigned(0, 4);
						end if;

					-- Random State
					when others =>
						d_setup <= '0';
						player_draw <= '0';
						computer_turn <= '0';
						p_sum_out <= "000000";

						state := "0000";
						p_setup := '0';
						p_win_count := to_unsigned(0, 2);
						d_win_count := to_unsigned(0, 2);
						game_count := to_unsigned(0, 4);
				end case;
			end if;

			p_win_streak <= std_logic_vector(p_win_count);
			d_win_streak <= std_logic_vector(d_win_count);
			game_score <= std_logic_vector(game_count);
			--state_out <= state;
		end process;
end behavior;