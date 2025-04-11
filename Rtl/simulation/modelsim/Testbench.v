`timescale 1ns/1ps

module Testbench();
	// Tín hi?u ?i?u khi?n và d? li?u
	reg clk;
	reg clr;
	reg write_en;
	reg [127:0] data_in;
	wire [255:0] hashvalue;
	wire valid;

	// SHA Core wrapper: B?n c?n wrapper x? lý buffer và start t? 4 l?n ghi
	sha_wrapper dut (
	.clk(clk),
	.clr(clr),
	.write_en(write_en),
	.data_in(data_in),
	.hashvalue(hashvalue),
	.valid(valid)
	);

	// Clock generator: 10ns period
	always #5 clk = ~clk;

	// Test logic
	initial begin
		// Init
		clk = 0;
		clr = 0;
		write_en = 0;
		data_in = 128'd0;

		// Reset
		#10;
		clr = 1;

		// G?i 512 bit message ("abc" v?i padding)
		// SHA-256 input: "abc" = 616263
		// Padded full message: 512-bit = 4x128-bit
		write_en = 1;
		data_in = 128'h61626380_00000000_00000000_00000000; // 1st 128-bit
		#10;
		data_in = 128'h00000000_00000000_00000000_00000000; // 2nd 128-bit
		#10;
		data_in = 128'h00000000_00000000_00000000_00000000; // 3rd 128-bit
		#10;
		data_in = 128'h00000000_00000000_00000000_00000018; // 4th 128-bit (message length: 0x18 bits)

		// T?t write_en
		#10;
		write_en = 0;

		// ??i cho t?i khi valid
		wait (valid == 1);
		$display("SHA-256 Hash Output: %h", hashvalue);

		#10;
		$finish;
	end
endmodule
