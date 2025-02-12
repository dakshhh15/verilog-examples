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
