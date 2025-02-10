//design
module main_decoder (output PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite,
                     output [1:0] ImmSrc,
                     output [1:0] ALUOp,
                     input Zero,
                     input [6:0] Op);
  
  wire Branch;
  
  assign RegWrite = ((Op == 7'b0000011) | (Op == 7'b0110011)) ? 1'b1 : 1'b0;
  assign ALUSrc = ((Op == 7'b0000011) | (Op == 7'b0100011)) ? 1'b1 : 1'b0;
  assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;
  assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;
  assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;
  assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : (Op == 7'b1100011) ? 2'b10 : 2'b00;
  assign ALUOp = (Op == 7'b0110011) ? 2'b10 : (Op == 7'b1100011) ? 2'b01 : 2'b00;
  
  assign PCSrc = Branch & Zero;
  
endmodule

//testbench
module tb;
  wire PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
  wire [1:0] ImmSrc;
  wire [1:0] ALUOp;
  reg Zero;
  reg [6:0] op;
  
  main_decoder i1 (.PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ImmSrc(ImmSrc), .ALUOp(ALUOp), .Zero(Zero), .Op(op));
  
  initial
    begin
      
      Zero = 0;
      op = 0;
      
      $monitor("pc=%b | res=%b | mem=%b | alu=%b | reg=%b | imm=%b | aluop=%b | zero=%b | op=%b", PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite, ImmSrc, ALUOp, Zero, op);
      
      #10 op = 7'b0000011;
      #10 op = 7'b0110011;
      #10 op = 7'b0100011;
      #10 op = 7'b1100011;
      
    end
endmodule
