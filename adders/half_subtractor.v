//design
module half_subtractor (output diff, borrow,
			input a, b);
	assign diff = a ^ b;
	assign borrow = (~a) & b;

endmodule

//testbench
module tb;
reg A, B;
wire DIFF, BORROW;
integer i;

half_subtractor i1 (.a(A), .b(B), .diff(DIFF), .borrow(BORROW));

initial
	begin
		A <= 1'b0;
		B <= 1'b0;

		$monitor ("A=%b, B=%b, DIFF=%b, BORROW=%b", A, B, DIFF, BORROW);

		for (i = 0; i<4; i=i+1)
			begin
				{A,B} = i;
				#10;
			end
	end
endmodule
