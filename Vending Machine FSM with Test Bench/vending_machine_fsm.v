module vending_machine_fsm (
	input clk, reset, nickel, dime, quarter,
	output dispense, returnNickel, returnDime, returnTwoDimes
);
	reg [2:0] state, nextstate;
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	
	// State Register
	always @ (posedge clk, posedge reset) 
	begin
		if (reset) state <= S0;
		else state <= nextstate;
	end
	
	// Next State Logic
	always @ (*) begin
		case (state)
			S0: begin
				if (nickel) nextstate = S1;
				else if (dime) nextstate = S2;
				else if (quarter) nextstate = S0;
			end
			S1: begin
				if (nickel) nextstate = S2;
				else if (dime) nextstate = S3;
				else if (quarter) nextstate = S0;
			end
			S2: begin
				if (nickel) nextstate = S3;
				else if (dime) nextstate = S4;
				else if (quarter) nextstate = S0;
			end
			S3: begin
				if (nickel) nextstate = S4;
				else if (dime) nextstate = S0;
				else if (quarter) nextstate = S0;
			end
			S4: begin
				if (nickel) nextstate = S0;
				else if (dime) nextstate = S0;
				else if (quarter) nextstate = S0;
			end
		endcase
	end
	
	// Output Logic
	assign dispense = (state == S0 && quarter) || (state == S1 && quarter) || (state == S2 && quarter) || (state == S3 && dime) || (state == S3 && quarter) || (state == S4 && nickel) || (state == S4 && dime) || (state == S4 && quarter);
	assign returnNickel = (state == S1 && quarter) || (state == S3 && quarter) || (state == S4 && dime);
	assign returnDime = (state == S2 && quarter) || (state == S3 && quarter); 
	assign returnTwoDimes = (state == S4 && quarter);
	
endmodule