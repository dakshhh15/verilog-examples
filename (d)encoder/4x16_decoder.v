//design
module q10 (output d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,
	    input w,x,y,z);

assign d0 = (~w) & (~x) & (~y) & (~z);
assign d1 = (~w) & (~x) & (~y) & (z);
assign d2 = (~w) & (~x) & (y) & (~z);
assign d3 = (~w) & (~x) & (y) & (z);
assign d4 = (~w) & (x) & (~y) & (~z);
assign d5 = (~w) & (x) & (~y) & (z);
assign d6 = (~w) & (x) & (y) & (~z);
assign d7 = (~w) & (x) & (y) & (z);
assign d8 = (w) & (~x) & (~y) & (~z);
assign d9 = (w) & (~x) & (~y) & (z);
assign d10 = (w) & (~x) & (y) & (~z);
assign d11 = (w) & (~x) & (y) & (z);
assign d12 = (w) & (x) & (~y) & (~z);
assign d13 = (w) & (x) & (~y) & (z);
assign d14 = (w) & (x) & (y) & (~z);
assign d15 = (w) & (x) & (y) & (z);

endmodule

//testbench
module tb;
  reg W,X,Y,Z;
  wire D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15;
  integer i;

  wire [15:0] d = {D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15};
  q10 i1(.w(W), .x(X), .y(Y), .z(Z), .d0(D0), .d1(D1), .d2(D2), .d3(D3), .d4(D4), .d5(D5), .d6(D6), .d7(D7), .d8(D8), .d9(D9), .d10(D10), .d11(D11), .d12(D12), .d13(D13), .d14(D14), .d15(D15));

initial
	begin
		W <= 1'b0;
		X <= 1'b0;
		Y <= 1'b0;
		Z <= 1'b0;

		$monitor("time=%t, w=%b, x=%b, y=%b, z=%b, d=%b", $time, W,X,Y,Z, d);

		for(i=0; i<16; i=i+1)
			begin
				{W,X,Y,Z} = i;
				#10;
			end
	end
endmodule
