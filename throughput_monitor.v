module throughput_monitor(
input clk,
input rst,
input wr_en,
input rd_en,
input full,
input empty,
output reg [15:0] write_throughput,
output reg [15:0] read_throughput,
output reg [31:0] bytes_transferred,
output reg [15:0] monitoring_window
);

reg [15:0] write_transactions;
reg [15:0] read_transactions;

always @(posedge clk)
begin

if(rst)
begin
write_transactions <= 0;
read_transactions <= 0;
write_throughput <= 0;
read_throughput <= 0;
bytes_transferred <= 0;
monitoring_window <= 0;
end

else
begin

monitoring_window <= monitoring_window + 1;

if(wr_en && !full)
begin
write_transactions <= write_transactions + 1;
bytes_transferred <= bytes_transferred + 4;
end

if(rd_en && !empty)
begin
read_transactions <= read_transactions + 1;
end

if(monitoring_window == 1000)
begin
write_throughput <= write_transactions;
read_throughput <= read_transactions;
monitoring_window <= 0;
write_transactions <= 0;
read_transactions <= 0;
end

end

end

endmodule
