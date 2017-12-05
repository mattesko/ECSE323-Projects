library verilog;
use verilog.vl_types.all;
entity g27_decision_maker_FSM_schematic_vlg_check_tst is
    port(
        COMPUTER_W      : in     vl_logic_vector(1 downto 0);
        ENDGAME_OUT     : in     vl_logic;
        PLAYER_W        : in     vl_logic_vector(1 downto 0);
        sampler_rx      : in     vl_logic
    );
end g27_decision_maker_FSM_schematic_vlg_check_tst;
