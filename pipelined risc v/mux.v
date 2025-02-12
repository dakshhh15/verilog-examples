module mux (output [31:0] c,
            input [31:0] a, b,
            input s);
  assign c = (s) ? b : a;
endmodule
