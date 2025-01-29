//design
module n_bit_reg #(parameter n = 4) (output reg [n-1:0] q,
                  input [n-1:0] d,
                  input clk, rst, enable);
  
  
  always@(posedge clk or posedge rst or posedge enable)
    begin
      if (rst)
        q <= 0;
      else if (enable)
        q <= d;
      else 
        q <= q;
    end
  
endmodule

//testbench
`include "q5.v"

module tb;
  parameter N = 4;
  reg [N-1:0] D;
  reg CLK, RST, ENABLE;
  wire [N-1:0] Q;
  integer i;
  
  n_bit_reg #(.n(N)) u1(.q(Q), .d(D), .clk(CLK), .rst(RST), .enable(ENABLE));
  
  initial
    begin
      CLK = 0;
      RST = 1;
      ENABLE = 0;
      $monitor("time=%t, rst=%b, enable=%b, clk=%b, d=%b, q=%b",$time,RST,ENABLE,CLK,D,Q);
      #10 RST = 0;
      
      for(i=0; i<50; i=i+1)
        begin
          D = i;
          #10;
        end
      
      #10 $finish;
    end
  
  always #10 CLK=~CLK;
  always #30 ENABLE=~ENABLE;
endmodule
