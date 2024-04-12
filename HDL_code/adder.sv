module adder  #(
	parameter Q = 15,	// fractional-bits
	parameter N = 32	// total-bits
)
(
    input 	logic [N - 1 : 0] a,
    input 	logic [N - 1 : 0] b,
    output	logic [N - 1 : 0] c
);

	logic [N - 1 : 0] result;
	assign c = result;

// In this case:
// (Q,N) = (15,32) => 1 sign-bit + 16 integer-bits + 15 fractional-bits = 32 total-bits
//
//                    |S|IIIIIIIIIIIIIIII|FFFFFFFFFFFFFFF|
//
//
//Since we supply every negative number in it's 2's complement form by default, all we 
//need to do is add these two numbers together (note that to subtract a binary number 
//is the same as to add its two's complement)

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
			result[N-2:0] = b[N-2:0] - a[N-2:0];			
			if (result[N-2:0] == 0)
			result[N-1] = 0;										
			else
			result[N-1] = 1;									
			end
		end
		else 
		begin												
		if( a[N-2:0] > b[N-2:0] ) 
		begin					
		result[N-2:0] = a[N-2:0] - b[N-2:0];			
		if (result[N-2:0] == 0)
		result[N-1] = 0;										
		else
		result[N-1] = 1;										
		end
		else 
		begin												
		result[N-2:0] = b[N-2:0] - a[N-2:0];			
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