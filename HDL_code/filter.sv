module filter (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input signed [15:0] xn,
	input signed [15:0] coef[15:0],

	output signed [15:0] yn
);
	// khoi delay
	reg [15:0] delay_x[14:0];
	integer i;
	always @(posedge clk or negedge rst_n) begin : proc_generate_delay
		if(~rst_n) 
		begin
			for (i = 0; i < 15; i = i + 1) 
			begin
				delay_x[i] <= 0;
			end
		end else 
		begin
			delay_x[0] <= xn;
			for (i = 1; i < 15; i = i + 1) 
			begin
				delay_x[i] <= delay_x[i - 1] ;
			end
		end
	end 

	// wire bo nhan voi bo cong
	wire [15:0] wa00, wa01, wa02, wa03, wa04, wa05, wa06;
	wire [15:0]wa07, wa08, wa09, wa10, wa11, wa12, wa13, wa14;

	// define multiplier : bo nhan
	multiplier a00 (.a(delay_x[0]), .b(coef[0]), .c(wa00));
	multiplier a01 (.a(delay_x[1]), .b(coef[1]), .c(wa01));
	multiplier a02 (.a(delay_x[2]), .b(coef[2]), .c(wa02));
	multiplier a03 (.a(delay_x[3]), .b(coef[3]), .c(wa03));
	multiplier a04 (.a(delay_x[4]), .b(coef[4]), .c(wa04));
	multiplier a05 (.a(delay_x[5]), .b(coef[5]), .c(wa05));
	multiplier a06 (.a(delay_x[6]), .b(coef[6]), .c(wa06));
	multiplier a07 (.a(delay_x[7]), .b(coef[7]), .c(wa07));
	multiplier a08 (.a(delay_x[8]), .b(coef[8]), .c(wa08));
	multiplier a09 (.a(delay_x[9]), .b(coef[9]), .c(wa09));
	multiplier a10 (.a(delay_x[10]), .b(coef[10]), .c(wa10));
	multiplier a11 (.a(delay_x[11]), .b(coef[11]), .c(wa11));
	multiplier a12 (.a(delay_x[12]), .b(coef[12]), .c(wa12));
	multiplier a13 (.a(delay_x[13]), .b(coef[13]), .c(wa13));
	multiplier a14 (.a(delay_x[14]), .b(coef[14]), .c(wa14));

	// wire cac bo cong voi nhau
	wire [15:0]	wad00, wad01, wad02, wad03, wad04, wad05;
	wire [15:0]	wad06, wad07,wad08, wad09, wad10, wad11, wad12;
	reg signed [15:0] wad13;

	// bo cong cac kieu con da dieu
	adder add00 (.a(wa00), .b(wa01), .c(wad00));
	adder add01 (.a(wad00), .b(wa02), .c(wad01));
	adder add02 (.a(wad01), .b(wa03), .c(wad02));
	adder add03 (.a(wad02), .b(wa04), .c(wad03));
	adder add04 (.a(wad03), .b(wa05), .c(wad04));
	adder add05 (.a(wad04), .b(wa06), .c(wad05));
	adder add06 (.a(wad05), .b(wa07), .c(wad06));
	adder add07 (.a(wad06), .b(wa08), .c(wad07));
	adder add08 (.a(wad07), .b(wa09), .c(wad08));
	adder add09 (.a(wad08), .b(wa10), .c(wad09));
	adder add10 (.a(wad09), .b(wa11), .c(wad10));
	adder add11 (.a(wad10), .b(wa12), .c(wad11));
	adder add12 (.a(wad11), .b(wa13), .c(wad12));
	adder add13 (.a(wad12), .b(wa14), .c(wad13));

	assign yn = wad13;

endmodule : filter
