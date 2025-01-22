//design
module ms_jk (output q, qb,
              input in1, in2, clk, rst);
  wire a,b,k;
  not (k, clk);
  jk_ff first ( .j(in1), .k(in2), .clk(clk), .rst(rst), .q(a), .qb(b));
  gated_sr_latch second ( .s(a), .r(b), .e(k), .q(q), .qb(qb));
  
  initial
    begin
      $monitor ("master: time=%t, j=%b, k=%b, a=%b, b=%b", $time,in1,in2,a,b);
    end
endmodule


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
          default : ;
        endcase
    end

endmodule
module ms_jk (output q, qb,
              input in1, in2, clk, rst);
  wire a,b,k;
  not (k, clk);
  jk_ff first ( .j(in1), .k(in2), .clk(clk), .rst(rst), .q(a), .qb(b));
  gated_sr_latch second ( .s(a), .r(b), .e(k), .q(q), .qb(qb));
  
endmodule


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
          default : ;
        endcase
    end
endmodule

module jk_ff (output reg q, qb,
              input j,k, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q <= 0;
          qb <= 1;
        end
      else
        case({j,k})
          2'b00 : ;
          2'b01 : begin q <= 0; qb <= 1; end
          2'b10 : begin q <= 1; qb <= 0; end
          2'b11 : begin q <= ~q; qb <= ~qb; end
          default : ;
        endcase
    end
endmodule
  
module jk_ff (output reg q, qb,
              input j,k, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q <= 0;
          qb <= 1;
        end
      else
        case({j,k})
          2'b00 : ;
          2'b01 : begin q <= 0; qb <= 1; end
          2'b10 : begin q <= 1; qb <= 0; end
          2'b11 : begin q <= ~q; qb <= ~qb; end
          default : ;
        endcase
    end
endmodule

//testbench
module tb;
  wire Q, QB;
  reg IN1, IN2, CLK, RST;
  integer i;
  
  ms_jk i1 (.q(Q), .qb(QB), .in1(IN1), .in2(IN2), .clk(CLK), .rst(RST));

  always #5 CLK = ~CLK; 
  
  initial begin
    
    IN1 = 0;
    IN2 = 0;
    CLK = 0;
    RST = 0;
    
    $monitor("time=%t, clk=%b, rst=%b, j=%b, k=%b, a=%b, b=%b, q=%b, qb=%b", 
             $time, CLK, RST, IN1, IN2, i1.a, i1.b, Q, QB);
    
    RST = 1;
    #10;
    RST = 0;
    

    for (i = 0; i < 4; i = i + 1) begin
      {IN1, IN2} = i; 
      #20; 
    end
    
   
    #100 $finish;
  end
  
endmodule
