module filter_tb ();
	reg t_clk, t_rst;
	reg signed [15:0] stim_xn;
	reg signed [15:0] t_coef[15:0];
	wire signed [15:0] out_yn;
	reg signed[15:0]correct_yn;

	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #20 ~t_clk; //clock switches value every 20ns
	end

	// t_coef value is imp_res1
	assign t_coef[0] = 338;
	assign t_coef[1] = 533;
	assign t_coef[2] = 1080;
	assign t_coef[3] = 1872;
	assign t_coef[4] = 2754;
	assign t_coef[5] = 3550;
	assign t_coef[6] = 4102;
	assign t_coef[7] = 4300;
	assign t_coef[8] = 4102;
	assign t_coef[9] = 3550;
	assign t_coef[10] = 2754;
	assign t_coef[11] = 1872;
	assign t_coef[12] = 1080;
	assign t_coef[13] = 533;
	assign t_coef[14] = 338;

	filter dut(.clk(t_clk), .rst_n(t_rst), .xn(stim_xn), .coef(t_coef), .yn(out_yn));
	initial $monitor ("a = %t, xn = %b, yn = %b", $time, stim_xn, out_yn);
	always @(out_yn or correct_yn)
	begin
		if (out_yn!=correct_yn) 
			$display("t = %t FAILED, a = %b, b = %b, c = %b, correct = %b\n", $time, stim_a, stim_b, out_c, correct_c);
	end

	initial //direct input generation
	begin
		t_rst = 1;
		#10 t_rst = 0;
		#10 t_rst = 1;
		stim_xn = 0; correct_yn = 0;

		#10 stim_xn = 16'b1111111100010111; correct_yn = 1;	// 1
		#10 stim_xn = 16'b0000001101101000; correct_yn = 1;	// 2
		#10 stim_xn = 16'b0000000010111000; correct_yn = 1;	// 3
		#10 stim_xn = 16'b0000000000010110; correct_yn = 1;	// 4
		#10 stim_xn = 16'b0000001010000011; correct_yn = 1;	// 5
		#10 stim_xn = 16'b0000001011101110; correct_yn = 1;	// 6
		#10 stim_xn = 16'b1111111110111010; correct_yn = 1;	// 7
		#10 stim_xn = 16'b0000000001000001; correct_yn = 1;	// 8
		#10 stim_xn = 16'b1111111100000010; correct_yn = 1;	// 9
		#10 stim_xn = 16'b1111110101111001; correct_yn = 1;	// 10
	end


endmodule : filter_tb