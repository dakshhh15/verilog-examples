//design
module q7(output reg s,
	  output reg c,
	  input k,
	  input a, b);
  
  always@(*)
	begin
		case({k,a,b})
			3'b000 : begin s = 1'b0; c = 1'b0; end
			3'b001 : begin s = 1'b1; c = 1'b0; end
			3'b010 : begin s = 1'b1; c = 1'b0; end
			3'b011 : begin s = 1'b0; c = 1'b1; end
			3'b100 : begin s = 1'b0; c = 1'b0; end
			3'b101 : begin s = 1'b1; c = 1'b1; end
			3'b110 : begin s = 1'b1; c = 1'b0; end
			3'b111 : begin s = 1'b0; c = 1'b0; end
			default : begin s = 1'b0; c = 1'b0; end
		endcase
	end
	

endmodule

//testbench
module tb;
  wire S, C;
  reg K, A, B;
  integer i;

  q7 i1 (.k(K), .a(A), .b(B), .s(S), .c(C));

initial
	begin
		K <= 1'b0;
		A <= 1'b0;
		B <= 1'b0;

		$monitor ("time=%t, k=%b, a=%b, b=%b, s=%b, c=%b", $time, K,A,B,S,C);

		for(i=0; i<8; i=i+1)
			begin
				{K,A,B} = i;
				#10;
			end 
	end
endmodule
