module ram_dual_port(q1, q2, a1, a2, d1, d2, we1, we2, clk1, clk2); 
	output[7:0] q1, q2;
	input [7:0] d1, d2;
	input [6:0] a1, a2;
	input we1, we2, clk1, clk2;

	reg [7:0] mem1 [127:0];
	reg [7:0] mem2 [127:0];

	assign q1 = mem1[a1];
	assign q2 = mem2[a2];

	always @(posedge clk1) begin
		if (we1) begin
			mem1[a1] <= d1;
		end
	end
	always @(posedge clk2) begin
		if(we2) begin
			mem2[a2] <= d2;
		end

	end
endmodule