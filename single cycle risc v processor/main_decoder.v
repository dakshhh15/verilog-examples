//design
module main_decoder (output PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite,
                     output [1:0] ImmSrc,
                     output [1:0] ALUOp,
                     input Zero,
                     input [6:0] op);
  
  wire Branch;
  
  assign RegWrite = ((op == 7'b0000011) | (op == 7'b0110011)) ? 1'b1 : 1'b0;
  assign ALUSrc = ((op == 7'b0000011) | (op == 7'b0100011)) ? 1'b1 : 1'b0;
  assign MemWrite = (op == 7'b0100011) ? 1'b1 : 1'b0;
  assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0;
  assign Branch = (op == 7'b1100011) ? 1'b1 : 1'b0;
  assign ImmSrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : 2'b00;
  assign ALUOp = (op == 7'b0110011) ? 2'b10 : (op == 7'b1100011) ? 2'b01 : 2'b00;
  
  assign PCSrc = Branch & Zero;
  
endmodule

//testbench
module tb;
  wire PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
  wire [1:0] ImmSrc;
  wire [1:0] ALUOp;
  reg Zero;
  reg [6:0] op;
  
  main_decoder i1 (.PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ImmSrc(ImmSrc), .ALUOp(ALUOp), .Zero(Zero), .op(op));
  
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
