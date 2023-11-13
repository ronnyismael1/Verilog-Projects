module fsm_ab (A,B,clk,RESET,Z);
	
	input A,B,clk,RESET;
	output Z;
	reg [1:0] current_state, next_state;
	wire Z_wire, next_state_1, next_state_0;

	assign next_state_1 = (current_state[1] & ~A & ~B) | (~current_state[1] & A & ~B);
	assign next_state_0 = (~current_state[0] & A) | (current_state[0] & B);
	assign Z_wire = (current_state[1] & A) | (current_state[0] & ~B & A);

	always @(posedge clk or posedge RESET) 
	begin
		if (RESET) begin
			current_state <= 2'b00;
		end else begin
			current_state <= next_state;
		end
	end
	
	always @(*) begin
		next_state = {next_state_1, next_state_0};
	end
	
	assign Z = Z_wire;
	
endmodule
