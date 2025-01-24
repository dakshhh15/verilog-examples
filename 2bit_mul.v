//design
module twobit_mul (output [3:0] p,
                   input [1:0] a, b);
  wire c,d, a1, a2, a3;
  
  assign p[0] = a[0] & b[0];
  
  assign a1 = a[1] & b[0];
  assign a2 = b[1] & a[0];
  half_adder i1 (.a(a1), .b(a2), .sum(p[1]), .cout(c));
  
  assign a3 = a[1] & b[1];
  half_adder i2 (.a(c), .b(a3), .sum(p[2]), .cout(p[3]));
  
  
endmodule


module half_adder (output sum, cout,
                   input a,b);
  assign sum = a ^ b;
  assign cout = a & b;

endmodule

//testbench
module tb;
  reg [1:0] A, B;
  wire [3:0] P;
  integer i,j;
  
  twobit_mul u1 (.p(P), .a(A), .b(B));
  
  initial
    begin
      A <= 0;
      B <= 0;
      
      
      $monitor ("time=%t, a=%d, b=%d, p=%b, p=%d", $time,A,B,P,P);
      
      for (i=0; i< 4; i=i+1)
        for (j=0; j< 4; j=j+1)
          begin
            A = i;
            B = j;
            #10;
          end
    end
endmodule
