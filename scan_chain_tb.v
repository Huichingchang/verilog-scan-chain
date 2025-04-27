`timescale 1ns/1ps
module scan_chain_tb;
	reg clk;
	reg rst_n;
	reg scan_en;
	reg scan_in;
	wire scan_out;
	
	//實例化 UUT(Unit Under Test)
	scan_chain uut(
		.clk(clk),
		.rst_n(rst_n),
		.scan_en(scan_en),
		.scan_in(scan_in),
		.q(q)
	);
	
	initial begin
	   //初始化訊號
		clk  = 0;
		rst_n = 0;
		scan_en = 0;
		scan_in = 0;
		
		//釋放Reset
		#10;
		rst_n = 1;
		
		
		//Normal模式(scan_en=0)
		#10;
		scan_en = 0;
		scan_in = 0;
		
		//切換到Scan模式(scan_en=1)
		#20;
		scan_en = 1;
		
		//開始送Scan資料(像是送"1011")
		scan_in = 1; #10;
		scan_in = 0; #10;
		scan_in = 1; #10;
		scan_in = 1; #10;
		
		//Scan模式完成,回Normal模式
		scan_en = 0;
		scan_in = 0;
		
		#50;
		$finish;
	end
	
	always #5 clk = ~clk;
endmodule
		
		