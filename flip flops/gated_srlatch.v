//design
module gated_sr_latch (output reg q, qb,
                      input s, r, e);
  
  always@(e or s or r)
    begin
      if (!e)
        begin
          q = 0;
          qb = 1;
        end
      else
        case({s,r})
          2'b00 : ;
          2'b01 : begin q = 0; qb = 1; end
          2'b10 : begin q = 1; qb = 0; end
          2'b11 : begin q = 1'bx; qb = 1'bx; end
          //default : begin q <= q; qb <= ~q; end
        endcase
    end

endmodule

//testbench
module tb;
  wire Q,QB;
  reg S,R,E;
  integer i;
  
  gated_sr_latch i1 (.q(Q), .s(S), .r(R), .qb(QB), .e(E) );
  
  
  initial
    begin
      S = 1'b0;
      R = 1'b0;
      E = 1'b0;  
            
      $monitor("time=%t, e=%b, s=%b, r=%b, q=%b, qb=%b", $time,E,S,R,Q,QB);
       
      for(i=0; i<8; i=i+1)
        begin
          {E,S,R} = i;
          #10;
        end
      #100 $finish;
    end
  
  //always #5 E = ~E;
  
endmodule
