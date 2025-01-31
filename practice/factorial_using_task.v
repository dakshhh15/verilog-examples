//design
module factorial_4bit(input [3:0] num,
                      output reg [31:0] fact);
    
    task factorial;
        input [3:0] n;
        output [31:0] result;
        integer i;
        begin
            if (n == 0 || n == 1) 
                result = 1;  
            else
              begin
                result = 1;
                for (i = 1; i <= n; i = i + 1)
                  begin
                    result = result * i;
                  end
              end
        end
    endtask

    always @(*) begin
        factorial(num, fact);
    end

endmodule

//testbench
module tb;
  reg [3:0] NUM;
  wire [31:0] FACT;
  integer i;
  
  factorial_4bit i1 (.num(NUM), .fact(FACT));
  
  initial
    begin
      $monitor("time=%t || num = %d || numb = %b || out = %d || outb = %b", $time,NUM,NUM,FACT,FACT);
      
      for (i=0; i<16; i=i+1)
        begin
          NUM = i;
          #10;
        end
    end
  
endmodule
