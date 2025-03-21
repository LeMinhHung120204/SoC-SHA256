module s0(
    input [31:0] X,
    output [31:0] Y
);
    assign Y = ( {X[6:0],X[31:7]} ^ {X[17:0],X[31:18]} ^ X>>3 );
endmodule
    
module s1(
    input [31:0] X,
    output [31:0] Y
);
    assign Y = ( {X[16:0],X[31:17]} ^ {X[18:0],X[31:19]} ^ X>>10 );
endmodule

// calculation Wi (16 <= i <= 63)
module w_new_calc(
    input [31:0] w_16,
    input [31:0] w_15,
    input [31:0] w_7,
    input [31:0] w_2,
    output [31:0] w_new
);
    
    wire [31:0] temp1, temp2;

    s0 s0(w_15, temp1);
    s1 s1(w_2, temp2);

    assign w_new = temp1 + temp2 + w_16 + w_7;
endmodule

module sha256(
	input clk,
   input rst,
	input	[255:0]	digest_in,
	input [511:0] message,
	output [255:0]	digest_out,
	output [255:0] hashvalue,
	output valid
);
	//Expander
	wire 	[31:0]  w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16;
	assign w1 = message[511:480];
	assign w2 = message[479:448];
	assign w3 = message[447:416];
	assign w4 = message[415:384];
	assign w5 = message[383:352];
	assign w6 = message[351:320];
	assign w7 = message[319:288];
	assign w8 = message[287:256];
	assign w9 = message[255:224];
	assign w10 = message[223:192];
	assign w11 = message[191:160];
	assign w12 = message[159:128];
	assign w13 = message[127:96];
	assign w14 = message[95:64];
	assign w15 = message[63:32];
	assign w16 = message[31:0];
	
	
	wire [31:0] k[0:63];
   assign k[00] = 32'h428a2f98;
   assign k[01] = 32'h71374491;
   assign k[02] = 32'hb5c0fbcf;
   assign k[03] = 32'he9b5dba5;
   assign k[04] = 32'h3956c25b;
   assign k[05] = 32'h59f111f1;
   assign k[06] = 32'h923f82a4;
   assign k[07] = 32'hab1c5ed5;
   assign k[08] = 32'hd807aa98;
   assign k[09] = 32'h12835b01;
   assign k[10] = 32'h243185be;
   assign k[11] = 32'h550c7dc3;
   assign k[12] = 32'h72be5d74;
   assign k[13] = 32'h80deb1fe;
   assign k[14] = 32'h9bdc06a7;
   assign k[15] = 32'hc19bf174;
   assign k[16] = 32'he49b69c1;
   assign k[17] = 32'hefbe4786;
   assign k[18] = 32'h0fc19dc6;
   assign k[19] = 32'h240ca1cc;
   assign k[20] = 32'h2de92c6f;
   assign k[21] = 32'h4a7484aa;
   assign k[22] = 32'h5cb0a9dc;
   assign k[23] = 32'h76f988da;
   assign k[24] = 32'h983e5152;
   assign k[25] = 32'ha831c66d;
   assign k[26] = 32'hb00327c8;
   assign k[27] = 32'hbf597fc7;
   assign k[28] = 32'hc6e00bf3;
   assign k[29] = 32'hd5a79147;
   assign k[30] = 32'h06ca6351;
   assign k[31] = 32'h14292967;
   assign k[32] = 32'h27b70a85;
   assign k[33] = 32'h2e1b2138;
   assign k[34] = 32'h4d2c6dfc;
   assign k[35] = 32'h53380d13;
   assign k[36] = 32'h650a7354;
   assign k[37] = 32'h766a0abb;
   assign k[38] = 32'h81c2c92e;
   assign k[39] = 32'h92722c85;
   assign k[40] = 32'ha2bfe8a1;
   assign k[41] = 32'ha81a664b;
   assign k[42] = 32'hc24b8b70;
   assign k[43] = 32'hc76c51a3;
   assign k[44] = 32'hd192e819;
   assign k[45] = 32'hd6990624;
   assign k[46] = 32'hf40e3585;
   assign k[47] = 32'h106aa070;
   assign k[48] = 32'h19a4c116;
   assign k[49] = 32'h1e376c08;
   assign k[50] = 32'h2748774c;
   assign k[51] = 32'h34b0bcb5;
   assign k[52] = 32'h391c0cb3;
   assign k[53] = 32'h4ed8aa4a;
   assign k[54] = 32'h5b9cca4f;
   assign k[55] = 32'h682e6ff3;
   assign k[56] = 32'h748f82ee;
   assign k[57] = 32'h78a5636f;
   assign k[58] = 32'h84c87814;
   assign k[59] = 32'h8cc70208;
   assign k[60] = 32'h90befffa;
   assign k[61] = 32'ha4506ceb;
   assign k[62] = 32'hbef9a3f7;
   assign k[63] = 32'hc67178f2;

   wire [31:0] h0, h1, h2, h3, h4, h5, h6, h7;
   assign h0 = 32'h6a09e667;
   assign h1 = 32'hbb67ae85;
   assign h2 = 32'h3c6ef372;
   assign h3 = 32'ha54ff53a;
   assign h4 = 32'h510e527f;
   assign h5 = 32'h9b05688c;
   assign h6 = 32'h1f83d9ab;
   assign h7 = 32'h5be0cd19;
	
	wire 	[31:0]  a, b, c, d, e, f, g, h;
	
	assign ch    = (e & f) ^ ((~e) & g);
	assign maj   = (a & b) ^ (a & c) ^ (b & c);
	
endmodule 