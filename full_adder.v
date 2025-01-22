//design
module full_adder (output sum, cout,
                   input a, b, cin);
  
  assign {cout, sum} = a+b+cin;
  
endmodule

//testbench
module tb;
  reg A,B,CIN;
  wire SUM,COUT;
  integer i;
  
  full_adder u1 (.a(A), .b(B), .cin(CIN), .sum(SUM), .cout(COUT));
  
  initial 
    begin
      
      A <= 1'b0;
      B <= 1'b0;
      CIN <= 1'b0;
      
      $monitor ("a=%b, b=%b, cin=%b, sum =%b, cout =%b", A,B,CIN,SUM,COUT);
      
      for (i=0; i<16; i=i+1)
        begin
          {CIN, A, B} = i;
          #10;
        end
      
    end
endmodule
