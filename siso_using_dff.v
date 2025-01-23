//design
module siso_reg (output x,
                 input d, clk, rst);
  wire a,b,c;
  reg [3:0] q;
  d_ff i1 (.d(d), .clk(clk), .rst(rst), .q(a), .qb());
  d_ff i2 (.d(a), .clk(clk), .rst(rst), .q(b), .qb());
  d_ff i3 (.d(b), .clk(clk), .rst(rst), .q(c), .qb());
  d_ff i4 (.d(c), .clk(clk), .rst(rst), .q(x), .qb());
  
  assign q = {a,b,c,x};
  
endmodule


module d_ff (output reg q, qb,
              input d, clk, rst);
  
  always@(posedge clk)
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
          default : ;
        endcase
    end
endmodule

//testbench
module tb;
  reg D, RST, CLK;
  wire X;
  
  siso_reg u1 (.d(D), .rst(RST), .clk(CLK), .x(X));
  
  always #5 CLK = ~CLK;
  always #20 D = ~D;
  
  initial
    begin
      RST = 1;
      
      CLK = 1;
      D = 1'b0;
      #10 RST = 0;
      
      $monitor ("time=%t, clk=%d, d=%b, q=%b, x=%b", $time,CLK,D,u1.q,X);
      #100 $finish;
    end
  
endmodule
