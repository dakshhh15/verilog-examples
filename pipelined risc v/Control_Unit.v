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
