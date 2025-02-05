//design
module alu (output [31:0] Result,
            output z, n, c, v,
            input [31:0] A, B,
            input [2:0] ALU_Control);
  
  wire [31:0] sum;
  wire [31:0] and_out, or_out;
  wire [31:0] mux_out, not_b, sub;
  wire [31:0] mux2_out;
  wire cout;
  wire sign_ext;
  
  assign and_out = A & B;
  assign or_out = A | B;

  assign sub = A - B;
  assign {cout, sum} = (ALU_Control[0]) ? sub : (A+B);
  
  assign sign_ext = { 31'b0000000000000000000000000000000 , sum[31] };
  
  assign mux2_out = (ALU_Control[2:0] == 3'b000) ? sum : 
    (ALU_Control[2:0] == 3'b001) ? sum :
    (ALU_Control[2:0] == 3'b010) ? and_out :
    (ALU_Control[2:0] == 3'b011) ? or_out : 
    (ALU_Control[2:0] == 3'b101) ? sign_ext : 32'h00000000;
  
  assign Result = mux2_out;
  
  assign c = (~ALU_Control[1]) & cout;
  assign v = (~ALU_Control[1]) & (A[31] ^ sum[31]) & (~(A[31]) ^ B[31] ^ ALU_Control[0]);
  assign z = &(~Result);
  assign n = Result[31];
  
endmodule

//testbench
module tb_alu;
  reg [31:0] A, B;
  reg [2:0] ALU_CONTROL;
  wire Z, N, C, V;
  wire [31:0] RESULT;
  integer i,j,k;
  
  alu i1 (.A(A), .B(B), .ALU_Control(ALU_CONTROL), .z(Z), .n(N), .c(C), .v(V), .Result(RESULT));
  
  initial
    begin
      
      A = 0;
      B = 0;
      ALU_CONTROL = 0;
      
      $monitor("a=%b|%0d | b=%b|%0d | ctrl=%b|%0d | z=%b n=%b c=%b v=%b | res=%b|%0d", A,A, B,B, ALU_CONTROL,ALU_CONTROL, Z,N,C,V, RESULT,RESULT);
      
      for (i=0; i<64; i=i+1)
        for (j=0; j<64; j=j+1)
          for (k=0; k<8; k=k+1)
            begin
              A = i;
              B = j;
              ALU_CONTROL = k;
              #10;
            end
      $finish;
    end
  
endmodule
