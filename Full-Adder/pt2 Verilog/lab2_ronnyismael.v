module lab2_ronnyismael(input a, input b, input cin, output s, output cout);

	wire w1, w2;
	xor(s,a,b);
	and(w1,a,b);
	and(w2,s,cin);
	or(cout,w1,w2);

endmodule
