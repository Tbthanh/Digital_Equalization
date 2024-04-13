`timescale 1ns/1ps

module tb();

reg clk;
integer fptr;
integer fptr1;
reg [15:0] testData;
reg reset;
integer i;
reg data_valid;
wire outValid;
wire [255:0] outData;
integer counter=0;

initial
begin
    clk = 0;
    forever
    begin
    	clk = !clk;
    	#5;
    end
end

initial
begin
     reset = 1'b1;
     fptr = $fopen("testData.txt","r");
     fptr1 = $fopen("outputData.txt","w");
     testData = 0;
     data_valid = 0;
     #100;
     reset = 1'b0;
     #50;
     for(i=0;i<10;i=i+1)
     begin
	  @(posedge clk);
          $fscanf(fptr,"%h",testData);
	  data_valid <= 1'b1;
     end
     @(posedge clk);
     data_valid <= 1'b0;
     $fclose(fptr);
end

always @(posedge clk)
begin
    if(outValid)
    begin
        $fwriteh(fptr1,outData,"\n");
        counter = counter + 1;
     end
     if(counter == 10)
     begin
         $fclose(fptr1);
         $finish;
     end
end


runningAdd rA(
.clock(clk),
.reset(reset),
.i_data(testData),
.i_data_valid(data_valid),
.o_data(outData),
.o_data_valid(outValid)
);



endmodule