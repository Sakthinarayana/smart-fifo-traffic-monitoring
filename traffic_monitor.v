module traffic_monitor(
input clk,
input rst,
input wr_en,
input rd_en,
input full,
input empty,
output reg [15:0] write_counter,
output reg [15:0] read_counter,
output reg [7:0] occupancy_count,
output reg [15:0] cycle_counter
);

always @(posedge clk or posedge rst)
begin

if(rst)
begin
write_counter<=0;
read_counter<=0;
occupancy_count<=0;
cycle_counter<=0;
end

else
begin

cycle_counter<=cycle_counter+1;

if(wr_en && !full)
begin
write_counter<=write_counter+1;
occupancy_count<=occupancy_count+1;
end

if(rd_en && !empty)
begin
read_counter<=read_counter+1;
occupancy_count<=occupancy_count-1;
end

end

end

endmodule
