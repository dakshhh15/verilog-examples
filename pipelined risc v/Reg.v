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
  
   initial
    begin
      //registers[9] = 32'h00000020;
      //registers[6] = 32'h00000040;
      
      //registers[11] = 32'h00000028;
      //registers[12] = 32'h00000030;
      
      registers[5] = 32'h00000006;
      registers[6] = 32'h0000000A;
    end
  
endmodule
