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

	// assign coeficient for 8 filter
		// filter no 00
	reg signed [15:0] coef_n0[15:0];
	assign coef_n0[0] = 338;
	assign coef_n0[1] = 533;
	assign coef_n0[2] = 1080;
	assign coef_n0[3] = 1872;
	assign coef_n0[4] = 2754;
	assign coef_n0[5] = 3550;
	assign coef_n0[6] = 4102;
	assign coef_n0[7] = 4300;
	assign coef_n0[8] = 4102;
	assign coef_n0[9] = 3550;
	assign coef_n0[10] = 2754;
	assign coef_n0[11] = 1872;
	assign coef_n0[12] = 1080;
	assign coef_n0[13] = 533;
	assign coef_n0[14] = 338;

		// filter no 01
	reg signed [15:0] coef_n1[15:0];
	assign coef_n1[0] = 318;
	assign coef_n1[1] = 514;
	assign coef_n1[2] = 1064;
	assign coef_n1[3] = 1876;
	assign coef_n1[4] = 2798;
	assign coef_n1[5] = 3641;
	assign coef_n1[6] = 4231;
	assign coef_n1[7] = 4443;
	assign coef_n1[8] = 4231;
	assign coef_n1[9] = 3641;
	assign coef_n1[10] = 2798;
	assign coef_n1[11] = 1876;
	assign coef_n1[12] = 1064;
	assign coef_n1[13] = 514;
	assign coef_n1[14] = 318;

		// filter no 02
	reg signed [15:0] coef_n2[15:0];
	assign coef_n2[0] = 237;
	assign coef_n2[1] = 433;
	assign coef_n2[2] = 981;
	assign coef_n2[3] = 1855;
	assign coef_n2[4] = 2909;
	assign coef_n2[5] = 3919;
	assign coef_n2[6] = 4646;
	assign coef_n2[7] = 4911;
	assign coef_n2[8] = 4646;
	assign coef_n2[9] = 3919;
	assign coef_n2[10] = 2909;
	assign coef_n2[11] = 1855;
	assign coef_n2[12] = 981;
	assign coef_n2[13] = 433;
	assign coef_n2[14] = 237;

		// filter no 03
	reg signed [15:0] coef_n3[15:0];
	assign coef_n3[0] = -124;
	assign coef_n3[1] = 6;
	assign coef_n3[2] = 434;
	assign coef_n3[3] = 1442;
	assign coef_n3[4] = 3003;
	assign coef_n3[5] = 4751;
	assign coef_n3[6] = 6132;
	assign coef_n3[7] = 6657;
	assign coef_n3[8] = 6132;
	assign coef_n3[9] = 4751;
	assign coef_n3[10] = 3003;
	assign coef_n3[11] = 1442;
	assign coef_n3[12] = 434;
	assign coef_n3[13] = 6;
	assign coef_n3[14] = -124;

		// filter no 04
	reg signed [15:0] coef_n4[15:0];
	assign coef_n4[0] = -483;
	assign coef_n4[1] = -929;
	assign coef_n4[2] = -1707;
	assign coef_n4[3] = -1765;
	assign coef_n4[4] = 47;
	assign coef_n4[5] = 3656;
	assign coef_n4[6] = 7360;
	assign coef_n4[7] = 8935;
	assign coef_n4[8] = 7360;
	assign coef_n4[9] = 3656;
	assign coef_n4[10] = 47;
	assign coef_n4[11] = -1765;
	assign coef_n4[12] = -1707;
	assign coef_n4[13] = -929;
	assign coef_n4[14] = -483;

		// filter no 05
	reg signed [15:0] coef_n5[15:0];
	assign coef_n5[0] = 115;
	assign coef_n5[1] = 528;
	assign coef_n5[2] = 687;
	assign coef_n5[3] = -1620;
	assign coef_n5[4] = -5355;
	assign coef_n5[5] = -3756;
	assign coef_n5[6] = 4752;
	assign coef_n5[7] = 10060;
	assign coef_n5[8] = 4752;
	assign coef_n5[9] = -3756;
	assign coef_n5[10] = -5355;
	assign coef_n5[11] = -1620;
	assign coef_n5[12] = 687;
	assign coef_n5[13] = 528;
	assign coef_n5[14] = 115;

		// filter no 06
	reg signed [15:0] coef_n6[15:0];
	assign coef_n6[0] = 102;
	assign coef_n6[1] = -377;
	assign coef_n6[2] = 190;
	assign coef_n6[3] = -379;
	assign coef_n6[4] = 3952;
	assign coef_n6[5] = -4479;
	assign coef_n6[6] = -6334;
	assign coef_n6[7] = 14703;
	assign coef_n6[8] = -6334;
	assign coef_n6[9] = -4479;
	assign coef_n6[10] = 3952;
	assign coef_n6[11] = -379;
	assign coef_n6[12] = 190;
	assign coef_n6[13] = -377;
	assign coef_n6[14] = 102;

		// filter no 07
	reg signed [15:0] coef_n7[15:0];
	assign coef_n7[0] = -88;
	assign coef_n7[1] = 238;
	assign coef_n7[2] = -686;
	assign coef_n7[3] = 1522;
	assign coef_n7[4] = -2664;
	assign coef_n7[5] = 3859;
	assign coef_n7[6] = -4768;
	assign coef_n7[7] = 5108;
	assign coef_n7[8] = -4768;
	assign coef_n7[9] = 3859;
	assign coef_n7[10] = -2664;
	assign coef_n7[11] = 1522;
	assign coef_n7[12] = -686;
	assign coef_n7[13] = 238;
	assign coef_n7[14] = -88;


	// connection between filter and gain
	wire [15:0] fg0, fg1, fg2, fg3, fg4, fg5, fg6, fg7;

	// connection between gain and adder module
	wire [15:0] ga0, ga1, ga2, ga3, ga4, ga5, ga6, ga7;
	wire [15:0] ga01, ga23, ga45, ga67;	
	wire [15:0] ga13, ga47;

	// initialize filter module:
	filter fil00 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n0), .yn(fg0));
	filter fil01 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n1), .yn(fg1));
	filter fil02 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n2), .yn(fg2));
	filter fil03 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n3), .yn(fg3));
	filter fil04 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n4), .yn(fg4));
	filter fil05 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n5), .yn(fg5));
	filter fil06 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n6), .yn(fg6));
	filter fil07 (.clk(clk), .rst_n(rst_n), .xn(x), .coef(coef_n7), .yn(fg7));
	

	// initialize gain module:
		// gain value
	reg signed [7:0] g0, g1, g2, g3, g4, g5, g6, g7;
	assign g0 = 1;
	assign g1 = 1; 
	assign g2 = 1; 
	assign g3 = 1; 
	assign g4 = 1; 
	assign g5 = 1; 
	assign g6 = 1;
	assign g7 = 1;  
		// gain module
	gain gain00 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g0), .yn(ga0));
	gain gain01 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g1), .yn(ga1));
	gain gain02 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g2), .yn(ga2));
	gain gain03 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g3), .yn(ga3));
	gain gain04 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g4), .yn(ga4));
	gain gain05 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g5), .yn(ga5));
	gain gain06 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g6), .yn(ga6));
	gain gain07 (.clk(clk), .rst_n(rst_n), .xn(x), .g(g7), .yn(ga7));

	

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