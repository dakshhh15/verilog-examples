//design

module q3 (output y,
	   input i0,i1,i2,i3,i4,i5,i6,i7, s0,s1,s2);

  wire a,b,c,d,e,f;

  //mux1
  wire a1,a2,s0b;
  not (s0b, s0);
  and (a1, i1, s0);
  and (a2, s0b, i0);
  or (a, a1, a2);

  //mux2
  wire b1,b2;
  and (b1, i3, s0);
  and (b2, s0b, i2);
  or (b, b1, b2);

  //mux3
  wire c1,c2;
  and (c1, i5, s0);
  and (c2, s0b, i4);
  or (c, c1,c2);

  //mux4
  wire d1,d2;
  and (d1, i7, s0);
  and (d2, s0b, i6);
  or (d, d1, d2);


  //mux2.1
  wire e1, e2, s1b;
  not (s1b, s1);
  and (e1, b, s1);
  and (e2, s1b, a);
  or (e, e1, e2);

  //mux2.1
  wire f1, f2;
  and (f1, d, s1);
  and (f2, s1b, c);
  or (f, f1, f2);

  //final mux
  wire y1, y2, s2b;
  not (s2b, s2);
  and (y1, f, s2);
  and (y2, s2b, e);
  or (y, y1, y2);

endmodule

//testbench

module tb;
  wire Y;
  reg I0,I1,I2,I3,I4,I5,I6,I7, S0,S1,S2;
  integer i;

  q3 i1 (.i0(I0), .i1(I1), .i2(I2), .i3(I3), .i4(I4), .i5(I5), .i6(I6), .i7(I7), .s0(S0), .s1(S1), .s2(S2), .y(Y));

initial
	begin
		S0 <= 1'b0;
		S1 <= 1'b0;
		S2 <= 1'b0;
		
		I0 <= 1'b1;
		I1 <= 1'b0;
		I2 <= 1'b1;
		I3 <= 1'b1;
		I4 <= 1'b1;
		I5 <= 1'b1;
		I6 <= 1'b1;
		I7 <= 1'b1;

      $monitor("time=%t, s2=%b, s1=%b, s0=%b, y=%b", $time, S2, S1, S0, Y);

	for(i=0; i<8; i=i+1)
		begin
			{S2,S1,S0} = i;
			#10;
		end		
		
	end
endmodule
