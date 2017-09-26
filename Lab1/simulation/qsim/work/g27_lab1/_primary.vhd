library verilog;
use verilog.vl_types.all;
entity g27_lab1 is
    port(
        AeqB            : out    vl_logic;
        A               : in     vl_logic_vector(6 downto 0);
        B               : in     vl_logic_vector(6 downto 0)
    );
end g27_lab1;
