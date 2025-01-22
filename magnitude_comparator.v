//design
module magnitude_comp (output agb, aeb, alb,
                       input [3:0] a,b);
  
  //4th bit
  wire a3b, b3b, x1, x2, a31;
  not (a3b, a[3]);
  not (b3b, b[3]);
  
  and (x1, a3b, b[3]);
  and (x2, b3b, a[3]);
  nor (a31, x1, x2);
  
  //3rd bit
  wire a2b, b2b, x3, x4, a21;
  not (a2b, a[2]);
  not (b2b, b[2]);
  
  and (x3, a2b, b[2]);
  and (x4, b2b, a[2]);
  nor (a21, x3, x4);
  
  //2nd bit
  wire a1b, b1b, x5, x6, a11;
  not (a1b, a[1]);
  not (b1b, b[1]);
  
  and (x5, a1b, b[1]);
  and (x6, b1b, a[1]);
  nor (a11, x5, x6);
  
  //1st bit
  wire a0b, b0b, x7, x8, a01;
  not (a0b, a[0]);
  not (b0b, b[0]);
  
  and (x7, a0b, b[0]);
  and (x8, b0b, a[0]);
  nor (a11, x7, x8);
  
  //second stage
  wire o1,o2,o3,o4,o5,o6;
  and (o1, a31, x1);
  and (o2, a31, x4);
  and (o3, a31, a21, x5);
  and (o4, a31, a21, x6);
  and (o5, a31, a21, a11, x7);
  and (o6, a31, a21, a11, x8);
  and (aeb, a31, a21, a11, a01);
  
  //third stage
  or (alb, x1, o1, o3, o5);
  or (agb, o2, x2, o4, o6);
  
endmodule

//testbench
module tb;
  reg [3:0] A,B;
  wire AGB, AEB, ALB;
  integer i,j;
  
  magnitude_comp i1 (.a(A), .b(B), .agb(AGB), .aeb(AEB), .alb(ALB));
  
  initial 
    begin
      A <= 4'b0000;
      B <= 4'b0000;      
      
      $monitor("time=%t, a=%b, b=%b, agb=%b, aeb=%b, alb=%b", $time, A,B,AGB,AEB,ALB);
      
      for (i=0; i<16; i=i+1)
        for (j=0; j<16; j=j+1)
          begin
            A= i;
            B= j;
            #10;
          end      
    end
endmodule
  
