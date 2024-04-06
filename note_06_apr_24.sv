module name (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	...
	
);
	reg [15:0] delay_x[0:k];
	integer i;
	always @(posedge clk or negedge rst_n) begin : proc_
		if(~rst_n) 
		begin
			y <= 0;
			for (i = 0; i < k; i = i + 1) 
			begin
				delay_x[i] <= 0;
		end
		end else 
		begin
			for (i = 1; i < k; i = i + 1) 
			begin
				delay_x[i] <= delay_x[i - 1] ;
			end

			delay_x[0] <= x;
			y <= a[0]

		end
	end

endmodule : name