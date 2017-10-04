library verilog;
use verilog.vl_types.all;
entity testing is
    port(
        Cout            : out    vl_logic;
        A               : in     vl_logic_vector(7 downto 0);
        S               : out    vl_logic_vector(7 downto 0)
    );
end testing;
