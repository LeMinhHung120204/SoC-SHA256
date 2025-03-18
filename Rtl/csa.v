module csa(
	input [31:0] a, b, c,
	output [31:0] sum,
	output carry
);
	wire [31:0] tmp1, tmp2;
	genvar i;
   generate
       for (i = 0; i < 32; i = i + 1) begin: fa_array
           FA3 fa_inst (
               .a(a[i]), 
               .b(b[i]), 
               .c(c[i]), 
               .sum(tmp1[i]), 
               .carry(tmp2[i])
           );
       end
	endgenerate
	assign {carry, sum} = {tmp2[30:0], 1'b0} + tmp1;
endmodule 

module FA3(
	input a, b, c,
	output sum, carry
);
	assign sum   = a ^ b ^ c;
   assign carry = (a & b) | (b & c) | (a & c);
endmodule 