library verilog;
use verilog.vl_types.all;
entity g27_shift_left_3 is
    port(
        S               : out    vl_logic_vector(7 downto 0);
        A               : in     vl_logic_vector(7 downto 0)
    );
end g27_shift_left_3;
