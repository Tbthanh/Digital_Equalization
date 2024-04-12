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

	// connection between gain and adder module
	wire ga0, ga1, ga2, ga3, ga4, ga5, ga6, ga7;
	wire ga01, ga23, ga45, ga67
;	wire ga13, ga47;

	// initialize filter module:
	filter fil00 (.clk(clk), .rst_n(rst_n), .xn(x), .yn(fg0);
	filter fil01 (.clk(clk), .rst_n(rst_n), .xn(x), .yn(fg1);
	// filter ...

	// initialize gain module:
	gain gain00 (.clk(clk), .rst_n(rst_n), .xn(x), .gk(g0), .yn(ga0));

	// initialize addition module:
	adder adder00 (); // add fil-gain0 and fil-gain1
	// ...
	adder adder_1_to_7(.clk(clk), .rst_n(rst_n), .x1(ga13), .x2(.ga47), .yn(y));

endmodule : Equalizer_8_band