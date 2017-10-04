library verilog;
use verilog.vl_types.all;
entity testing_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end testing_vlg_sample_tst;
