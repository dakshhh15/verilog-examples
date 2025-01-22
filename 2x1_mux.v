//design

module mux (output out,
                input a, b, s);
  
  assign out = s ? b:a;
  
endmodule

//testbench

`include "2x1_mux.v"
module stimulus;
  reg A, B, S;
  wire OUT;
  integer i;
  
  mux i1 (.a(A), .b(B), .s(S), .out(OUT));
  
  initial
    begin
      
      A <= 1;
      B <= 0;
      S <= 0;
      
      $monitor ("a=%b, b=%b, s=%b, out=%b", A,B,S,OUT);
      
      for (i = 0; i <2; i=i+1)
        begin
          S <= i;
          #10;
        end
      
    end
endmodule
