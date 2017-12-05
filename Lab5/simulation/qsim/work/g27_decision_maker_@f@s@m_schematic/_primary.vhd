library verilog;
use verilog.vl_types.all;
entity g27_decision_maker_FSM_schematic is
    port(
        ENDGAME_OUT     : out    vl_logic;
        RESET           : in     vl_logic;
        CLK             : in     vl_logic;
        EN_DECISION     : in     vl_logic;
        COMPUTER_LP     : in     vl_logic;
        PLAYER_LP       : in     vl_logic;
        COMPUTER_HAND   : in     vl_logic_vector(4 downto 0);
        PLAYER_H        : in     vl_logic_vector(4 downto 0);
        COMPUTER_W      : out    vl_logic_vector(1 downto 0);
        PLAYER_W        : out    vl_logic_vector(1 downto 0)
    );
end g27_decision_maker_FSM_schematic;
