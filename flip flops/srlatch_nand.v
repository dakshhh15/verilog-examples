//design
module sr_latch_nand (output q, qb,
                      input s, r);
  wire sb, rb;
  
  //not (qb,q);
  not (sb,s);
  not (rb,r);
  
  //always@(*)
    //begin
     // q <= ~(s & qb);
      //qb <= ~(r & q);
    //end
  
  nand (q, sb, qb);
  nand (qb, rb, q);
    
endmodule

//testbench
module tb;
  wire Q,QB;
  reg S,R;
  integer i;
  
  sr_latch_nand i1 (.q(Q), .s(S), .r(R), .qb(QB));
  
  
  initial
    begin
      S <= 1'b0;
      R <= 1'b0;
      
            
      $monitor("time=%t, s=%b, r=%b, q=%b, qb=%b", $time, S,R,Q,QB);
      
      for(i=0; i<4; i=i+1)
        begin
          {S,R} = i;
          #10;
        end
    end
endmodule
