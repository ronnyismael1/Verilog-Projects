module GPFullAdder(Ai, Bi, Cin, G, P, Sum); 
	input Ai, Bi, Cin;
	output G, P, Sum;

	assign G = Ai & Bi;
	assign P = Ai ^ Bi;
	assign Sum = P ^ Cin;
endmodule

module CLALogic(G, P, Ci, C, Co, PG, GG);
	input [3:0] G, P, Ci;
	output [3:0] C;
	output Co, PG, GG;

	assign C[0] = G[0] | (P[0] & Ci[0]);
	assign C[1] = G[1] | (P[1] & (Ci[1] | G[0]));
	assign C[2] = G[2] | (P[2] & (Ci[2] | G[1] | (P[0] & Ci[1])));
	assign C[3] = G[3] | (P[3] & (Ci[3] | G[2] | (P[1] & (Ci[2] | G[0]))));

	assign Co = C[3];
	assign PG = G[0] & G[1] & G[2] & G[3];
	assign GG = (G[0] & G[1]) | (G[0] & G[2]) | (G[0] & G[3]) | (G[1] & G[2]) | (G[1] & G[3]) | (G[2] & G[3]);
endmodule

module CLA4(A, B, Ci, S, Co, PG, GG);
	input [3:0] A, B;
	input Ci;
	output [3:0] S;
	output Co, PG, GG;
	//wire [3:0] G, P, C;
	wire [3:0] G, P;
	wire [2:0] C;

	GPFullAdder fa0(A[0], B[0], Ci, G[0], P[0], S[0]);
	GPFullAdder fa1(A[1], B[1], G[0], G[1], P[1], S[1]);
	GPFullAdder fa2(A[2], B[2], G[1], G[2], P[2], S[2]);
	GPFullAdder fa3(A[3], B[3], G[2], G[3], P[3], S[3]);

	CLALogic cl(G, P, Ci, C, Co, PG, GG);
endmodule
