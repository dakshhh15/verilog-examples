//design
module binary_gray(output g0, g1, g2, g3,
		   input b0, b1, b2, b3);

	assign g0 = b0^b1;
	assign g1 = b1^b2;
	assign g2 = b2^b3;
	assign g3 = b3;

endmodule

//testbench
module tb;
  wire G0, G1, G2, G3;
  reg B0, B1, B2, B3;
  integer i;

  binary_gray u1 (.b0(B0), .b1(B1), .b2(B2), .b3(B3), .g0(G0), .g1(G1), .g2(G2), .g3(G3));

initial 
	begin
		B0 <= 1'b0;
		B1 <= 1'b0;
		B2 <= 1'b0;
		B3 <= 1'b0;

		$monitor ("b0=%b, b1=%b, b2=%b, b3=%b, g0=%b, g1=%b, g2=%b, g3=%b", B0,B1,B2,B3,G0,G1,G2,G3);

		for(i=0; i<16; i=i+1)
			begin
				{B3,B2,B1,B0} = i;
				#10;
			end
	end
endmodule
