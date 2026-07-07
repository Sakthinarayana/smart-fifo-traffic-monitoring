`timescale 1ns/1ps

module smart_fifo_tb;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [31:0] data_in;

wire [31:0] data_out;
wire full;
wire empty;
wire overflow;
wire underflow;
wire [7:0] utilization_percent;
wire [1:0] traffic_level;
wire congestion_alert;

smart_fifo_top DUT(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.rd_en(rd_en),
.data_in(data_in),
.data_out(data_out),
.full(full),
.empty(empty),
.overflow(overflow),
.underflow(underflow),
.utilization_percent(utilization_percent),
.traffic_level(traffic_level),
.congestion_alert(congestion_alert)
);

initial
begin
clk=0;
forever #5 clk=~clk;
end

initial
begin

rst=1;
wr_en=0;
rd_en=0;
data_in=0;

#20;
rst=0;

#10;

wr_en=1;
data_in=32'h11;

#10;
data_in=32'h22;

#10;
data_in=32'h33;

#10;
data_in=32'h44;

#10;
wr_en=0;

#20;

rd_en=1;

#40;

rd_en=0;

#20;

repeat(130)
begin
@(posedge clk);
wr_en=1;
data_in=data_in+1;
end

wr_en=0;

#20;

repeat(130)
begin
@(posedge clk);
rd_en=1;
end

rd_en=0;

#100;

$finish;

end

endmodule
