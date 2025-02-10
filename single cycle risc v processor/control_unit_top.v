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
