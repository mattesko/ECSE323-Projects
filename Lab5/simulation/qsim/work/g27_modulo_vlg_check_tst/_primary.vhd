library verilog;
use verilog.vl_types.all;
entity g27_modulo_vlg_check_tst is
    port(
        output_modulo   : in     vl_logic_vector(5 downto 0);
        sampler_rx      : in     vl_logic
    );
end g27_modulo_vlg_check_tst;
