//design
module test (output reg [31:0] out,
             input [3:0] num);
  
  
  always@(*)
    begin
      out = factorial(num);
    end
  
  function [31:0] factorial;
    input [3:0] n;
    integer i;
    
    begin
      factorial = 1;
      for (i=1; i<=n; i=i+1)
        begin
          factorial = factorial*i;
        end
    end
  endfunction
  
endmodule

//testbench
module tb;
  reg [3:0] NUM;
  wire [31:0] OUT;
  integer i;
  
  test i1 (.num(NUM), .out(OUT));
  
  initial
    begin
      $monitor("time=%t || num = %d || numb = %b || out = %d || outb = %b", $time,NUM,NUM,OUT,OUT);
      
      for (i=0; i<16; i=i+1)
        begin
          NUM = i;
          #10;
        end
    end
  
endmodule
