//design
module counter (output reg [3:0] q,
                input clk, rst);
  initial 
    begin
      q <= 0;
    end
  
  always@(negedge clk or posedge rst)
    begin
      if (rst)
        q <= 0;
      else
        q <= q + 1;
    end
  
endmodule

//testbench
module tb;
  reg CLK, RST;
  wire [3:0] Q;
  integer i;
  
  counter i1 ( .clk(CLK), .rst(RST), .q(Q));
  always #5 CLK = ~CLK;
  always #50 RST = ~RST;
  
  initial
    begin
      
      CLK = 1;
      RST = 0;
      
      $monitor ("time=%t, clk=%d, q=%b", $time,CLK,Q);
      
      #200 $finish;
    end
  
  initial
    begin
      $dumpvars (0, tb);
      $dumpfile ("dump.vcd");
    end
  
endmodule
