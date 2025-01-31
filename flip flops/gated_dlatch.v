
//design
module gated_d_latch (output q, qb,
                      input d, e);
  
  wire db, d1, d2;
  not (db,d);
  
  nand (d1, d, e);
  nand (d2, db, e);
  nand (q, d1, qb);
  nand (qb, d2, q);
  
endmodule

//testbench
module tb;
  wire Q,QB;
  reg D,E;
  integer i;
  
  gated_d_latch i1 (.q(Q), .d(D), .qb(QB), .e(E));
  
  
  initial
    begin
      D <= 1'b0;
      E <= 1'b0;
      
            
      $monitor("time=%t, e=%b, d=%b, q=%b, qb=%b", $time, E,D,Q,QB);
      
      for(i=0; i<4; i=i+1)
        begin
          {E,D} = i;
          #10;
        end
    end
endmodule
