//design
module mealy_1001_nonover (output reg out,
                          input clk, rst, in);
  reg [1:0] state;
  parameter s0 = 0, s1 = 1, s10 = 2, s100 =3;
  
  always@(posedge clk)
    begin
      if (rst)
        begin
          state <= s0;
          out <= 0;
        end
      else
        begin
          case(state)
            
            s0 : begin
              state <= in ? s1 : s0;
              out <= 0;
            end
            s1 : begin
              state <= in ? s1 : s10;
              out <= 0;
            end
            s10 : begin
              state <= in ? s1 : s100;
              out <= 0;
            end
            s100 : begin
              state <= in ? s1 : s0;
              out <= in ? 1 : 0;
            end
            default : begin
              state <= s0;
              out <= 0;
            end
            
          endcase
        end
    end
  
endmodule

//testbench
module tb;
  reg CLK, RST, IN;
  wire OUT;
  
  mealy_1001_nonover i1 (.clk(CLK), .rst(RST), .in(IN), .out(OUT));
  
  always #10 CLK = ~CLK;
  
  initial
    begin
      CLK = 0;
      RST = 1;
      $monitor("time=%t, clk=%b, in=%b, out=%b, state=%d", $time,CLK,IN,OUT,i1.state);
      #10 RST = 0;
      
      #10 IN = 1; #10 IN = 0; #10 IN = 0; #10 IN = 1;
      #10 IN = 1; #10 IN = 1; #10 IN = 0; #10 IN = 1;
      #10 IN = 1; #10 IN = 0; #10 IN = 1; #10 IN = 1;
      #10 IN = 1; #10 IN = 1; #10 IN = 1; #10 IN = 1;
      #10 IN = 1; #10 IN = 1; #10 IN = 0; #10 IN = 0;
      #10 IN = 1; #10 IN = 0; #10 IN = 0; #10 IN = 1;
      
      #20 $finish;
    end
  
endmodule
