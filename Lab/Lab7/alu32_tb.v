module alu32_tb();
  reg clk, reset;
  reg [31:0] A, B;
  reg [2:0] F;
  reg [31:0] Y_expected;
  reg Overflow_expected, Zero_expected;
  wire [31:0] Y;
  wire Overflow, Zero;
  reg [31:0] vectornum, errors;
  reg [100:0] testvectors[10000:0];
  integer TEST_CASES = 7;
  
  // Instantiate device under test
  alu32 dut(A, B, F, Y, Overflow, Zero);

  // Generate clock
  always begin
    clk = 1; #50; clk = 0; #50;
  end

  // At the start of the test, load vectors and pulse reset
  initial begin
    $readmemb("C:/Users/rismael/Documents/SJSU/Homework/S23/CMPE125/Lab/Lab7/test_vectors.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #27; reset = 0;
  end

  // Apply test vectors on the rising edge of clk
  always @(posedge clk) begin
    #1; {A, B, F, Y_expected, Overflow_expected, Zero_expected} = testvectors[vectornum];
  end

  // Check results on the falling edge of clk
  always @(negedge clk) begin
    if (~reset) begin // Skip cycles during reset
		if (Y !== Y_expected) begin
			$display("Y result Error: inputs = %b", {Y});
			$display(" outputs = %b (%b expected)", Y, Y_expected);
			errors = errors + 1;
      end
		if (Overflow !== Overflow_expected) begin
			$display("Overflow result Error: inputs = %b", {Overflow});
			$display(" outputs = %b (%b expected)", Overflow, Overflow_expected);
			errors = errors + 1;
      end
		if (Zero !== Zero_expected) begin
			$display("Zero result Error: inputs = %b", {Zero});
			$display(" outputs = %b (%b expected)", Zero, Zero_expected);
			errors = errors + 1;
      end
      vectornum = vectornum + 1;
      if (vectornum >= TEST_CASES) begin
        $display("%d tests completed with %d errors", vectornum, errors);
        $finish;
      end
    end
  end
endmodule
