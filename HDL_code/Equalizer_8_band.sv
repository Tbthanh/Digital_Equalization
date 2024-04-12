module Equalizer_8_band (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low

	// txt input
	input [15:0] x,

	// gain input
	input [15:0] g [7:0],

	output [15:0] y
);
	reg [15:0]result;

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
	// gain ...

	// initialize addition module:
	adder adder_0_n_1(.a(ga0), .b(ga1), .c(ga01));
	adder adder_2_n_3(.a(ga2), .b(ga3), .c(ga23));
	adder adder_4_n_5(.a(ga4), .b(ga5), .c(ga45));
	adder adder_6_n_7(.a(ga6), .b(ga7), .c(ga67));

	adder adder_0_to_3(.a(ga01), .b(ga23), .c(ga13));
	adder adder_4_to_7(.a(ga45), .b(ga67), .c(ga47));
	
	adder adder_1_to_7(.a(ga13), .b(ga47), .c(result));

	assign y = result;

endmodule : Equalizer_8_band