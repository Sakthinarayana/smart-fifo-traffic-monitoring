module smart_fifo_top(
input clk,
input rst,
input wr_en,
input rd_en,
input [31:0] data_in,
output [31:0] data_out,
output full,
output empty,
output overflow,
output underflow,
output [7:0] utilization_percent,
output [1:0] traffic_level,
output congestion_alert
);

wire [6:0] wr_ptr;
wire [6:0] rd_ptr;

wire [7:0] occupancy_count;

wire [15:0] write_counter;
wire [15:0] read_counter;

wire congestion;

wire almost_full;
wire almost_empty;

wire overflow_alert;
wire underflow_alert;

wire [15:0] write_throughput;
wire [15:0] read_throughput;

wire [31:0] bytes_transferred;

wire [15:0] monitoring_window;

fifo_memory u_fifo_memory(
.clk(clk),
.wr_en(wr_en),
.rd_en(rd_en),
.wr_ptr(wr_ptr),
.rd_ptr(rd_ptr),
.data_in(data_in),
.data_out(data_out)
);

write_controller u_write_controller(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.occupancy_count(occupancy_count),
.wr_ptr(wr_ptr),
.full(full),
.overflow(overflow)
);

read_controller u_read_controller(
.clk(clk),
.rst(rst),
.rd_en(rd_en),
.occupancy_count(occupancy_count),
.rd_ptr(rd_ptr),
.empty(empty),
.underflow(underflow)
);

traffic_monitor u_traffic_monitor(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.rd_en(rd_en),
.full(full),
.empty(empty),
.write_counter(write_counter),
.read_counter(read_counter),
.occupancy_count(occupancy_count),
.cycle_counter()
);

occupancy_analyzer u_occupancy_analyzer(
.occupancy_count(occupancy_count),
.utilization_percent(utilization_percent),
.traffic_level(traffic_level),
.congestion(congestion)
);

throughput_monitor u_throughput_monitor(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.rd_en(rd_en),
.full(full),
.empty(empty),
.write_throughput(write_throughput),
.read_throughput(read_throughput),
.bytes_transferred(bytes_transferred),
.monitoring_window(monitoring_window)
);

alert_generator u_alert_generator(
.occupancy_count(occupancy_count),
.overflow(overflow),
.underflow(underflow),
.congestion(congestion),
.almost_full(almost_full),
.almost_empty(almost_empty),
.overflow_alert(overflow_alert),
.underflow_alert(underflow_alert),
.congestion_alert(congestion_alert)
);

endmodule
