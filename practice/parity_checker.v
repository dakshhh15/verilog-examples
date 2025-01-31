//design
module parity (output reg out,
               input clk,
               input [15:0] num);
  
  task compute_parity;
    input [15:0] n;
    output result;
    begin
      result = ^n;
    end
  endtask
  
  always@(posedge clk)
    begin
      compute_parity(num,out);
    end
  always@(negedge clk)
    begin
      out = 0;
    end
endmodule    

//testbench
module tb;
  reg CLK;
  reg [15:0] NUM;
  wire OUT;
  integer i;
  
  parity i1 (.num(NUM), .clk(CLK), .out(OUT));
  
  initial
    begin
      
      CLK=0;
      $monitor("time=%t | clk=%b | num=%b | out=%b", $time,CLK,NUM,OUT);
      #10 NUM = 0;
      
      
      
      for (i=0; i<16; i=i+1)
        begin
          NUM = i;
          #20;
        end
      #200 $finish;
    end
  
  always #10 CLK = ~CLK;
  
endmodule
