//design

module demux (output out1, out0, out2, out3,
              input in, s0, s1);
  
  assign out0 = in & (~s0) & (~s1);
  assign out1 = in & (~s0) & s1;
  assign out2 = in & (s0) & (~s1);
  assign out3 = in & (s0) & (s1);
  
endmodule


//testbench

module tb;
  wire OUT0, OUT1, OUT2, OUT3;
  reg IN, S0, S1;
  integer i;
  
  demux i1 (.in(IN), .s0(S0), .s1(S1), .out0(OUT0), .out1(OUT1), .out2(OUT2), .out3(OUT3));
  
  initial
    begin
      
      S0 <= 0;
      S1 <= 0;
      IN <= 0;
      
      $monitor ("in=%b, s0=%b, s1=%b, out0=%b, out1=%b, out2=%b, out3=%b", IN, S0, S1,  OUT0, OUT1, OUT2, OUT3);
      
      for(i=0; i<8; i=i+1)
        begin
          {IN,S0,S1} <= i;
          #10;
        end
      
    end
endmodule
