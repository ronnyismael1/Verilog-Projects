module test_true_dual_port_tb();
	reg we1, we2, clk1;
	wire [7:0] q1, q2;
	reg [7:0] d1, d2;
	reg [6:0] a1, a2;
	
	ram_true_dual_port main(q1, q2, a1, a2, d1, d2, we1, we2, clk1);
	
	always begin
		clk1 = 1; #50;
		clk1 = 0; #50;
	end

	initial begin	
		// Memory Test 1
		d1 = 8'b11001100; a1 = 7'b1111001; 
		d2 = 8'b11001101; a2 = 7'b1111000;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b0; we2 = 1'b0; #100;
		$display("Expected=b11001100, Read = %b", q1);
		$display("Expected=b11001101, Read = %b", q2);
		
		// Memory Test 2
		d1 = 8'b10101010; a1 = 7'b1111101; 
		d2 = 8'b10101011; a2 = 7'b1111100;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b0; we2 = 1'b0; #100;
		$display("Expected=b10101010, Read = %b", q1);
		$display("Expected=b10101011, Read = %b", q2);

		// Memory Test 3
		d1 = 8'b00001111; a1 = 7'b1111011; 
		d2 = 8'b10001111; a2 = 7'b1111010; 
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b0; we2 = 1'b0; #100;
		$display("Expected=b00001111, Read = %b", q1);
		$display("Expected=b10001111, Read = %b", q2);
		
		// Memory Test 4
		d1 = 8'b11110000; a1 = 7'b1111111; 
		d2 = 8'b11110001; a2 = 7'b1111110; 
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b1; we2 = 1'b1; #50;
		we1 = 1'b0; we2 = 1'b0; #100;
		$display("Expected=11110000, Read = %b", q1);
		$display("Expected=11110001, Read = %b", q2);
	end
endmodule