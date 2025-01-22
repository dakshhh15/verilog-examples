//design
module d_ff (output reg q, qb,
              input d, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q = 0;
          qb = 1;
        end
      else
        case(d)
          1'b0 : begin q = 0; qb = ~q; end
          1'b1 : begin q = 1; qb = ~q; end
        endcase
    end
endmodule

//testbench
module tb;
  wire Q,QB;
  reg D,CLK,RST;
  integer i;
  
  d_ff i1 (.q(Q), .d(D), .qb(QB), .clk(CLK), .rst(RST) );
  
  
  initial
    begin
      D <= 1'b0;
      CLK = 1;
      
      RST <= 1'b0;      
            
      $monitor("time=%t, rst=%b, d=%b, q=%b, qb=%b", $time,RST,D,Q,QB);
       
      for(i=0; i<4; i=i+1)
        begin
          {RST,D} = i;
          #10;
        end
      #100 $finish;
    end
  
  always #5 CLK = ~CLK;
  
endmodule
