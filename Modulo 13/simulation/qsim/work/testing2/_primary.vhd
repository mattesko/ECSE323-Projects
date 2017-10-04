library verilog;
use verilog.vl_types.all;
entity testing2 is
    port(
        S               : out    vl_logic_vector(7 downto 0);
        \IN\            : in     vl_logic_vector(5 downto 0)
    );
end testing2;
