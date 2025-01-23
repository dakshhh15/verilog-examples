//design
module piso_reg (output reg x,
                 input [3:0] d,
                 input rst, clk, sel);
  
  reg [3:0] q;
  
  
  always @(posedge clk)
    begin
      if (rst)
        q <= 0;
      else
        case(sel)
          1'b0 : q <= d;
          1'b1 : begin x <= q[0]; q <= q >> 1; end
        endcase
    end
  
endmodule

//testbench
module tb;
  reg [3:0] D;
  reg RST, CLK, SEL;
  wire X;
  
  piso_reg u1 (.d(D), .rst(RST), .clk(CLK), .x(X), .sel(SEL));
  
  always #1 CLK = ~CLK;
  
  initial
    begin
      RST = 1'b1;
      CLK = 0;
      #2 RST = 0;
      SEL = 0;
      D = 4'b0100;
      #2 SEL = 1;
      #10 SEL = 0;
      D = 4'b1110;
      #2 SEL = 1;
    end
  initial 
    begin      
      $monitor ("time=%t, clk=%d, s=%b, d=%b, q=%b, x=%b", $time,CLK,SEL,D,u1.q,X);
      #25 $finish;
    end
  
endmodule
