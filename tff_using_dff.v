//design
module t_ff (output q,
            input t,
	    input clk, rst);
  wire x;
  //always@(t or q)
	//begin
		assign x = (t^q);
	//end
  
  d_ff i1 (.d(x), .out(q), .clk(clk), .rst(rst));
  
endmodule


module d_ff (output reg out,
              input d,clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          out <= 0;
        end
      else
        begin
          out <= d;     
        end
    end
endmodule

//testbench
`include "q4.v"

module tb;
  reg T, CLK, RST;
  wire Q;
  integer i;
  
  t_ff u1 (.t(T), .q(Q), .clk(CLK), .rst(RST));
  
  always #5 CLK = ~CLK;
  always #10 T = ~T;
  
  initial 
    begin
      CLK = 1;
      T = 0;
      
      $monitor("time=%t, rst=%b, clk=%b, t=%b q=%b", $time,RST,CLK,T,Q);
      
      RST = 1;
      #10 RST = 0;
   
      #100 $finish;
    end
  
  /*initial
    begin
      $dumpvars(0,tb);
      $dumpfile("dump.vcd");
    end*/
  
endmodule
