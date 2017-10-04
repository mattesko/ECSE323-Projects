library verilog;
use verilog.vl_types.all;
entity g27_6bit_adder is
    port(
        Cout            : out    vl_logic;
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        S               : out    vl_logic_vector(5 downto 0)
    );
end g27_6bit_adder;
