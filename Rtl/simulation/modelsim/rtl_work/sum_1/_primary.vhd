library verilog;
use verilog.vl_types.all;
entity sum_1 is
    port(
        e               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end sum_1;
