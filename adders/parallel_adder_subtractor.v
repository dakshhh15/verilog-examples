//design
module parallel_addsub (output [3:0] sum,
                        output cout,
                        input [3:0] a,b,
                        input cin);
  
  wire x,y,z, x1,x2,x3,x4;
  xor a1 (x1, b[0], cin);
  xor a2 (x2, b[1], cin);
  xor a3 (x3, b[2], cin);
  xor a4 (x4, b[3], cin);
  
  full_adder i1 (.fa_a(a[0]), .fa_b(x1), .fa_cin(cin), .fa_sum(sum[0]), .fa_cout(x));
  full_adder i2 (.fa_a(a[1]), .fa_b(x2), .fa_cin(x), .fa_sum(sum[1]), .fa_cout(y));
  full_adder i3 (.fa_a(a[2]), .fa_b(x3), .fa_cin(y), .fa_sum(sum[2]), .fa_cout(z));
  full_adder i4 (.fa_a(a[3]), .fa_b(x4), .fa_cin(z), .fa_sum(sum[3]), .fa_cout(cout));
                       
endmodule


module full_adder (output fa_sum, fa_cout,
                   input fa_a, fa_b, fa_cin);
  
  assign {fa_cout, fa_sum} = fa_a + fa_b + fa_cin;
  
endmodule

//testbench
module tb;
  reg [3:0] A,B;
  reg CIN;
  wire [3:0] SUM;
  wire COUT;
  integer i,j,k;
  
  parallel_addsub i1 (.a(A), .b(B), .cin(CIN), .sum(SUM), .cout(COUT));
  
  initial 
    begin
      A <= 1'b0;
      B <= 1'b0;
      CIN <= 1'b0;
      
      
      $monitor("time=%t, cin=%b, a=%b, b=%b, sum=%b, cout=%b", $time, CIN,A,B,SUM,COUT);
      
      for (i=0; i<2; i=i+1)
        for(j=0; j<16; j=j+1)
          for(k=0; k<16; k=k+1)
          begin
            CIN = i;
            A = j;
            B = k;
            #10;
          end      
    end
endmodule
  
