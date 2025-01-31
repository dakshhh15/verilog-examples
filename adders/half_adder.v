//design
module half_adder (output sum, cout,
                   input a,b);
  assign sum = a^ b;
  assign cout = a&b;

endmodule

//testbench
module tb;
  reg A, B;
  wire SUM, COUT;
  integer i;
  
  half_adder u1 (.a(A), .b(B), .sum(SUM), .cout(COUT));
  
  initial 
    begin
      
      A <= 1'b0;
      B <= 1'b0;
      
      
      $monitor ("A=%b, B=%b, SUM=%b, CARRY=%b", A,B,SUM,COUT);
      
      for (i = 0; i<4; i=i+1)
        begin
          {A, B} = i;
          #10;
        end
    end
endmodule
