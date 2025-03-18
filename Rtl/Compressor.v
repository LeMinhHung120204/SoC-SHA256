module Compressor(
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