module read_controller(
input clk,
input rst,
input rd_en,
input [7:0] occupancy_count,
output reg [6:0] rd_ptr,
output empty,
output reg underflow
);

assign empty=(occupancy_count==0);

always @(posedge clk or posedge rst)
begin

if(rst)
begin
rd_ptr<=0;
underflow<=0;
end

else
begin

if(rd_en && !empty)
begin
rd_ptr<=rd_ptr+1;
underflow<=0;
end

else if(rd_en && empty)
begin
underflow<=1;
end

else
begin
underflow<=0;
end

end

end

endmodule
