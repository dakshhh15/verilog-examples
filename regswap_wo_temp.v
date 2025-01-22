module q8;
  reg [7:0] a, b; 
  
  initial
    begin
      a = 8'b10101010;
      b = 8'b01010101;
      
      $display("Before swap: a = %b, b = %b", a, b);
    end
  
  always @*
    begin
      #10 a <= b;
      #10 b <= a;
      
      $display("After swap: a = %b, b = %b", a, b);
      $finish;
    end
endmodule
