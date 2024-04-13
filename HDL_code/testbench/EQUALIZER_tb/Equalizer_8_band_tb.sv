module Equalizer_8_band_tb ();

	reg t_clk, t_rst;
	reg signed [15:0] stim_x;
	reg signed [7:0] gud [7:0];
	wire signed [15:0] out_y;
	reg signed [15:0]correct_y;

	parameter inbit = 288000;

	reg[15:0] data_in_array[inbit - 1:0];

	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #10 ~t_clk; //clock switches value every 20ns
	end

	// gain value
	assign gud[0] = 8'd1;
	assign gud[1] = 8'd1;
	assign gud[2] = 8'd1;
	assign gud[3] = 8'd1;
	assign gud[4] = 8'd1;
	assign gud[5] = 8'd1;
	assign gud[6] = 8'd1;
	assign gud[7] = 8'd1;

	Equalizer_8_band dut(.clk(t_clk), .rst_n(t_rst), .x(stim_x), .g(gud), .y(out_y));

	integer i, f;
	initial begin // khoi tao reset
	t_rst = 0;
	stim_x = 0;
	i = 0;
	end


	initial begin // doc file txt 
	$readmemb("input_wave_binary.txt", data_in_array);
	end


	initial begin 
		#10 t_rst = 1; 
	end

	initial begin
		#10;
		for (i = 0; i < inbit; i = i + 1) begin
			stim_x = data_in_array[i];
			#20;
		end
	end

	initial begin
  		f = $fopen("output.txt","w");

  		// @(negedge t_rst); //Wait for reset to be released
  		// @(posedge t_clk);   //Wait for fisrt clock out of reset

  		for (i = 0; i<inbit; i=i+1) 
  		begin
    		$fwrite(f,"%b\n",out_y[i]);
  		end

  		$fclose(f);  
	end

	initial begin
		$finish;
	end 



	// initial $monitor ("a = %t, xn = %b, yn = %b", $time, stim_xn, out_yn);
	// always @(out_yn or correct_yn)
	// begin
	// 	if (out_yn!=correct_yn) 
	// 		$display("t = %t FAILED, xn = %b, out_yn = %b, correct = %b\n", $time, stim_xn, out_yn, correct_yn);
	// end

	// initial //direct input generation
	// begin
	// 	t_rst = 1;
	// 	#10 t_rst = 0;
	// 	#10 t_rst = 1;
	// 	stim_xn = 0; correct_yn = 0;

	// 	#10 stim_xn = 16'b1111111100010111; correct_yn = 1;	// 1
	// 	#10 stim_xn = 16'b0000001101101000; correct_yn = 1;	// 2
	// 	#10 stim_xn = 16'b0000000010111000; correct_yn = 1;	// 3
	// 	#10 stim_xn = 16'b0000000000010110; correct_yn = 1;	// 4
	// 	#10 stim_xn = 16'b0000001010000011; correct_yn = 1;	// 5
	// 	#10 stim_xn = 16'b0000001011101110; correct_yn = 1;	// 6
	// 	#10 stim_xn = 16'b1111111110111010; correct_yn = 1;	// 7
	// 	#10 stim_xn = 16'b0000000001000001; correct_yn = 1;	// 8
	// 	#10 stim_xn = 16'b1111111100000010; correct_yn = 1;	// 9
	// 	#10 stim_xn = 16'b1111110101111001; correct_yn = 1;	// 10
	// end

endmodule : Equalizer_8_band_tb