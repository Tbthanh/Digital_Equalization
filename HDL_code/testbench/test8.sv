//input: x (1 bit)
//output: y (1 bit)
//I/O: y = 1 if input string is 101
module test8 (
	input x,
	output y,
	input clk,
	input rst_n //negative reset signal
);	

	// =: block assignment
	// <=: non-blocking assignment (basically means all the assigments are synchronous)
	// assign: continuous assignment
		localparam wait_1st_1 = 2'b00;
		localparam wait_0 = 2'b01;
		localparam wait_2nd_1 = 2'b10;
		reg [1:0] state, nextstate;
			
		//describe next state function delta and output function lambda
		always @(x or state)
		//in always block without clock -> always use blocking assignment
		begin
			//for nested control sequence, the first control sequence in the nest has the highest priority
			//for non-nested control sequence, the last control sequence has the highest priority
			y = 0; //only when state = wait_2nd_1 and x = 0 where y = 1 -> can remove all y = 0 in the control sequence
			nextstate = wait_0; //when x = 1 -> nextstate = wait_0 -> can remove all "else nextstate = wait_0"
			case (state)
				wait_1st_1: 
					if (x=0) nextstate = wait_1st_1;
					//else nextstate = wait_0;
				wait_0:
					if (x=0) nextstate = wait_2nd_1;
					//else nextstate = wait_0;
				wait_2nd_1:
					if (x=0) nextstate = wait_1st_1;
					else 	y = 1; //nextstate = wait_0;
				default: nextstate = wait_1st_1;
			endcase
		end
		
		//describe clock function
		always @(posedge clk or negedge rst_n) //when positive edge of clock or when negative edge of reset
		//in always block with clock -> always use non-blocking assignment
		begin
			if (~rst_n) 
			begin
				state <= wait_1st_1;
			end
			else begin
				state <= nextstate;
			end
		end
endmodule

`timescale 1ns/1ps

module fsm_testbench();
	reg t_clk, t_rst;
	reg stim_x;
	wire out_y;
	reg correct_y;
	
	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns
	end;
	
	test8 dut(.clk(t_clk), .rst_n(t_rst), .x(stim_x), .y(out_y));
	
	initial $monitor ("t = %t, x = %b, y = %b\n", $time, stim_x, out_y);
	always @(out_y or correct_y)
	begin
		if (out_y!=correct_y) printf("t = %t FAILED, x = %b, y = %b, correct = %b\n", $time, stim_x, out_y, correct_y);
	end
	
	initial //direct input generation
	begin
		t_rst = 1;
		#2 t_rst = 0;
		#7 t_rst = 1;
		
		stim_x = 0; correct_y = 0;
		#5 stim_x = 1; correct_y = 0;
		#5 stim_x = 0; correct_y = 0;
		#5 stim_x = 1; correct_y = 1;
		#5 stim_x = 0; correct_y = 0;
		#5 stim_x = 0; correct_y = 0;
	end
	
	reg [2:0] seq_3x; //random input generation with clock synchronization
	always @(negedge clk or negedge t_rst) 
	begin
		if (~rst_n) 
		begin
			seq_3x <= 0;
			stim_x <= 0;
		end
		else
		begin
			stim_x <= $random();
			seq_3x <= {seq_3x[1:0], stim_x};
		end; 
		correct_y <= ({seq_3x[1:0], stim_x}==3'b101); //use stim_x to compare rather than using register -> register will be slowed by 1 clock cycle, while stim_x compares instantly.
	end
	
	//input generation using operational run (input stream that yield the most significant outputs) aka task?
	task run1()
	begin
		@negedge(clk); //wait for negative edge of clock
		stim_x = 0; correct_y = 0;
		@negedge(clk);
		stim_x = 1; correct_y = 0;
	end
	endtask
	task run2()
	begin
		@negedge(clk); //wait for negative edge of clock
		stim_x = 1; correct_y = 0;
		@negedge(clk);
		stim_x = 0; correct_y = 0;
		@negedge(clk);
		stim_x = 1; correct_y = 1;
	end
	endtask
	initial 
	begin
		repeat(10) run1;
		repeat(2) run2;
	end
	
	//note: choose only 1 of the 3 input generation methods for compiling. (comment the other 2 methods) 
endmodule
