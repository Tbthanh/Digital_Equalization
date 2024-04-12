module filter (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input signed [15:0] xn,
	input signed [15:0] coef[15:0],

	output signed [15:0] yn
);

	// define khoi delay
	reg signed [15:0] delay_pipeline[15:0];

	// // define he so : coefficient
	// wire signed [15:0] coef[15:0];

	// assign coef[0] = ;
	// assign coef[1] = ;
	// assign coef[2] = ;
	// assign coef[3] = ;
	// assign coef[4] = ;
	// assign coef[5] = ;
	// assign coef[6] = ;
	// assign coef[7] = ;
	// assign coef[8] = ;
	// assign coef[9] = ;
	// assign coef[10] = ;
	// assign coef[11] = ;
	// assign coef[12] = ;
	// assign coef[13] = ;
	// assign coef[14] = ;
	// assign coef[15] = ;

	// define multiplier : bo nhan
	reg signed [15:0] product[15:0];


	// define tổng buffer 
	reg signed [15:0] sum_buff;

	//define input cua buffer
	reg signed [15:0] data_in_buff;



	// FF nhận data buffer 
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			data_in_buff <= 0;
		end
		else begin
			data_in_buff <= filter_in;
		end
	end

	// Đường pipeline của các khối delay
	always @(posedge clk or negedge rst_n) begin
		if (!rst) begin
			delay_pipeline[0] <= 0;
			delay_pipeline[1] <= 0;
			delay_pipeline[2] <= 0 ;
			delay_pipeline[3] <= 0 ;
			delay_pipeline[4] <= 0 ;
			delay_pipeline[5] <= 0 ;
			delay_pipeline[6] <= 0 ;
			delay_pipeline[7] <= 0 ;
			delay_pipeline[8] <= 0 ;
			delay_pipeline[9] <= 0 ;
			delay_pipeline[10] <= 0 ;
			delay_pipeline[11] <= 0 ;
			delay_pipeline[12] <= 0 ;
			delay_pipeline[13] <= 0 ;
			delay_pipeline[14] <= 0 ;
			delay_pipeline[15] <= 0 ;
		end
		else begin
			delay_pipeline[0] <= data_in_buff;
			delay_pipeline[1] <= delay_pipeline[0];
			delay_pipeline[2] <= delay_pipeline[1];
			delay_pipeline[3] <= delay_pipeline[2];
			delay_pipeline[4] <= delay_pipeline[3];
			delay_pipeline[5] <= delay_pipeline[4];
			delay_pipeline[6] <= delay_pipeline[5];
			delay_pipeline[7] <= delay_pipeline[6];
			delay_pipeline[8] <= delay_pipeline[7];
			delay_pipeline[9] <= delay_pipeline[8];
			delay_pipeline[10] <= delay_pipeline[9];
			delay_pipeline[11] <= delay_pipeline[10];
			delay_pipeline[12] <= delay_pipeline[11];
			delay_pipeline[13] <= delay_pipeline[12];
			delay_pipeline[14] <= delay_pipeline[13];
			delay_pipeline[15] <= delay_pipeline[14];
		end
	end

	// Nối  bộ nhân với coefficient
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			product[0] <= 0;
			product[1] <= 0;
			product[2] <= 0;
			product[3] <= 0;
			product[4] <= 0;
			product[5] <= 0;
			product[6] <= 0;
			product[7] <= 0;
			product[8] <= 0;
			product[9] <= 0;
			product[10] <= 0;
			product[11] <= 0;
			product[12] <= 0;
			product[13] <= 0;
			product[14] <= 0;
			product[15] <= 0;
		end
		else begin
		product[0] <= coef[0] * delay_pipeline[0];
		product[1] <= coef[1] * delay_pipeline[1];
		product[2] <= coef[2] * delay_pipeline[2];
		product[3] <= coef[3] * delay_pipeline[3];
		product[4] <= coef[4] * delay_pipeline[4];
		product[5] <= coef[5] * delay_pipeline[5];
		product[6] <= coef[6] * delay_pipeline[6];
		product[7] <= coef[7] * delay_pipeline[7];
		product[8] <= coef[8] * delay_pipeline[8];
		product[9] <= coef[9] * delay_pipeline[9];
		product[10] <= coef[10] * delay_pipeline[10];
		product[11] <= coef[11] * delay_pipeline[11];
		product[12] <= coef[12] * delay_pipeline[12];
		product[13] <= coef[13] * delay_pipeline[13];
		product[14] <= coef[14] * delay_pipeline[14];
		product[15] <= coef[15] * delay_pipeline[15];			
		end
	end

	// Phép cộng cuối 
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			sum_buff <= 0;
		end
		else begin
			sum_buff <= product[0] + product[1] + product[2] + product[3] + product[4] + product[5] + product[6] + product[7] + product[8] +
	product[9] + product[10] + product[11] + product[12] + product[13] + product[14] + product[15];
	end
	end

	always@ (sum_buff) begin
		if (!rst_n) begin
			filter_out = 0;
			end
		else begin
			filter_out = sum_buff;
		end
	end
endmodule : filter
