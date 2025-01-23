//design
module universal_shift_reg (output q3,q2,q1,q0,
                           input d3,d2,d1,d0,clk,clr,sr,sl,s0,s1);
  
  wire m3,m2,m1,m0;
  d_ff i1 ( .d(m3), .clk(clk), .rst(clr), .q(q3) /*.qb()*/);
  d_ff i2 ( .d(m2), .clk(clk), .rst(clr), .q(q2) /*.qb()*/); 
  d_ff i3 ( .d(m1), .clk(clk), .rst(clr), .q(q1) /*.qb()*/); 
  d_ff i4 ( .d(m0), .clk(clk), .rst(clr), .q(q0) /*.qb()*/);
  
  mux j1 ( .hold(q3), .sh_right(sr), .sh_left(q2), .load(d3), .s0(s0), .s1(s1), .y(m3));
  mux j2 ( .hold(q2), .sh_right(q3), .sh_left(q1), .load(d2), .s0(s0), .s1(s1), .y(m2));
  mux j3 ( .hold(q1), .sh_right(q2), .sh_left(q0), .load(d1), .s0(s0), .s1(s1), .y(m1));
  mux j4 ( .hold(q0), .sh_right(ql), .sh_left(sl), .load(d0), .s0(s0), .s1(s1), .y(m0));
  
endmodule

module d_ff (output reg q,
              input d, clk,rst);
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          q <= 0;
          //qb <= 1;
        end
      else
        case(d)
          1'b0 : begin q <= 0; /*qb <= 1;*/ end
          1'b1 : begin q <= 1; /*qb <= 0;*/ end
          default : ;
        endcase
    end
endmodule

module mux (output reg y,
            input hold, sh_right, sh_left, load, s0, s1);
  
  always@(*)
    begin
      case({s1,s0})
          2'b00 : y <= hold;
          2'b01 : y <= sh_right;
          2'b10 : y <= sh_left;
          2'b11 : y <= load;
          default : y = 0;
      endcase
    end
endmodule

//testbench
module tb;
  reg D3,D2,D1,D0;
  reg CLK,CLR;
  reg SR, SL;
  reg S0,S1;
  wire Q3, Q2, Q1, Q0;
  
  wire [3:0] Q = {Q3,Q2,Q1,Q0};
  wire [3:0] D = {D3,D2,D1,D0};
  wire [1:0] S = {S1, S0};
  
  universal_shift_reg u1 (.q3(Q3), .q2(Q2), .q1(Q1), .q0(Q0), .d3(D3), .d2(D2), .d1(D1), .d0(D0), .clk(CLK), .clr(CLR), .sr(SR), .sl(SL), .s0(S0), .s1(S1));
  
  always #5 CLK = ~CLK;
  
  initial
    begin
      
      CLR = 1;
      CLK = 0;
      #10 CLR = 0;
      
      //load data
      SR <= 0;
      SL <= 0;
      {D3,D2,D1,D0} <= 4'b0100;
      {S1, S0} <= 2'b11;
      #10;
      
      //shift right
      SR <= 1'b1;
      SL <= 1'b0;
      //#5 SR <= 0;
      {S1, S0} <= 2'b01;
      #40;
      
      /*//load data
      SR = 0;
      SL = 0;
      {D3,D2,D1,D0} = 4'b1001;
      {S1, S0} = 2'b11;
      #10;*/
      
      //shift left
      SR <= 1'b0;
      SL <= 1'b1;
      {S1, S0} <= 2'b10;
      #40;
      
      /*//load data
      SR = 0;
      SL = 0;
      {D3,D2,D1,D0} = 4'b1101;
      {S1, S0} = 2'b11;
      #10;*/
      
      //hold data
      SR <= 0;
      SL <= 0;
      {S1, S0} <= 2'b00;
      #20;
      
      
      #10 $finish;
      
    end
  
  initial
    begin
      $monitor("time=%t, clk=%d, clr=%b, s=%b, d=%b, q=%b", $time,CLK,CLR,S,D,Q); 
    end
  
endmodule
