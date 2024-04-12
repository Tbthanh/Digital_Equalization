module Equalizer_8_band (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low

	// txt input
	input [15:0] x,

	// gain input
	input [15:0] g [7:0],

	output [15:0] y
);
	// connection between filter and gain
	wire fg0, fg1, fg2, fg3, fg4, fg5, fg6, fg7;

	// initialize filter module:
	filter fil00 (.clk(clk), .rst_n(rst_n), .xn(x), .yn(fg0);
	filter fil01 (.clk(clk), .rst_n(rst_n), .xn(x), .yn(fg1);
	// filter ...

	// initialize gain module:

	// initialize addition module:

endmodule : Equalizer_8_band