
//design
module q10(output [15:0] d,
           input w, x, y, z);
  wire k;
  not (k, w);
  
  a3x8_decoder i1 (.e(k), .b(x), .c(y), .d(z), .o(d[15:8])); 
  a3x8_decoder i2 (.e(w), .b(x), .c(y), .d(z), .o(d[7:0]));
  
endmodule


module a3x8_decoder(input e,b,c,d,
                   output reg [7:0] o);
  always@(*)
    begin
      if (e == 0)
        o <= 0;
      else
        case({b,c,d})
          3'b000 : o = 8'b10000000;
          3'b001 : o = 8'b01000000;
          3'b010 : o = 8'b00100000;
          3'b011 : o = 8'b00010000;
          3'b100 : o = 8'b00001000;
          3'b101 : o = 8'b00000100;
          3'b110 : o = 8'b00000010;
          3'b111 : o = 8'b00000001;
          default : o = 8'b00000000;
        endcase 
    end
endmodule

//testbench
module tb;
  reg W,X,Y,Z;
  wire [15:0] D;
  integer i;
  
  q10 i1 (.w(W), .x(X), .y(Y), .z(Z), .d(D));
  
  initial 
    begin
      W <= 1'b0;
      X <= 1'b0;
      Y <= 1'b0;
      Z <= 1'b0;
      
      $monitor("time=%t, w=%b, x=%b, y=%b, z=%b, d=%b", $time, W,X,Y,Z,D);
      
      for (i=0; i<16; i=i+1)
        begin
          {W,X,Y,Z} = i;
          #10;
        end
      
    end
endmodule
  
