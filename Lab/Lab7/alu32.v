module alu32(
  input [31:0] A, B,			// Two 32-bit numbers 
  input [2:0] F,				// Multiplexer switch (operation selector)
  output reg [31:0] Y,		// Output value (result of operation)
  output reg Overflow,		// Overflow flag (sets when aritmetic operation overflow)
  output reg Zero				// Zero flag (sets when the output value is zero)
);
  wire [31:0] S, Bout;					// Sum and first mux output intermediate wires
  wire CarryIn_MSB, CarryOut_MSB;	// Wires for overflow detection (carry-in and carry-out of MSB)

  assign Bout = F[2] ? ~B : B;		// Choose between ~B, B based on the MSB of F (inverts B if F[2] is 1)
  assign S = A + Bout + F[2];			// Sum calcuation
  assign CarryIn_MSB = (A[31] & Bout[31]) | (A[31] & F[2]) | (Bout[31] & F[2]);	// Carry-in of the MSB
  assign CarryOut_MSB = S[31] ^ A[31] ^ Bout[31];											// Carry-out of the MSB

  always @ (*)							// Performs the operation selection
    case (F[1:0])						// Mux switch for Multiplexer
      2'b00: Y <= A & Bout;		// AND operation
      2'b01: Y <= A | Bout;		// OR operation
      2'b10: Y <= S;					// ADD operation (addition result is already in S)
      2'b11: Y <= S[31];			// LESS THAN operation (result is the MSB of S)
    endcase

  always @ (*) begin
    Overflow <= CarryIn_MSB ^ CarryOut_MSB;	// Update Overflow flag (XOR of CarryIn_MSB and CarryOut_MSB)
    Zero <= (Y == 32'b0);							// Update Zero flag (set if Y is equal to zero)
  end

endmodule
