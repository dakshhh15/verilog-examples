module single_cycle_top (input clk, rst);
  
  wire [31:0] PC_top, RD_inst, RD1_Top, Imm_Ext_Top, ALUControl_Top, ALUResult, ReadData, PCPlus4;
  wire RegWrite;
  
  
  Program_Counter PC (.clk(clk),
                      .rst (rst),
                      .PC(PC_top),
                      .PC_NEXT(PCPlus4));
  
  PC_Adder PC_Adder (.c(PCPlus4),
                     .b(32'd4),
                     .a(PC_top));
  
  Instruction_Memory Instruction_Memory (.rst(rst),
                                         .A(PC_top),
                                         .RD(RD_inst));
  
  Reg Reg (.clk(clk),
           .rst(rst),
           .RD1(RD1_Top),
           .RD2(),
           .WD3(ReadData),
           .A1(RD_inst[19:15]),
           .A2(),
           .A3(RD_inst[11:7]),
           .WE3(RegWrite));
  
  Sign_Ext Sign_Ext (.In(RD_inst),
                     .Imm_Ext(Imm_Ext_Top));
  
  alu ALU (.Result(ALUResult),
           .z(),
           .n(),
           .c(),
           .v(),
           .A(RD1_Top),
           .B(Imm_Ext_Top),
           .ALUControl(ALUControl_Top));
  
  Control_Unit_Top Control_Unit_Top (.Op(RD_inst[6:0]),
                                     .RegWrite(RegWrite),
                                     .ImmSrc(),
                                     .ALUSrc(),
                                     .MemWrite(),
                                     .ResultSrc(),
                                     .Branch(),
                                     .funct3(RD_inst[14:12]),
                                     .funct7(),
                                     .ALUControl(ALUControl_Top));
  
  Data_Memory Data_Memory (.RD(ReadData),
                           .clk(clk),
                           .WE(),
                           .A(ALUResult),
                           .WD(),
                           .rst(rst));
  
endmodule

module Program_Counter (output reg [31:0] PC,
                        input [31:0] PC_NEXT,
                        input clk, rst);
  
  always @(posedge clk)
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
  
  initial
    begin
      Mem[0] = 32'hFFC4A303;
    end
  
endmodule

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
      registers[9] = 32'h00000020;
    end
  
endmodule

module alu (output [31:0] Result,
            output z, n, c, v,
            input [31:0] A, B,
            input [2:0] ALUControl);
  
  wire [31:0] sum;
  wire [31:0] and_out, or_out;
  wire [31:0] mux_out, not_b, sub;
  wire [31:0] mux2_out;
  wire cout;
  wire sign_ext;
  
  assign and_out = A & B;
  assign or_out = A | B;

  assign sub = A - B;
  assign {cout, sum} = (ALUControl[0]) ? sub : (A+B);
  
  assign sign_ext = { 31'b0000000000000000000000000000000 , sum[31] };
  
  assign mux2_out = (ALUControl[2:0] == 3'b000) ? sum : 
    (ALUControl[2:0] == 3'b001) ? sum :
    (ALUControl[2:0] == 3'b010) ? and_out :
    (ALUControl[2:0] == 3'b011) ? or_out : 
    (ALUControl[2:0] == 3'b101) ? sign_ext : 32'h00000000;
  
  assign Result = mux2_out;
  
  assign c = (~ALUControl[1]) & cout;
  assign v = (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31]) ^ B[31] ^ ALUControl[0]);
  assign z = &(~Result);
  assign n = Result[31];
  
endmodule

module Control_Unit_Top (output [2:0] ALUControl,
                         output [1:0] ImmSrc,
                         output ResultSrc, MemWrite, ALUSrc, RegWrite, Branch,
                         input [6:0] Op, funct7,
                         input [2:0] funct3);
  
  wire [1:0] ALU;
  
  ALU_Decoder ALU_Decoder (.ALUControl(ALUControl),
                           .ALUOp(ALU),
                           .op(Op),
                           .funct7(funct7),
                           .funct3(funct3));
  
  main_decoder main_decoder (.ResultSrc(ResultSrc),
                             .MemWrite(MemWrite),
                             .ALUSrc(ALUSrc),
                             .RegWrite(RegWrite),
                             .ImmSrc(ImmSrc),
                             .ALUOp(ALU),
                             .Branch(Branch),
                             .Op(Op));
  
endmodule

module ALU_Decoder (output [2:0] ALUControl,
                    input [1:0] ALUOp,
                    input [6:0] op, funct7,
                    input [2:0] funct3);
  
  wire [1:0] int1;
  
  assign int1 = {op[5], funct7[5]};
  
  assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
    (ALUOp == 2'b01) ? 3'b001 : 
    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (int1 == !2'b11)) ? 3'b000 :
    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (int1 == 2'b11)) ? 3'b001 :
    ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :
    ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :
    ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 3'b000;
     
endmodule

module main_decoder (output ResultSrc, MemWrite, ALUSrc, RegWrite,
                     output [1:0] ImmSrc,
                     output [1:0] ALUOp,
                     output Branch,
                     input [6:0] Op);
  
  //wire Branch;
  
  assign RegWrite = ((Op == 7'b0000011) | (Op == 7'b0110011)) ? 1'b1 : 1'b0;
  assign ALUSrc = ((Op == 7'b0000011) | (Op == 7'b0100011)) ? 1'b1 : 1'b0;
  assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;
  assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;
  assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;
  assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : (Op == 7'b1100011) ? 2'b10 : 2'b00;
  assign ALUOp = (Op == 7'b0110011) ? 2'b10 : (Op == 7'b1100011) ? 2'b01 : 2'b00;
  
  //assign PCSrc = Branch & Zero;
  assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0 ;
  
endmodule

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
  
  initial
    begin
      data_mem[28] = 32'h00000020;
    end
  
endmodule  

module Sign_Ext (output [31:0] Imm_Ext,
                 input [31:0] In);
  
  assign Imm_Ext = (In[31]) ? {{20{1'b1}}, In[31:20]} : {{20{1'b0}}, In[31:20]};
  
endmodule
