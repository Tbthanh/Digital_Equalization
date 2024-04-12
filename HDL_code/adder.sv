module adder  #(
	parameter N = 16	// total-bits
)
(
    input 	logic [N - 1 : 0] a,
    input 	logic [N - 1 : 0] b,
    output	logic [N - 1 : 0] c
);

	logic [N - 1 : 0] result;
	assign c = result;

	always @(a,b) 
	begin
		if(a[N - 1] == b[N - 1]) 
		begin						
			result[N - 2 : 0] = a[N - 2 : 0] + b[N - 2 : 0];		
			result[N - 1] = a[N - 1];						
		end											
		else if(a[N - 1] == 0 && b[N - 1] == 1) 
		begin
			if( a[N - 2 : 0] > b[N - 2 : 0] ) 
			begin					
				result[N - 2 : 0] = a[N - 2 : 0] - b[N - 2 : 0];			
				result[N - 1] = 0;										
			end
			else 
			begin												
				result[N - 2 : 0] = b[N - 2 : 0] - a[N - 2 : 0];			
				if (result[N - 2 : 0] == 0)
					result[N - 1] = 0;										
				else
					result[N - 1] = 1;									
			end
		end
		else 
		begin												
			if( a[N - 2 : 0] > b[N - 2 : 0] ) 
			begin					
				result[N - 2 : 0] = a[N - 2 : 0] - b[N - 2 : 0];			
				if (result[N - 2 : 0] == 0)
					result[N - 1] = 0;										
				else
					result[N - 1] = 1;										
			end
			else 
			begin												
				result[N - 2 : 0] = b[N - 2 : 0] - a[N - 2 : 0];			
				result[N-1] = 0;										
			end
		end
	end


endmodule : adder

/*
Reference:
	https://github.com/Mehdi0xC/SystemVerilog-FixedPoint-Arithmetic/blob/8e36ee03258bf7554d0aaed4897cd01342891ef6/adder.sv
	https://thedatabus.io/fixed-point?fbclid=IwAR02-f_cmxg8-c92_rK1k3aleQTpni2s-hmU0qAxFK6H54si98jXDmSBFNE_aem_AWQx0J6E3adM5C6HwH-x-Ae4IQLaGlwSdc5xHbAA7hRaH8tk2V0PyXD6yDzSkZ-upHnxbF_UVwJYbgJZquYPyMJh
*/
