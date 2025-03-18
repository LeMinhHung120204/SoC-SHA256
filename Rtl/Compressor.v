// chua xong
module Compressor(
	input [31:0] A, B, C, D, Cin,
	output [31:0]Sum,
	output Carry
);
	wire [31:0] Cout_c;
	wire [31:0] cout_fa;
	wire [31:0] tmp_carry;
	wire [31:1] tmp_sum;
	
	compressor_1b c0(
		.A(A[0]),
		.B(B[0]),
		.C(C[0]),
		.D(D[0]),
		.Cin(Cin),
		.Sum(Sum[0]),
		.Cout(Cout_c[0]),
		.Carry(tmp_carry[0])
	);
	
	genvar i;
	generate
		for(i = 1; i < 32; i = i + 1) begin : array_compressor
			compressor_1b Cn(
				.A(A[i]),
				.B(B[i]),
				.C(C[i]),
				.D(D[i]),
				.Cin(Cout_c[i - 1]),
				.Sum(tmp_sum[i]),
				.Cout(Cout_c[i]),
				.Carry(tmp_carry[i])
			);
			
			FA fa(
				.a(tmp_carry[i - 1]),
				.b(tmp_sum[i]),
				.cin(i == 1 ? 1'b0 : cout_fa[i - 1]),
				.sum(Sum[i]),
				.carry(cout_fa[i])
			);
		end
	endgenerate
	
	assign Carry = cout_fa[31];
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
