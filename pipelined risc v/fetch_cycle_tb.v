module tb;
  reg clk = 0, rst; 
  reg PCSrcE;
  reg [31:0] PCTargetE;
  wire [31:0]  InstrD, PCD, PCPlus4D;
  
  Fetch_cycle dut (.PCSrcE(PCSrcE),
                   .clk(clk),
                   .rst(rst),
                   .InstrD(InstrD),
                   .PCD(PCD),
                   .PCPlus4D(PCPlus4D),
                   .PCTargetE(PCTargetE));
  
  always #50 clk = ~clk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, tb);
    end
  
  initial
    begin
      rst <= 1'b0;
      #200
      rst <= 1'b1;
      PCSrcE <= 1'b0;
      PCTargetE <= 32'h00000000;
      #500;
      $finish;
      
    end
endmodule
