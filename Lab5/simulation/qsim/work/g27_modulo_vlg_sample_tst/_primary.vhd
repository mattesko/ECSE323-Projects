library verilog;
use verilog.vl_types.all;
entity g27_modulo_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        input_modulo    : in     vl_logic_vector(5 downto 0);
        input_num       : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end g27_modulo_vlg_sample_tst;
