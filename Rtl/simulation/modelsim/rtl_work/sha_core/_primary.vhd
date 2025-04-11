library verilog;
use verilog.vl_types.all;
entity sha_core is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        write_en        : in     vl_logic;
        data_in         : in     vl_logic_vector(127 downto 0);
        hashvalue       : out    vl_logic_vector(255 downto 0);
        valid           : out    vl_logic
    );
end sha_core;
