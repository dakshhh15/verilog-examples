//design
module fourbit_mul (output [7:0] p,
                   input [3:0] a, b);
  
  
  //0
  assign p[0] = a[0] & b[0];
  
  //1
  wire aa;
  wire a1, a2;
  assign a1 = a[0] & b[1];
  assign a2 = a[1] & b[0];
  half_adder i1 (.a(a1), .b(a2), .sum(p[1]), .cout(aa));
  
  //2
  wire bb,c,d;
  wire b1,b2,b3;
  assign b1 = a[1] & b[1];
  assign b2 = a[2] & b[0];
  assign b3 = a[0] & b[2];
  full_adder i2 (.a(b1), .b(b2), .cin(aa), .sum(c), .cout(bb));
  half_adder i3 (.a(b3), .b(c), .sum(p[2]), .cout(d));
  
  //3
  wire e,f,g,h,q;
  wire c1,c2,c3,c4;
  assign c1 = a[2] & b[1];
  assign c2 = a[3] & b[0];
  assign c3 = a[1] & b[2];
  assign c4 = a[0] & b[3];
  full_adder i4 (.a(c1), .b(c2), .cin(bb), .sum(f), .cout(e));
  full_adder i5 (.a(f), .b(c3), .cin(d), .sum(h), .cout(g));
  half_adder i6 (.a(c4), .b(h), .sum(p[3]), .cout(q));
  
  //4
  wire i,j,k,l,r;
  wire d1,d2,d3;
  assign d1 = a[3] & b[1];
  assign d2 = a[2] & b[2];
  assign d3 = a[1] & b[3];
  half_adder i7 (.a(d1), .b(e), .sum(i), .cout(l));
  full_adder i8 (.a(d2), .b(i), .cin(g), .sum(k), .cout(j));
  full_adder i9 (.a(k), .b(d3), .cin(q), .sum(p[4]), .cout(r));
  
  //5
  wire m,n,s;
  wire e1,e2;
  assign e1 = a[3] & b[2];
  assign e2 = a[2] & b[3];
  full_adder i10 (.a(l), .b(e1), .cin(j), .sum(m), .cout(n));
  full_adder i11 (.a(m), .b(e2), .cin(r), .sum(p[5]), .cout(s)); 
  
  //6,7
  wire f1;
  assign f1 = a[3] & b[3];
  full_adder i12 (.a(f1), .b(n), .cin(s), .sum(p[6]), .cout(p[7]));
  
endmodule


module half_adder (output sum, cout,
                   input a,b);
  assign sum = a ^ b;
  assign cout = a & b;

endmodule

module full_adder (output sum, cout,
                   input a, b, cin);
  
  assign {cout, sum} = a+b+cin;
  
endmodule

//testbench
module tb;
  reg [3:0] A, B;
  wire [7:0] P;
  integer i,j;
  
  fourbit_mul u1 (.p(P), .a(A), .b(B));
  
  initial
    begin
      A <= 0;
      B <= 0;
      
      
      $monitor ("time=%t, a=%d, b=%d, p=%b, p=%d", $time,A,B,P,P);
      
      for (i=0; i< 8; i=i+1)
        for (j=0; j< 8; j=j+1)
          begin
            A = i;
            B = j;
            #10;
          end
    end
endmodule
