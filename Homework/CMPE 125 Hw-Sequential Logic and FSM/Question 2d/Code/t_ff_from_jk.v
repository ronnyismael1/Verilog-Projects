module t_ff_from_jk (T, clk, Q);
	input T;
	input clk;
	output reg Q;
	wire J, K;

	assign J = T;
	assign K = T;

	always @(posedge clk) 
	begin
		if (J && !K) begin
			Q <= 1'b1;
		end
		else if (!J && K) begin
			Q <= 1'b0;
		end
		else if (J && K) begin
			Q <= ~Q;
		end
	end
endmodule