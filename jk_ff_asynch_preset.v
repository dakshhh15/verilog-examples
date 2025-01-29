//design
module jk_ff (output reg q, qb,
              input j,k, clk,rst, preset);
  
  always@(posedge clk)
    begin
      
      case({preset, rst})
          2'b00 : 
            begin
              case({j,k})
                2'b00 : begin q = q; qb = ~q; end
                2'b01 : begin q = 0; qb = 1; end
                2'b10 : begin q = 1; qb = 0; end
                2'b11 : begin q = ~q; qb = q; end
            endcase
            end   
          2'b01 : begin q = 0; qb = 1; end
          2'b10 : begin q = 1; qb = 0; end
          2'b11 : begin q = 1'bx; qb = 1'bx; end
      endcase
                
    end

  
endmodule

//testbench
module tb;
  wire Q,QB;
  reg J,K,CLK,RST,PRESET;
  integer i;
  
  jk_ff i1 (.q(Q), .j(J), .k(K), .qb(QB), .clk(CLK), .rst(RST), .preset(PRESET));
  
  
  initial
    begin
      J <= 1'b0;
      K <= 1'b0;
      CLK <= 1;
      
      RST <= 1'b0;      
            
      $monitor("time=%t, preset=%b, rst=%b, j=%b, k=%b, q=%b, qb=%b", $time,PRESET,RST,J,K,Q,QB);
       
      for(i=0; i<16; i=i+1)
        begin
          {PRESET,RST,J,K} = i;
          #10;
        end
      #100 $finish;
    end
  
  always #5 CLK = ~CLK;
  
endmodule
