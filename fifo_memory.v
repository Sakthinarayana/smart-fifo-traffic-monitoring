module fifo_memory(
input clk,
input wr_en,
input rd_en,
input [6:0] wr_ptr,
input [6:0] rd_ptr,
input [31:0] data_in,
output reg [31:0] data_out
);

reg [31:0] fifo_mem [0:127];

always @(posedge clk)
begin
if(wr_en)
begin
fifo_mem[wr_ptr]<=data_in;
end
end

always @(posedge clk)
begin
if(rd_en)
begin
data_out<=fifo_mem[rd_ptr];
end
end

endmodule
