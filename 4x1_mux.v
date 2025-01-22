//design

module a4x1_mux (output reg y,
                 input in1, in2, in3, in0, s0, s1);
  
  always@(*)
    begin
      case({s1,s0})
          2'b00 : y = in0;
          2'b01 : y = in1;
          2'b10 : y = in2;
          2'b11 : y = in3;
          default : y = 0;
      endcase
    end
endmodule


//testbench

module tb;
  wire Y;
  reg IN0,IN1,IN2,IN3,S0,S1;
  integer i;
  
  a4x1_mux i1 (.y(Y), .in0(IN0), .in1(IN1), .in2(IN2), .in3(IN3), .s0(S0), .s1(S1));
  
  initial
    begin
      IN0 <= 1'b0;
      IN1 <= 1'b1;
      IN2 <= 1'b0;
      IN3 <= 1'b1;
      S0 <= 1'b0;
      S1 <= 1'b0;
            
      $monitor("time=%t, s1=%b, s0=%b, y=%b", $time, S1,S0,Y);
      
      for(i=0; i<4; i=i+1)
        begin
          {S1,S0} = i;
          #10;
        end
    end
endmodule
