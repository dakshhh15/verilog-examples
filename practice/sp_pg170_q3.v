//design
module alu (output reg [4:0] out,
            input [3:0] a, b,
            input [2:0] select);
  
  always@(*)
    begin
      out = calc(a,b,select);
    end
  

  function [4:0] calc;
    input [3:0] a1, b1;
    input [2:0] s;
    
    begin
      case (s)
        3'b000 : calc = a1;
        3'b001 : calc = a1 + b1;
        3'b010 : calc = a1 - b1;
        3'b011 : calc = a1 / b1;
        3'b100 : calc = a1 % b1;
        3'b101 : calc = a1 << 1;
        3'b110 : calc = a1 >> 1;
        3'b111 : calc = a1 > b1;
      endcase
    end
  endfunction
  
endmodule  

//testbench
module tb;
  reg [3:0] A,B;
  reg [2:0] SELECT;
  wire [4:0] OUT;
  integer i,j,k;
  
  alu i1 (.a(A), .b(B), .select(SELECT), .out(OUT));
  
  initial
    begin
      A = 0;
      B = 0;
      SELECT = 0;
      
      $monitor ("time=%t | a=%d,a=%b | b=%d,b=%b | sel=%b | out=%d,out=%b", $time,A,A,B,B,SELECT,OUT,OUT);
      
      for(i=0; i<16; i=i+1)
        for(j=0; j<16; j=j+1)
          for(k=0; k<8; k=k+1)
            begin
              A = i;
              B = j;
              SELECT = k;
              #10;
            end
    end
endmodule
