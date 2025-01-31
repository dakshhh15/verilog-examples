//design
module bcd_excess3 (output w,x,y,z,
		    input a,b,c,d);

	assign w = a | (b&c) | (b&d);
	assign x = (~b&c) | (~b&d) | (b&(~c)&(~d));
	assign y = ~(c^d);
	assign z = ~d;

endmodule

//testbench
module tb;
  wire W,X,Y,Z;
  reg A,B,C,D;
  integer i;

  bcd_excess3 i1 (.a(A), .b(B), .c(C), .d(D), .w(W), .x(X), .y(Y), .z(Z));

  initial
	begin
		A <= 1'b0;
		B <= 1'b0;
		C <= 1'b0;
		D <= 1'b0;

		$monitor ("a=%b, b=%b, c=%b, d=%b, w=%b, x=%b, y=%b, z=%b", A,B,C,D,W,X,Y,Z);

		for (i=0; i<16; i=i+1)
			begin
				{A,B,C,D} = i;
				#10;
			end
	end
endmodule
