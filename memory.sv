module memory (clk, reset, addr, wr_en, rd_en, wdata, rdata);
  
  input logic clk, rst, wr_en, rd_en;
  input logic [1:0] addr;
  input logic [7:0] wdata;
  output logic [7:0] rdata;
  
  logic [7:0] mem [3:0];
  
  logic [7:0] read_data_reg;
  assign rdata = read_data_reg;
  
  always @(posedge clk or posedge rst)
    begin
      if (reset)
        begin
          mem[0] <= 8'hFF;
          mem[1] <= 8'hFF;
          mem[2] <= 8'hFF;
          mem[3] <= 8'hFF;
          read_data_reg <= 0;
        end
      else 
        begin
          if (wr_en)
            begin
              mem[addr] <= wdata;
            end
          if (rd_en)
            begin
              read_data_reg <= mem[addr];
            end
        end
    end
  
endmodule      
