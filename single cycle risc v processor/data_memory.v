//design
module Data_Memory (output [31:0] RD,
                    input clk, WE, rst,
                    input [31:0] A, WD);
  
  reg [31:0] data_mem [1023:0];
  
  assign RD = (rst) ? data_mem[A] : 32'h00000000;
  
  always@(posedge clk)
    begin
      if (WE)
        data_mem[A] <= WD;
    end
  
endmodule

//testbench
module tb;
  wire [31:0] RD;
  reg clk, WE;
  reg [31:0] A, WD;
  
  Data_Memory i1 (.RD(RD), .clk(clk), .WE(WE), .A(A), .WD(WD));
  
  always #10 clk=~clk;
  
  initial
    begin
      clk = 0;
      WE = 0;
      A = 0;
      WD = 0;
      
      $monitor("[%0t] CLK=%d | A = %0d WE = %b WD = %0h | RD = %0h data_mem = %0h", $time,clk,A,WE,WD,RD,i1.data_mem[45]);
      
      #10 A = 34; 
      i1.data_mem[34] = 32'habcd1234;
      #10  A = 25;
      i1.data_mem[25] = 32'h12345678;
      
      #20 WE = 1;
      A = 45;
      WD = 32'hffffffff;
      
      #20 $finish;
      
     end
  
endmodule
