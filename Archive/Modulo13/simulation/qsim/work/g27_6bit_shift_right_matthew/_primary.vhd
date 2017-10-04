library verilog;
use verilog.vl_types.all;
entity g27_6bit_shift_right_matthew is
    port(
        S               : out    vl_logic_vector(7 downto 0);
        A               : in     vl_logic_vector(7 downto 0)
    );
end g27_6bit_shift_right_matthew;
