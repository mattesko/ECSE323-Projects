library verilog;
use verilog.vl_types.all;
entity g27_modulo is
    port(
        input_num       : in     vl_logic_vector(5 downto 0);
        input_modulo    : in     vl_logic_vector(5 downto 0);
        clk             : in     vl_logic;
        output_modulo   : out    vl_logic_vector(5 downto 0)
    );
end g27_modulo;
