library verilog;
use verilog.vl_types.all;
entity csa is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        c               : in     vl_logic_vector(31 downto 0);
        sum             : out    vl_logic_vector(31 downto 0);
        carry           : out    vl_logic
    );
end csa;
