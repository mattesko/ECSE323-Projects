library verilog;
use verilog.vl_types.all;
entity testing2_vlg_check_tst is
    port(
        S               : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end testing2_vlg_check_tst;
