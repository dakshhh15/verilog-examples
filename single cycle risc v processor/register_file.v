//design
module Reg (output reg [31:0] RD1, RD2,
            input [31:0] WD3,
            input [4:0] A1, A2, A3,
            input WE3, clk, rst);
  
  reg [31:0] registers [31:0];
  
  assign RD1 = (rst==0) ? 32'h00000000 : registers[A1]; 
  assign RD2 = (rst==0) ? 32'h00000000 : registers[A2];
  
  always@(posedge clk)
    begin
      if (WE3)
        begin
          registers[A3] <= WD3;
        end
    end
  
endmodule

//testbench
module tb;
  wire [31:0] RD1, RD2;
  reg [31:0] WD3;
  reg [4:0] A1, A2, A3;
  reg WE3, clk, rst;
  
  Reg u1 (.RD1(RD1), .RD2(RD2), .WD3(WD3), .A1(A1), .A2(A2), .A3(A3), .WE3(WE3), .clk(clk), .rst(rst));
  
  always #10 clk = ~ clk;
  
  initial
    begin
      WD3 = 0;
      A1 = 0; 
      A2 = 0;
      A3 = 0;
      WE3 = 1;
      clk = 0;
      rst = 1;
      u1.registers[5] = 32'hffff0000;
      u1.registers[12] = 32'h0000ffff;
      
      $monitor ("[%0t] A1 = %h  RD1 = %h | A2 = %h  RD2 = %h | A3 = %h reg[0] =%h", $time,A1,RD1,A2,RD2,A3,u1.registers[0]);
      
      A1 = 5;
      #10 A2 = 12;
      #20 rst = 0;
      A1 = 12;
      A2 = 5;
      
      #10 WD3 = 32'habcd4321;
      #20 WE3 = 0;
      #10 WD3 = 32'h4321abcd;
      
      #20 $finish;
    end
  
endmodule
