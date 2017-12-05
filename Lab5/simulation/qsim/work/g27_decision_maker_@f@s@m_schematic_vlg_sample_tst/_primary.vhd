library verilog;
use verilog.vl_types.all;
entity g27_decision_maker_FSM_schematic_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        COMPUTER_HAND   : in     vl_logic_vector(4 downto 0);
        COMPUTER_LP     : in     vl_logic;
        EN_DECISION     : in     vl_logic;
        PLAYER_H        : in     vl_logic_vector(4 downto 0);
        PLAYER_LP       : in     vl_logic;
        RESET           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end g27_decision_maker_FSM_schematic_vlg_sample_tst;
