//design
module jk_ff (output reg q, qb,
              input j,k, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q = 0;
          qb = 1;
        end
      else
        case({j,k})
          2'b00 : begin q = q; qb = ~q; end
          2'b01 : begin q = 0; qb = ~q; end
          2'b10 : begin q = 1; qb = ~q; end
          2'b11 : begin q = ~q; qb = ~q; end
        endcase
    end

  
endmodule

//testbench
module tb;
  wire Q,QB;
  reg J,K,CLK,RST;
  integer i;
  
  jk_ff i1 (.q(Q), .j(J), .k(K), .qb(QB), .clk(CLK), .rst(RST) );
  
  
  initial
    begin
      J <= 1'b0;
      K <= 1'b0;
      CLK = 1;
      
      RST <= 1'b0;      
            
      $monitor("time=%t, rst=%b, j=%b, k=%b, q=%b, qb=%b", $time,RST,J,K,Q,QB);
       
      for(i=0; i<8; i=i+1)
        begin
          {RST,J,K} = i;
          #10;
        end
      #100 $finish;
    end
  
  always #5 CLK = ~CLK;
  
endmodule
