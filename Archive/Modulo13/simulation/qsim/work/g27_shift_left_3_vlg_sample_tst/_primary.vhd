library verilog;
use verilog.vl_types.all;
entity g27_shift_left_3_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end g27_shift_left_3_vlg_sample_tst;
