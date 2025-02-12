module Instruction_Memory (output [31:0] RD,
                            input [31:0] A,
                            input rst);
  
  reg [31:0] Mem [1023:0];
  
  assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];

endmodule
