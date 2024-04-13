module Equalizer_8_band_tb ();

	reg t_clk, t_rst;
	reg signed [15:0] stim_x;
	reg signed [7:0] gud [7:0];
	wire signed [15:0] out_y;
	// reg signed [15:0]correct_y;

	parameter inbit = 288000;

	reg[15:0] data_in_array[inbit - 1:0];

	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #10 ~t_clk; //clock switches value every 10ns
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

	integer i, fread, fwrite, count;
	initial begin // khoi tao reset
		t_rst = 0;
		fread = $fopen("input_wave_binary.txt","r");
		fwrite = $fopen("output.txt","w");
		stim_x = 0;
		count = 0;
		#100
		t_rst = 1;
		#50
		for (i = 0; i < inbit; i = i + 1) begin
			@(posedge t_clk);
				$fscanf(fread,"%h",stim_x);
		end
		$fclose(fread);
	end

	always @(posedge t_clk) begin : proc_something
		$fwrite(fwrite, out_y,"\n");
		count = count + 1;
		if(count == inbit - 1)
		begin
			$fclose(fwrite);
			$finish;
		end
	end

  	// initial begin
  	// 	stim_x = 0;
	// 	t_clk=0; 
	// 	t_rst=1; //Clock low at time zero
	// 	@(posedge t_clk);
	// 	@(posedge t_clk);
	// 	t_rst=0;
	// end


	// initial begin // doc file txt 
	// $readmemb("input_wave_binary.txt", data_in_array);
	// end


	// initial begin 
	// 	#10 t_rst = 1; 
	// end

	// initial begin
	// 	#10;
	// 	for (i = 0; i < inbit; i = i + 1) begin
	// 		stim_x = data_in_array[i];
	// 		#20;
	// 	end
	// end

	// initial begin
  	// 	f = $fopen("output.txt","w");

  	// 	for (i = 0; i<inbit; i=i+1) 
  	// 	begin
  	// 		@(posedge t_clk);
	// 		// lfsr[i] <= out;
	// 		// $display("LFSR %b", out);
	// 		// $fwrite(f,"%b\n",   out);
    // 		$fwrite(f,"%b\n",out_y[i]);
  	// 	end

  	// 	$fclose(f);  
	// end

	// initial begin
	// 	$finish;
	// end

endmodule : Equalizer_8_band_tb