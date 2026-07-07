module occupancy_analyzer(
input [7:0] occupancy_count,
output reg [7:0] utilization_percent,
output reg [1:0] traffic_level,
output reg congestion
);

always @(*)
begin

utilization_percent=(occupancy_count*100)/128;

if(utilization_percent<=25)
begin
traffic_level=2'b00;
congestion=0;
end

else if(utilization_percent<=50)
begin
traffic_level=2'b01;
congestion=0;
end

else if(utilization_percent<=75)
begin
traffic_level=2'b10;
congestion=0;
end

else
begin
traffic_level=2'b11;
congestion=1;
end

end

endmodule
