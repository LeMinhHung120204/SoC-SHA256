module sha256(
    input wire clk,
    input wire reset,
    input wire [127:0] data_in,
    input wire write_en,
    output wire [255:0] data_out,
    output wire valid_out
);

	reg [511:0] buffer;  // Thanh ghi lưu 512-bit
	reg [1:0] counter;   // Đếm số lần ghi (0 -> 3)
	reg valid_in;        // Tín hiệu kích hoạt sha_core khi đủ 512-bit
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			buffer <= 512'b0;
			counter <= 2'b00;
			valid_in <= 1'b0;
		end else if (write_en) begin
			// Dịch 128-bit vào thanh ghi buffer
			buffer <= {buffer[383:0], data_in};
			counter <= counter + 2'b01;
			
			if (counter == 2'b11) begin
				valid_in <= 1'b1; // Báo hiệu buffer đã đầy
			end else begin
				valid_in <= 1'b0;
			end
		end
	end

	// Kết nối với module sha_core
	/*sha_core sha1 (
		.clk(clk),
		.reset(reset),
		.data_in(buffer),  // Đưa dữ liệu 512-bit vào
		.valid_in(valid_in),
		.data_out(data_out),
		.valid_out(valid_out)
	);*/

endmodule
