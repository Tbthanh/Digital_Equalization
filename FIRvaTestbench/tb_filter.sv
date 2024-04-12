module tb_filter; 

int i; 
reg clk;
reg rst_n;
reg signed[15:0] data_in;

wire signed[15:0] data_out;

reg[15:0] data_in_array[0:255];


filter dut( // instantine dut
	.clk(clk),
	.rst_n(rst_n),
	.xn(data_in),
	.yn(data_out)
	);

initial begin // khoi tao clk
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin // khoi tao reset
	rst_n = 0;
	data_in = 0;
	i = 0;
end


initial begin // doc file txt 
$readmemb("input_wave_binary.txt", data_in_array);
end


initial begin 
	#10 rst_n = 1; 
end

initial begin
	#15;
	for (int i = 0; i < 256; i = i + 1) begin
		data_in = data_in_array[i];
		#20;
	end
end

initial begin
$finish;
end 
endmodule : tb_filter
