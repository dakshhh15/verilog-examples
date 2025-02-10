//design
module ALU_Decoder (output [2:0] ALUControl,
                    input [1:0] ALUOp,
                    input op_5,
                    input [2:0] funct3,
                    input funct7_5);
  
  wire [1:0] int1;
  
  assign int1 = {op_5, funct7_5};
  
  assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
    (ALUOp == 2'b01) ? 3'b001 : 
    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (int1 == !2'b11)) ? 3'b000 :
    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (int1 == 2'b11)) ? 3'b001 :
    ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :
    ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :
    ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 3'b000;
     
endmodule
     
//testbench
`include "alu_decoder.v"

module tb;
  reg [1:0] ALUOp;
  reg op_5;
  reg [2:0] funct3;
  reg funct7_5;
  wire [2:0] ALU_Control;
  
  ALU_Decoder i1 (.ALUOp(ALUOp), .op_5(op_5), .funct3(funct3), .funct7_5(funct7_5), .ALUControl(ALU_Control));
  
  initial
    begin
      
      ALUOp = 0;
      op_5 = 0;
      funct3 = 0;
      funct7_5 = 0;
      
      $monitor("aluop=%b | funct3=%b | int1=%b | alu=%b", ALUOp, funct3, i1.int1, ALU_Control);
      
      #10 ALUOp = 2'b00; 
      #10 ALUOp = 2'b01;
      #10 ALUOp = 2'b10;
      #10 funct3 = 3'b000;
      #10 op_5 = 1;
      #10 funct7_5 = 1;
      #10 funct3 = 3'b010; 
      #10 funct3 = 3'b110; 
      #10 funct3 = 3'b111; 
      
    end
  
endmodule
