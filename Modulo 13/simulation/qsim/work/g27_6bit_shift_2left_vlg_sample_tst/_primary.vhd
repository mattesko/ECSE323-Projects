library verilog;
use verilog.vl_types.all;
entity g27_6bit_shift_2left_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end g27_6bit_shift_2left_vlg_sample_tst;
