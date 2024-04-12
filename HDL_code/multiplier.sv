module multiplier (
	input 	logic [15:0] a, b,
	output 	logic [15:0] c 	
);
	parameter N = 16;

	logic [2*N - 1:0]	result;
	logic [N - 1:0] finalResult;
	assign c = finalResult;

	always @(a, b)	
	begin						
		result <= a[N - 2:0] * b[N - 2:0];													
	end
	
	always @(result) 
	begin											
		finalResult[N - 1] <= a[N - 1] ^ b[N - 1];	
		// finalResult[N - 2:0] <= result[29:15];
		finalResult[N - 2:0] <= result[14:0];							
	end



endmodule : multiplier