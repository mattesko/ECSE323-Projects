library verilog;
use verilog.vl_types.all;
entity rand_modulo_test is
    port(
        PROB            : out    vl_logic_vector(5 downto 0);
        CLK             : in     vl_logic;
        RANDFINAL       : out    vl_logic_vector(5 downto 0);
        NUM             : in     vl_logic_vector(5 downto 0)
    );
end rand_modulo_test;
