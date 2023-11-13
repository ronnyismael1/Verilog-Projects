module problem2(input a, input b, input c, output reg y );
	always @(*)
	begin
		if (a + b + c <= 1)
			y = 1;
		else
			y = 0;
	end
endmodule
