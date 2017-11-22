library verilog;
use verilog.vl_types.all;
entity deal_schematic is
    port(
        rand_enable     : out    vl_logic;
        request_deal    : in     vl_logic;
        rand_lt_num     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        stack_enable    : out    vl_logic
    );
end deal_schematic;
