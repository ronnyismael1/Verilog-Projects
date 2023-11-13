module test_single_port_tb();
	reg [7:0] mem[127:0];
	wire [7:0] q;
	reg [7:0] d;
	reg [6:0] a;
	reg we, clk;
	
	ram_single main(q, a, d, we, clk);
	
	always begin
		clk = 1; #50;
		clk = 0; #50;
	end
	
	initial begin	
		// Memory Test 1
		d = 8'b11001100; a = 7'b1111001; we = 1'b1; #50;
		we = 1'b1; #50;
		we = 1'b0; #100;
		$display("Expectd = b11001100, Read = %b", q);

		// Memory Test 2
		d = 8'b10101010; a = 7'b1111101; we = 1'b1; #50;
		we = 1'b1; #50;
		we = 1'b0; #100;

		// Memory Test 3
		$display("Expectd = b10101010, Read = %b", q);
		d = 8'b00001111; a = 7'b1111011; we = 1'b1; #50;
		we = 1'b1; #50;
		we = 1'b0; #100;
		$display("Expectd = b00001111, Read = %b", q);
		
		// Memory Test 4
		d = 8'b11110000; a = 7'b1111111; we = 1'b1; #50;
		we = 1'b1; #50;
		we = 1'b0; #100;
		$display("Expectd = 11110000, Read = %b", q);

	end
endmodule
