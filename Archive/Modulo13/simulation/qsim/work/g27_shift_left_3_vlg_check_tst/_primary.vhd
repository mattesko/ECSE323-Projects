library verilog;
use verilog.vl_types.all;
entity g27_shift_left_3_vlg_check_tst is
    port(
        S               : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end g27_shift_left_3_vlg_check_tst;
