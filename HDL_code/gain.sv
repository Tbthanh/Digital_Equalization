module gain (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input signed [15:0] xn,
	input signed [7:0] g,
	output signed [15:0] yn
);
	reg signed [15:0] g16;
	assign g16 = {g[7], 8'b00000000, g[6:0]};

	reg signed [15:0] result;
	multiplier mul (.a(xn), .b(g16),  .c(result));
	assign yn = result;

endmodule : gain