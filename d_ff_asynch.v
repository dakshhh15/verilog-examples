//design
module d_ff (output reg q, qb,
              input d, clk,rst);
  
  always@(posedge clk or posedge rst)
    begin
      if (rst)
        begin
          q <= 0;
          qb <= 1;
        end
      else
        case(d)
          1'b0 : begin q <= 0; qb <= 1; end
          1'b1 : begin q <= 1; qb <= 0; end
        endcase
    end
endmodule

//testbench
`include "q2a.v"

module tb;
  wire Q,QB;
  reg D,CLK,RST;
  integer i;
  
  d_ff i1 (.q(Q), .d(D), .qb(QB), .clk(CLK), .rst(RST) );
  
  
  initial
    begin
      D = 1'b0;
      CLK = 1;
      
      RST = 1'b0;      
            
      $monitor("time=%t, clk=%b, rst=%b, d=%b, q=%b, qb=%b", $time,CLK,RST,D,Q,QB);
      
      #200 $finish;
    end
  always #5 CLK = ~CLK;
  always #30 RST = ~RST;
  always #10 D = ~D;      
  
endmodule
