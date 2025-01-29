//design
module universal_shift_reg (output reg [3:0] q,
                            input [3:0] d,
                            input clk,clr, sl, sr,
                            input [1:0] s);
  always@(posedge clk)
    begin
      if (clr)
        q <= 0;
      else
        case(s)
          2'b00 : q <= q;
          2'b01 : begin q <= q >> 1; q[3]<=sr;  end
          2'b10 : begin q <= q << 1; q[0]<=sl; end
          2'b11 : q <= d; 
          default : ;
        endcase
    end
  
endmodule


//testbench
module tb;
  reg [3:0] D;
  reg CLK,CLR,SL,SR;
  reg [1:0] S;
  wire [3:0] Q;

  
  universal_shift_reg u1 (.q(Q), .d(D), .clk(CLK), .clr(CLR), .s(S), .sl(SL), .sr(SR));
  
  always #5 CLK = ~CLK;
  
  initial
    begin
      
      CLR = 1;
      CLK = 0;
      #10 CLR = 0;
      
      //load data
      SR <= 0;
      SL <= 0;
      D <= 4'b0100;
      S <= 2'b11;
      #10;
      
      //shift right
      SR <= 1'b1;
      SL <= 1'b0;
      //#5 SR <= 0;
      S <= 2'b01;
      #40;
      
      //load data
      SR = 0;
      SL = 0;
      D = 4'b1001;
      S = 2'b11;
      #10;
      
      //shift left
      SR <= 1'b0;
      SL <= 1'b1;
      S <= 2'b10;
      #40;
      
      //load data
      SR = 0;
      SL = 0;
      D = 4'b1101;
      S = 2'b11;
      #10;
      
      //hold data
      SR <= 0;
      SL <= 0;
      S <= 2'b00;
      #20;
      
      
      #10 $finish;
      
    end
  
  initial
    begin
      $monitor("time=%t, clk=%d, clr=%b, s=%b, d=%b, q=%b", $time,CLK,CLR,S,D,Q); 
    end
  
endmodule
