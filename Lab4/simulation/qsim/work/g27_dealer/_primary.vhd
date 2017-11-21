library verilog;
use verilog.vl_types.all;
entity g27_dealer is
    port(
        request_deal    : in     vl_logic;
        rand_lt_num     : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        rand_enable     : out    vl_logic;
        stack_enable    : out    vl_logic
    );
end g27_dealer;
