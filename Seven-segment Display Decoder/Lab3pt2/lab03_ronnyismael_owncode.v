module lab03_ronnyismael_owncode(input [3:0] d, output reg [6:0] s);
// 
// We will be using a decoder to select the output
// that we want to display. This way, it is a lot
// simplier to select our desired display. 
// 
// Behavioral
//
	always@(d)
	begin
		s[0] <= (~d[3]&~d[2]&~d[1]&d[0]) | (d[2]&~d[1]&~d[0]) | (d[3]&d[2]&~d[1]) | (d[3]&~d[2]&d[1]&d[0]);
		s[1] <= (d[3]&d[2]&~d[1]&~d[0]) | (~d[3]&d[2]&~d[1]&d[0]) | (d[3]&d[1]&d[0]) | (d[2]&d[1]&~d[0]);
		s[2] <= (~d[3]&~d[2]&d[1]&~d[0]) | (d[3]&d[2]&~d[0]) | (d[3]&d[2]&d[1]);
		s[3] <= (~d[2]&~d[1]&d[0]) | (~d[3]&d[2]&~d[1]&~d[0]) | (d[2]&d[1]&d[0]) | (d[3]&~d[2]&d[1]&~d[0]);
		s[4] <= (~d[3]&d[2]&~d[1]) | (~d[2]&~d[1]&d[0]) | (~d[3]&d[0]);
		s[5] <= (~d[3]&~d[2]&d[0]) | (d[3]&d[2]&~d[1]) | (~d[3]&~d[2]&d[1]) | (~d[3]&d[1]&d[0]);
		s[6] <= (~d[3]&~d[2]&~d[1]) | (~d[3]&d[2]&d[1]&d[0]);
	end
endmodule
