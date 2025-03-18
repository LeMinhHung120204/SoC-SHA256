// Cong 4 so cung luc
module Compressor(
	input [31:0] A, B, C, D, Cin,
	output [33:0]Sum
);
	wire [31:0] Cout_c;
	wire [31:0] cout_fa;
	wire [31:0] tmp_carry;
	wire [31:1] tmp_sum;
	
	compressor_1b c0(A[0], B[0], C[0], D[0], Cin, Sum[0], Cout_c[0], tmp_carry[0]);
	
	genvar i;
	generate
		for(i = 1; i < 32; i = i + 1) begin : array_compressor
			compressor_1b cn(A[i], B[i], C[i], D[i], Cout_c[i-1], tmp_sum[i], Cout_c[i], tmp_carry[i]);
			FA fa(tmp_carry[i-1], tmp_sum[i], i == 1 ? 1'b0 : cout_fa[i-1], Sum[i], cout_fa[i]);
		end
	endgenerate
	
	FA fa_n(tmp_carry[31], Cout_c[31], cout_fa[31], Sum[32], Sum[33]);
endmodule 

module compressor_1b(
	input A, B, C, D, Cin,
	output Sum, Cout, Carry
);
	wire xorAB, xorABCD;
	
	assign xorAB = A ^ B;
   assign xorABCD = A ^ B ^ C ^ D;
	
	assign Sum   = xorABCD ^ Cin;
	assign Cout  = (xorAB & C) | (~xorAB & A);
	assign Carry = (xorABCD & Cin) | (~xorABCD & D);
endmodule 

module FA(
	input a, b, cin,
	output sum, carry
);
	assign {carry, sum} = a + b + cin;
endmodule
