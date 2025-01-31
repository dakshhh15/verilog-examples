//design
module siso_reg (output x,
                 input d, rst, clk);
  
  reg [3:0] q;
  
  initial 
    begin
    end
  
  always @(posedge clk)
    begin
      if (rst)
        q <= 0;
      else
        begin
          q <= q >> 1;
          q[3] <= d;
        end
    end
  assign x = q[0];
endmodule

//testbench
module tb;
  reg D, RST, CLK;
  wire X;
  
  siso_reg i1 (.d(D), .rst(RST), .clk(CLK), .x(X));
  
  always #5 CLK = ~CLK;
  always #20 D = ~D;
  
  initial
    begin
      RST = 1;
      
      CLK = 1;
      D = 1'b0;
      #10 RST = 0;
      
      $monitor ("time=%t, clk=%d, d=%b, q=%b, x=%b", $time,CLK,D,i1.q,X);
      #100 $finish;
    end
  
endmodule
