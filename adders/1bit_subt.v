//design
module full_subtractor (output diff, bout,
			input a, b, bin);

	assign diff = (a ^ b) ^ bin;
	assign bout = ((~a) & b) | ((~(a^b)) & bin);

endmodule

//testbench
module tb;
  wire DIFF, BOUT;
  reg A, B, BIN;
  integer i;

  full_subtractor i1 (.a(A), .b(B), .bin(BIN), .bout(BOUT), .diff(DIFF));

  initial
	begin
		A <= 1'b0;
		B <= 1'b0;
		BIN <= 1'b0;

		$monitor ("a=%b, b=%b, bin=%b, diff=%b, bout=%b", A,B,BIN,DIFF,BOUT);

		for (i=0; i<8; i=i+1)
			begin
				{A,B,BIN} = i;
				#10;
			end
	end
endmodule
