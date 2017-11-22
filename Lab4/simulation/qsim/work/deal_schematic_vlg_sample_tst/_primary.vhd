library verilog;
use verilog.vl_types.all;
entity deal_schematic_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        rand_lt_num     : in     vl_logic;
        request_deal    : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end deal_schematic_vlg_sample_tst;
