`timescale 1ns/1ps
module scan_chain(
	input wire clk,
	input wire rst_n,
	input wire scan_en,
	input wire scan_in,
	input wire [2:0] d, //正常模式的資料輸入
	output wire [2:0] q, //資料輸出
	output wire scan_out //新增Scan Chain出口
);

//內部連接用wire
wire q0,q1,q2;
//三顆Scan DFF串聯
scan_dff u0(
	.clk(clk),
	.rst_n(rst_n),
	.scan_en(scan_en),
	.d(d[0]),
	.scan_in(scan_in),
	.q(q0)
);

scan_dff u1(
	.clk(clk),
	.rst_n(rst_n),
	.scan_en(scan_en),
	.d(d[1]),
	.scan_in(q0), //由上一顆q0接進來
	.q(q1)
);

scan_dff u2(
	.clk(clk),
	.rst_n(rst_n),
	.scan_en(scan_en),
	.d(d[2]),
	.scan_in(q1), //由上一顆q1接進來
	.q(q2)
);

//最後的輸出(整理成q[2:0])
assign q[0]=q0;
assign q[1]=q1;
assign q[2]=q2;
assign scan_out = q2;
endmodule