library verilog;
use verilog.vl_types.all;
entity rand_modulo_test_vlg_check_tst is
    port(
        PROB            : in     vl_logic_vector(5 downto 0);
        RANDFINAL       : in     vl_logic_vector(5 downto 0);
        sampler_rx      : in     vl_logic
    );
end rand_modulo_test_vlg_check_tst;
