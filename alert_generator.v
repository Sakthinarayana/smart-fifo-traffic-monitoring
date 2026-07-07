module alert_generator(
input [7:0] occupancy_count,
input overflow,
input underflow,
input congestion,
output reg almost_full,
output reg almost_empty,
output reg overflow_alert,
output reg underflow_alert,
output reg congestion_alert
);

always @(*)
begin

almost_full=0;
almost_empty=0;
overflow_alert=0;
underflow_alert=0;
congestion_alert=0;

if(occupancy_count>=96)
begin
almost_full=1;
end

if(occupancy_count<=16)
begin
almost_empty=1;
end

if(overflow)
begin
overflow_alert=1;
end

if(underflow)
begin
underflow_alert=1;
end

if(congestion)
begin
congestion_alert=1;
end

end

endmodule
