/*
	Do thay code theo hinh thay de minh 
 	hoa nen day chac chan la
	code dởm, cần do better nếu muốn 賞品!

  	Cas buoc de lam:
   		B1: dung Matlab/py thiet ke Filter
     			xác định loại filter (FIR/IIR)
     			xac dinh hệ số k (số tap)
			xác định số bit và vị trí fixed-point.
   		B2: xác định cấu trúc phần cứng bộ lọc FIR
     			cấu trúc logic/dataflow
			cấu trúc vật lsy & ánh xạ logic vào vật lý
   				x(n) * a[0] (hình trong vở) (keyword: MAC - multiplier ...)
       		B3: viết nhiều gỗ.
	 	B4: Testbench simulation
   			Đưa x(n)
      			Lấy y(n)
	 		rồi quay về py tính THD
    		
*/
module name (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	...
	input [15:0] x[7:0],
	
	output [15:0] y;
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
			s <= s + a[0] + x;
			for (i = 1; i < k; i = i + 1) 
			begin
				s <= s + a[i] * delay_x[i];
			end
			
		end
	end

endmodule : name
