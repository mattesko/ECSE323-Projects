library verilog;
use verilog.vl_types.all;
entity rand_modulo_test_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        NUM             : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end rand_modulo_test_vlg_sample_tst;
