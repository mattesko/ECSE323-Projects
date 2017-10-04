library verilog;
use verilog.vl_types.all;
entity g27_8bit_adder_vlg_check_tst is
    port(
        Cout            : in     vl_logic;
        S               : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end g27_8bit_adder_vlg_check_tst;
