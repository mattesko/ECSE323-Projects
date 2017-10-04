library verilog;
use verilog.vl_types.all;
entity g27_adder_vlg_check_tst is
    port(
        Cout            : in     vl_logic;
        S               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end g27_adder_vlg_check_tst;
