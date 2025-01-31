//design
module modncount #(parameter n=4) (output reg [n-1:0] out,
                                   input clk, rst);
  
  always@(posedge clk)
    begin
      if (rst)
        out <= 0;
      else
        out <= out + 1;
    end
  
endmodule

//testbench
module tb;
  parameter N = 4;
  reg CLK, RST;
  wire [N-1:0] OUT;
  
  modncount #(.n(N)) u1 (.clk(CLK), .rst(RST), .out(OUT));
  
  initial
    begin
      CLK = 0;
      #10 RST = 1;
      
      #10 RST = 0;
      $monitor("time=%t, clk=%b, rst=%b, out=%b", $time,CLK,RST,OUT);
      #110 RST = 1;
      #10 RST = 0;
      
      #200 $finish;
    end
  
  always #10 CLK = ~CLK;
  
endmodule
