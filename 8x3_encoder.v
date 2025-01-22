//design

module a8x3_encoder (input [7:0] d,
                     output reg x,y,z);
  
  //or (x, d[4], d[5], d[6], d[7]);
  //or (y, d[2], d[3], d[6], d[7]);
  //or (z, d[1], d[3], d[5], d[7]);
  
  always@(*)
    begin
      case({d})
        8'b00000001 : {x,y,z} = 3'b000;
        8'b00000010 : {x,y,z} = 3'b001;
        8'b00000100 : {x,y,z} = 3'b010;
        8'b00001000 : {x,y,z} = 3'b011;
        8'b00010000 : {x,y,z} = 3'b100;
        8'b00100000 : {x,y,z} = 3'b101;
        8'b01000000 : {x,y,z} = 3'b110;
        8'b10000000 : {x,y,z} = 3'b111;
        default : {x,y,z} = 3'b000;
      endcase
    end
  
endmodule

//testbench

module tb;
  wire X,Y,Z;
  reg [7:0] D;
  integer i;
  
  a8x3_encoder i1 (.x(X), .y(Y), .z(Z), .d(D));
  
  initial
    begin
      D <= 8'b00000000;
      
            
      $monitor("time=%t, x=%b, y=%b, z=%b, d=%b", $time, X,Y,Z,D);
      
      for(i=0; i<256; i=i+1)
        begin
          D = i;
          #10;
        end
    end
endmodule
