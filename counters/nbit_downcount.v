//design
module downcount #(parameter n=4) (output reg [n-1:0] q,
                                 input clk, clr);
  
  always@(posedge clk)
    begin
      if (clr)
        q <= 4'b1111;
      else
        q <= q - 1;
    end
endmodule

//testbench
`include "q9_2.v"

module tb;
  parameter N =4;
  reg CLR, CLK;
  wire [N-1:0] Q;
  
  downcount #(.n(N)) u1(.clr(CLR), .clk(CLK), .q(Q));
  
  always #5 CLK = ~CLK;
  
  initial
    begin
      CLR = 1;
      CLK = 1;
      $monitor ("time=%t, clk=%d, q=%b", $time,CLK,Q);
      //D = 1'b0;
      #10 CLR = 0;
      
      #160 $finish;
    end
  
endmodule
