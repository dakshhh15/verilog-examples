//design
module carry_look_ahead_adder (output sum, cout,
                               input a, b, cin);
  
  assign sum = (a^b)^cin;
  assign cout = ((a^b)&cin) | (a&b);
  
endmodule

//testbench
`include "carry_look_ahead_adder.v"

module tb;
  reg A,B,CIN;
  wire SUM, COUT;
  integer i;
  
  carry_look_ahead_adder i1 (.a(A), .b(B), .cin(CIN), .sum(SUM), .cout(COUT));
  
  initial 
    begin
      A <= 1'b0;
      B <= 1'b0;
      CIN <= 1'b0;
      
      
      $monitor("time=%t, cin=%b, a=%b, b=%b, sum=%b, cout=%b", $time, CIN,A,B,SUM,COUT);
      
      for (i=0; i<8; i=i+1)
          begin
            {CIN,A,B} = i;
            #10;
          end      
    end
endmodule
  
