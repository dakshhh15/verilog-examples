//design
module jk_ff (output q,
            input j,k, clk, rst);
  wire x;
  assign x = ((~k)&q) | (j&(~q));
  
  d_ff i1 (.d(x), .out(q), .clk(clk), .rst(rst));
  
endmodule


module d_ff (output reg out,
              input d, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          out <= 0;
        end
      else
        begin
          case(d)
		1'b0 : out <= 0;
		1'b1 : out <= 1;
	  endcase     
        end
    end
endmodule

//testbench
module tb;
  reg J,K, CLK, RST;
  wire Q;
  integer i;
  
  jk_ff u1 (.j(J), .k(K), .q(Q), .clk(CLK), .rst(RST));
  
  always #5 CLK = ~CLK;
  
  initial 
    begin
      CLK = 1;
      J = 0;
      K = 0;
      
      $monitor("time=%t, rst=%b, clk=%b, j=%b, k=%b, q=%b", $time,RST,CLK,J,K,Q);
      
      RST = 1;
      #10 RST = 0;
      
      for (i=0; i<4; i=i+1)
        begin
          {J,K} = i;
          #10;
        end
   
      #100 $finish;
    end
  
  /*initial
    begin
      $dumpvars(0,tb);
      $dumpfile("dump.vcd");
    end*/
  
endmodule
