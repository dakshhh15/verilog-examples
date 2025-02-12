module Sign_Ext (output [31:0] Imm_Ext,
                 input [31:0] In);
  
  assign Imm_Ext = (In[31]) ? {{20{1'b1}}, In[31:20]} : {{20{1'b0}}, In[31:20]};
  
endmodule
