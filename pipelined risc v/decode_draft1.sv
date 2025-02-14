module decode_cycle (clk, rst, InstrD, PCD, PCPlus4D, RDW, ResultW, RegWriteW, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, PCPluse4E, RS1E, RS2E, RDE);
  
  input clk, rst, RegWriteW;
  input [4:0] RDW;
  input [31:0] InstrD, PCD, PCPlus4D, ResultW;
  
  output RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
  output [2:0] ALUControlE;
  output [4:0] RS1E, RS2E, RDE;
  output [31:0] PCE, PCPlus4E;
  
  wire RegWriteD, ResultSrcD, MemWriteD, BranchD, ALUSrcD;
  wire [2:0] ALUControlD;
  wire [1:0] ImmSrcD;
  wire [31:0] RD1_D, RD2_D, Imm_ExtD;
  
  reg [31:0] RD1_D_r, RD2_D_r, Imm_ExtD_r;
  reg RegWriteD_r, ResultSrcD_r, MemWriteD_r, BranchD_r, ALUSrcD_r;
  reg [2:0] ALUControlD_r;
  reg [4:0] RD_D_r;
  reg [31:0] PCD_r, PCPlus4D_r;
  
  
  Control_Unit_Top Control_Unit_Top (.ALUControl(ALUControlD),
                                     .ImmSrc(ImmSrcD),
                                     .ResultSrc(ResultSrcD),
                                     .MemWrite(MemWriteD),
                                     .ALUSrc(ALUSrcD),
                                     .RegWrite(RegWriteD),
                                     .Branch(BranchD),
                                     .Op(InstrD[6:0]),
                                     .funct7(InstrD[31:25]),
                                     .funct3(InstrD[14:12]));
  
  Reg Reg (.RD1(RD1_D),
           .RD2(RD2_D),
           .WD3(ResultW),
           .A1(InstrD[19:15]),
           .A2(InstrD[24:20]),
           .A3(RDW),
           .WE3(RegWriteW),
           .clk(clk),
           .rst(rst));
  
  Sign_Ext Sign_Ext (.Imm_Ext(Imm_ExtD),
                     .In(InstrD[31:0]),
                     .ImmSrc(ImmSrcD));
  
  
  always @(posedge clk or negedge rst)
    begin
      if (rst == 1'b0)
        begin
          RD1_D_r <= 32'h00000000;
          RD2_D_r <= 32'h00000000;
          Imm_ExtD_r <= 32'h00000000;
          RegWriteD_r <= 1'b0;
          ResultSrcD_r <= 1'b0;
          MemWriteD_r <= 1'b0;
          BranchD_r <= 1'b0;
          ALUSrcD_r <= 1'b0;
          ALUControlD_r <= 3'b000;
          RD_D_r <= 5'b00000;
          PCD_r <= 32'h0000000;
          PCPlus4D <= 32'h00000000;
        end
      else
        begin
          RD1_D_r <= RD1_D;
          RD2_D_r <= RD2_D;
          Imm_ExtD_r <= Imm_ExtD;
          RegWriteD_r <= RegWriteD;
          ResultSrcD_r <= ResultSrcD;
          MemWriteD_r <= MemWriteD;
          BranchD_r <= BranchD;
          ALUSrcD_r <= ALUSrcD;
          ALUControlD_r <= ALUControlD;
          RD_D_r <= InstrD[11:7];
          PCD_r <= PCD;
          PCPlus4D_r <= PCPlus4D;
        end
    end
  
  assign RD1E = RD1_D_r;
  assign RD2E = RD2_D_r;
  assign Imm_ExtE = Imm_ExtD_r;
  assign RegWriteE = RegWriteD_r;
  assign ResultSrcE = ResultSrcD_r;
  assign MemWriteE = MemWriteD_r;
  assign BranchE = BranchD_r;
  assign ALUSrcE = ALUSrcD_r;
  assign ALUControlE = ALUControlD_r;
  assign RdE = RD_D_r;
  assign PCE = PCD_r;
  assign PCPlus4E = PCPlus4D_r;

endmodule

////// sign ext change

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

module Sign_Ext (output [31:0] Imm_Ext,
                 input [1:0] ImmSrc,
                 input [31:0] In);
  
  //assign Imm_Ext = (In[31]) ? {{20{1'b1}}, In[31:20]} : {{20{1'b0}}, In[31:20]};
  assign Imm_Ext = (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:20]} : 
                   (ImmSrc == 2'b01) ? {{20{In[31]}},In[31:25],In[11:7]} : 32'h00000000; 
  
endmodule
