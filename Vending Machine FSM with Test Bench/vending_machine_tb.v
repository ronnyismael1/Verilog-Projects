module vending_machine_tb;

	reg clk, reset, nickel, dime, quarter;
	wire dispense, returnNickel, returnDime, returnTwoDimes;
	reg dispenseexpected, returnNickelexpected, returnDimeexpected, returnTwoDimesexpected;
	reg [19:0] vectornum, errors;
	reg [7:0] testvectors[10000:0];

	// Instantiate the device under test
	vending_machine_fsm main (clk, reset, nickel, dime, quarter, dispense, returnNickel, returnDime, returnTwoDimes);

	// Generate clock
	always 
	begin
		clk = 1; #50; clk = 0; #50;
	end
	 
	// At start if test, load vectors and pulse reset
	initial begin
		$readmemb("C:/Users/rismael/Documents/SJSU/Homework/S23/CMPE125/Lab/Lab6/test_vector.tv", testvectors);
		vectornum = 0; errors = 0;
	end
	 
	// Apply test vectors on rising edge of clk
	always @ (posedge clk)
	begin
		#1; {quarter, dime, nickel, reset, dispenseexpected, returnNickelexpected, returnDimeexpected, returnTwoDimesexpected} = testvectors[vectornum];
		if (quarter)
			$display ("Inserting Quarter...");
		else if (dime)
			$display ("Inserting Dime...");
		else if (nickel)
			$display ("Inserting Nickel...");
		else if (reset)
			$display ("Reseting Vending Machine...");
	end
	
	// Check results on falling edge of clk
	always @ (negedge clk)
	begin
		if ((dispense !== dispenseexpected) || (returnNickel !== returnNickelexpected) || (returnDime !== returnDimeexpected) || (returnTwoDimes !== returnTwoDimesexpected)) 
		begin
			$display("Error: Input = %b", {nickel, dime, quarter});
			$display(" outputs = Dispense = %b (%b expected)", dispense, dispenseexpected);
			$display(" outputs = Return Nicke = %b (%b expected)", returnNickel, returnNickelexpected);
			$display(" outputs = Return Dime = %b (%b expected)", returnDime, returnDimeexpected);
			$display(" outputs = Return Two Dime = %b (%b expected)", returnTwoDimes, returnTwoDimesexpected);
			errors = errors + 1; // Count number of errors
		end
		else begin
			$display("Success: Input = %b", {nickel, dime, quarter});
			$display(" outputs = Dispense = %b (%b expected)", dispense, dispenseexpected);
			$display(" outputs = Return Nicke = %b (%b expected)", returnNickel, returnNickelexpected);
			$display(" outputs = Return Dime = %b (%b expected)", returnDime, returnDimeexpected);
			$display(" outputs = Return Two Dime = %b (%b expected)", returnTwoDimes, returnTwoDimesexpected);

		end
		vectornum = vectornum + 1; // Count number of tests
		if (testvectors[vectornum] === 8'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
		end
	end
endmodule
