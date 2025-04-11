module sha256 (
	input iClk, 
	input iReset_n,
	input iChipSelect_n,
	input iWrite_n,
	input iRead_n,
	input start,
	input [4:0] iAddress,
	input [31:0] iData,
	output reg [31:0] oData
);
	reg [511:0] buffer;       // Tổng 512-bit dữ liệu
	wire [255:0] hash_out;

	always @(posedge iClk or negedge iReset_n) begin
		if (!iReset_n) begin
			buffer <= 512'd0;
			oData <= 32'd0;
		end else begin
			if (~iChipSelect_n && ~iWrite_n) begin
				case(iAddress)
					5'd0:	buffer[31:0]		<= iData[31:0];
					5'd1:	buffer[63:32]		<= iData[31:0];
					5'd2: buffer[95:64]		<= iData[31:0];
					5'd3: buffer[127:96]		<= iData[31:0];
					5'd4: buffer[159:128]	<= iData[31:0];
					5'd5: buffer[191:160]	<= iData[31:0];
					5'd6: buffer[223:192]	<= iData[31:0];
					5'd7: buffer[255:224]	<= iData[31:0];
					5'd8: buffer[287:256]	<= iData[31:0];
					5'd9: buffer[319:288]	<= iData[31:0];
					5'd10: buffer[351:320]	<= iData[31:0];
					5'd11: buffer[383:352]	<= iData[31:0];
					5'd12: buffer[415:384]	<= iData[31:0];
					5'd13: buffer[447:416]	<= iData[31:0];
					5'd14: buffer[479:448]	<= iData[31:0];
					5'd15: buffer[511:480]	<= iData[31:0];

					default: buffer <= buffer;

				endcase
			end

			if (~iChipSelect_n && ~iRead_n) begin
				case (iAddress)
				// Đọc buffer (512-bit input)
					5'd0: oData		<= buffer[31:0];
					5'd1: oData		<= buffer[63:32];
					5'd2: oData		<= buffer[95:64];
					5'd3: oData		<= buffer[127:96];
					5'd4: oData		<= buffer[159:128];
					5'd5: oData		<= buffer[191:160];
					5'd6: oData		<= buffer[223:192];
					5'd7: oData		<= buffer[255:224];
					5'd8: oData		<= buffer[287:256];
					5'd9: oData		<= buffer[319:288];
					5'd10: oData	<= buffer[351:320];
					5'd11: oData	<= buffer[383:352];
					5'd12: oData	<= buffer[415:384];
					5'd13: oData	<= buffer[447:416];
					5'd14: oData	<= buffer[479:448];
					5'd15: oData	<= buffer[511:480];
					
					// Đọc hash_out (256-bit output)
					5'd16: oData <= hash_out[31:0];
					5'd17: oData <= hash_out[63:32];
					5'd18: oData <= hash_out[95:64];
					5'd19: oData <= hash_out[127:96];
					5'd20: oData <= hash_out[159:128];
					5'd21: oData <= hash_out[191:160];
					5'd22: oData <= hash_out[223:192];
					5'd23: oData <= hash_out[255:224];
					
					default: oData <= 32'd0;
				endcase
			end
		end
	end
	
	// Module SHA core
	wire done;
	sha_core core (
		.clk(iClk),
		.clr(iReset_n),
		.start(start),
		.message(buffer),
		.hashvalue(hash_out),
		.valid(done)
	);
endmodule
