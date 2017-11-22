library verilog;
use verilog.vl_types.all;
entity deal_schematic_vlg_check_tst is
    port(
        rand_enable     : in     vl_logic;
        stack_enable    : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end deal_schematic_vlg_check_tst;
