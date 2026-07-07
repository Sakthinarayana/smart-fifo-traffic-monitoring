module write_controller(
input clk,
input rst,
input wr_en,
input [7:0] occupancy_count,
output reg [6:0] wr_ptr,
output full,
output reg overflow
);

assign full=(occupancy_count==128);

always @(posedge clk or posedge rst)
begin

if(rst)
begin
wr_ptr<=0;
overflow<=0;
end

else
begin

if(wr_en && !full)
begin
wr_ptr<=wr_ptr+1;
overflow<=0;
end

else if(wr_en && full)
begin
overflow<=1;
end

else
begin
overflow<=0;
end

end

end

endmodule
