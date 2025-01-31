//design
module q5(output reg o0, o1, o2, o3,
	  input in1, in2);

always@(in1,in2)
	begin
		if({in2,in1} == 2'b00)
			{o3,o2,o1,o0} <= 4'b0001;
		else if({in2,in1} == 2'b01)
			{o3,o2,o1,o0} <= 4'b0010;
		else if({in2,in1} == 2'b10)
			{o3,o2,o1,o0} <= 4'b0100;
		else if({in2,in1} == 2'b11)
			{o3,o2,o1,o0} <= 4'b1000;
		else
			{o3,o2,o1,o0} <= 4'b0000;
	end

endmodule

//testbench
module tb;
  wire O0, O1, O2, O3;
  reg IN1, IN2;
  integer i;

  q5 i1 (.in1(IN1), .in2(IN2), .o0(O0), .o1(O1), .o2(O2), .o3(O3));

initial 
	begin
		IN1 <= 1'b0;
		IN2 <= 1'b0;

		$monitor("time=%t, in2=%b, in1=%b, o3=%b, 02=%b, 01=%b, o0=%b", $time, IN2, IN1, O3, O2, O1, O0);

		for(i=0; i<4; i=i+1)
			begin
				{IN2,IN1} = i;
				#10;
			end
	end
endmodule
