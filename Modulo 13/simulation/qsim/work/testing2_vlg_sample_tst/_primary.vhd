library verilog;
use verilog.vl_types.all;
entity testing2_vlg_sample_tst is
    port(
        \IN\            : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end testing2_vlg_sample_tst;
