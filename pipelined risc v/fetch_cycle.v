module Fetch_cycle (PCSrcE, clk, rst, InstrD, PCD, PCPlus4D, PCTargetE);
  input clk, rst; 
  input PCSrcE;
  input [31:0] PCTargetE;
  output [31:0]  InstrD, PCD, PCPlus4D;
  
  wire [31:0] PCPlus4F, PC_F, PCF, InstrF;
  reg [31:0] InstrF_reg;
  reg [31:0] PCF_reg, PCPlus4F_reg;
  
  mux mux (.a(PCPlus4F),
           .b(PCTargetE),
           .s(PCSrcE),
           .c(PC_F));
  
  Program_Counter Program_Counter (.PC_NEXT(PC_F),
                                   .clk(clk),
                                   .rst(rst),
                                   .PC(PCF));
  
  PC_Adder PC_Adder (.a(PCF),
                     .b(32'h00000004),
                     .c(PCPlus4F));
  
  Instruction_Memory Instruction_Memory (.rst(rst),
                                         .A(PCF),
                                         .RD(InstrF));
  
  always @(posedge clk or negedge rst)
    begin
      if (rst == 0)
        begin
          InstrF_reg <= 32'h00000000;
          PCF_reg <= 32'h00000000;
          PCPlus4F_reg <= 32'h00000000;
        end
      else
        begin
          InstrF_reg <= InstrF;
          PCF_reg <= PCF;
          PCPlus4F_reg <= PCPlus4F;
        end
    end
  
  
  assign InstrD = (rst == 0) ? 32'h00000000 : InstrF_reg;
  assign PCD = (rst == 0) ? 32'h00000000 : PCF_reg;
  assign PCPlus4D = (rst == 0) ? 32'h00000000 : PCPlus4F_reg;
    
endmodule 
  
  
module mux (output [31:0] c,
            input [31:0] a, b,
            input s);
  assign c = (s) ? b : a;
endmodule

module Program_Counter (output reg [31:0] PC,
                        input [31:0] PC_NEXT,
                        input clk, rst);
  
  always @(posedge clk or negedge rst)
    begin
      if (rst == 0)
        PC <= 0;
      else 
        PC <= PC_NEXT;
    end
  
endmodule

module PC_Adder (output [31:0] c,
                 input [31:0] a, b);
  
  assign c = a+b;
  
endmodule

module Instruction_Memory (output [31:0] RD,
                            input [31:0] A,
                            input rst);
  
  reg [31:0] Mem [1023:0];
  
  assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];
  
  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    Mem[0] = 32'h0062E233;
    // mem[1] = 32'h00B62423;

  end


endmodule
