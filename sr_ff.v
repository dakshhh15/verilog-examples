//design
module sr_ff (output reg q, qb,
              input s, r, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q = 0;
          qb = 1;
        end
      else
        case({s,r})
          2'b00 : begin q = q; qb = ~q; end
          2'b01 : begin q = 0; qb = ~q; end
          2'b10 : begin q = 1; qb = ~q; end
          2'b11 : begin q = 1'bx; qb = ~q; end
        endcase
    end

  
endmodule

//testbench
module tb;
  wire Q,QB;
  reg S,R,CLK,RST;
  integer i;
  
  sr_ff i1 (.q(Q), .s(S), .r(R), .qb(QB), .clk(CLK), .rst(RST) );
  
  
  initial
    begin
      S <= 1'b0;
      R <= 1'b0;
      CLK = 1;
      
      RST <= 1'b0;      
            
      $monitor("time=%t, rst=%b, s=%b, r=%b, q=%b, qb=%b", $time,RST,S,R,Q,QB);
       
      for(i=0; i<8; i=i+1)
        begin
          {RST, S,R} = i;
          #10;
        end
      #100 $finish;
    end
  
  always #5 CLK = ~CLK;
  
endmodule
