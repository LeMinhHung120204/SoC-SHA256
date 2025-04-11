library verilog;
use verilog.vl_types.all;
entity ch is
    port(
        e               : in     vl_logic_vector(31 downto 0);
        f               : in     vl_logic_vector(31 downto 0);
        g               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end ch;
