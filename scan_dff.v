`timescale 1ns/1ps
module scan_dff (
	input wire clk, //時脈
	input wire rst_n, //非同步Reset
	input wire scan_en, //Scan模式控制(1=Scan模式,0=正常模式)
	input wire d, //正常資料輸入
	input wire scan_in, //Scan資料輸
	output reg q //輸出
);

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		q <= 0;
	end else if(scan_en) begin
		q <= scan_in; //Scan模式:走scan_in
	end else begin
		q <= d; //正常模式:走正常d
	end
end

endmodule