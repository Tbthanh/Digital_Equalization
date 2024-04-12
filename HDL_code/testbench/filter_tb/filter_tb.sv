module filter_tb ();
	reg t_clk, t_rst;
	reg [15:0]stim_a;
	reg [15:0]stim_b;
	wire [15:0]out_c;
	reg [15:0]correct_c;

	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns
	end

	multiplier dut(.a(stim_a), .b(stim_b), .c(out_c));
	initial $monitor ("a = %t, a = %b, b = %b, c = %b\n", $time, stim_a, stim_b, out_c);
	always @(out_c or correct_c)
	begin
		if (out_c!=correct_c) 
			$display("t = %t FAILED, a = %b, b = %b, c = %b, correct = %b\n", $time, stim_a, stim_b, out_c, correct_c);
	end

	initial //direct input generation
	begin
		t_rst = 1;
		#2 t_rst = 0;
		#7 t_rst = 1;
		
		stim_a = 0;
		stim_b = 0; 
		correct_c = 0;

		#5 stim_a = 10;	stim_b = 10; correct_c = 100;
		#5 stim_a = 8;	stim_b = -8; correct_c = -64;
		#5 stim_a = -9;	stim_b = 9; correct_c = 81;
		#5 stim_a = 1;	stim_b = 0; correct_c = 0;
		#5 stim_a = 0;	stim_b = 1; correct_c = 0;
		#5 stim_a = -3731;	stim_b = 8; correct_c = -29858;
	end


endmodule : filter_tb