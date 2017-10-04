library verilog;
use verilog.vl_types.all;
entity g27_6bit_adder_vlg_check_tst is
    port(
        Cout            : in     vl_logic;
        S               : in     vl_logic_vector(5 downto 0);
        sampler_rx      : in     vl_logic
    );
end g27_6bit_adder_vlg_check_tst;
